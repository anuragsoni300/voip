import 'package:call/infrastructure/call.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'application/call_cubit/call_cubit.dart';
import 'application/permission_cubit/permission_cubit.dart';
import 'presentation/main_page.dart';

void main() {
  CallHandler callHandler = CallHandler();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => PermissionCubit(),
    ),
    BlocProvider(
      create: (context) => CallCubit(callHandler: callHandler),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(),
    );
  }
}
