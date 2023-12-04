import 'PosPaymode.dart';
import 'PosCurrencyDenamination.dart';

class PosSettlementDetailModel {
  PosSettlementDetailModel({
      this.orgId, 
      this.settlementNo, 
      this.slNo, 
      this.denomination, 
      this.denominationCount, 
      this.total, 
      this.createdBy, 
      this.createdOn, 
      this.changedBy, 
      this.changedOn, 
      this.isActive, 
      this.posPaymode, 
      this.posCurrencyDenamination,});

  PosSettlementDetailModel.fromJson(dynamic json) {
    orgId = json['OrgId'];
    settlementNo = json['SettlementNo'];
    slNo = json['SlNo'];
    denomination = json['Denomination'];
    denominationCount = json['DenominationCount'];
    total = json['Total'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    changedBy = json['ChangedBy'];
    changedOn = json['ChangedOn'];
    isActive = json['IsActive'];
    if (json['PosPaymode'] != null) {
      posPaymode = [];
      json['PosPaymode'].forEach((v) {
        posPaymode?.add(PosPaymode.fromJson(v));
      });
    }
    if (json['PosCurrencyDenamination'] != null) {
      posCurrencyDenamination = [];
      json['PosCurrencyDenamination'].forEach((v) {
        posCurrencyDenamination?.add(PosCurrencyDenamination.fromJson(v));
      });
    }
  }
  int? orgId;
  String? settlementNo;
  int? slNo;
  double? denomination;
  int? denominationCount;
  double? total;
  String? createdBy;
  String? createdOn;
  String? changedBy;
  String? changedOn;
  bool? isActive;
  List<PosPaymode>? posPaymode;
  List<PosCurrencyDenamination>? posCurrencyDenamination;



  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = orgId;
    map['SettlementNo'] = settlementNo;
    map['SlNo'] = slNo;
    map['Denomination'] = denomination;
    map['DenominationCount'] = denominationCount;
    map['Total'] = total;
    map['CreatedBy'] = createdBy;
    map['CreatedOn'] = createdOn;
    map['ChangedBy'] = changedBy;
    map['ChangedOn'] = changedOn;
    map['IsActive'] = isActive;
    if (posPaymode != null) {
      map['PosPaymode'] = posPaymode?.map((v) => v.toJson()).toList();
    }
    if (posCurrencyDenamination != null) {
      map['PosCurrencyDenamination'] = posCurrencyDenamination?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}