import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../favorites_state.dart';
import 'checkout_screen.dart';
import '../cart_state.dart'; // Pastikan kamu sudah membuat file cart_state.dart

// ---> TAMBAHKAN IMPORT HALAMAN ULASAN DI SINI <---
import 'product_reviews_user_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;

  // Tema Warna Ungu Genshin
  static const Color primaryPurple = Color(0xFF5A4CA9);
  static const Color bgLightPurple = Color(0xFFECEAE6);

  // KAMUS DESKRIPSI (DATABASE LOKAL UNTUK HALAMAN DETAIL)
  final Map<String, String> itemDescriptions = {
    'w1':
        'Pedang iblis berwarna merah darah ini direplika dengan skala 1:1 (ukuran asli manusia), menjadikannya prop berukuran besar yang sangat mengesankan. Bilah panjangnya memancarkan gradasi warna merah gelap yang konon memiliki kesadarannya sendiri. Dibuat menggunakan paduan metal kokoh dan anti-karat, pedang berukuran masif ini sangat ideal sebagai centerpiece pajangan dinding kamar premium Anda atau andalan utama saat tampil di panggung cosplay.',
    'w2':
        'Pedang suci peninggalan ordo misterius di Fontaine yang direka ulang dalam ukuran raksasa dan detail presisi tinggi. Dengan skala besar menyerupai versi in-game, pedang ini memiliki bobot yang mantap berkat core besi di bagian dalamnya, serta berlapis material PVC tebal yang aman namun tetap kokoh. Lekukan dan ornamen emasnya dipahat dengan teliti, memberikan presensi mewah yang mendominasi ruangan.',
    'w3':
        'Busur raksasa nan elegan peninggalan seorang miko legendaris dari Inazuma. Jangan tertipu oleh desain indahnya, busur ini memiliki rentang sayap yang sangat lebar, dibuat proporsional untuk karakter dewasa seukuran manusia asli. Dilengkapi dengan replika anak panah dekorasi tunggal, busur berukuran besar ini adalah penyempurna mutlak untuk kebutuhan properti cosplay Yoimiya atau sekadar pajangan epik.',
    'w4':
        'Tombak legendaris dari Liyue ini hadir dengan panjang total mencapai hampir 2 meter, memberikan presensi yang luar biasa nyata dan mengintimidasi. Ujung tombaknya didesain memancarkan gradasi hijau zamrud yang seolah menyimpan energi kuno para Yaksha. Dibuat dari tiang metal ringan namun sangat kokoh, senjata berskala raksasa ini memastikan Anda menjadi pusat perhatian di setiap event.',
    'w5':
        'Katana pusaka mahakarya dari klan Amenoma di Inazuma. Walaupun berwujud katana tradisional, pedang ini ditempa dengan ukuran panjang ekstra (skala 1:1 seukuran katana tempur asli Jepang), lengkap dengan sarung (saya) berornamen indah yang tebal. Bilahnya dirancang memantulkan cahaya dengan sempurna, menghadirkan nuansa samurai sejati yang tajam, besar, dan elegan.',
    'w6':
        'Mahakarya claymore raksasa peninggalan sang Ksatria Serigala (Boreas). Ini adalah senjata terbesar dan paling masif di katalog kami, dengan bilah super lebar dan tebal yang membutuhkan dua tangan untuk diangkat secara stabil. Dicetak dengan detail ukiran batu retak kemerahan yang menyala-nyala, replika kolosal ini memancarkan aura dominasi mutlak bagi para kolektor senjata kelas berat.',
    'w7':
        'Replika mahakarya A Thousand Floating Dreams berskala 1:1 yang sangat memukau. Catalyst berbentuk lampu poci ajaib bernuansa dedaunan dan emas ini direka ulang dengan ukuran masif yang pas untuk digenggam dengan dua tangan. Inti hijaunya terbuat dari material akrilik khusus yang memancarkan cahaya LED lembut, melambangkan kebijaksanaan sang Dendro Archon. Dibuat dari paduan resin premium yang kokoh, properti megah ini adalah penyempurna absolut untuk cosplay Nahida Anda atau sebagai lampu pajangan estetik nan mewah di meja koleksi.',
    'w8':
        'Mahakarya claymore raksasa peninggalan sang Ksatria Serigala (Boreas). Ini adalah senjata terbesar dan paling masif di katalog kami, dengan bilah super lebar dan tebal yang membutuhkan dua tangan untuk diangkat secara stabil. Dicetak dengan detail ukiran batu retak kemerahan yang menyala-nyala, replika kolosal ini memancarkan aura dominasi mutlak bagi para kolektor senjata kelas berat.',
    'w9':
        'Sacrificer\'s Staff berskala 1:1 yang memukau dengan desain perak elegan dan inti kristal biru bersinar. Prop berukuran raksasa ini direplika dengan material metal dan PVC kokoh, memberikan bobot realistis saat digenggam. Detail mistis pada bilahnya memancarkan nuansa kuno dari waktu yang membeku, menjadikannya pilihan sempurna untuk melengkapi kostum cosplay epik Anda atau sebagai barang pameran premium di kamar.',
    'w10':
        'Replika mahakarya senjata bintang 5 berskala 1:1 (ukuran asli manusia) yang dirancang dengan tingkat presisi dan detail luar biasa tinggi mendekati versi in-game. Properti berukuran masif ini memadukan material premium yang tebal, kokoh, namun tetap memiliki distribusi bobot yang seimbang sehingga sangat nyaman saat digenggam dengan kedua tangan. Lapisan cat berkualitas tinggi memberikan efek kilau metalik dan gradasi warna yang menawan, menjadikannya senjata andalan yang sangat megah untuk panggung cosplay Anda sekaligus centerpiece koleksi pajangan paling mewah di dalam kamar.',
    'w11':
        'Replika mahakarya senjata bintang 5 berskala 1:1 (ukuran asli manusia) yang dirancang dengan tingkat presisi dan detail luar biasa tinggi mendekati versi in-game. Properti berukuran masif ini memadukan material premium yang tebal, kokoh, namun tetap memiliki distribusi bobot yang seimbang sehingga sangat nyaman saat digenggam dengan kedua tangan. Lapisan cat berkualitas tinggi memberikan efek kilau metalik dan gradasi warna yang menawan, menjadikannya senjata andalan yang sangat megah untuk panggung cosplay Anda sekaligus centerpiece koleksi pajangan paling mewah di dalam kamar.',
    'w12':
        'Replika mahakarya Memory of Dust berskala 1:1 yang memancarkan keagungan elemen Geo. Untuk mereplikasi wujud in-game yang mengambang, kubus geometris berukuran masif ini dilengkapi dengan penyangga akrilik transparan tebal yang menciptakan ilusi melayang sempurna. Dibuat dari material resin premium dengan corak emas khas Liyue yang sangat detail, bagian intinya dilengkapi sistem LED kuning keemasan yang memberikan pendaran mistis menawan. Properti berbobot mantap ini adalah penyempurna mutlak untuk kemewahan cosplay Ningguang sang Tianquan, sekaligus menjadi lampu pajangan paling elegan di ruang kerja Anda.',
    'w13':
        'Replika mahakarya Memory of Dust berskala 1:1 yang memancarkan keagungan elemen Geo. Untuk mereplikasi wujud in-game yang mengambang, kubus geometris berukuran masif ini dilengkapi dengan penyangga akrilik transparan tebal yang menciptakan ilusi melayang sempurna. Dibuat dari material resin premium dengan corak emas khas Liyue yang sangat detail, bagian intinya dilengkapi sistem LED kuning keemasan yang memberikan pendaran mistis menawan. Properti berbobot mantap ini adalah penyempurna mutlak untuk kemewahan cosplay Ningguang sang Tianquan, sekaligus menjadi lampu pajangan paling elegan di ruang kerja Anda.',
    'w14':
        'Replika pusaka legendaris berskala penuh 1:1 dengan ukuran megah nan menjulang tinggi hingga melebihi 2 meter (melebihi postur tubuh manusia dewasa). Senjata jenis polearm ini ditempa menggunakan inti logam tebal berkekuatan tinggi yang dilapisi material khusus tahan benturan, memastikan bilah utamanya tetap kokoh, lurus, dan tidak mudah bengkok. Setiap lekukan ornamen mistisnya dipahat secara sangat presisi dengan finishing cat metalik bergradasi tajam yang memukau. Skalanya yang luar biasa besar memberikan presensi yang sangat gagah dan berwibawa saat digenggam, menjadikannya properti cosplay tingkat sultan yang siap mendominasi panggung event sekaligus menjadi centerpiece pajangan paling mewah di dinding kamar Anda.',
    'a1':
        'Replika fisik dari artefak Flower of Life (set Crimson Witch of Flames). Tidak sekadar bunga biasa, artefak ini direka ulang menjadi bros dekoratif berukuran cukup besar yang eye-catching. Kelopaknya dibentuk dari campuran material resin tahan banting, bertatahkan permata akrilik merah menyala di tengahnya yang seolah memendam bara api abadi.',
    'a2':
        'Replika mahakarya jam pasir Sands of Eon berskala realistik yang dirancang sangat tebal dan berat. Di dalamnya berisi pasir luminous khusus berwarna jingga kemerahan yang perlahan jatuh memutar waktu, serta mampu menyala terang dalam gelap (Glow in the Dark). Tabung kacanya dilindungi oleh bingkai metalik hitam elegan bergaya gothic, sangat memukau di atas meja kerja Anda.',
    'a3':
        'Cawan mewah peninggalan sang gladiator legendaris yang kini terlahir kembali. Direplika menjadi cawan besar (goblet) berkapasitas 400ml, terbuat dari paduan stainless steel berlapis warna emas food-grade berkualitas tinggi. Hiasan permata sintetis merah darah mengelilingi permukaannya. Tidak hanya megah sebagai pajangan, cawan berukuran mantap ini 100% fungsional untuk menemani waktu santai Anda.',
  };

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

    // MENGAMBIL DESKRIPSI BERDASARKAN ID
    final String description =
        itemDescriptions[id] ??
        'Senjata bintang 5 eksklusif edisi Genshin Import. Sangat cocok dijadikan sebagai pajangan koleksi premium di kamar Anda, ataupun digunakan sebagai pelengkap cosplay untuk event jejepangan.';

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
                // 1. Top Image Card
                Container(
                  width: double.infinity,
                  height: 310,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F0ED),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Stack(
                    children: [
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

                // 2. Product Name and Favourites row
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
                      ValueListenableBuilder<List<Map<String, dynamic>>>(
                        valueListenable: FavoritesState.items,
                        builder: (context, favItems, child) {
                          // Mengecek apakah produk di-like menggunakan fungsi baru
                          final isFav = FavoritesState.isFavorite(id);

                          return GestureDetector(
                            onTap: () {
                              // Mengirim data Map utuh, bukan cuma 'id'
                              FavoritesState.toggleFavorite({
                                'id': id,
                                'name': name,
                                'price': price,
                                'image': image,
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Icon(
                                isFav
                                    ? Icons.favorite
                                    : Icons.favorite_border_rounded,
                                color: isFav ? Colors.red : Colors.black,
                                size: 26,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),

                // 3. Price
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
                const SizedBox(height: 8),

                // ==============================================================
                // 4. Yellow Stars Rating (SEKARANG BISA DIKLIK MENUJU ULASAN)
                // ==============================================================
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: GestureDetector(
                    onTap: () {
                      // Pindah ke Halaman Ulasan saat bintang diklik
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductReviewsUserScreen(
                            productName:
                                name, // Mengirim nama produk agar sesuai
                          ),
                        ),
                      );
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Row(
                      mainAxisSize:
                          MainAxisSize.min, // Agar klik hanya di area bintang
                      children: [
                        Row(
                          children: List.generate(5, (starIdx) {
                            return const Icon(
                              Icons.star_rounded,
                              color: Color(0xFFFFB300),
                              size: 19,
                            );
                          }),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          rating.toStringAsFixed(1),
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 4),
                        // Tambahan Icon Panah Kecil agar terlihat bisa diklik
                        const Icon(
                          Icons.chevron_right_rounded,
                          size: 18,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 18),

                // 5. White Rounded floated description and checkout card
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

                      // --- BAGIAN KONTROL & TOMBOL BAWAH ---
                      Row(
                        children: [
                          // Quantity controls (+ / -)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE2DFDC),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (_quantity > 1) {
                                      setState(() => _quantity--);
                                    }
                                  },
                                  behavior: HitTestBehavior.opaque,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                      vertical: 2.0,
                                    ),
                                    child: Text(
                                      '-',
                                      style: GoogleFonts.inter(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                  ),
                                  child: Text(
                                    '$_quantity',
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 14.5,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() => _quantity++);
                                  },
                                  behavior: HitTestBehavior.opaque,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                      vertical: 2.0,
                                    ),
                                    child: Text(
                                      '+',
                                      style: GoogleFonts.inter(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 14),

                          // --- TOMBOL TAMBAH KE KERANJANG (IconButton WAJIB ada onPressed) ---
                          Container(
                            height: 52,
                            width: 52,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: primaryPurple,
                                width: 2,
                              ),
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.add_shopping_cart_rounded,
                                color: primaryPurple,
                              ),
                              onPressed: () {
                                // Fungsi saat tombol diklik
                                CartState.addToCart(
                                  id,
                                  name,
                                  price,
                                  image,
                                  _quantity,
                                );

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      '$_quantity unit $name berhasil masuk ke keranjang!',
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    backgroundColor: Colors.green,
                                    duration: const Duration(seconds: 1),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 10),

                          // --- TOMBOL CHECKOUT (ElevatedButton WAJIB ada onPressed) ---
                          Expanded(
                            child: Container(
                              height: 52,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: primaryPurple.withOpacity(0.24),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  // 1. HAPUS SEMUA HURUF UNTUK MENGAMBIL ANGKA SAJA (Contoh: "Rp 300.000" jadi "300000")
                                  String rawPrice = price.replaceAll(
                                    RegExp(r'[^0-9]'),
                                    '',
                                  );
                                  double priceVal =
                                      double.tryParse(rawPrice) ?? 0;

                                  // 2. KALIKAN HARGA DENGAN JUMLAH BARANG
                                  double total = priceVal * _quantity;

                                  // 3. FORMAT KEMBALI MENJADI RUPIAH (Contoh: 600000 jadi "Rp 600.000")
                                  String formattedTotal =
                                      'Rp ${total.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';

                                  // 4. KIRIM HARGA YANG SUDAH DIHITUNG KE CHECKOUT SCREEN
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CheckoutScreen(
                                        productName: name,
                                        price:
                                            formattedTotal, // <--- KITA GUNAKAN HARGA HASIL KALI DI SINI
                                        imageUrl: image,
                                        quantity: _quantity,
                                      ),
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
                                  'BELI',
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 15,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
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
        ),
      ),
    );
  }

  Widget _buildProductImage(String imagePath) {
    if (imagePath.startsWith('http')) {
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
    } else {
      return Image.asset(
        imagePath,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.broken_image, size: 64, color: Colors.black26),
      );
    }
  }
}
