import 'package:web_socket_channel/web_socket_channel.dart';

abstract class VoiceRemoteDataSource {
  Stream<dynamic> connect();

  void send(List<int> bytes);

  void disconnect();
}

class WebSocketVoiceRemoteDataSource implements VoiceRemoteDataSource {
  late WebSocketChannel _channel;
  final String address;

  WebSocketVoiceRemoteDataSource(this.address);

  @override
  Stream connect() {
    _channel = WebSocketChannel.connect(Uri.parse("$address/wsmic"));
    return _channel.stream;
  }

  @override
  void send(List<int> bytes) {
    _channel.sink.add(bytes);
  }

  @override
  void disconnect() {
    _channel.sink.close();
  }
}
