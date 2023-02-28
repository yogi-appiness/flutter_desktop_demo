import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:techcloudpro_demo/common/constants.dart';
import 'package:techcloudpro_demo/common/user.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState()) {
    Future.microtask(() => initialize());
  }

  late Db db;
  late DbCollection usersCollection;

  /// Establish connection and initialize db and collection.
  Future<void> initialize() async {
    try {
      db = await Db.create(Constants.mongoUrl);
      await db.open();
      debugPrint("Connection status: ${db.isConnected}");
      usersCollection = db.collection(Constants.usersCollection);
      emit(state.copyWith(isBusy: false));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isBusy: false));
    }
  }

  /// Login user with credentials
  Future<bool> loginUser(
      {required String username, required String password}) async {
    try {
      final result = await usersCollection
          .findOne({"username": username, "password": password});

      if (result != null) {
        final user = User.fromJson(result);
        emit(state.copyWith(user: user));
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
  Future<void> registerNewUser(User user) async {
    try {
      final result = await usersCollection.insert(user.toJson());

      debugPrint(result.toString());

      emit(state.copyWith(user: user));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }
}
