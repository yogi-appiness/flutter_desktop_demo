import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:techcloud_login_demo/common/constants.dart';
import 'package:techcloud_login_demo/common/user.dart';

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
    db = await Db.create(Constants.mongoUrl);
    await db.open();
    debugPrint("Connection status: ${db.isConnected}");
    usersCollection = db.collection(Constants.usersCollection);
  }

  /// Register for a new user
  Future<void> registerNewUser(User user) async {
    await usersCollection.insert(user.toJson());
  }
}
