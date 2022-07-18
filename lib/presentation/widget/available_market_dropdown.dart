import 'package:deriv_price_tracker/core/notifiers/tick_stream_notifier.dart';
import 'package:deriv_price_tracker/data/models/active_symbol_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvailableMarketDropdownWidget extends StatefulWidget {
  final AsyncSnapshot<ActiveSymbolModel>? snapshhot;
  const AvailableMarketDropdownWidget({Key? key, this.snapshhot})
      : super(key: key);

  @override
  State<AvailableMarketDropdownWidget> createState() =>
      _AvailableMarketDropdownWidgetState();
}

class _AvailableMarketDropdownWidgetState
    extends State<AvailableMarketDropdownWidget> {
  String? selectedSymbol;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 70.0.w),
      height: 50,
      width: size.width,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 226, 224, 224),
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 30.0.w),
      child: Consumer(
        builder: (context, ref, child) {
        return DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            icon: const Icon(Icons.arrow_drop_down),
            hint: Text(
              "Available Market",
              style: TextStyle(fontSize: 12.0.sp),
            ),
            items: widget.snapshhot!.data!.activeSymbols!
                .map<DropdownMenuItem<String>>((e) => DropdownMenuItem<String>(
                      value: e.symbol,
                      child: Text(
                        e.displayName!,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ))
                .toList(),
            value: selectedSymbol,
            onChanged: (String? value) {
              setState(() {
                selectedSymbol = value;
              });
              debugPrint(selectedSymbol!);

              ref.watch(tickStreamProvider.notifier).getTicks(tick: selectedSymbol!);
              //ref.watch(provider)
            },
            buttonHeight: 40,
            buttonWidth: 140,
            itemHeight: 40,
          ),
        );
      }),
    );
  }
}
