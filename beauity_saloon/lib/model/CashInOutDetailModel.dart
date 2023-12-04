class CashInOutDetailModel {
  CashInOutDetailModel({
      this.orgId, 
      this.branchCode, 
      this.cashRegisterCode, 
      this.terminalName, 
      this.settlementNo, 
      this.settlementDate, 
      this.settlementDateString, 
      this.totalCashAmount, 
      this.cashInAmount, 
      this.cashOutAmount, 
      this.settlementBy, 
      this.createdBy, 
      this.createdOn, 
      this.changedBy, 
      this.changedOn, 
      this.isActive, 
      this.pOSSettlementDetails, 
      this.pOSPaymode, 
      this.shortageAmount, 
      this.excessAmount, 
      this.openingAmount,});

  CashInOutDetailModel.fromJson(dynamic json) {
    orgId = json['OrgId'];
    branchCode = json['BranchCode'];
    cashRegisterCode = json['CashRegisterCode'];
    terminalName = json['TerminalName'];
    settlementNo = json['SettlementNo'];
    settlementDate = json['SettlementDate'];
    settlementDateString = json['SettlementDateString'];
    totalCashAmount = json['TotalCashAmount'];
    cashInAmount = json['CashInAmount'];
    cashOutAmount = json['CashOutAmount'];
    settlementBy = json['SettlementBy'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    changedBy = json['ChangedBy'];
    changedOn = json['ChangedOn'];
    isActive = json['IsActive'];
    pOSSettlementDetails = json['POSSettlementDetails'];
    pOSPaymode = json['POSPaymode'];
    shortageAmount = json['ShortageAmount'];
    excessAmount = json['ExcessAmount'];
    openingAmount = json['OpeningAmount'];
  }
  int? orgId;
  dynamic branchCode;
  dynamic cashRegisterCode;
  dynamic terminalName;
  dynamic settlementNo;
  dynamic settlementDate;
  dynamic settlementDateString;
  dynamic totalCashAmount;
  double? cashInAmount;
  double? cashOutAmount;
  dynamic settlementBy;
  dynamic createdBy;
  dynamic createdOn;
  dynamic changedBy;
  dynamic changedOn;
  dynamic isActive;
  dynamic pOSSettlementDetails;
  dynamic pOSPaymode;
  dynamic shortageAmount;
  dynamic excessAmount;
  dynamic openingAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = orgId;
    map['BranchCode'] = branchCode;
    map['CashRegisterCode'] = cashRegisterCode;
    map['TerminalName'] = terminalName;
    map['SettlementNo'] = settlementNo;
    map['SettlementDate'] = settlementDate;
    map['SettlementDateString'] = settlementDateString;
    map['TotalCashAmount'] = totalCashAmount;
    map['CashInAmount'] = cashInAmount;
    map['CashOutAmount'] = cashOutAmount;
    map['SettlementBy'] = settlementBy;
    map['CreatedBy'] = createdBy;
    map['CreatedOn'] = createdOn;
    map['ChangedBy'] = changedBy;
    map['ChangedOn'] = changedOn;
    map['IsActive'] = isActive;
    map['POSSettlementDetails'] = pOSSettlementDetails;
    map['POSPaymode'] = pOSPaymode;
    map['ShortageAmount'] = shortageAmount;
    map['ExcessAmount'] = excessAmount;
    map['OpeningAmount'] = openingAmount;
    return map;
  }

}