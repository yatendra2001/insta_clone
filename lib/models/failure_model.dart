import 'package:equatable/equatable.dart';

class FailureModel extends Equatable {
  final String code;
  final String message;

  const FailureModel({this.code = '', this.message = ''});
  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [code, message];
}
