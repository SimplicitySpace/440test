import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_item.freezed.dart';

@freezed
abstract class OrderItem with _$OrderItem {
  const factory OrderItem({
    required String productId,
    required String name,
    required String imageUrl,
    required double price,
    required int quantity,
  }) = _OrderItem;

  const OrderItem._();

  double get totalPrice => price * quantity;
}
