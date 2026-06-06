import 'dart:io'; // ---> TAMBAHAN PENTING UNTUK BACA GAMBAR GALERI <---
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Jika Anda sudah memiliki file AddEditWeaponScreen, pastikan di-import di sini
// import 'add_deleted_edit_weapon_screen.dart';

// ---> TAMBAHKAN IMPORT HALAMAN REVIEW ADMIN DI SINI <---
import 'admin_reviews_screen.dart';

class ProductDetailAdminScreen extends StatefulWidget {
  const ProductDetailAdminScreen({super.key});

  @override
  State<ProductDetailAdminScreen> createState() =>
      _ProductDetailAdminScreenState();
}

class _ProductDetailAdminScreenState extends State<ProductDetailAdminScreen> {
  // Tema Warna Ungu Genshin
  static const Color primaryPurple = Color(0xFF5A4CA9);
  static const Color bgLightPurple = Color(0xFFECEAE6);

  // ===========================================================================
  // KAMUS DESKRIPSI PRODUK (DATABASE LOKAL)
  // ===========================================================================
  final Map<String, String> itemDescriptions = {
    'w1':
        'Pedang iblis berwarna merah darah ini direplika dengan skala 1:1, menjadikannya prop berukuran besar yang sangat mengesankan. Bilah panjangnya memancarkan gradasi warna merah gelap yang konon memiliki kesadarannya sendiri. Dibuat menggunakan paduan metal kokoh dan anti-karat, pedang ini ideal sebagai pajangan dinding premium atau andalan saat tampil cosplay menjadi Kaedehara Kazuha.',
    'w2':
        'Pedang suci peninggalan ordo misterius di Fontaine yang direka ulang dalam detail presisi tinggi. Dengan warna biru sapphire yang elegan dipadukan dengan aksen emas, pedang ini memiliki bobot yang mantap berkat core besi di bagian dalamnya. Lekukan ornamennya dipahat dengan teliti, memberikan presensi mewah yang mendominasi ruangan.',
    'w3':
        'Busur raksasa nan elegan peninggalan seorang miko legendaris. Desainnya yang asimetris khas Inazuma dibuat proporsional untuk ukuran manusia asli. Terbuat dari material PVC berkualitas tinggi dengan *finishing* cat semi-glossy, busur ini adalah penyempurna mutlak untuk kebutuhan properti cosplay Yoimiya atau sekadar pajangan epik.',
    'w4':
        'Tombak legendaris dari Liyue ini hadir dengan panjang total mencapai 2 meter, memberikan presensi yang luar biasa nyata. Ujung tombaknya didesain memancarkan gradasi hijau zamrud yang seolah menyimpan energi Adeptus kuno. Dibuat dari tiang metal ringan namun kokoh, senjata ini memastikan Anda menjadi pusat perhatian di setiap event.',
    'w5':
        'Katana pusaka mahakarya dari klan Amenoma di Inazuma. Bilahnya ditempa dengan detail hamon (pola asah) yang realistis, lengkap dengan sarung (saya) berornamen indah. Walaupun terlihat tajam, bilah terbuat dari material tumpul yang aman untuk *convention*. Menghadirkan nuansa samurai sejati yang elegan dan mematikan.',
    'w6':
        'Claymore raksasa peninggalan sang Ksatria Serigala. Ini adalah senjata terbesar dan paling masif di katalog kami, dengan bilah super lebar yang membutuhkan dua tangan untuk diangkat secara stabil. Dicetak dengan detail ukiran batu retak kemerahan yang menyala, replika ini memancarkan aura dominasi mutlak bagi para kolektor senjata kelas berat.',
  };
  // ===========================================================================

  @override
  Widget build(BuildContext context) {
    // MENANGKAP ARGUMEN DARI NAVIGATION
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final String id = args?['id'] ?? 'w1';
    final String name = args?['name'] ?? 'Kagotsurube Isshin';
    final String price = args?['price'] ?? 'Rp 300.000';
    final double rating = args?['rating']?.toDouble() ?? 5.0;
    final String image = args?['image'] ?? 'assets/images/Kagotsurube.png';

    // =====================================================
    // PERBAIKAN: TANGKAP DESKRIPSI DARI HALAMAN SEBELUMNYA
    // =====================================================
    final String description =
        args?['description'] ?? // Cek dari inputan baru dulu
        itemDescriptions[id] ?? // Kalau kosong, cek database lokal
        'Senjata bintang 5 eksklusif edisi Genshin Import. Sangat cocok dijadikan sebagai pajangan koleksi premium di kamar Anda, ataupun digunakan sebagai pelengkap cosplay untuk event jejepangan.'; // Teks default

    return Scaffold(
      backgroundColor: bgLightPurple,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. TOP IMAGE CARD
                Container(
                  width: double.infinity,
                  height: 310,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F0ED),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Stack(
                    children: [
                      // TOMBOL BACK (Kiri Atas)
                      Positioned(
                        top: 14,
                        left: 14,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          behavior: HitTestBehavior.opaque,
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.arrow_back_rounded,
                              color: Colors.black,
                              size: 26,
                            ),
                          ),
                        ),
                      ),

                      // =====================================================
                      // TOMBOL HAMBURGER MENU (Kanan Atas)
                      // =====================================================
                      Positioned(
                        top: 14,
                        right: 14,
                        child: PopupMenuButton<String>(
                          offset: const Offset(0, 45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          icon: const Icon(
                            Icons.more_vert_rounded,
                            color: Colors.black,
                            size: 28,
                          ),
                          onSelected: (String value) {
                            if (value == 'edit') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Beralih ke halaman Edit Produk...',
                                  ),
                                ),
                              );
                            } else if (value == 'delete') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Produk berhasil dihapus'),
                                ),
                              );
                            }
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                                PopupMenuItem<String>(
                                  value: 'edit',
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.edit_outlined,
                                        color: Colors.black87,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        'Edit Produk',
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const PopupMenuDivider(),
                                PopupMenuItem<String>(
                                  value: 'delete',
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.delete_outline,
                                        color: Colors.red,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        'Hapus Produk',
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                        ),
                      ),
                      // =====================================================

                      // GAMBAR PRODUK
                      Positioned.fill(
                        top: 45,
                        bottom: 40,
                        left: 20,
                        right: 20,
                        child: Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: _buildProductImage(image),
                          ),
                        ),
                      ),

                      // DOTS INDICATOR
                      Positioned(
                        bottom: 18,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(4, (index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 4.5,
                              ),
                              width: 7,
                              height: 7,
                              decoration: BoxDecoration(
                                color: index == 0
                                    ? primaryPurple
                                    : const Color(0xFFC4BDB5),
                                shape: BoxShape.circle,
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),

                // 2. PRODUCT NAME
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          name.toUpperCase(),
                          style: GoogleFonts.inter(
                            fontSize: 21,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                            letterSpacing: 0.1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),

                // 3. PRICE
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Text(
                    price,
                    style: GoogleFonts.inter(
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                      color: primaryPurple,
                    ),
                  ),
                ),
                const SizedBox(height: 18),

                // 4. DESKRIPSI & PANEL INFO ADMIN BAWAH
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 24.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'DESKRIPSI',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w900,
                          fontSize: 13,
                          letterSpacing: 0.2,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        description,
                        style: GoogleFonts.inter(
                          color: Colors.black.withOpacity(0.85),
                          fontSize: 12.5,
                          height: 1.6,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // =====================================================
                      // PENGGANTI TOMBOL BELI -> PANEL STATISTIK ADMIN
                      // =====================================================
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: const Color(
                            0xFFF2F0ED,
                          ), // Background abu-abu muda lembut
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // KOLOM RATING
                            Column(
                              children: [
                                Text(
                                  'RATING PRODUK',
                                  style: GoogleFonts.inter(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black54,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.star_rounded,
                                      color: Color(0xFFFFB300),
                                      size: 22,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      rating.toStringAsFixed(1),
                                      style: GoogleFonts.inter(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            // GARIS PEMISAH TENGAH
                            Container(
                              width: 2,
                              height: 35,
                              color: Colors.black12,
                            ),

                            // KOLOM JUMLAH TERJUAL
                            Column(
                              children: [
                                Text(
                                  'TOTAL TERJUAL',
                                  style: GoogleFonts.inter(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black54,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  '150 Pcs', // Anda bisa membuat ini dinamis nanti
                                  style: GoogleFonts.inter(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // =====================================================
                      const SizedBox(height: 24), // Spasi ke tombol baru
                      // =====================================================
                      // TOMBOL BARU: LIHAT ULASAN DARI USER
                      // =====================================================
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () {
                            // ---> NAVIGASI KE HALAMAN ADMIN REVIEW DISINI <---
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const AdminReviewsScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryPurple,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: Text(
                            'LIHAT ULASAN',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 14,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                      // =====================================================
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // =====================================================
  // PERBAIKAN: WIDGET BANTUAN UNTUK GAMBAR (SUPPORT GALERI)
  // =====================================================
  Widget _buildProductImage(String imagePath) {
    if (imagePath.isEmpty) {
      return const Icon(Icons.broken_image, size: 64, color: Colors.black26);
    }

    // Jika gambar diambil dari memori HP / Galeri
    if (imagePath.startsWith('/data') || imagePath.startsWith('/storage')) {
      return Image.file(
        File(imagePath),
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.broken_image, size: 64, color: Colors.black26),
      );
    }
    // Jika gambar dari Internet
    else if (imagePath.startsWith('http')) {
      return Image.network(
        imagePath,
        fit: BoxFit.contain,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(
            child: CircularProgressIndicator(color: primaryPurple),
          );
        },
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.broken_image, size: 64, color: Colors.black26),
      );
    }
    // Jika gambar dari folder assets project
    else {
      return Image.asset(
        imagePath,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.broken_image, size: 64, color: Colors.black26),
      );
    }
  }
}
