import 'dart:convert';
import 'dart:math';

import 'package:deriv_price_tracker/core/notifiers/previous_tick_notifier.dart';
import 'package:deriv_price_tracker/core/notifiers/price_status_notifier.dart';
import 'package:deriv_price_tracker/core/notifiers/web_socket_channel.dart';
import 'package:deriv_price_tracker/core/providers/subscription_id_provider.dart';
import 'package:deriv_price_tracker/core/states/tick_state.dart';
import 'package:deriv_price_tracker/data/models/tick_stream_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/src/channel.dart';

class TickStreamNotifier extends StateNotifier<TickState> {
  TickStreamNotifier(this.ref) : super(const TickState.initial());

  final Ref ref;

  WebSocketChannel channel = WebSocketChannel.connect(
      Uri.parse("wss://ws.binaryws.com/websockets/v3?app_id=1089"));

  getTickStream() {
    state = const TickState.loading();
    return channel.stream.listen(
      (event) {
        ref.read(subscriptionIdProvider.notifier).state =
            TickStreamModel.fromJson(jsonDecode(event)).subscription!.id!;
        ref.watch(priceStatusProvider.notifier).compare(
            tick: TickStreamModel.fromJson(jsonDecode(event)).tick!.quote!);
        state =
            TickState.loaded(data: TickStreamModel.fromJson(jsonDecode(event)));
      },
    );
  }

  getTicks({required String tick}) {
    channel.sink.add(json.encode({"ticks": tick, "subscribe": 1}));
  }

  forgetSuscription(){
    channel.sink.add(json.encode({"forget": ref.watch(subscriptionIdProvider)}));
  }
}

final tickStreamProvider =
    StateNotifierProvider<TickStreamNotifier, TickState>((ref) {
  return TickStreamNotifier(ref);
});
