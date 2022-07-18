

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketNotifier extends ChangeNotifier {
  WebSocketNotifier(this.ref);

  final Ref ref;
 
   WebSocketChannel channel = WebSocketChannel.connect(
        Uri.parse("wss://ws.binaryws.com/websockets/v3?app_id=1089"));

  void closeActiveSymbolChannel() {
    channel.sink.close();
    notifyListeners();
  }
}

final webSocketChannelProvider =
    ChangeNotifierProvider<WebSocketNotifier>((ref) {
  return WebSocketNotifier(ref);
});
