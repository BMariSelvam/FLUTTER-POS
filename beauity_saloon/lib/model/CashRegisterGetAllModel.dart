class CashRegisterGetAllModel {
  CashRegisterGetAllModel({
      this.orgId, 
      this.branchCode, 
      this.cashRegisterCode, 
      this.terminalName, 
      this.depositAmount, 
      this.cashierName, 
      this.isActive, 
      this.createdBy, 
      this.createdOn, 
      this.createdOnString, 
      this.changedBy, 
      this.changedOn, 
      this.changedOnString, 
      this.oBstatus,});

  CashRegisterGetAllModel.fromJson(dynamic json) {
    orgId = json['OrgId'];
    branchCode = json['BranchCode'];
    cashRegisterCode = json['CashRegisterCode'];
    terminalName = json['TerminalName'];
    depositAmount = json['DepositAmount'];
    cashierName = json['CashierName'];
    isActive = json['IsActive'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    createdOnString = json['CreatedOnString'];
    changedBy = json['ChangedBy'];
    changedOn = json['ChangedOn'];
    changedOnString = json['ChangedOnString'];
    oBstatus = json['OBstatus'];
  }
  int? orgId;
  String? branchCode;
  String? cashRegisterCode;
  String? terminalName;
  double? depositAmount;
  String? cashierName;
  bool? isActive;
  String? createdBy;
  String? createdOn;
  dynamic createdOnString;
  String? changedBy;
  String? changedOn;
  dynamic changedOnString;
  dynamic oBstatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = orgId;
    map['BranchCode'] = branchCode;
    map['CashRegisterCode'] = cashRegisterCode;
    map['TerminalName'] = terminalName;
    map['DepositAmount'] = depositAmount;
    map['CashierName'] = cashierName;
    map['IsActive'] = isActive;
    map['CreatedBy'] = createdBy;
    map['CreatedOn'] = createdOn;
    map['CreatedOnString'] = createdOnString;
    map['ChangedBy'] = changedBy;
    map['ChangedOn'] = changedOn;
    map['ChangedOnString'] = changedOnString;
    map['OBstatus'] = oBstatus;
    return map;
  }

}