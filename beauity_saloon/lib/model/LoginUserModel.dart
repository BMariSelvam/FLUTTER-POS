class LoginUserModel {
  LoginUserModel({
      this.organisationName, 
      this.orgId, 
      this.username, 
      this.userRolecode, 
      this.uniqueNo, 
      this.name, 
      this.password, 
      this.mail, 
      this.addressLine1, 
      this.addressLine2, 
      this.addressLine3, 
      this.country, 
      this.countryName, 
      this.postalCode, 
      this.mobile, 
      this.phone, 
      this.fax, 
      this.facebook, 
      this.linkedIn, 
      this.isActive, 
      this.createdBy, 
      this.createdOn, 
      this.changedBy, 
      this.changedOn, 
      this.itemImage, 
      this.itemImageString, 
      this.branchCode, 
      this.location, 
      this.companyImageString,});

  LoginUserModel.fromJson(dynamic json) {
    organisationName = json['OrganisationName'];
    orgId = json['OrgId'];
    username = json['Username'];
    userRolecode = json['UserRolecode'];
    uniqueNo = json['UniqueNo'];
    name = json['Name'];
    password = json['Password'];
    mail = json['Mail'];
    addressLine1 = json['AddressLine1'];
    addressLine2 = json['AddressLine2'];
    addressLine3 = json['AddressLine3'];
    country = json['Country'];
    countryName = json['CountryName'];
    postalCode = json['PostalCode'];
    mobile = json['Mobile'];
    phone = json['Phone'];
    fax = json['Fax'];
    facebook = json['Facebook'];
    linkedIn = json['LinkedIn'];
    isActive = json['IsActive'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    changedBy = json['ChangedBy'];
    changedOn = json['ChangedOn'];
    itemImage = json['ItemImage'];
    itemImageString = json['ItemImageString'];
    branchCode = json['BranchCode'];
    location = json['Location'];
    companyImageString = json['CompanyImageString'];
  }
  String? organisationName;
  int? orgId;
  String? username;
  String? userRolecode;
  String? uniqueNo;
  String? name;
  String? password;
  String? mail;
  String? addressLine1;
  String? addressLine2;
  String? addressLine3;
  String? country;
  String? countryName;
  String? postalCode;
  String? mobile;
  String? phone;
  String? fax;
  String? facebook;
  String? linkedIn;
  bool? isActive;
  String? createdBy;
  String? createdOn;
  String? changedBy;
  String? changedOn;
  String? itemImage;
  String? itemImageString;
  String? branchCode;
  String? location;
  String? companyImageString;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrganisationName'] = organisationName;
    map['OrgId'] = orgId;
    map['Username'] = username;
    map['UserRolecode'] = userRolecode;
    map['UniqueNo'] = uniqueNo;
    map['Name'] = name;
    map['Password'] = password;
    map['Mail'] = mail;
    map['AddressLine1'] = addressLine1;
    map['AddressLine2'] = addressLine2;
    map['AddressLine3'] = addressLine3;
    map['Country'] = country;
    map['CountryName'] = countryName;
    map['PostalCode'] = postalCode;
    map['Mobile'] = mobile;
    map['Phone'] = phone;
    map['Fax'] = fax;
    map['Facebook'] = facebook;
    map['LinkedIn'] = linkedIn;
    map['IsActive'] = isActive;
    map['CreatedBy'] = createdBy;
    map['CreatedOn'] = createdOn;
    map['ChangedBy'] = changedBy;
    map['ChangedOn'] = changedOn;
    map['ItemImage'] = itemImage;
    map['ItemImageString'] = itemImageString;
    map['BranchCode'] = branchCode;
    map['Location'] = location;
    map['CompanyImageString'] = companyImageString;
    return map;
  }

}