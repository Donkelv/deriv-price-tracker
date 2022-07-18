import 'dart:io';

import 'package:deriv_price_tracker/core/notifiers/active_symbol.dart';
import 'package:deriv_price_tracker/core/notifiers/tick_stream_notifier.dart';
import 'package:deriv_price_tracker/data/models/tick_price_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/notifiers/price_status_notifier.dart';
import '../../data/models/active_symbol_model.dart';

import '../widget/available_market_dropdown.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      ref.watch(activeSymbolChannelProvider).getActiveSymbol();
      ref.watch(tickStreamProvider.notifier).getTickStream();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: size.width,
          height: size.height,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StreamBuilder<ActiveSymbolModel>(
                  stream: ref
                      .watch(activeSymbolChannelProvider)
                      .getActiveSymbolStream(),
                  builder: (context, snapshhot) {
                    if (snapshhot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Platform.isIOS
                            ? const CircularProgressIndicator.adaptive(
                                backgroundColor: Colors.black,
                              )
                            : const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.black),
                              ),
                      );
                    } else if (snapshhot.hasData) {
                      return AvailableMarketDropdownWidget(
                        snapshhot: snapshhot,
                      );
                    } else if (snapshhot.hasError) {
                      return Center(
                        child: Text(snapshhot.error.toString()),
                      );
                    } else {
                      return Center(
                        child: Platform.isIOS
                            ? const CircularProgressIndicator.adaptive(
                                backgroundColor: Colors.black,
                              )
                            : const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.black),
                              ),
                      );
                    }
                  }),
              SizedBox(
                height: 40.0.h,
              ),
              Consumer(builder: (context, ref, child) {
                return ref.watch(tickStreamProvider).when(
                  initial: () {
                    return Center(
                      child: Text(
                        "Select an available\nmarket to continue",
                        style: TextStyle(fontSize: 15.0.sp),
                      ),
                    );
                  },
                  loading: () {
                    return Center(
                      child: Platform.isIOS
                          ? const CircularProgressIndicator.adaptive(
                              backgroundColor: Colors.black,
                            )
                          : const CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.black),
                            ),
                    );
                  },
                  loaded: (loaded) {
                    return Center(
                      child: Text(
                        loaded.tick!.quote.toString(),
                        style: TextStyle(fontSize: 15.0.sp, color: ref.watch(priceStatusProvider) == TickPriceStatus.higher ? Colors.green : ref.watch(priceStatusProvider) ==
                                    TickPriceStatus.lower ? Colors.red  : Color.fromARGB(255, 209, 207, 207)),
                      ),
                    );
                  },
                );
              })
            ],
          ),
        ));
  }
}
