import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../user_session.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  // Tema Warna
  static const Color primaryPurple = Color(0xFF5A4CA9);
  static const Color bgLightGrey = Color(
    0xFFF8F8F8,
  ); // Background abu-abu muda ala desain baru

  @override
  Widget build(BuildContext context) {
    final session = UserSession();

    return Scaffold(
      backgroundColor: bgLightGrey,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // ISI HALAMAN BISA DI-SCROLL
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 20.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1. HEADER TITLE
                      Text(
                        'Akun Saya',
                        style: GoogleFonts.inter(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // 2. KARTU PROFIL (Gaya Baru)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: primaryPurple,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: primaryPurple.withValues(alpha: 0.3),
                              blurRadius: 15,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 65,
                              height: 65,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(session.photoUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    session.name,
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    session.email,
                                    style: GoogleFonts.inter(
                                      color: Colors.white.withValues(
                                        alpha: 0.8,
                                      ),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // 3. MENU PENGATURAN AKUN
                      Text(
                        'PENGATURAN AKUN',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: Colors.black45,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.black12, width: 0.5),
                        ),
                        child: Column(
                          children: [
                            // FUNGSI ROUTE TETAP SAMA SEPERTI MILIK USER!
                            _buildMenuItem(
                              Icons.inventory_2_outlined,
                              'My Orders',
                              '/orders',
                            ),
                            _buildDivider(),
                            _buildMenuItem(
                              Icons.badge_outlined,
                              'My Details',
                              '/my_details',
                            ),
                            _buildDivider(),
                            _buildMenuItem(
                              Icons.location_on_outlined,
                              'Delivery Address',
                              '/delivery_address',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),

                      // 4. MENU BANTUAN
                      Text(
                        'BANTUAN',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: Colors.black45,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.black12, width: 0.5),
                        ),
                        child: Column(
                          children: [
                            _buildMenuItem(
                              Icons.contact_support_outlined,
                              'Help and Support',
                              '/help_support',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // 5. TOMBOL LOGOUT (Gaya Baru)
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () {
                            // Fungsi logout kembali ke halaman awal (route '/')
                            Navigator.pushReplacementNamed(context, '/');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFF0F0),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: const BorderSide(
                                color: Colors.redAccent,
                                width: 1,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.logout_rounded,
                                color: Colors.redAccent,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Keluar dari Akun',
                                style: GoogleFonts.inter(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),

            // BOTTOM NAVBAR (Dipertahankan)
            _buildBottomNav(context),
          ],
        ),
      ),
    );
  }

  // WIDGET ITEM MENU BERSERTA NAVIGASINYA
  Widget _buildMenuItem(IconData icon, String label, String route) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      borderRadius: BorderRadius.circular(24),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F1F5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: primaryPurple, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: Colors.black38),
          ],
        ),
      ),
    );
  }

  // WIDGET GARIS PEMISAH
  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Divider(height: 1, color: Colors.black12),
    );
  }

  // WIDGET BOTTOM NAVBAR ASLI MILIK USER
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
          _buildNavItem(Icons.storefront_outlined, 'Shop', false, '/menu'),
          _buildNavItem(Icons.manage_search, 'Kategori', false, '/category'),
          _buildNavItem(Icons.shopping_cart_outlined, 'Cart', false, '/cart'),
          _buildNavItem(
            Icons.favorite_outline,
            'Favourite',
            false,
            '/favourite',
          ),
          _buildNavItem(
            Icons.person,
            'Account',
            true,
            '',
          ), // Aktif di halaman ini
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool active, String route) {
    return GestureDetector(
      onTap: () => route.isNotEmpty
          ? Navigator.pushReplacementNamed(context, route)
          : null,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: active ? primaryPurple : Colors.black45, size: 22),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 9,
              fontWeight: FontWeight.w900,
              color: active ? primaryPurple : Colors.black45,
            ),
          ),
        ],
      ),
    );
  }
}
