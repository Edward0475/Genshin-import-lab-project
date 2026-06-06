import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../favorites_state.dart';
// ---> PASTIKAN IMPORT INI SESUAI DENGAN LOKASI FILE SEARCH SCREEN-MU <---
import 'search_screen.dart';
import 'customer_notification_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ==========================================
    // 1. DAFTAR KATEGORI MENGGUNAKAN GAMBAR
    // ==========================================
    final categories = [
      {'name': 'Bow', 'image': 'assets/images/Bow.png'},
      {'name': 'Claymore', 'image': 'assets/images/claymore.png'},
      {'name': 'Sword', 'image': 'assets/images/sword.png'},
      {'name': 'Catalyst', 'image': 'assets/images/catalyst.png'},
      {'name': 'Polearm', 'image': 'assets/images/poleyean.png'},
      {'name': 'Artifacts', 'image': 'assets/images/Artifact.png'},
    ];

    // Daftar semua senjata dengan path folder images lokal
    final weapons = [
      {
        'id': 'w1',
        'name': 'Kagotsurube Isshin',
        'price': 'RP.300.000',
        'image': 'assets/images/Kagotsurube.png',
      },
      {
        'id': 'w2',
        'name': 'Narzissenkreuz Pneuma',
        'price': 'RP.300.000',
        'image': 'assets/images/Pneuma.png',
      },
      {
        'id': 'w3',
        'name': 'Hamayumi Bow',
        'price': 'RP.300.000',
        'image': 'assets/images/Hamayumi.png',
      },
      {
        'id': 'w4',
        'name': 'Jade Winged Spear',
        'price': 'RP.300.000',
        'image': 'assets/images/Winged.png',
      },
      {
        'id': 'w5',
        'name': 'Amenoma Kageuchi',
        'price': 'RP.320.000',
        'image': 'assets/images/Amenoma.png',
      },
      {
        'id': 'w6',
        'name': 'Wolf\'s Gravestone',
        'price': 'RP.300.000',
        'image': 'assets/images/Wolf.png',
      },
      {
        'id': 'w7',
        'name': 'Fruit',
        'price': 'RP.350.000',
        'image': 'assets/images/Fruit.png',
      },
      {
        'id': 'w8',
        'name': 'Wolf\'s Gravestone',
        'price': 'RP.300.000',
        'image': 'assets/images/Gravestone.png',
      },
      {
        'id': 'w9',
        'name': 'Sacrificer\'s Staff',
        'price': 'RP.300.000',
        'image': 'assets/images/Sacrificer.png',
      },
      {
        'id': 'w10',
        'name': 'Amos bow',
        'price': 'RP.310.000',
        'image': 'assets/images/Amos.png',
      },
      {
        'id': 'w11',
        'name': 'Compound Bow',
        'price': 'RP.320.000',
        'image': 'assets/images/Compound.png',
      },
      {
        'id': 'w12',
        'name': 'Skyward Spine',
        'price': 'RP.360.000',
        'image': 'assets/images/Skyward.png',
      },
      {
        'id': 'w13',
        'name': 'Blazing Suns',
        'price': 'RP.300.000',
        'image': 'assets/images/Suns.png',
      },
      {
        'id': 'w14',
        'name': 'Ash Graven Drinking Horn',
        'price': 'RP.300.000',
        'image': 'assets/images/Drinking.png',
      },
    ];

    const primaryPurple = Color(0xFF5A4CA9);

    return Scaffold(
      backgroundColor: primaryPurple,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // TOP HEADER
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'HI ANDI',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigasi ke halaman notifikasi pelanggan
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CustomerNotificationScreen(),
                            ),
                          );
                        },
                        child: Stack(
                          children: [
                            const Icon(
                              Icons.notifications_none_rounded,
                              color: Colors.white,
                              size: 26,
                            ),
                            Positioned(
                              top: 2,
                              right: 2,
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: primaryPurple,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Search Pill
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 2,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextField(
                            readOnly: true, // Mematikan keyboard di halaman ini
                            onTap: () {
                              // Pindah ke Search Screen saat di-klik
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SearchScreen(),
                                ),
                              );
                            },
                            decoration: InputDecoration(
                              hintText: 'Search weapon',
                              hintStyle: GoogleFonts.inter(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 12,
                              ),
                            ),
                            style: GoogleFonts.inter(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        const Icon(Icons.search, color: Colors.black, size: 20),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),

            // WHITE BODY CONTENT
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 24.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // BANNER PROMO
                        Container(
                          width: double.infinity,
                          height: 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: const LinearGradient(
                              colors: [Color(0xFF382977), Color(0xFF7E6DD3)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            image: const DecorationImage(
                              image: AssetImage('assets/images/promo.png'),
                              fit: BoxFit.cover,
                              opacity: 0.3,
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // WEAPON CATEGORY
                        Text(
                          'Weapon category',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w900,
                            fontSize: 11,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Kategori Horizontal (Diubah agar muat 6 item dan scrollable)
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: categories.map((cat) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 18.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/category',
                                      arguments: cat['name'],
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      // ==========================================
                                      // 2. UKURAN GAMBAR DIPERBESAR (width 58, height 58)
                                      // ==========================================
                                      Image.asset(
                                        cat['image'] as String,
                                        width: 58,
                                        height: 58,
                                        fit: BoxFit.contain,
                                      ),
                                      // ==========================================
                                      const SizedBox(height: 8),
                                      Text(
                                        cat['name'] as String,
                                        style: GoogleFonts.inter(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),

                        const SizedBox(height: 32),

                        // ALL WEAPON HEADER
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'All Weapon',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w800,
                                fontSize: 13,
                                color: primaryPurple,
                              ),
                            ),
                            Text(
                              'See all',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: primaryPurple,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // WEAPON GRID
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 14,
                                mainAxisSpacing: 16,
                                childAspectRatio: 0.72,
                              ),
                          itemCount: weapons.length,
                          itemBuilder: (context, idx) {
                            final item = weapons[idx];
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/product',
                                  arguments: item,
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFDADAED),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.black.withOpacity(0.05),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: Stack(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFF0ECEA),
                                              borderRadius:
                                                  const BorderRadius.vertical(
                                                    top: Radius.circular(20),
                                                  ),
                                              image: DecorationImage(
                                                image: AssetImage(
                                                  item['image']!,
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          // Logika Favorites
                                          Positioned(
                                            top: 10,
                                            right: 10,
                                            child:
                                                ValueListenableBuilder<
                                                  List<Map<String, dynamic>>
                                                >(
                                                  valueListenable:
                                                      FavoritesState.items,
                                                  builder: (context, favItems, child) {
                                                    final isFav =
                                                        FavoritesState.isFavorite(
                                                          item['id']!,
                                                        );

                                                    return GestureDetector(
                                                      onTap: () {
                                                        FavoritesState.toggleFavorite(
                                                          {
                                                            'id': item['id'],
                                                            'name':
                                                                item['name'],
                                                            'price':
                                                                item['price'],
                                                            'image':
                                                                item['image'],
                                                          },
                                                        );
                                                      },
                                                      child: Icon(
                                                        isFav
                                                            ? Icons.favorite
                                                            : Icons
                                                                  .favorite_border,
                                                        color: isFav
                                                            ? Colors.red
                                                            : Colors.black,
                                                        size: 22,
                                                      ),
                                                    );
                                                  },
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 10,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item['name']!,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.inter(
                                                fontWeight: FontWeight.w900,
                                                fontSize: 10,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  item['price']!,
                                                  style: GoogleFonts.inter(
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 11,
                                                    color: primaryPurple,
                                                  ),
                                                ),
                                                Container(
                                                  width: 24,
                                                  height: 24,
                                                  decoration:
                                                      const BoxDecoration(
                                                        color: primaryPurple,
                                                        shape: BoxShape.circle,
                                                      ),
                                                  child: const Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                    size: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // BOTTOM NAVIGATION BAR
      bottomNavigationBar: Container(
        height: 70,
        decoration: const BoxDecoration(
          color: Color(0xFFF5F5F5),
          border: Border(top: BorderSide(color: Colors.black12, width: 0.5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavTab(Icons.storefront, 'Shop', true, primaryPurple, () {}),
            _buildNavTab(
              Icons.manage_search,
              'Kategori',
              false,
              primaryPurple,
              () {
                Navigator.pushNamed(context, '/category');
              },
            ),
            _buildNavTab(
              Icons.shopping_cart_outlined,
              'Cart',
              false,
              primaryPurple,
              () {
                Navigator.pushNamed(context, '/cart');
              },
            ),
            _buildNavTab(
              Icons.favorite_outline,
              'Favourite',
              false,
              primaryPurple,
              () {
                Navigator.pushNamed(context, '/favourite');
              },
            ),
            _buildNavTab(
              Icons.person_outline,
              'Account',
              false,
              primaryPurple,
              () {
                Navigator.pushNamed(context, '/account');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavTab(
    IconData icon,
    String label,
    bool active,
    Color activeColor,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: active ? activeColor : Colors.black87, size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 9,
              fontWeight: active ? FontWeight.w800 : FontWeight.w600,
              color: active ? activeColor : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
