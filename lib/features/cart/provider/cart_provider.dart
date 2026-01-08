import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get440_test_app/features/cart/model/cart_state.dart';
import 'package:get440_test_app/features/products/data/dummy_data.dart';

import '../model/cart_item.dart';
import 'package:get440_test_app/features/products/model/product.dart';

final cartProvider = NotifierProvider<CartNotifier, CartState>(
  CartNotifier.new,
);

class CartNotifier extends Notifier<CartState> {
  @override
  CartState build() {
    return const CartState();
  }

  void addToCart(Product product) {
    final items = Map<String, CartItem>.from(state.items);
    if (items.containsKey(product.id)) {
      items[product.id] = items[product.id]!.copyWith(
        quantity: items[product.id]!.quantity + 1,
      );
    } else {
      items[product.id] = CartItem(product: product);
    }

    state = state.copyWith(items: items);
  }

  bool inCart(String productId) {
    final items = Map<String, CartItem>.from(state.items);
    return items.containsKey(productId);
  }

  void updateQuantity(String productId, int quantity) {
    final items = Map<String, CartItem>.from(state.items);

    if (quantity <= 0) {
      items.remove(productId);
    } else {
      if (items[productId] == null) {
        addToCart(
          dummyProducts.firstWhere((product) => productId == product.id),
        );
        return;
      }
      items[productId] = items[productId]!.copyWith(quantity: quantity);
    }

    state = state.copyWith(items: items);
  }

  void removeItem(String productId) {
    final items = Map<String, CartItem>.from(state.items);
    items.remove(productId);
    state = state.copyWith(items: items);
  }

  void clearCart() {
    state = const CartState();
  }
}
