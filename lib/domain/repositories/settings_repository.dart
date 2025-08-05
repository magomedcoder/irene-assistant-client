abstract class SettingsRepository {
  Future<String> getWebSocketAddress();

  Future<void> saveWebSocketAddress(String address);
}
