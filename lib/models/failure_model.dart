import 'package:equatable/equatable.dart';

class FailureModel extends Equatable {
  String? code;
  String? message;

  FailureModel({this.code = '', this.message = ''});
  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [code, message];
}
