import 'package:deriv_price_tracker/core/notifiers/previous_tick_notifier.dart';
import 'package:deriv_price_tracker/data/models/tick_price_status.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PriceStatusNotifier extends StateNotifier<TickPriceStatus> {
  PriceStatusNotifier(this.ref) : super(TickPriceStatus.equal);

  final Ref ref;

  void compare({required double tick}) {
    ref.watch(previousTickListNotifier.notifier).addTick(tick: tick);
    print(ref.watch(previousTickListNotifier));
    print(tick);
    if (ref.watch(previousTickListNotifier) != [] && ref.watch(previousTickListNotifier).length > 1) {
      if (ref.watch(previousTickListNotifier).last >
          ref.watch(previousTickListNotifier).reversed.elementAt(1)) {
        state = TickPriceStatus.higher;
      } else if (ref.watch(previousTickListNotifier).last <
          ref.watch(previousTickListNotifier).reversed.elementAt(1)) {
        state = TickPriceStatus.lower;
      } else {
        state = TickPriceStatus.equal;
      }
    } else {
      state = TickPriceStatus.equal;
    }
  }
}

final priceStatusProvider =
    StateNotifierProvider<PriceStatusNotifier, TickPriceStatus>((ref) {
  return PriceStatusNotifier(ref);
});
