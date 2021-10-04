part of 'permission_cubit.dart';

@immutable
abstract class PermissionState {}

class PermissionInitial extends PermissionState {}

class PermissionGranted extends PermissionInitial {}

class PermissionDenied extends PermissionInitial {}
