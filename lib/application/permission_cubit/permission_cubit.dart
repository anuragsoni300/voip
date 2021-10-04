import 'package:bloc/bloc.dart';
import 'package:flutter_voip_kit/flutter_voip_kit.dart';
import 'package:meta/meta.dart';

part 'permission_state.dart';

class PermissionCubit extends Cubit<PermissionState> {
  PermissionCubit() : super(PermissionInitial()) {
    FlutterVoipKit.checkPermissions(openSettings: true).then(
      (value) {
        if (value == true) {
          emit(PermissionGranted());
        } else {
          emit(PermissionDenied());
        }
      },
    );
  }

  check() {
    FlutterVoipKit.checkPermissions(openSettings: true).then(
      (value) {
        if (value == true) {
          emit(PermissionGranted());
        } else {
          emit(PermissionDenied());
        }
      },
    );
  }
}
