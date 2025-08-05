import 'package:irene_assistant/domain/repositories/settings_repository.dart';

class GetWebSocketAddress {
  final SettingsRepository repository;

  GetWebSocketAddress(this.repository);

  Future<String> call() => repository.getWebSocketAddress();
}
