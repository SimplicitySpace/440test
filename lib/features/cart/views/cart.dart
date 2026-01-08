import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get440_test_app/components/get440button.dart';
import 'package:get440_test_app/components/get440text.dart';
import 'package:get440_test_app/features/orders/provider/order_provider.dart';
import 'package:get440_test_app/ui_store/spacing.dart';
import 'package:go_router/go_router.dart';
import '../provider/cart_provider.dart';

class Cart extends ConsumerWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final notifier = ref.read(cartProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Get440text(text: "Cart")),
      body: cart.cartItems.isEmpty
          ? const Center(child: Get440text(text: "Your cart is empty"))
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    itemCount: cart.cartItems.length,
                    separatorBuilder: (_, c_) =>
                        const SizedBox(height: AppSpacing.md),
                    itemBuilder: (context, index) {
                      final item = cart.cartItems[index];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(AppSpacing.md),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Get440text(
                                      text: item.product.name,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    const SizedBox(height: 4),
                                    Get440text(
                                      text:
                                          "\$${item.product.price.toStringAsFixed(2)}",
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () => notifier.updateQuantity(
                                      item.product.id,
                                      item.quantity - 1,
                                    ),
                                  ),
                                  Get440text(text: item.quantity.toString()),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () => notifier.updateQuantity(
                                      item.product.id,
                                      item.quantity + 1,
                                    ),
                                  ),
                                ],
                              ),

                              /// Remove
                              IconButton(
                                icon: const Icon(Icons.delete_outline),
                                onPressed: () =>
                                    notifier.removeItem(item.product.id),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Get440text(
                        text: "Total",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      Get440text(
                        text: "\$${cart.totalPrice.toStringAsFixed(2)}",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                        child: Column(
                          children: [const SizedBox(height: AppSpacing.md)],
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                  child: Get440button(
                    isLoading: false,
                    onPressed: () {
                      ref.read(ordersProvider.notifier).placeOrder(ref);

                      GoRouter.of(context).push("/orders");
                    },
                    cta: "Checkout",
                  ),
                ),
              ],
            ),
    );
  }
}
