import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../favorites_state.dart';
import 'product_detail_screen.dart'; // Import agar kartu bisa diklik

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  String _searchQuery = '';
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Bow',
    'Sword',
    'Polearm', // Huruf awal dibuat kapital agar rapi
    'Catalyst',
    'Artifact',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECEAE6),
      body: SafeArea(
        // 1. MEMANTAU GUDANG FAVORIT SECARA REAL-TIME
        child: ValueListenableBuilder<List<Map<String, dynamic>>>(
          valueListenable: FavoritesState.items,
          builder: (context, favItems, child) {
            // 2. LOGIKA FILTER SEARCH DAN KATEGORI
            final filteredFavs = favItems.where((p) {
              final matchesQuery = p['name'].toString().toLowerCase().contains(
                _searchQuery.toLowerCase(),
              );

              if (_selectedCategory == 'All') return matchesQuery;

              // Mengambil kategori dari produk, jika kosong anggap 'Sword'
              final normalCategory = (p['category'] ?? 'Sword')
                  .toString()
                  .toLowerCase();
              final normalSelected = _selectedCategory.toLowerCase();

              return matchesQuery && (normalCategory == normalSelected);
            }).toList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HEADER
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    top: 18.0,
                    bottom: 8.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () =>
                            Navigator.pushReplacementNamed(context, '/menu'),
                        behavior: HitTestBehavior.opaque,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.arrow_back_rounded,
                            color: Color(0xFF3C2E8F),
                            size: 26,
                          ),
                        ),
                      ),
                      Text(
                        'FAVOURITES',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                          color: const Color(0xFF3C2E8F),
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(width: 42),
                    ],
                  ),
                ),

                // SEARCH BAR
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 8.0,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 1,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5E2DE),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFF3C2E8F).withOpacity(0.2),
                        width: 1.0,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextField(
                            onChanged: (val) {
                              setState(() => _searchQuery = val);
                            },
                            decoration: InputDecoration(
                              hintText: 'What do you mostly like?',
                              hintStyle: GoogleFonts.inter(
                                color: const Color(0xFF3C2E8F).withOpacity(0.6),
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 12,
                              ),
                            ),
                            style: GoogleFonts.inter(
                              color: const Color(0xFF3C2E8F),
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.search_rounded,
                          color: const Color(0xFF3C2E8F).withOpacity(0.7),
                          size: 24,
                        ),
                      ],
                    ),
                  ),
                ),

                // CATEGORY FILTER
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 14.0,
                    horizontal: 20.0,
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: _categories.map((cat) {
                        final isSelected = _selectedCategory == cat;
                        return Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() => _selectedCategory = cat);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFF3C2E8F)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color(0xFF3C2E8F),
                                  width: 1.5,
                                ),
                              ),
                              child: Text(
                                cat,
                                style: GoogleFonts.inter(
                                  color: isSelected
                                      ? Colors.white
                                      : const Color(0xFF3C2E8F),
                                  fontWeight: FontWeight.w900,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),

                // GRID FAVORIT & EMPTY STATE
                Expanded(
                  child: filteredFavs.isEmpty
                      ? Center(
                          // LAYAR KOSONG JIKA TIDAK ADA FAVORIT
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.favorite_border_rounded,
                                size: 54,
                                color: const Color(0xFF3C2E8F).withOpacity(0.4),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Belum ada produk favorit',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                  color: const Color(0xFF3C2E8F),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Tambahkan dengan menekan logo hati',
                                style: GoogleFonts.inter(
                                  fontSize: 11,
                                  color: const Color(
                                    0xFF3C2E8F,
                                  ).withOpacity(0.7),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Padding(
                          // JIKA ADA ISINYA
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                  childAspectRatio: 0.76,
                                ),
                            itemCount: filteredFavs.length,
                            itemBuilder: (context, idx) {
                              final item = filteredFavs[idx];
                              return GestureDetector(
                                onTap: () {
                                  // Navigasi ke detail
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ProductDetailScreen(),
                                      settings: RouteSettings(arguments: item),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE2DFDC),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 6,
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.vertical(
                                                    top: Radius.circular(24),
                                                  ),
                                              child:
                                                  item['image']
                                                      .toString()
                                                      .startsWith('http')
                                                  ? Image.network(
                                                      item['image'],
                                                      width: double.infinity,
                                                      height: double.infinity,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Image.asset(
                                                      item['image'],
                                                      width: double.infinity,
                                                      height: double.infinity,
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (c, e, s) =>
                                                          const Icon(
                                                            Icons.image,
                                                          ),
                                                    ),
                                            ),
                                            Positioned(
                                              top: 10,
                                              right: 10,
                                              child: GestureDetector(
                                                onTap: () {
                                                  // HAPUS DARI FAVORIT (UNLIKE)
                                                  FavoritesState.toggleFavorite(
                                                    item,
                                                  );
                                                },
                                                child: const Icon(
                                                  Icons.favorite,
                                                  color: Color(0xFF3C2E8F),
                                                  size: 21,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Container(
                                          width: double.infinity,
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                              bottomLeft: Radius.circular(24),
                                              bottomRight: Radius.circular(24),
                                            ),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 8,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    item['name'],
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.inter(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: 11,
                                                      color: const Color(
                                                        0xFF3C2E8F,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 1),
                                                  Row(
                                                    children: List.generate(
                                                      5,
                                                      (starIdx) => const Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                        size: 11,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    item['price'],
                                                    style: GoogleFonts.inter(
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      fontSize: 13,
                                                      color: const Color(
                                                        0xFF3C2E8F,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 24,
                                                    height: 24,
                                                    decoration:
                                                        const BoxDecoration(
                                                          color: Color(
                                                            0xFF3C2E8F,
                                                          ),
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                    child: const Icon(
                                                      Icons.add,
                                                      color: Colors.white,
                                                      size: 14,
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
                        ),
                ),
              ],
            );
          },
        ),
      ),

      // BOTTOM NAV BAR (Bisa kamu letakkan di sini)
    );
  }
}
