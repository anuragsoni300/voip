part of 'call_cubit.dart';

@immutable
abstract class CallState {}

class CallInitial extends CallState {}

class CallingState extends CallState {
  final List<Call> calls;

  CallingState({required this.calls});
}
