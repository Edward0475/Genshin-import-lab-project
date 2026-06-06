import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// PENTING: Pastikan ini sesuai dengan nama folder/file mu

class FlutterProduct {
  final String id;
  final String name;
  final String price;
  final double rating;
  final String category;
  final String image;

  FlutterProduct({
    required this.id,
    required this.name,
    required this.price,
    required this.rating,
    required this.category,
    required this.image,
  });
}

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String? _selectedCategory;
  bool _hasInitialArgument = false;

  // Tema Ungu Genshin
  static const Color primaryPurple = Color(0xFF5A4CA9);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasInitialArgument) {
      final String? arg = ModalRoute.of(context)?.settings.arguments as String?;
      if (arg != null) {
        setState(() => _selectedCategory = arg);
      }
      _hasInitialArgument = true;
    }
  }

  // DAFTAR KATEGORI LOKAL
  final List<Map<String, String>> _categories = [
    {'name': 'Sword', 'image': 'assets/images/sword.png'},
    {'name': 'Bow', 'image': 'assets/images/Bow.png'},
    {'name': 'Polearm', 'image': 'assets/images/poleyean.png'},
    {'name': 'Catalyst', 'image': 'assets/images/catalyst.png'},
    {'name': 'Claymore', 'image': 'assets/images/claymore.png'},
    {'name': 'Artifact', 'image': 'assets/images/Artifact.png'},
  ];

  // DATA PRODUK LOKAL
  final List<FlutterProduct> _products = [
    FlutterProduct(
      id: 'w1',
      name: 'Kagotsurube Isshin',
      price: 'RP.300.000',
      rating: 5.0,
      category: 'Sword',
      image: 'assets/images/Kagotsurube.png',
    ),
    FlutterProduct(
      id: 'w2',
      name: 'Narzissenkreuz Pneuma',
      price: 'RP.300.000',
      rating: 5.0,
      category: 'Sword',
      image: 'assets/images/Pneuma.png',
    ),
    FlutterProduct(
      id: 'w3',
      name: 'Amenoma Kageuchi',
      price: 'RP.300.000',
      rating: 5.0,
      category: 'Sword',
      image: 'assets/images/Amenoma.png',
    ),
    FlutterProduct(
      id: 'w4',
      name: 'Royal Masque',
      price: 'RP.300.000',
      rating: 4.8,
      category: 'Artifact',
      image: 'assets/images/Royal.png',
    ),
    FlutterProduct(
      id: 'w5',
      name: 'Jade Winged Spear',
      price: 'RP.300.000',
      rating: 5.0,
      category: 'Polearm',
      image: 'assets/images/Winged.png',
    ),
    FlutterProduct(
      id: 'w6',
      name: 'Wolf\'s Gravestone',
      price: 'RP.300.000',
      rating: 5.0,
      category: 'Claymore',
      image: 'assets/images/Wolf.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _selectedCategory == null
        ? <FlutterProduct>[]
        : _products
              .where(
                (p) =>
                    p.category.toLowerCase() ==
                    _selectedCategory!.toLowerCase(),
              )
              .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFECEAE6),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            // Header
            _buildHeader(),

            // Content body
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: _selectedCategory == null
                        ? _buildCategoryGrid()
                        : _buildProductGrid(filtered),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // BOTTOM NAVIGATION BAR
      bottomNavigationBar: Container(
        height: 72,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavTab(Icons.storefront_outlined, 'Shop', false, () {
              Navigator.pushReplacementNamed(context, '/menu');
            }),
            _buildNavTab(Icons.manage_search, 'Kategori', true, () {}),
            _buildNavTab(Icons.shopping_cart_outlined, 'Cart', false, () {
              Navigator.pushReplacementNamed(context, '/cart');
            }),
            _buildNavTab(Icons.favorite_outline, 'Favourite', false, () {
              Navigator.pushReplacementNamed(context, '/favourite');
            }),
            _buildNavTab(Icons.person_outline, 'Account', false, () {
              Navigator.pushReplacementNamed(context, '/account');
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 56, left: 16, right: 16, bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              if (_selectedCategory != null) {
                setState(() => _selectedCategory = null);
              } else {
                Navigator.pop(context);
              }
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 26,
              ),
            ),
          ),
          Text(
            _selectedCategory ?? 'EXPLORE CATEGORIES',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: primaryPurple,
            ),
          ),
          const SizedBox(width: 44),
        ],
      ),
    );
  }

  Widget _buildCategoryGrid() {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
      itemCount: _categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 0.82,
      ),
      itemBuilder: (context, index) {
        final cat = _categories[index];
        final name = cat['name']!;

        return Column(
          children: [
            GestureDetector(
              onTap: () => setState(() => _selectedCategory = name),
              child: AspectRatio(
                aspectRatio: 1.0,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(cat['image']!),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              name.toUpperCase(),
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w900,
                color: const Color(0xFF111111),
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    );
  }

  Widget _buildProductGrid(List<FlutterProduct> filtered) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      itemCount: filtered.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.72,
      ),
      itemBuilder: (context, index) {
        final product = filtered[index];

        return GestureDetector(
          onTap: () {
            // NAVIGASI MENGGUNAKAN ARGUMENTS
            Navigator.pushNamed(
              context,
              '/product',
              arguments: {
                'id': product.id,
                'name': product.name,
                'price': product.price,
                'rating': product.rating,
                'image': product.image,
              },
            );
          },

          child: Container(
            decoration: BoxDecoration(
              color: const Color(0x0AECEAE6),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                    child: Image.asset(product.image, fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 12),
                          const SizedBox(width: 2),
                          Text(
                            product.rating.toStringAsFixed(1),
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.price,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                              color: primaryPurple,
                            ),
                          ),
                          Container(
                            width: 28,
                            height: 28,
                            decoration: const BoxDecoration(
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
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavTab(
    IconData icon,
    String label,
    bool active,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: active ? primaryPurple : Colors.black45, size: 23),
          const SizedBox(height: 3),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 9,
              fontWeight: active ? FontWeight.w900 : FontWeight.w700,
              color: active ? primaryPurple : Colors.black45,
            ),
          ),
        ],
      ),
    );
  }
}
