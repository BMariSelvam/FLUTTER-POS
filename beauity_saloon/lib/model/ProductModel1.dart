import 'package:flutter/material.dart';

class Product {
  Product({
    this.orgId,
    this.branchCode,
    this.code,
    this.name,
    this.productCode,
    this.productName,
    this.specification,
    this.category,
    this.subCategory,
    this.categoryName,
    this.subCategoryName,
    this.uom,
    this.uomName,
    this.pcsPerCarton,
    this.productType,
    this.brand,
    this.weight,
    this.unitCost,
    this.averageCost,
    this.pcsPrice,
    this.cartonPrice,
    this.barCode,
    this.displayOrder,
    this.isActive,
    this.isStock,
    this.createdBy,
    this.createdOn,
    this.changedBy,
    this.changedOn,
    this.sellingCost,
    this.sellingBoxCost,
    this.stockQty,
    this.stockBoxQty,
    this.stockPcsQty,
    this.salesAccount,
    this.inventoryAccount,
    this.cOGAccount,
    this.productImageString,
    this.productImage,
    this.createdOnString,
    this.changedOnString,
    this.supplierCode,
    this.supplierName,
    this.taxPerc,
    this.productBarcode,
    this.boxCount,
    this.productImgBase64String,
    this.productImageFileName,
    this.productImagePath,
    this.minSellingCost,
    this.minSellingBoxCost,
    this.tag,
    this.isWeight,
    this.pOSSellingPrice,
    this.uomPriceDetail,
    this.stockWQty,
    this.unitMarginPerc,
    this.boxMarginPerc,
    this.haveTransaction,
    this.ecommerceDetail,
  });

  Product.fromJson(dynamic? json, {bool forSharedPreference = false}) {
    orgId = json['OrgId'];
    branchCode = json['BranchCode'];
    code = json['Code'];
    name = json['Name'];
    productCode = json['ProductCode'];
    productName = json['ProductName'];
    specification = json['Specification'];
    category = json['Category'];
    subCategory = json['SubCategory'];
    categoryName = json['CategoryName'];
    subCategoryName = json['SubCategoryName'];
    uom = json['Uom'];
    uomName = json['UomName'];
    pcsPerCarton = json['PcsPerCarton'];
    productType = json['ProductType'];
    brand = json['Brand'];
    weight = json['Weight'];
    unitCost = json['UnitCost'];
    averageCost = json['AverageCost'];
    pcsPrice = json['PcsPrice'];
    cartonPrice = json['CartonPrice'];
    barCode = json['BarCode'];
    displayOrder = json['DisplayOrder'];
    isActive = json['IsActive'];
    isStock = json['IsStock'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    changedBy = json['ChangedBy'];
    changedOn = json['ChangedOn'];
    sellingCost = json['SellingCost'];
    sellingBoxCost = json['SellingBoxCost'];
    stockQty = json['StockQty'];
    stockBoxQty = json['StockBoxQty'];
    stockPcsQty = json['StockPcsQty'];
    salesAccount = json['SalesAccount'];
    inventoryAccount = json['InventoryAccount'];
    cOGAccount = json['COGAccount'];
    productImageString = json['ProductImageString'];
    productImage = json['ProductImage'];
    createdOnString = json['CreatedOnString'];
    changedOnString = json['ChangedOnString'];
    supplierCode = json['SupplierCode'];
    supplierName = json['SupplierName'];
    taxPerc = json['TaxPerc'];
    productBarcode = json['ProductBarcode'];
    boxCount = json['BoxCount'];
    productImgBase64String = json['ProductImg_Base64String'];
    productImageFileName = json['ProductImageFileName'];
    productImagePath = json['ProductImagePath'];
    minSellingCost = json['MinSellingCost'];
    minSellingBoxCost = json['MinSellingBoxCost'];
    tag = json['Tag'];
    isWeight = json['IsWeight'];
    uomPriceDetail = json['UomPriceDetail'];
    pOSSellingPrice = json['POSSellingPrice'];
    stockWQty = json['StockWQty'];
    unitMarginPerc = json['UnitMarginPerc'];
    boxMarginPerc = json['BoxMarginPerc'];
    haveTransaction = json['HaveTransaction'];
    ecommerceDetail = json['EcommerceDetail'];
    if (forSharedPreference == true) {
      boxcount = json['boxcount'];
      unitcount = json['unitcount'];
    }
  }

  int? orgId;
  dynamic? branchCode;
  String? code;
  String? name;
  String? productCode;
  String? productName;
  String? specification;
  String? category;
  dynamic? subCategory;
  String? categoryName;
  String? subCategoryName;
  String? uom;
  dynamic? uomName;
  int? pcsPerCarton;
  String? productType;
  String? brand;
  double? weight;
  double? unitCost;
  double? averageCost;
  double? pcsPrice;
  double? cartonPrice;
  String? barCode;
  int? displayOrder;
  bool? isActive;
  bool? isStock;
  String? createdBy;
  String? createdOn;
  String? changedBy;
  String? changedOn;
  double? sellingCost;
  double? sellingBoxCost;
  dynamic? stockQty;
  dynamic? stockBoxQty;
  dynamic? stockPcsQty;
  String? salesAccount;
  String? inventoryAccount;
  String? cOGAccount;
  dynamic? productImageString;
  dynamic? productImage;
  String? createdOnString;
  String? changedOnString;
  String? supplierCode;
  String? supplierName;
  double? taxPerc;
  dynamic? productBarcode;
  dynamic? boxCount;
  dynamic? productImgBase64String;
  String? productImageFileName;
  String? productImagePath;
  double? minSellingCost;
  double? minSellingBoxCost;
  dynamic? tag;
  double? pOSSellingPrice;
  bool? isWeight;
  dynamic? uomPriceDetail;
  dynamic? stockWQty;
  double? unitMarginPerc;
  double? boxMarginPerc;
  dynamic? haveTransaction;
  dynamic? ecommerceDetail;
  int? slNO = 1;

  bool isShowButtons = false;

  bool isSelected = false;

  int boxcount = 0;
  int unitcount = 0;

  TextEditingController unitcountController = TextEditingController();


  unitincrement() {
    unitcount++;
    unitcountController.text = unitcount.toInt().toString();
  }

  unitdecrement() {
    if (unitcount != 0) {
      unitcount--;
      unitcountController.text = unitcount.toInt().toString();
    }
  }



  Map<String, dynamic?> toJson({bool forSharedPreference = false}) {
    final map = <String, dynamic?>{};
    map['OrgId'] = orgId;
    map['BranchCode'] = branchCode;
    map['Code'] = code;
    map['Name'] = name;
    map['ProductCode'] = productCode;
    map['ProductName'] = productName;
    map['Specification'] = specification;
    map['Category'] = category;
    map['SubCategory'] = subCategory;
    map['CategoryName'] = categoryName;
    map['SubCategoryName'] = subCategoryName;
    map['Uom'] = uom;
    map['UomName'] = uomName;
    map['PcsPerCarton'] = pcsPerCarton;
    map['ProductType'] = productType;
    map['Brand'] = brand;
    map['Weight'] = weight;
    map['UnitCost'] = unitCost;
    map['AverageCost'] = averageCost;
    map['PcsPrice'] = pcsPrice;
    map['CartonPrice'] = cartonPrice;
    map['BarCode'] = barCode;
    map['DisplayOrder'] = displayOrder;
    map['IsActive'] = isActive;
    map['IsStock'] = isStock;
    map['CreatedBy'] = createdBy;
    map['CreatedOn'] = createdOn;
    map['ChangedBy'] = changedBy;
    map['ChangedOn'] = changedOn;
    map['SellingCost'] = sellingCost;
    map['SellingBoxCost'] = sellingBoxCost;
    map['StockQty'] = stockQty;
    map['StockBoxQty'] = stockBoxQty;
    map['StockPcsQty'] = stockPcsQty;
    map['SalesAccount'] = salesAccount;
    map['InventoryAccount'] = inventoryAccount;
    map['COGAccount'] = cOGAccount;
    map['ProductImageString'] = productImageString;
    map['ProductImage'] = productImage;
    map['CreatedOnString'] = createdOnString;
    map['ChangedOnString'] = changedOnString;
    map['SupplierCode'] = supplierCode;
    map['SupplierName'] = supplierName;
    map['TaxPerc'] = taxPerc;
    map['ProductBarcode'] = productBarcode;
    map['BoxCount'] = boxCount;
    map['ProductImg_Base64String'] = productImgBase64String;
    map['ProductImageFileName'] = productImageFileName;
    map['ProductImagePath'] = productImagePath;
    map['MinSellingCost'] = minSellingCost;
    map['MinSellingBoxCost'] = minSellingBoxCost;
    map['Tag'] = tag;
    map['IsWeight'] = isWeight;
    map['UomPriceDetail'] = uomPriceDetail;
    map['StockWQty'] = stockWQty;
    map['UnitMarginPerc'] = unitMarginPerc;
    map['POSSellingPrice'] = pOSSellingPrice;
    map['BoxMarginPerc'] = boxMarginPerc;
    map['HaveTransaction'] = haveTransaction;
    map['EcommerceDetail'] = ecommerceDetail;
    if (forSharedPreference == true) {
      map['boxcount'] = boxcount;
      map['unitcount'] = unitcount;
    }
    return map;
  }

  @override
  List<Object> get props => [];
}
