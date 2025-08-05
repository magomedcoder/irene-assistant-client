import 'package:irene_assistant/domain/repositories/settings_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  static const _key = 'websocket_address';

  @override
  Future<String> getWebSocketAddress() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_key) ?? 'ws://127.0.0.1:5003';
  }

  @override
  Future<void> saveWebSocketAddress(String address) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, address);
  }
}
