import 'package:flutter/material.dart';

// Import layar pembeli
import 'screens/login_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/register_screen.dart';
import 'screens/menu_screen.dart';
import 'screens/account_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/favourites_screen.dart';
import 'screens/orders_screen.dart';
import 'screens/my_details_screen.dart';
import 'screens/delivery_address_screen.dart';
import 'screens/help_support_screen.dart';
import 'screens/category_screen.dart';

// Import layar admin (Pastikan namanya sudah huruf kecil semua!)
import 'screens/Admin/Admin_dasboard.dart';

import 'theme.dart';

void main() {
  runApp(const NestmartApp());
}

class NestmartApp extends StatelessWidget {
  const NestmartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Genshin Import',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,

      // Titik awal selalu di Login
      initialRoute: '/',

      routes: {
        // Rute Pembeli
        '/': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/menu': (context) => const MenuScreen(),
        '/account': (context) => const AccountScreen(),
        '/cart': (context) => CartScreen(),
        '/product': (context) => const ProductDetailScreen(),
        '/favourite': (context) => const FavouritesScreen(),
        '/orders': (context) => const OrdersScreen(),
        '/my_details': (context) => const MyDetailsScreen(),
        '/delivery_address': (context) => const DeliveryAddressScreen(),
        '/help_support': (context) => const HelpSupportScreen(),
        '/category': (context) => const CategoryScreen(),

        // Rute Admin
        '/admin': (context) => const AdminDashboardScreen(),
      },
    );
  }
}
