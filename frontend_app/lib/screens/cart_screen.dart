import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'checkout_screen.dart';
import 'product_detail_screen.dart';
import '../cart_state.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  static const Color primaryPurple = Color(0xFF5A4CA9);
  static const Color bgLightPurple = Color(0xFFECEAE6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgLightPurple,
      body: ValueListenableBuilder<List<Map<String, dynamic>>>(
        valueListenable: CartState.items,
        builder: (context, cartItems, child) {
          String totalPrice = CartState.calculateTotal();

          return SafeArea(
            child: Column(
              children: [
                // HEADER BAR
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color: primaryPurple,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Text(
                      'MY CART',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),

                // CEK JIKA KERANJANG KOSONG
                if (cartItems.isEmpty) ...[
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            LucideIcons.shoppingBag,
                            size: 80,
                            color: Colors.black26,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Keranjang kamu kosong!',
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Ayo cari item Genshin impianmu.',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: Colors.black45,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]
                // JIKA KERANJANG ADA ISINYA
                else ...[
                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      children: cartItems
                          .map((item) => _buildCartItem(context, item))
                          .toList(),
                    ),
                  ),

                  // BOTTOM SUMMARY & CHECKOUT
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(32),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'TOTAL (${cartItems.length} ITEMS)',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w900,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              totalPrice,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w900,
                                fontSize: 20,
                                color: primaryPurple,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: () {
                              // --- PERBAIKAN LOGIKA PENGIRIMAN DATA ---
                              // Mengambil gambar dari item pertama agar tidak error/kosong
                              final coverImage = cartItems.isNotEmpty
                                  ? cartItems[0]['image']
                                  : '';
                              // Jika hanya 1 barang, gunakan namanya. Jika lebih, tulis "Total X Barang"
                              final checkoutName = cartItems.length == 1
                                  ? cartItems[0]['name']
                                  : 'Total ${cartItems.length} Barang';
                              // Menghitung total kuantitas (pieces)
                              int totalQty = 0;
                              for (var i in cartItems) {
                                totalQty += (i['qty'] as int);
                              }

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CheckoutScreen(
                                    productName: checkoutName,
                                    price: totalPrice,
                                    imageUrl: coverImage,
                                    quantity: totalQty,
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryPurple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Text(
                              'CHECKOUT',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildCartItem(BuildContext context, Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProductDetailScreen(),
            settings: RouteSettings(
              arguments: {
                'id': item['id'],
                'name': item['name'],
                'price': item['price'],
                'image': item['image'],
              },
            ),
          ),
        );
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                color: bgLightPurple,
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: item['image'].startsWith('http')
                    ? Image.network(item['image'], fit: BoxFit.cover)
                    : Image.asset(
                        item['image'],
                        fit: BoxFit.cover,
                        errorBuilder: (c, e, s) => const Icon(Icons.image),
                      ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item['name'],
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w800,
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          CartState.removeFromCart(item['id']);
                        },
                        child: const Icon(
                          LucideIcons.trash2,
                          size: 16,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () =>
                                CartState.updateQuantity(item['id'], -1),
                            child: _qtyBtn(LucideIcons.minus),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              '${item['qty']}',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () =>
                                CartState.updateQuantity(item['id'], 1),
                            child: _qtyBtn(LucideIcons.plus),
                          ),
                        ],
                      ),
                      Text(
                        item['price'],
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w900,
                          color: primaryPurple,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _qtyBtn(IconData icon) {
    return Container(
      width: 26,
      height: 26,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(icon, size: 14),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.black12, width: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navTab(
            Icons.storefront_outlined,
            'Shop',
            false,
            () => Navigator.pushReplacementNamed(context, '/menu'),
          ),
          _navTab(Icons.manage_search, 'Kategori', false, () {}),
          _navTab(Icons.shopping_cart, 'Cart', true, () {}),
          _navTab(
            Icons.favorite_outline,
            'Favourite',
            false,
            () => Navigator.pushReplacementNamed(context, '/favourite'),
          ),
          _navTab(
            Icons.person_outline,
            'Account',
            false,
            () => Navigator.pushReplacementNamed(context, '/account'),
          ),
        ],
      ),
    );
  }

  Widget _navTab(IconData icon, String label, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: active ? primaryPurple : Colors.black45, size: 22),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 9,
              fontWeight: active ? FontWeight.w900 : FontWeight.w600,
              color: active ? primaryPurple : Colors.black45,
            ),
          ),
        ],
      ),
    );
  }
}
