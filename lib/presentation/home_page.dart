import 'package:call/application/call_cubit/call_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_voip_kit/call.dart' as c;

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CallCubit, CallState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Flutter Voip Kit Example'),
          ),
          body: SafeArea(
            child: Column(
              children: [
                ElevatedButton(
                  child: const Text("Simlualate incoming call"),
                  onPressed: () {
                    context.read<CallCubit>().simulateIncomingCall();
                  },
                ),
                ElevatedButton(
                  child: const Text("Start Call outgoing call"),
                  onPressed: () {
                    context.read<CallCubit>().startOutGoingCall();
                  },
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state is CallingState ? state.calls.length : 0,
                    itemBuilder: (context, index) {
                      if (state is CallingState) {
                        c.Call call = state.calls[index];
                        return Container(
                          color: call.callState == c.CallState.active
                              ? Colors.green[300]
                              : call.callState == c.CallState.held
                                  ? Colors.yellow[800]
                                  : (call.callState == c.CallState.connecting
                                      ? Colors.yellow[200]
                                      : Colors.red),
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text("Number: ${call.address}"),
                              ),
                              if (call.callState == c.CallState.connecting)
                                const CircularProgressIndicator(),
                              if (call.callState != c.CallState.connecting &&
                                  call.callState != c.CallState.incoming)
                                ElevatedButton(
                                  onPressed: () {
                                    call.hold(
                                        onHold: !(call.callState ==
                                            c.CallState.held));
                                  },
                                  child: Text(call.callState == c.CallState.held
                                      ? "Resume"
                                      : "Hold"),
                                ),
                              if (call.callState == c.CallState.active) ...[
                                IconButton(
                                  icon: const Icon(
                                    Icons.phone_disabled_sharp,
                                    size: 30,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    call.end();
                                  },
                                ),
                                IconButton(
                                    icon: Icon(
                                      call.muted ? Icons.mic : Icons.mic_off,
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      call.mute(muted: !call.muted);
                                    })
                              ]
                            ],
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
