class ForgetReqModel {
  EchoReq? echoReq;
  int? forget;
  String? msgType;

  ForgetReqModel({this.echoReq, this.forget, this.msgType});

  ForgetReqModel.fromJson(Map<String, dynamic> json) {
    echoReq = json['echo_req'] != null
        ? new EchoReq.fromJson(json['echo_req'])
        : null;
    forget = json['forget'];
    msgType = json['msg_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.echoReq != null) {
      data['echo_req'] = this.echoReq!.toJson();
    }
    data['forget'] = this.forget;
    data['msg_type'] = this.msgType;
    return data;
  }
}

class EchoReq {
  String? forget;

  EchoReq({this.forget});

  EchoReq.fromJson(Map<String, dynamic> json) {
    forget = json['forget'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['forget'] = this.forget;
    return data;
  }
}
