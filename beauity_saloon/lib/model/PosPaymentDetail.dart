class PosPaymentDetail {
  PosPaymentDetail({
      this.orderNo, 
      this.branchCode, 
      this.cashRegisterCode, 
      this.orgId, 
      this.slNo, 
      this.paymodeCode, 
      this.paymodeName, 
      this.amount, 
      this.settlementNo, 
      this.isCredit, 
      this.orderDate,});

  PosPaymentDetail.fromJson(dynamic json) {
    orderNo = json['OrderNo'];
    branchCode = json['BranchCode'];
    cashRegisterCode = json['CashRegisterCode'];
    orgId = json['OrgId'];
    slNo = json['SlNo'];
    paymodeCode = json['PaymodeCode'];
    paymodeName = json['PaymodeName'];
    amount = json['Amount'];
    settlementNo = json['SettlementNo'];
    isCredit = json['IsCredit'];
    orderDate = json['OrderDate'];
  }
  String? orderNo;
  String? branchCode;
  String? cashRegisterCode;
  int? orgId;
  int? slNo;
  String? paymodeCode;
  String? paymodeName;
  double? amount;
  String? settlementNo;
  bool? isCredit;
  String? orderDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrderNo'] = orderNo;
    map['BranchCode'] = branchCode;
    map['CashRegisterCode'] = cashRegisterCode;
    map['OrgId'] = orgId;
    map['SlNo'] = slNo;
    map['PaymodeCode'] = paymodeCode;
    map['PaymodeName'] = paymodeName;
    map['Amount'] = amount;
    map['SettlementNo'] = settlementNo;
    map['IsCredit'] = isCredit;
    map['OrderDate'] = orderDate;
    return map;
  }

}