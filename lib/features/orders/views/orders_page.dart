import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get440_test_app/components/get440text.dart';
import 'package:get440_test_app/features/orders/provider/order_provider.dart';
import 'package:get440_test_app/ui_store/spacing.dart';
import '../model/order.dart';

class OrdersPage extends ConsumerWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(ordersProvider);

    return Scaffold(
      appBar: AppBar(title: const Get440text(text: "My Orders")),
      body: orders.isEmpty
          ? const Center(child: Get440text(text: "No orders yet"))
          : ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: orders.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: AppSpacing.md),
              itemBuilder: (context, index) {
                final order = orders[index];

                return Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Get440text(
                              text: "Order #${order.id.substring(0, 8)}",
                              fontWeight: FontWeight.bold,
                            ),
                            _OrderStatusBadge(order.status),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: order.items.map((item) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: Get440text(
                                text: "${item.quantity} × ${item.name}",
                                fontSize: 14,
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Get440text(
                              text: "Total",
                              fontWeight: FontWeight.w600,
                            ),
                            Get440text(
                              text: "\$${order.totalAmount.toStringAsFixed(2)}",
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class _OrderStatusBadge extends StatelessWidget {
  final OrderStatus status;

  const _OrderStatusBadge(this.status);

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      OrderStatus.pending => Colors.orange,
      OrderStatus.processing => Colors.blue,
      OrderStatus.shipped => Colors.purple,
      OrderStatus.delivered => Colors.green,
      OrderStatus.cancelled => Colors.red,
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status.name.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}
