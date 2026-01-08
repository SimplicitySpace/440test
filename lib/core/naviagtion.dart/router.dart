import 'package:flutter/material.dart';
import 'package:get440_test_app/components/get440text.dart';
import 'package:get440_test_app/features/cart/views/cart.dart';
import 'package:get440_test_app/features/orders/views/orders_page.dart';
import 'package:get440_test_app/features/home/views/home.dart';
import 'package:get440_test_app/features/products/model/product.dart';
import 'package:get440_test_app/features/products/views/view_product.dart';
import 'package:get440_test_app/features/splash/views/splash.dart';
import 'package:get440_test_app/ui_store/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:magicoon_icons/icon_data/magicoon_regular_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'home');
final _cartplaceNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'cart');
final _orderNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'order');

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    navigatorKey: rootNavigatorKey,

    redirect: (context, state) {
      return null;
    },

    routes: [
      // Outside routes
      GoRoute(path: '/splash', builder: (_, c_) => const Splash()),

      // StatefulShellRoute for bottom nav tabs with nested navigation
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          // Home branch
          StatefulShellBranch(
            navigatorKey: _homeNavigatorKey,
            routes: [
              GoRoute(
                path: '/home',
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: Home()),
                routes: [
                  GoRoute(
                    path: 'viewproduct',
                    builder: (context, state) {
                      final product = state.extra as Product;
                      return ViewProduct(product: product);
                    },
                  ),
                ],
              ),
            ],
          ),
          // Cart branch with subroute
          StatefulShellBranch(
            navigatorKey: _cartplaceNavigatorKey,
            routes: [
              GoRoute(
                path: '/cart',
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: Cart()),
                routes: [],
              ),
            ],
          ),

          // Orders branch
          StatefulShellBranch(
            navigatorKey: _orderNavigatorKey,
            routes: [
              GoRoute(
                path: '/orders',
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: OrdersPage()),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});

class ScaffoldWithNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavBar({required this.navigationShell, super.key});

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = navigationShell.currentIndex;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: SizedBox(
        child: Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            useLegacyColorScheme: false,
            enableFeedback: false,
            showUnselectedLabels: true,
            selectedFontSize: 10,
            currentIndex: currentIndex,
            onTap: _goBranch,
            items: [
              _navItem(MagicoonRegular.home, "Home", 0, currentIndex),
              _navItem(MagicoonRegular.shoppingBag, "Cart", 1, currentIndex),
              _navItem(MagicoonRegular.chartBar, "Orders", 2, currentIndex),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _navItem(
    IconData icon,
    String label,
    int index,
    int currentIndex,
  ) {
    bool isActive = currentIndex == index;
    return BottomNavigationBarItem(
      icon: Column(
        children: [
          Icon(
            icon,
            color: isActive ? AppColors.accent : const Color(0xff4D5054),
          ),
          const SizedBox(height: 2),
          Get440text(
            text: label,
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: isActive ? AppColors.accent : const Color(0xff4D5054),
          ),
          if (isActive)
            Container(width: 20, height: 2, color: AppColors.accent),
        ],
      ),
      label: "",
    );
  }
}
