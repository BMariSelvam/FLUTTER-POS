import 'PosInvoiceDetail.dart';

class GetPrintPreviewModel {
  GetPrintPreviewModel({
      this.orgId, 
      this.brachCode, 
      this.cashRegisterCode, 
      this.orderNo, 
      this.orderDateString, 
      this.orderDate, 
      this.isCredit, 
      this.customerId, 
      this.customerName, 
      this.taxCode, 
      this.taxType, 
      this.taxPerc, 
      this.currencyCode, 
      this.currencyRate, 
      this.total, 
      this.billDiscount, 
      this.billDiscountPerc, 
      this.subTotal, 
      this.tax, 
      this.netTotal, 
      this.remarks, 
      this.isActive, 
      this.isUpdate, 
      this.createdBy, 
      this.createdOn, 
      this.changedBy, 
      this.changedOn, 
      this.pOSInvoiceDetail,});

  GetPrintPreviewModel.fromJson(dynamic json) {
    orgId = json['OrgId'];
    brachCode = json['BrachCode'];
    cashRegisterCode = json['CashRegisterCode'];
    orderNo = json['OrderNo'];
    orderDateString = json['OrderDateString'];
    orderDate = json['OrderDate'];
    isCredit = json['IsCredit'];
    customerId = json['CustomerId'];
    customerName = json['CustomerName'];
    taxCode = json['TaxCode'];
    taxType = json['TaxType'];
    taxPerc = json['TaxPerc'];
    currencyCode = json['CurrencyCode'];
    currencyRate = json['CurrencyRate'];
    total = json['Total'];
    billDiscount = json['BillDiscount'];
    billDiscountPerc = json['BillDiscountPerc'];
    subTotal = json['SubTotal'];
    tax = json['Tax'];
    netTotal = json['NetTotal'];
    remarks = json['Remarks'];
    isActive = json['IsActive'];
    isUpdate = json['IsUpdate'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    changedBy = json['ChangedBy'];
    changedOn = json['ChangedOn'];
    if (json['POSInvoiceDetail'] != null) {
      pOSInvoiceDetail = [];
      json['POSInvoiceDetail'].forEach((v) {
        pOSInvoiceDetail?.add(GetPosInvoiceDetail.fromJson(v));
      });
    }
  }
  int? orgId;
  String? brachCode;
  String? cashRegisterCode;
  String? orderNo;
  dynamic orderDateString;
  String? orderDate;
  bool? isCredit;
  String? customerId;
  String? customerName;
  int? taxCode;
  String? taxType;
  dynamic taxPerc;
  String? currencyCode;
  double? currencyRate;
  double? total;
  double? billDiscount;
  double? billDiscountPerc;
  double? subTotal;
  double? tax;
  double? netTotal;
  String? remarks;
  bool? isActive;
  bool? isUpdate;
  String? createdBy;
  String? createdOn;
  String? changedBy;
  String? changedOn;
  List<GetPosInvoiceDetail>? pOSInvoiceDetail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = orgId;
    map['BrachCode'] = brachCode;
    map['CashRegisterCode'] = cashRegisterCode;
    map['OrderNo'] = orderNo;
    map['OrderDateString'] = orderDateString;
    map['OrderDate'] = orderDate;
    map['IsCredit'] = isCredit;
    map['CustomerId'] = customerId;
    map['CustomerName'] = customerName;
    map['TaxCode'] = taxCode;
    map['TaxType'] = taxType;
    map['TaxPerc'] = taxPerc;
    map['CurrencyCode'] = currencyCode;
    map['CurrencyRate'] = currencyRate;
    map['Total'] = total;
    map['BillDiscount'] = billDiscount;
    map['BillDiscountPerc'] = billDiscountPerc;
    map['SubTotal'] = subTotal;
    map['Tax'] = tax;
    map['NetTotal'] = netTotal;
    map['Remarks'] = remarks;
    map['IsActive'] = isActive;
    map['IsUpdate'] = isUpdate;
    map['CreatedBy'] = createdBy;
    map['CreatedOn'] = createdOn;
    map['ChangedBy'] = changedBy;
    map['ChangedOn'] = changedOn;
    if (pOSInvoiceDetail != null) {
      map['POSInvoiceDetail'] = pOSInvoiceDetail?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}