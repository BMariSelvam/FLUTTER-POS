class PosInvoiceDetail {
  PosInvoiceDetail({
      this.orgId, 
      this.orderNo, 
      this.slNo, 
      this.productCode, 
      this.uOMName, 
      this.isCredit, 
      this.productName, 
      this.qty, 
      this.price, 
      this.foc, 
      this.total, 
      this.itemDiscount, 
      this.itemDiscountPerc, 
      this.subTotal, 
      this.tax, 
      this.netTotal, 
      this.taxCode, 
      this.taxType, 
      this.taxPerc, 
      this.remarks, 
      this.createdBy, 
      this.createdOn, 
      this.changedBy, 
      this.changedOn, 
      this.weight, 
      this.isSR,});

  PosInvoiceDetail.fromJson(dynamic json) {
    orgId = json['OrgId'];
    orderNo = json['OrderNo'];
    slNo = json['SlNo'];
    productCode = json['ProductCode'];
    uOMName = json['UOMName'];
    isCredit = json['IsCredit'];
    productName = json['ProductName'];
    qty = json['Qty'];
    price = json['Price'];
    foc = json['Foc'];
    total = json['Total'];
    itemDiscount = json['ItemDiscount'];
    itemDiscountPerc = json['ItemDiscountPerc'];
    subTotal = json['SubTotal'];
    tax = json['Tax'];
    netTotal = json['NetTotal'];
    taxCode = json['TaxCode'];
    taxType = json['TaxType'];
    taxPerc = json['TaxPerc'];
    remarks = json['Remarks'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    changedBy = json['ChangedBy'];
    changedOn = json['ChangedOn'];
    weight = json['Weight'];
    isSR = json['IsSR'];
  }
  int? orgId;
  String? orderNo;
  int? slNo;
  String? productCode;
  String? uOMName;
  bool? isCredit;
  String? productName;
  int? qty;
  double? price;
  double? foc;
  double? total;
  double? itemDiscount;
  double? itemDiscountPerc;
  double? subTotal;
  double? tax;
  double? netTotal;
  int? taxCode;
  String? taxType;
  double? taxPerc;
  String? remarks;
  String? createdBy;
  String? createdOn;
  String? changedBy;
  String? changedOn;
  double? weight;
  bool? isSR;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = orgId;
    map['OrderNo'] = orderNo;
    map['SlNo'] = slNo;
    map['ProductCode'] = productCode;
    map['UOMName'] = uOMName;
    map['IsCredit'] = isCredit;
    map['ProductName'] = productName;
    map['Qty'] = qty;
    map['Price'] = price;
    map['Foc'] = foc;
    map['Total'] = total;
    map['ItemDiscount'] = itemDiscount;
    map['ItemDiscountPerc'] = itemDiscountPerc;
    map['SubTotal'] = subTotal;
    map['Tax'] = tax;
    map['NetTotal'] = netTotal;
    map['TaxCode'] = taxCode;
    map['TaxType'] = taxType;
    map['TaxPerc'] = taxPerc;
    map['Remarks'] = remarks;
    map['CreatedBy'] = createdBy;
    map['CreatedOn'] = createdOn;
    map['ChangedBy'] = changedBy;
    map['ChangedOn'] = changedOn;
    map['Weight'] = weight;
    map['IsSR'] = isSR;
    return map;
  }

}