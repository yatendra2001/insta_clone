import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:insta_clone/models/models.dart';
import 'package:insta_clone/repositories/repositories.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepository _authRepository;

  SignupCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(SignupState.initial());

  void usernameChanged(String value) {
    emit(state.copyWith(username: value, status: SignupStatus.initial));
  }

  void emailChanged(String value) {
    emit(state.copyWith(email: value, status: SignupStatus.initial));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, status: SignupStatus.initial));
  }

  void signupWithCredentials() async {
    if (!state.isFormValid || state.status == SignupStatus.submitting) return;
    emit(state.copyWith(status: SignupStatus.submitting));
    try {
      await _authRepository.signUpWithEmailAndPassword(
          username: state.username,
          email: state.email,
          password: state.password);
      emit(state.copyWith(status: SignupStatus.success));
    } on FailureModel catch (err) {
      emit(state.copyWith(failureModel: err, status: SignupStatus.error));
    }
  }
}
