import 'dart:convert';

import 'package:deriv_price_tracker/core/notifiers/web_socket_channel.dart';
import 'package:deriv_price_tracker/data/models/active_symbol_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ActiveSymboltNotifier extends ChangeNotifier {
  ActiveSymboltNotifier(this.ref);

  final Ref ref;

  Stream<ActiveSymbolModel> getActiveSymbolStream() {
    WebSocketChannel activeSymbol = ref.watch(webSocketChannelProvider).channel;
    return activeSymbol.stream.map<ActiveSymbolModel>((event) {
      //print(ActiveSymbolModel.fromJson(event));
      //print(event);
      return ActiveSymbolModel.fromJson(jsonDecode(event));
    })
    .skipWhile((element) => element.msgType == "active_symbols");
  }

  void getActiveSymbol() {
    ref
        .watch(webSocketChannelProvider)
        .channel
        .sink
        .add(json.encode({"active_symbols": "brief", "product_type": "basic"}));
  }
}

final activeSymbolChannelProvider =
    ChangeNotifierProvider<ActiveSymboltNotifier>((ref) {
  return ActiveSymboltNotifier(ref);
});
