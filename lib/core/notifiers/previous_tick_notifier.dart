
import 'package:flutter_riverpod/flutter_riverpod.dart';

final previousTickListNotifier =
    StateNotifierProvider<PreviousTicktNotifier, List<double>>((ref) {
  return PreviousTicktNotifier();
});

class PreviousTicktNotifier extends StateNotifier<List<double>> {
  PreviousTicktNotifier() : super([]);

  List<double> tickList = [];

  void addTick({required double tick}) {
    tickList.add(tick);
    state = tickList;
  }

  void clearTickList() {
    tickList.clear();
    state = tickList;
  }
}
