import 'package:flutter/cupertino.dart';

class PosCurrencyDenamination {
  PosCurrencyDenamination({
      this.orgId, 
      this.denaminationValue, 
      this.isActive,});

  PosCurrencyDenamination.fromJson(dynamic json) {
    orgId = json['OrgId'];
    denaminationValue = json['DenaminationValue'];
    isActive = json['IsActive'];
  }
  int? orgId;
  double? denaminationValue;
  bool? isActive;

  int? sNo = 0;
  double? rowTotal;
  TextEditingController countControllers = TextEditingController();


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = orgId;
    map['DenaminationValue'] = denaminationValue;
    map['IsActive'] = isActive;
    return map;
  }

}