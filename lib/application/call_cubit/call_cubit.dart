import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:call/infrastructure/call.dart';
import 'package:flutter_voip_kit/call.dart';
import 'package:flutter_voip_kit/flutter_voip_kit.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'call_state.dart';

class CallCubit extends Cubit<CallState> {
  final CallHandler callHandler;
  late StreamSubscription streamSubscription;
  CallCubit({required this.callHandler}) : super(CallInitial()) {
    connect();
  }

  connect() {
    FlutterVoipKit.init(
      callStateChangeHandler: callHandler.callStateChangeHandler,
      callActionHandler: callHandler.callActionHandler,
    );
    streamSubscription = FlutterVoipKit.callListStream.listen(
      (allCalls) => emit(
        CallingState(calls: allCalls),
      ),
    );
  }

  simulateIncomingCall() {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      FlutterVoipKit.reportIncomingCall(
          handle: "${Random().nextInt(10)}" * 9, uuid: const Uuid().v4());
    });
  }

  startOutGoingCall() {
    FlutterVoipKit.startCall(
      "${Random().nextInt(10)}" * 9,
    );
  }

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}
