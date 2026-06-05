import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductReviewsUserScreen extends StatelessWidget {
  final String productName;

  const ProductReviewsUserScreen({super.key, required this.productName});

  @override
  Widget build(BuildContext context) {
    const primaryPurple = Color(0xFF5A4CA9);

    // Dummy data ulasan khusus untuk produk ini
    final List<Map<String, dynamic>> reviews = [
      {
        'username': 'Traveler_Anemo',
        'rating': 5,
        'date': '12 Mei 2026',
        'comment':
            'Senjatanya sangat bagus! Cocok banget buat build DPS karakter saya. Pengiriman kodenya juga instan.',
      },
      {
        'username': 'Zhongli_Main',
        'rating': 4,
        'date': '10 Mei 2026',
        'comment':
            'Overall bagus dan terpercaya. Bintang 4 dulu karena proses transaksinya agak loading lama tadi.',
      },
      {
        'username': 'PaimonMakanTerus',
        'rating': 5,
        'date': '01 Mei 2026',
        'comment':
            'Wihhh mantap! Senjatanya keren abis, harganya juga lumayan bersahabat buat pelajar.',
      },
      {
        'username': 'Raiden_Shogun',
        'rating': 5,
        'date': '28 Apr 2026',
        'comment': 'Perfect.',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Ulasan $productName',
          style: GoogleFonts.inter(
            color: Colors.black87,
            fontWeight: FontWeight.w800,
            fontSize: 16,
          ),
        ),
      ),
      body: Column(
        children: [
          // Header Ringkasan Rating
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                Text(
                  '4.8',
                  style: GoogleFonts.inter(
                    fontSize: 42,
                    fontWeight: FontWeight.w900,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildStars(5, size: 20),
                    const SizedBox(height: 4),
                    Text(
                      'Berdasarkan ${reviews.length} ulasan',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // List Ulasan
          Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              itemCount: reviews.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final review = reviews[index];
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.black.withOpacity(0.05)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // User Info & Rating
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 16,
                                backgroundColor: primaryPurple.withOpacity(0.1),
                                child: Text(
                                  review['username'][0].toUpperCase(),
                                  style: GoogleFonts.inter(
                                    color: primaryPurple,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                review['username'],
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            review['date'],
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              color: Colors.black45,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildStars(review['rating'], size: 14),
                      const SizedBox(height: 8),
                      // Komentar
                      Text(
                        review['comment'],
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          height: 1.5,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Helper untuk membuat rentetan bintang
  Widget _buildStars(int rating, {double size = 16}) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: const Color(0xFFFFC107),
          size: size,
        );
      }),
    );
  }
}
