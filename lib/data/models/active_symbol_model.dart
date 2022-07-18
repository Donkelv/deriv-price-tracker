class ActiveSymbolModel {
  List<ActiveSymbols>? activeSymbols;
  EchoReq? echoReq;
  String? msgType;

  ActiveSymbolModel({this.activeSymbols, this.echoReq, this.msgType});

  ActiveSymbolModel.fromJson(Map<String, dynamic> json) {
    if (json['active_symbols'] != null) {
      activeSymbols = <ActiveSymbols>[];
      json['active_symbols'].forEach((v) {
        activeSymbols!.add(new ActiveSymbols.fromJson(v));
      });
    }
    // echoReq = json['echo_req'] != null
    //     ? new EchoReq.fromJson(json['echo_req'])
    //     : null;
    // msgType = json['msg_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.activeSymbols != null) {
      data['active_symbols'] =
          this.activeSymbols!.map((v) => v.toJson()).toList();
    }
    if (this.echoReq != null) {
      data['echo_req'] = this.echoReq!.toJson();
    }
    data['msg_type'] = this.msgType;
    return data;
  }
}

class ActiveSymbols {
  int? allowForwardStarting;
  String? displayName;
  int? exchangeIsOpen;
  int? isTradingSuspended;
  String? market;
  String? marketDisplayName;
  double? pip;
  String? submarket;
  String? submarketDisplayName;
  String? symbol;
  String? symbolType;

  ActiveSymbols(
      {this.allowForwardStarting,
      this.displayName,
      this.exchangeIsOpen,
      this.isTradingSuspended,
      this.market,
      this.marketDisplayName,
      this.pip,
      this.submarket,
      this.submarketDisplayName,
      this.symbol,
      this.symbolType});

  ActiveSymbols.fromJson(Map<String, dynamic> json) {
    allowForwardStarting = json['allow_forward_starting'];
    displayName = json['display_name'];
    exchangeIsOpen = json['exchange_is_open'];
    isTradingSuspended = json['is_trading_suspended'];
    market = json['market'];
    marketDisplayName = json['market_display_name'];
    pip = json['pip'];
    submarket = json['submarket'];
    submarketDisplayName = json['submarket_display_name'];
    symbol = json['symbol'];
    symbolType = json['symbol_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['allow_forward_starting'] = this.allowForwardStarting;
    data['display_name'] = this.displayName;
    data['exchange_is_open'] = this.exchangeIsOpen;
    data['is_trading_suspended'] = this.isTradingSuspended;
    data['market'] = this.market;
    data['market_display_name'] = this.marketDisplayName;
    data['pip'] = this.pip;
    data['submarket'] = this.submarket;
    data['submarket_display_name'] = this.submarketDisplayName;
    data['symbol'] = this.symbol;
    data['symbol_type'] = this.symbolType;
    return data;
  }
}

class EchoReq {
  String? activeSymbols;
  String? productType;

  EchoReq({this.activeSymbols, this.productType});

  EchoReq.fromJson(Map<String, dynamic> json) {
    activeSymbols = json['active_symbols'];
    productType = json['product_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active_symbols'] = this.activeSymbols;
    data['product_type'] = this.productType;
    return data;
  }
}
