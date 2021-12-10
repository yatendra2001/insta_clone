part of 'login_cubit.dart';

enum LoginStatus { initial, submitting, success, error }

class LoginState extends Equatable {
  final String email;
  final String password;
  final LoginStatus status;
  final FailureModel failureModel;

  bool get isFormValid => email.isNotEmpty && password.isNotEmpty;

  const LoginState(
      {required this.email,
      required this.password,
      required this.status,
      required this.failureModel});

  factory LoginState.initial() {
    return const LoginState(
        email: '',
        password: '',
        status: LoginStatus.initial,
        failureModel: FailureModel());
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [email, password, status, failureModel];

  LoginState copyWith({
    String? email,
    String? password,
    LoginStatus? status,
    FailureModel? failureModel,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      failureModel: failureModel ?? this.failureModel,
    );
  }
}
