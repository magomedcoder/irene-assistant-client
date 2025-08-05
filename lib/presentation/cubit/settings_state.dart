part of 'settings_cubit.dart';

abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final String address;

  SettingsLoaded(this.address);
}

class SettingsSaved extends SettingsState {
  final String address;

  SettingsSaved(this.address);
}

class SettingsError extends SettingsState {
  final String message;

  SettingsError(this.message);
}
