import 'dart:convert';
import 'package:deriv_price_tracker/core/notifiers/price_status_notifier.dart';
import 'package:deriv_price_tracker/core/providers/subscription_id_provider.dart';
import 'package:deriv_price_tracker/core/states/tick_state.dart';
import 'package:deriv_price_tracker/data/models/error_msg_model.dart';
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
    return channel.stream.asBroadcastStream().listen(
      (event) {
        if (TickStreamModel.fromJson(jsonDecode(event)).msgType == "tick") {
          if (TickStreamModel.fromJson(jsonDecode(event)).tick != null) {
            print(event);
            ref.read(subscriptionIdProvider.notifier).state =
                TickStreamModel.fromJson(jsonDecode(event)).subscription!.id!;
            ref.watch(priceStatusProvider.notifier).compare(
                tick: TickStreamModel.fromJson(jsonDecode(event)).tick!.quote!);
            if (!mounted) return;
            state = TickState.loaded(
                data: TickStreamModel.fromJson(jsonDecode(event)));
          } else {
            if (TickStreamModel.fromJson(jsonDecode(event)).msgType ==
                "forget") {
              debugPrint("forget");
              state = const TickState.loading();
            } else {
              if (!mounted) return;
              state = TickState.error(
                  ErrorMessage.fromJson(jsonDecode(event)).error!.message!);
            }
          }
        } else {
          print(event);
          if (!mounted) return;
          state = const TickState.loading();
        }
      },
    ).onError((error) {
      print(error);
      state = TickState.error(error);
    });
  }

  getTicks({required String tick}) {
    channel.sink.add(json.encode({"ticks": tick, "subscribe": 1}));
  }

  disposeStream() {
    channel.sink.close();
    //channel.c
  }

  forgetSuscription({
    required String tick,
  }) {
    //channel.sink.close();
    // channel.stream.listen((event) {
    //   if (TickStreamModel.fromJson(jsonDecode(event)).msgType == "tick") {
    //     if (TickStreamModel.fromJson(jsonDecode(event)).tick != null) {
    //       print(event);
    //       ref.read(subscriptionIdProvider.notifier).state =
    //           TickStreamModel.fromJson(jsonDecode(event)).subscription!.id!;
    //       ref.watch(priceStatusProvider.notifier).compare(
    //           tick: TickStreamModel.fromJson(jsonDecode(event)).tick!.quote!);
    //       if (!mounted) return;
    //       state = TickState.loaded(
    //           data: TickStreamModel.fromJson(jsonDecode(event)));
    //     } else {
    //       state = TickState.error(
    //           ErrorMessage.fromJson(jsonDecode(event)).error!.message!);
    //     }
    //   } else {
    //     print(event);
    //     if (!mounted) return;
    //     state = const TickState.loading();
    //   }
    // });
    channel.sink
        .add(json.encode({"forget": ref.watch(subscriptionIdProvider)}));

    // channel.sink.addStream()
    //getTickStream();
    // print("right before adding tick");
    channel.sink.add(json.encode({"ticks": tick, "subscribe": 1}));
    // print("right after adding tick");
  }
}

final tickStreamProvider =
    StateNotifierProvider<TickStreamNotifier, TickState>((ref) {
  return TickStreamNotifier(ref);
});
