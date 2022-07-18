class ErrorMessage {
  EchoReq? echoReq;
  Error? error;
  String? msgType;

  ErrorMessage({this.echoReq, this.error, this.msgType});

  ErrorMessage.fromJson(Map<String, dynamic> json) {
    echoReq = json['echo_req'] != null
        ? new EchoReq.fromJson(json['echo_req'])
        : null;
    error = json['error'] != null ? new Error.fromJson(json['error']) : null;
    msgType = json['msg_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.echoReq != null) {
      data['echo_req'] = this.echoReq!.toJson();
    }
    if (this.error != null) {
      data['error'] = this.error!.toJson();
    }
    data['msg_type'] = this.msgType;
    return data;
  }
}

class EchoReq {
  int? subscribe;
  String? ticks;

  EchoReq({this.subscribe, this.ticks});

  EchoReq.fromJson(Map<String, dynamic> json) {
    subscribe = json['subscribe'];
    ticks = json['ticks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subscribe'] = this.subscribe;
    data['ticks'] = this.ticks;
    return data;
  }
}

class Error {
  String? code;
  Details? details;
  String? message;

  Error({this.code, this.details, this.message});

  Error.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    details =
        json['details'] != null ? new Details.fromJson(json['details']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.details != null) {
      data['details'] = this.details!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Details {
  String? field;

  Details({this.field});

  Details.fromJson(Map<String, dynamic> json) {
    field = json['field'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['field'] = this.field;
    return data;
  }
}
