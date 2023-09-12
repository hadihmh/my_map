import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

class WebSocketService {
  final String _socketServerUrl =
      "ws://flutter-test.iran.liara.run/ws/locations";
  late WebSocketChannel _channel;

  WebSocketChannel connect() {
    _channel = IOWebSocketChannel.connect(_socketServerUrl);
    return _channel;
  }

  void sendMessage(String message) {
    _channel.sink.add(message);
  }

  Stream<dynamic> get stream => _channel.stream;

  void close() {
    _channel.sink.close();
  }
}
