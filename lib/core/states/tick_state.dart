import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/tick_stream_model.dart';

part 'tick_state.freezed.dart';

@freezed
class TickState with _$TickState {
  const factory TickState.initial() = _$TickStateInitial;
  const factory TickState.loading() = _$TickStateLoading;
  const factory TickState.loaded({required TickStreamModel data}) =
      _$TickStateLoaded;

  const factory TickState.error(String error) = _$TickStateError;
}
