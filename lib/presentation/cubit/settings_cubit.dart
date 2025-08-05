import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:irene_assistant/domain/usecases/get_websocket_address.dart';
import 'package:irene_assistant/domain/usecases/save_websocket_address.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final GetWebSocketAddress getUseCase;
  final SaveWebSocketAddress saveUseCase;

  SettingsCubit({required this.getUseCase, required this.saveUseCase})
    : super(SettingsInitial());

  void loadAddress() async {
    final address = await getUseCase();
    emit(SettingsLoaded(address));
  }

  void updateAddress(String newValue) {
    if (state is SettingsLoaded) {
      emit(SettingsLoaded(newValue));
    }
  }

  Future<void> saveAddress() async {
    if (state is SettingsLoaded) {
      final address = (state as SettingsLoaded).address.trim();

      if (!address.startsWith('ws://') && !address.startsWith('wss://')) {
        emit(SettingsError("Некорректный адрес WebSocket"));
        emit(SettingsLoaded(address));
        return;
      }

      await saveUseCase(address);
      emit(SettingsSaved(address));
    }
  }
}
