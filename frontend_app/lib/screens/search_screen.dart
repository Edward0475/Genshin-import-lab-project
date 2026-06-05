import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../favorites_state.dart';
import '../weapons_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final Color primaryPurple = const Color(0xFF5A4CA9);
  String selectedCategory = 'All';
  final List<String> filterCategories = [
    'All',
    'Sword',
    'Polearm', // Typo Poleyean diperbaiki
    'Bow',
    'Claymore',
    'Catalyst',
  ];

  final TextEditingController _searchController = TextEditingController();

  List<Map<String, String>> filteredWeapons = [];

  @override
  void initState() {
    super.initState();
    // Mengambil data dari Global State saat halaman pertama dibuka
    filteredWeapons = List.from(WeaponsState.allWeapons);
  }

  // Fungsi penyaring yang akan dipanggil oleh TextField
  void _runFilter(String enteredKeyword) {
    List<Map<String, String>> results = [];
    if (enteredKeyword.isEmpty) {
      results = List.from(WeaponsState.allWeapons);
    } else {
      results = WeaponsState.allWeapons
          .where(
            (weapon) => weapon['name']!.toLowerCase().contains(
              enteredKeyword.toLowerCase(),
            ),
          )
          .toList();
    }

    setState(() {
      filteredWeapons = results;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),

            // HEADER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                      size: 22,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'SEARCH WEAPONS',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                          color: primaryPurple,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 22),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // SEARCH BAR
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black87, width: 1),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        autofocus: true,
                        onChanged: (value) => _runFilter(value),
                        decoration: InputDecoration(
                          hintText: 'What do you mostly like?',
                          hintStyle: GoogleFonts.inter(
                            color: Colors.black87,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                          border: InputBorder.none,
                        ),
                        style: GoogleFonts.inter(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const Icon(Icons.search, color: Colors.black87, size: 22),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // FILTER CATEGORY (Chips)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: filterCategories.map((category) {
                  bool isActive = selectedCategory == category;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isActive ? primaryPurple : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: primaryPurple, width: 1.5),
                      ),
                      child: Text(
                        category,
                        style: GoogleFonts.inter(
                          color: isActive ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),

            // WEAPON GRID
            Expanded(
              child: filteredWeapons.isNotEmpty
                  ? GridView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 8.0,
                      ),
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.75,
                          ),
                      itemCount: filteredWeapons.length,
                      itemBuilder: (context, index) {
                        return _buildUserWeaponCard(filteredWeapons[index]);
                      },
                    )
                  : Center(
                      child: Text(
                        'Weapon not found.',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserWeaponCard(Map<String, String> item) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF2F3F8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12, width: 1),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: Stack(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset(
                      item['image']!,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.image_not_supported,
                        color: Colors.black26,
                      ),
                    ),
                  ),
                ),

                // --- INI ADALAH KODINGAN TOMBOL HATI YANG SUDAH DIPERBAIKI ---
                Positioned(
                  top: 12,
                  right: 12,
                  child: ValueListenableBuilder<List<Map<String, dynamic>>>(
                    valueListenable: FavoritesState.items,
                    builder: (context, favItems, child) {
                      final isFav = FavoritesState.isFavorite(item['id']!);

                      return GestureDetector(
                        onTap: () {
                          FavoritesState.toggleFavorite({
                            'id': item['id'],
                            'name': item['name'],
                            'price': item['price'],
                            'image': item['image'],
                          });
                        },
                        child: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: isFav ? Colors.red : Colors.black,
                          size: 22,
                        ),
                      );
                    },
                  ),
                ),

                // -------------------------------------------------------------
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          item['name']!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item['price']!,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w900,
                            fontSize: 11,
                            color: primaryPurple,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      color: primaryPurple,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


//test ini adalah