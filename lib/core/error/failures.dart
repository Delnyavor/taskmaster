import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([List props = const <dynamic>[]]) : super();
}

//General Failures
class ServerFailure extends Failure {
  final String? message;

  const ServerFailure({this.message}) : super();
  @override
  List<Object?> get props => [];
}

class CacheFailure extends Failure {
  final String? message;

  const CacheFailure({this.message});
  @override
  List<Object?> get props => [message];
}
