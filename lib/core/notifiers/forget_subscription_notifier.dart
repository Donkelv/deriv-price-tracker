import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../providers/subscription_id_provider.dart';

class ForgetSubscriptionNotifier extends ChangeNotifier {
  ForgetSubscriptionNotifier(this.ref);

  final Ref ref;

  WebSocketChannel channel = WebSocketChannel.connect(
      Uri.parse("wss://ws.binaryws.com/websockets/v3?app_id=1089"));

  forgetSuscription() {
    channel.stream.map((event) => print(event));
    channel.sink
        .add(json.encode({"forget": ref.watch(subscriptionIdProvider)}));
  }
}

final forgetSubscriptionProvider =
    ChangeNotifierProvider<ForgetSubscriptionNotifier>((ref) {
  return ForgetSubscriptionNotifier(ref);
});
