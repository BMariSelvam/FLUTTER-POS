import 'package:beauity_saloon/model/PosPaymode.dart';
import 'package:beauity_saloon/model/PosSettlementDetailModel.dart';

class PosSettlement {
  PosSettlement({
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
      this.shortageAmount, 
      this.excessAmount, this.pOSPaymode,
    this.openingAmount,});

  PosSettlement.fromJson(dynamic json) {
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
    if (json['POSSettlementDetails'] != null) {
      pOSSettlementDetails = [];
      json['POSSettlementDetails'].forEach((v) {
        pOSSettlementDetails?.add(PosSettlementDetailModel.fromJson(v));
      });
    }
    shortageAmount = json['ShortageAmount'];
    if (json['PosPaymode'] != null) {
      pOSPaymode = [];
      json['PosPaymode'].forEach((v) {
        pOSPaymode?.add(PosPaymode.fromJson(v));
      });
    }
    excessAmount = json['ExcessAmount'];
    openingAmount = json['OpeningAmount'];
  }
  int? orgId;
  String? branchCode;
  String? cashRegisterCode;
  String? terminalName;
  String? settlementNo;
  String? settlementDate;
  String? settlementDateString;
  double? totalCashAmount;
  double? cashInAmount;
  double? cashOutAmount;
  String? settlementBy;
  String? createdBy;
  String? createdOn;
  String? changedBy;
  String? changedOn;
  bool? isActive;
  List<PosSettlementDetailModel>? pOSSettlementDetails;
  double? shortageAmount;List<PosPaymode>? pOSPaymode;
  double? excessAmount;
  double? openingAmount;

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
    if (pOSSettlementDetails != null) {
      map['POSSettlementDetails'] = pOSSettlementDetails?.map((v) => v.toJson()).toList();
    }
    map['ShortageAmount'] = shortageAmount;
    if (pOSPaymode != null) {
      map['PosPaymode'] = pOSPaymode?.map((v) => v.toJson()).toList();
    }
    map['ExcessAmount'] = excessAmount;
    map['OpeningAmount'] = openingAmount;
    return map;
  }

}