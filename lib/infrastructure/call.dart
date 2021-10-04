import 'dart:developer' as dev;

import 'package:flutter_voip_kit/call.dart';

class CallHandler {
  Future<bool> callStateChangeHandler(call) async {
    switch (call.callState) {
      case CallState
          .connecting: //simulate connection time of 3 seconds for our VOIP service
        dev.log("--------------> Call connecting");
        await Future.delayed(const Duration(seconds: 3));
        return true;
      case CallState
          .active: //here we would likely begin playig audio out of speakers
        dev.log("--------> Call active");
        return true;
      case CallState.ended: //end audio, disconnect
        dev.log("--------> Call ended");
        await Future.delayed(const Duration(seconds: 1));
        return true;
      case CallState.failed: //cleanup
        dev.log("--------> Call failed");
        return true;
      case CallState.held: //pause audio for specified call
        dev.log("--------> Call held");
        return true;
      default:
        return false;
    }
  }

  Future<bool> callActionHandler(Call call, CallAction action) async {
//calls states have been updated, setState so ui can reflect that

    //it is important we perform logic and return true/false for every CallState possible
    switch (action) {
      case CallAction.muted:
        //EXAMPLE: here we would perform the logic on our end to mute the audio streams between the caller and reciever
        return true;
      default:
        return false;
    }
  }
}
