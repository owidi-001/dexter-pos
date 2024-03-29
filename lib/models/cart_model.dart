import 'package:dexter/models/products_model.dart';

class CartItemModel {
  late final Product product;
  late final int quantity;

  CartItemModel({
    required this.product,
    required this.quantity,
  });

  CartItemModel copyWith({Product? product, int? quantity}) {
    return CartItemModel(
        product: product ?? this.product, quantity: quantity ?? this.quantity);
  }

  static Map<String, dynamic> toMap(CartItemModel item) {
    Map<String, dynamic> data = {
      "product": item.product.id,
      "quantity": item.quantity
    };

    return data;
  }
}
