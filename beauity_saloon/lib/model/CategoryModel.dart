import 'dart:convert';

/// OrgId : 1
/// Code : "0008"
/// Name : "DISHWASH"
/// ChineseDescription : ""
/// DisplayOrder : 1
/// IsPOS : true
/// IsB2B : true
/// IsB2C : true
/// IsERP : true
/// IsActive : true
/// CreatedBy : "admin"
/// CreatedOn : "2023-04-01T00:25:23.687"
/// ChangedBy : "admin"
/// ChangedOn : "2023-04-01T00:25:23.687"
/// CreatedOnString : "01/04/2023"
/// ChangedOnString : "01/04/2023"
/// IconImageFileName : ""
/// IconImageFilePath : ""
/// IconImg_Base64String : null
/// IconImage : null
/// CategoryImageFileName : ""
/// CategoryImageFilePath : ""
/// CategoryImg_Base64String : null
/// CategoryImage : null

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));
String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  CategoryModel({
    int? orgId,
    String? code,
    String? name,
    String? chineseDescription,
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
    String? createdOnString,
    String? changedOnString,
    String? iconImageFileName,
    String? iconImageFilePath,
    dynamic iconImgBase64String,
    dynamic iconImage,
    String? categoryImageFileName,
    String? categoryImageFilePath,
    dynamic categoryImgBase64String,
    dynamic categoryImage,
  }) {
    _orgId = orgId;
    _code = code;
    _name = name;
    _chineseDescription = chineseDescription;
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
    _iconImageFileName = iconImageFileName;
    _iconImageFilePath = iconImageFilePath;
    _iconImgBase64String = iconImgBase64String;
    _iconImage = iconImage;
    _categoryImageFileName = categoryImageFileName;
    _categoryImageFilePath = categoryImageFilePath;
    _categoryImgBase64String = categoryImgBase64String;
    _categoryImage = categoryImage;
  }

  CategoryModel.fromJson(dynamic json) {
    _orgId = json['OrgId'];
    _code = json['Code'];
    _name = json['Name'];
    _chineseDescription = json['ChineseDescription'];
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
    _iconImageFileName = json['IconImageFileName'];
    _iconImageFilePath = json['IconImageFilePath'];
    _iconImgBase64String = json['IconImg_Base64String'];
    _iconImage = json['IconImage'];
    _categoryImageFileName = json['CategoryImageFileName'];
    _categoryImageFilePath = json['CategoryImageFilePath'];
    _categoryImgBase64String = json['CategoryImg_Base64String'];
    _categoryImage = json['CategoryImage'];
  }
  int? _orgId;
  String? _code;
  String? _name;
  String? _chineseDescription;
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
  String? _createdOnString;
  String? _changedOnString;
  String? _iconImageFileName;
  String? _iconImageFilePath;
  dynamic _iconImgBase64String;
  dynamic _iconImage;
  String? _categoryImageFileName;
  String? _categoryImageFilePath;
  dynamic _categoryImgBase64String;
  dynamic _categoryImage;
  CategoryModel copyWith({
    int? orgId,
    String? code,
    String? name,
    String? chineseDescription,
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
    String? createdOnString,
    String? changedOnString,
    String? iconImageFileName,
    String? iconImageFilePath,
    dynamic iconImgBase64String,
    dynamic iconImage,
    String? categoryImageFileName,
    String? categoryImageFilePath,
    dynamic categoryImgBase64String,
    dynamic categoryImage,
  }) =>
      CategoryModel(
        orgId: orgId ?? _orgId,
        code: code ?? _code,
        name: name ?? _name,
        chineseDescription: chineseDescription ?? _chineseDescription,
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
        iconImageFileName: iconImageFileName ?? _iconImageFileName,
        iconImageFilePath: iconImageFilePath ?? _iconImageFilePath,
        iconImgBase64String: iconImgBase64String ?? _iconImgBase64String,
        iconImage: iconImage ?? _iconImage,
        categoryImageFileName: categoryImageFileName ?? _categoryImageFileName,
        categoryImageFilePath: categoryImageFilePath ?? _categoryImageFilePath,
        categoryImgBase64String:
            categoryImgBase64String ?? _categoryImgBase64String,
        categoryImage: categoryImage ?? _categoryImage,
      );
  int? get orgId => _orgId;
  String? get code => _code;
  String? get name => _name;
  String? get chineseDescription => _chineseDescription;
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
  String? get createdOnString => _createdOnString;
  String? get changedOnString => _changedOnString;
  String? get iconImageFileName => _iconImageFileName;
  String? get iconImageFilePath => _iconImageFilePath;
  dynamic get iconImgBase64String => _iconImgBase64String;
  dynamic get iconImage => _iconImage;
  String? get categoryImageFileName => _categoryImageFileName;
  String? get categoryImageFilePath => _categoryImageFilePath;
  dynamic get categoryImgBase64String => _categoryImgBase64String;
  dynamic get categoryImage => _categoryImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = _orgId;
    map['Code'] = _code;
    map['Name'] = _name;
    map['ChineseDescription'] = _chineseDescription;
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
    map['IconImageFileName'] = _iconImageFileName;
    map['IconImageFilePath'] = _iconImageFilePath;
    map['IconImg_Base64String'] = _iconImgBase64String;
    map['IconImage'] = _iconImage;
    map['CategoryImageFileName'] = _categoryImageFileName;
    map['CategoryImageFilePath'] = _categoryImageFilePath;
    map['CategoryImg_Base64String'] = _categoryImgBase64String;
    map['CategoryImage'] = _categoryImage;
    return map;
  }
}
