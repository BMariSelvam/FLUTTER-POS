import 'dart:convert';

/// OrgId : 1
/// Code : "0032"
/// Name : "Non - vegetarian"
/// CategoryName : null
/// ChineseDescription : null
/// CategoryCode : "0027"
/// DisplayOrder : 0
/// IsPOS : false
/// IsB2B : false
/// IsB2C : false
/// IsERP : false
/// IsActive : true
/// CreatedBy : "admin"
/// CreatedOn : "2023-06-09T16:50:56.797"
/// ChangedBy : "admin"
/// ChangedOn : "2023-06-09T16:50:56.797"
/// CreatedOnString : null
/// ChangedOnString : null

SubCategoryModel subCategoryModelFromJson(String str) =>
    SubCategoryModel.fromJson(json.decode(str));
String subCategoryModelToJson(SubCategoryModel data) =>
    json.encode(data.toJson());

class SubCategoryModel {
  SubCategoryModel({
    num? orgId,
    String? code,
    String? name,
    dynamic categoryName,
    dynamic chineseDescription,
    String? categoryCode,
    num? displayOrder,
    bool? isPOS,
    bool? isB2B,
    bool? isB2C,
    bool? isERP,
    bool? isActive,
    String? createdBy,
    String? createdOn,
    String? changedBy,
    String? changedOn,
    dynamic createdOnString,
    dynamic changedOnString,
  }) {
    _orgId = orgId;
    _code = code;
    _name = name;
    _categoryName = categoryName;
    _chineseDescription = chineseDescription;
    _categoryCode = categoryCode;
    _displayOrder = displayOrder;
    _isPOS = isPOS;
    _isB2B = isB2B;
    _isB2C = isB2C;
    _isERP = isERP;
    _isActive = isActive;
    _createdBy = createdBy;
    _createdOn = createdOn;
    _changedBy = changedBy;
    _changedOn = changedOn;
    _createdOnString = createdOnString;
    _changedOnString = changedOnString;
  }

  SubCategoryModel.fromJson(dynamic json) {
    _orgId = json['OrgId'];
    _code = json['Code'];
    _name = json['Name'];
    _categoryName = json['CategoryName'];
    _chineseDescription = json['ChineseDescription'];
    _categoryCode = json['CategoryCode'];
    _displayOrder = json['DisplayOrder'];
    _isPOS = json['IsPOS'];
    _isB2B = json['IsB2B'];
    _isB2C = json['IsB2C'];
    _isERP = json['IsERP'];
    _isActive = json['IsActive'];
    _createdBy = json['CreatedBy'];
    _createdOn = json['CreatedOn'];
    _changedBy = json['ChangedBy'];
    _changedOn = json['ChangedOn'];
    _createdOnString = json['CreatedOnString'];
    _changedOnString = json['ChangedOnString'];
  }
  num? _orgId;
  String? _code;
  String? _name;
  dynamic _categoryName;
  dynamic _chineseDescription;
  String? _categoryCode;
  num? _displayOrder;
  bool? _isPOS;
  bool? _isB2B;
  bool? _isB2C;
  bool? _isERP;
  bool? _isActive;
  String? _createdBy;
  String? _createdOn;
  String? _changedBy;
  String? _changedOn;
  dynamic _createdOnString;
  dynamic _changedOnString;
  SubCategoryModel copyWith({
    num? orgId,
    String? code,
    String? name,
    dynamic categoryName,
    dynamic chineseDescription,
    String? categoryCode,
    num? displayOrder,
    bool? isPOS,
    bool? isB2B,
    bool? isB2C,
    bool? isERP,
    bool? isActive,
    String? createdBy,
    String? createdOn,
    String? changedBy,
    String? changedOn,
    dynamic createdOnString,
    dynamic changedOnString,
  }) =>
      SubCategoryModel(
        orgId: orgId ?? _orgId,
        code: code ?? _code,
        name: name ?? _name,
        categoryName: categoryName ?? _categoryName,
        chineseDescription: chineseDescription ?? _chineseDescription,
        categoryCode: categoryCode ?? _categoryCode,
        displayOrder: displayOrder ?? _displayOrder,
        isPOS: isPOS ?? _isPOS,
        isB2B: isB2B ?? _isB2B,
        isB2C: isB2C ?? _isB2C,
        isERP: isERP ?? _isERP,
        isActive: isActive ?? _isActive,
        createdBy: createdBy ?? _createdBy,
        createdOn: createdOn ?? _createdOn,
        changedBy: changedBy ?? _changedBy,
        changedOn: changedOn ?? _changedOn,
        createdOnString: createdOnString ?? _createdOnString,
        changedOnString: changedOnString ?? _changedOnString,
      );
  num? get orgId => _orgId;
  String? get code => _code;
  String? get name => _name;
  dynamic get categoryName => _categoryName;
  dynamic get chineseDescription => _chineseDescription;
  String? get categoryCode => _categoryCode;
  num? get displayOrder => _displayOrder;
  bool? get isPOS => _isPOS;
  bool? get isB2B => _isB2B;
  bool? get isB2C => _isB2C;
  bool? get isERP => _isERP;
  bool? get isActive => _isActive;
  String? get createdBy => _createdBy;
  String? get createdOn => _createdOn;
  String? get changedBy => _changedBy;
  String? get changedOn => _changedOn;
  dynamic get createdOnString => _createdOnString;
  dynamic get changedOnString => _changedOnString;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = _orgId;
    map['Code'] = _code;
    map['Name'] = _name;
    map['CategoryName'] = _categoryName;
    map['ChineseDescription'] = _chineseDescription;
    map['CategoryCode'] = _categoryCode;
    map['DisplayOrder'] = _displayOrder;
    map['IsPOS'] = _isPOS;
    map['IsB2B'] = _isB2B;
    map['IsB2C'] = _isB2C;
    map['IsERP'] = _isERP;
    map['IsActive'] = _isActive;
    map['CreatedBy'] = _createdBy;
    map['CreatedOn'] = _createdOn;
    map['ChangedBy'] = _changedBy;
    map['ChangedOn'] = _changedOn;
    map['CreatedOnString'] = _createdOnString;
    map['ChangedOnString'] = _changedOnString;
    return map;
  }
}
