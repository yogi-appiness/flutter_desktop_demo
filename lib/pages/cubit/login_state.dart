part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({
    this.user,
    this.isBusy = true,
    this.errorMessage,
  });

  /// Logged in user if exists
  final User? user;

  /// Whether busy state or not
  final bool isBusy;

  /// Error
  final String? errorMessage;

  LoginState copyWith({
    User? user,
    bool? isBusy,
    String? errorMessage,
  }) =>
      LoginState(
        user: user ?? this.user,
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
