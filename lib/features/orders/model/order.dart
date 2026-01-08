import 'package:freezed_annotation/freezed_annotation.dart';
import 'order_item.dart';

part 'order.freezed.dart';

enum OrderStatus { pending, processing, shipped, delivered, cancelled }

@freezed
abstract class Order with _$Order {
  const factory Order({
    required String id,
    required DateTime createdAt,
    required List<OrderItem> items,
    required double totalAmount,
    @Default(OrderStatus.pending) OrderStatus status,
  }) = _Order;

  const Order._();
}
