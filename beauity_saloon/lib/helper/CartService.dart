import 'dart:async';
import 'package:get/get.dart';
import '../model/ProductModel1.dart';

class CartService {
  List<Product> _cartItems = [];

  void addToCart({required Product product}) {
    // Check if the item is already in the cart
    var existingItem = _cartItems
        .firstWhereOrNull((item) => item.productCode == product.productCode);

    if (existingItem != null) {
      // If item exists, update the quantity
      //   existingItem.isSelected = true;
        existingItem.unitincrement();
    } else {
      // If item doesn't exist, add it to the cart
      // product.isSelected = true;
      product.unitincrement();
      _cartItems.add(product);
    }
    // Notify listeners that the cart has changed
    _cartChangeController.add(true);
  }

  void removeFromCart({required Product product}) {
    // Check if the item is already in the cart
    var existingItem = _cartItems
        .firstWhereOrNull((item) => item.productCode == product.productCode);

    if (existingItem != null) {
      // If item exists, update the quantity
      // if (isBox == true) {
      existingItem.unitdecrement();
      // existingItem.isSelected = false;
      // } else {
      //   existingItem.unitdecrement();
      // }
    }

    if (product.boxcount < 1 && product.unitcount < 1) {
      _cartItems.removeWhere((item) => item.productCode == product.productCode);
    }
    // Notify listeners that the cart has changed
    _cartChangeController.add(true);
  }

  List<Product> get cartItems => _cartItems;

  final _cartChangeController = StreamController<bool>.broadcast();

  Stream<bool> get cartChangeStream => _cartChangeController.stream;


  void clearCart() {
    _cartItems.clear();
    _cartChangeController.add(true);
  }

  void slectedProductClear({required Product product}) {
    _cartItems.removeWhere((item) => item.productCode == product.productCode);
    product.unitcount = 0;
    _cartChangeController.add(true);
    }

  // Dispose the stream controller
  void dispose() {
    _cartChangeController.close();
  }

}
