import 'package:freezed_annotation/freezed_annotation.dart';
import '../model/cart_item.dart';

part 'cart_state.freezed.dart';

@freezed
abstract class CartState with _$CartState {
  const factory CartState({@Default({}) Map<String, CartItem> items}) =
      _CartState;

  const CartState._();

  List<CartItem> get cartItems => items.values.toList();

  double get totalPrice =>
      items.values.fold(0, (sum, item) => sum + item.totalPrice);
}
