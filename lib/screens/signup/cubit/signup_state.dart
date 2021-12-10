part of 'signup_cubit.dart';

enum SignupStatus { initial, submitting, success, error }

class SignupState extends Equatable {
  final String username;
  final String email;
  final String password;
  final SignupStatus status;
  final FailureModel failureModel;

  bool get isFormValid =>
      username.isNotEmpty && email.isNotEmpty && password.isNotEmpty;

  const SignupState(
      {required this.username,
      required this.email,
      required this.password,
      required this.status,
      required this.failureModel});

  factory SignupState.initial() {
    return const SignupState(
        username: '',
        email: '',
        password: '',
        status: SignupStatus.initial,
        failureModel: FailureModel());
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [username, email, password, status, failureModel];

  SignupState copyWith({
    String? username,
    String? email,
    String? password,
    SignupStatus? status,
    FailureModel? failureModel,
  }) {
    return SignupState(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      failureModel: failureModel ?? this.failureModel,
    );
  }
}
