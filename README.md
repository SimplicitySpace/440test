Get440 Test App
Overview
This is a simple e-commerce demo application built with Flutter. It demonstrates core features like browsing products, managing a shopping cart, and placing/viewing orders. The app uses Riverpod for state management, GoRouter for navigation, and includes dummy data for products. It's designed as a minimal viable product (MVP) for a technical assessment, showcasing clean code, functionality, and thoughtful implementation.
Features

Splash Screen: Animated introduction with a "Take a Tour" button leading to the home page.
Home/Products Page: Displays a "Deal of the Day" product and a grid of other products, including images, names, prices, and stock availability.
Product Details: View detailed product info, adjust quantity, and add to cart.
Cart Page: View cart items, adjust quantities, remove items, and display total price. Includes a "Checkout" button to place an order.
Orders Page: Lists placed orders with ID, items, total price, and status (e.g., Pending, with color-coded badges).
Navigation: Bottom navigation bar for switching between Home, Cart, and Orders tabs, preserving state.
State Management: Uses Riverpod providers for cart and orders, ensuring reactive UI updates.
UI Enhancements: Cached network images, custom buttons/text components, and basic animations.

Tech Stack

Flutter SDK: ^3.0.0 (assumed; compatible with recent versions)
State Management: flutter_riverpod
Navigation: go_router
Icons: magicoon_icons
Image Caching: cached_network_image
Other: uuid for order IDs

Installation

Ensure you have Flutter installed (version 3.0+ recommended). Follow the official Flutter installation guide.

Install dependencies:textflutter pub get
Run the app:
For iOS: flutter run --release (requires Xcode)
For Android: flutter run --release (requires Android Studio/SDK)


lib/
├── components/         # Reusable UI widgets (e.g., Get440text, Get440button)
├── features/
│   ├── cart/           # Cart models, providers, views
│   ├── home/           # Home views and components
│   ├── orders/         # Orders models, providers, views
│   ├── products/       # Product models, data, views (e.g., ProductCard)
│   └── splash/         # Splash screen
├── ui_store/           # Shared styles (colors, spacing)
└── main.dart           # Entry point (not provided, but assumed to set up Riverpod and GoRouter)
assets/                 # Images (e.g., splash_hoodie.jpeg)
pubspec.yaml            # Dependencies and assets config



Limitations & Improvements

No real backend integration or data persistence (e.g., use Firebase or Hive for production).

Basic UI; add themes, accessibility, and tests for enhancement.
Potential enhancements: User authentication, payment gateway simulation, search/filter products
