import 'package:irene_assistant/domain/repositories/settings_repository.dart';

class SaveWebSocketAddress {
  final SettingsRepository repository;

  SaveWebSocketAddress(this.repository);

  Future<void> call(String address) => repository.saveWebSocketAddress(address);
}
