import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techcloudpro_demo/common/constants.dart';
import 'package:techcloudpro_demo/common/user.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState()) {
    Future.microtask(() => initialize());
  }

  late Db db;
  late DbCollection usersCollection;

  late SharedPreferences prefs;

  /// Establish connection and initialize db and collection.
  Future<void> initialize() async {
    try {
      db = await Db.create(Constants.mongoUrl);
      await db.open();
      debugPrint("Connection status: ${db.isConnected}");
      usersCollection = db.collection(Constants.usersCollection);

      // Initialize caching and check if user logged in
      prefs = await SharedPreferences.getInstance();

      final username = prefs.getString(Constants.loggedInUser);

      if (username != null) {
        final userData = await usersCollection.findOne({"username": username});

        if (userData != null) {
          final user = User.fromJson(userData);
          emit(state.copyWith(user: user));
        }
      }
      emit(state.copyWith(isBusy: false));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isBusy: false));
    }
  }

  /// Login user with credentials
  Future<bool> loginUser(
      {required String username, required String password}) async {
    try {
      emit(state.copyWith(isBusy: false));
      final result = await usersCollection
          .findOne({"username": username, "password": password});

      if (result != null) {
        final user = User.fromJson(result);
        emit(state.copyWith(user: user));

        prefs.setString(Constants.loggedInUser, user.username);
        return true;
      } else {
        emit(state.copyWith(errorMessage: "Invalid username/password"));
      }
      return false;
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
      return false;
    }
  }

  /// Register for a new user
  Future<bool> registerNewUser(
      {required String name,
      required String username,
      required String password}) async {
    try {
      emit(state.copyWith(isBusy: false));
      final existingUser =
          await usersCollection.findOne({"username": username});
      if (existingUser != null) {
        emit(state.copyWith(errorMessage: "User already exists"));
        return false;
      }
      final user = User(
          id: ObjectId(), name: name, username: username, password: password);

      final result = await usersCollection.insert(user.toJson());

      debugPrint(result.toString());

      emit(state.copyWith(
          errorMessage: "Successfully registered. Please login."));
      return true;
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
      return false;
    }
  }

  /// Reset password
  Future<bool> resetPassword(
      {required String name,
      required String username,
      required String password}) async {
    try {
      emit(state.copyWith(isBusy: false));
      final user =
          await usersCollection.findOne({"username": username, "name": name});
      if (user == null) {
        emit(state.copyWith(errorMessage: "Username and name does not match"));
        return false;
      }

      // Update new password
      final result = await usersCollection.updateOne(
          where.eq("username", username), modify.set("password", password));

      if (result.isSuccess) {
        emit(state.copyWith(
            errorMessage: "Successfully reset password. Please login."));
      } else {
        emit(state.copyWith(
            errorMessage: "An error occured. Please try again."));
        return false;
      }

      return true;
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
      return false;
    }
  }

  Future<void> logoutUser() async {
    prefs.remove(Constants.loggedInUser);
    emit(state.copyWith(logoutUser: true));
  }
}
