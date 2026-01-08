import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get440_test_app/components/get440text.dart';
import 'package:get440_test_app/features/cart/provider/cart_provider.dart';
import 'package:get440_test_app/features/products/model/product.dart';
import 'package:get440_test_app/ui_store/app_colors.dart';
import 'package:get440_test_app/ui_store/spacing.dart';
import 'package:get440_test_app/components/get440button.dart';

class ViewProduct extends ConsumerWidget {
  final Product product;

  const ViewProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool inStock = product.stock > 0;
    final _ = ref.watch(cartProvider);

    bool inCart = ref.read(cartProvider.notifier).inCart(product.id);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.onPrimary,
        elevation: 0,
        title: const Get440text(
          text: "Product Details",
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: product.imageUrl,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const SizedBox(
                    height: 300,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 300,
                    color: Colors.grey[300],
                    child: const Icon(Icons.broken_image, size: 60),
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              Get440text(
                text: product.name,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  Get440text(
                    text: "\$${product.price.toStringAsFixed(2)}",
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: AppSpacing.lg),
                  Get440text(
                    text: inStock
                        ? "In Stock: ${product.stock}"
                        : "Out of Stock",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: inStock ? AppColors.secondary : Colors.red,
                  ),
                ],
              ),

              const SizedBox(height: AppSpacing.lg),
              Get440text(
                text:
                    "This is a premium quality ${product.name}. Perfect for your daily activities and casual style. Crafted with care and attention to detail.",
                fontSize: 14,
                color: AppColors.secondary,
              ),

              const SizedBox(height: AppSpacing.xl),

              inStock
                  ? Column(
                      children: [
                        Row(
                          children: [
                            Get440text(
                              text: "Quantity",
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(width: AppSpacing.md),
                            QuantitySelector(product: product),
                          ],
                        ),

                        const SizedBox(height: AppSpacing.xl),

                        Get440button(
                          color: inCart
                              ? AppColors.secondary
                              : AppColors.accent,
                          cta: inCart ? "In Cart" : "Add to Cart",
                          onPressed: () {
                            if (inCart) {
                              return;
                            }
                            ref.watch(cartProvider.notifier).addToCart(product);
                          },

                          isLoading: false,
                        ),
                      ],
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

class QuantitySelector extends ConsumerWidget {
  final Product product;

  const QuantitySelector({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final notifier = ref.read(cartProvider.notifier);

    final cartItem = cart.items[product.id];
    final quantity = cartItem?.quantity ?? 1;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            iconSize: 20,
            onPressed: quantity > 1
                ? () {
                    notifier.updateQuantity(product.id, quantity - 1);
                  }
                : null,
          ),
          Get440text(
            text: quantity.toString(),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          IconButton(
            icon: const Icon(Icons.add),
            iconSize: 20,
            onPressed: () {
              if (quantity < product.stock) {
                notifier.updateQuantity(product.id, quantity + 1);
              } else {
                const snackBar = SnackBar(
                  content: Text("Can't purchase more than items in stock"),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
          ),
        ],
      ),
    );
  }
}
