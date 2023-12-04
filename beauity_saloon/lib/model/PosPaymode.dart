class PosPaymode {
  PosPaymode({
      this.paymentType, 
      this.paidAmount,});

  PosPaymode.fromJson(dynamic json) {
    paymentType = json['PaymentType'];
    paidAmount = json['PaidAmount'];
  }
  String? paymentType;
  double? paidAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['PaymentType'] = paymentType;
    map['PaidAmount'] = paidAmount;
    return map;
  }

}