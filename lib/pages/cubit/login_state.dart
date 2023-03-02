part of 'login_cubit.dart';

/// State which is used by the cubit state management.
/// AUTHOR: Yogendra J Pai
class LoginState extends Equatable {
  const LoginState({
    this.user,
    this.isBusy = false,
    this.errorMessage,
  });

  /// User data if logged in
  final User? user;

  /// Whether busy state or not
  final bool isBusy;

  /// Error
  final String? errorMessage;

  /// Copy with function
  LoginState copyWith(
          {User? user,
          bool? isBusy,
          String? errorMessage,
          bool logoutUser = false}) =>
      LoginState(
        user: (logoutUser) ? null : user ?? this.user,
        isBusy: isBusy ?? this.isBusy,
        errorMessage: errorMessage,
      );

  @override
  List<Object?> get props => [
        user,
        isBusy,
        errorMessage,
      ];
}
