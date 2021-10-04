import 'package:call/application/permission_cubit/permission_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PermissionCubit, PermissionState>(
        builder: (contect, state) {
          if (state is PermissionGranted) {
            return const HomePage();
          } else {
            return Scaffold(
              body: Center(
                child: TextButton(
                  style: ButtonStyle(elevation: MaterialStateProperty.all(10)),
                  child: const Text('permission denied :( Give me permission'),
                  onPressed: () => context.read<PermissionCubit>().check(),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
