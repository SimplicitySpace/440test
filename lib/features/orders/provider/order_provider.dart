import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../model/order.dart';
import '../model/order_item.dart';
import '../../cart/provider/cart_provider.dart';

final ordersProvider = NotifierProvider<OrdersNotifier, List<Order>>(
  OrdersNotifier.new,
);

class OrdersNotifier extends Notifier<List<Order>> {
  final _uuid = const Uuid();

  @override
  List<Order> build() => [];

  void placeOrder(WidgetRef ref) {
    final cart = ref.read(cartProvider);

    if (cart.items.isEmpty) return;

    final items = cart.items.values.map((cartItem) {
      return OrderItem(
        productId: cartItem.product.id,
        name: cartItem.product.name,
        imageUrl: cartItem.product.imageUrl,
        price: cartItem.product.price,
        quantity: cartItem.quantity,
      );
    }).toList();

    final order = Order(
      id: _uuid.v4(),
      createdAt: DateTime.now(),
      items: items,
      totalAmount: cart.totalPrice,
    );

    state = [order, ...state];
    ref.read(cartProvider.notifier).clearCart();
  }

  void updateStatus(String orderId, OrderStatus status) {
    state = [
      for (final order in state)
        if (order.id == orderId) order.copyWith(status: status) else order,
    ];
  }
}
