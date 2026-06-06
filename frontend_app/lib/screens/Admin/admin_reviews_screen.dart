import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminReviewsScreen extends StatelessWidget {
  const AdminReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryPurple = Color(0xFF5A4CA9);

    // Dummy data ulasan Global (Semua Produk)
    final List<Map<String, dynamic>> allReviews = [
      {
        'productName': 'Kagotsurube Isshin',
        'username': 'Traveler_Anemo',
        'rating': 5,
        'date': '12 Mei 2026',
        'comment': 'Senjatanya sangat bagus! Cocok banget buat build DPS.',
      },
      {
        'productName': 'Narzissenkreuz Pneuma',
        'username': 'Furina_Fans',
        'rating': 3,
        'date': '11 Mei 2026',
        'comment': 'Deskripsi produk kurang jelas, tapi barangnya oke lah.',
      },
      {
        'productName': 'Staff of Homa',
        'username': 'HuTao_Main',
        'rating': 5,
        'date': '09 Mei 2026',
        'comment': 'WANGYYYY MANTAPP!! Langsung kritikal tembus naga!',
      },
      {
        'productName': 'Hamayumi Bow',
        'username': 'Yoimiya_Spark',
        'rating': 4,
        'date': '05 Mei 2026',
        'comment': 'Bagus, recommended seller.',
      },
    ];

    return Scaffold(
      backgroundColor: primaryPurple,
      appBar: AppBar(
        backgroundColor: primaryPurple,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Customer Reviews',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 16,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFFF8F8F8),
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
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            itemCount: allReviews.length,
            itemBuilder: (context, index) {
              final review = allReviews[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tag Nama Produk
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: primaryPurple.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Produk: ${review['productName']}',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: primaryPurple,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // User Info & Rating
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          review['username'],
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w800,
                            fontSize: 13,
                            color: Colors.black87,
                          ),
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
                    const SizedBox(height: 6),
                    _buildStars(review['rating'], size: 14),
                    const SizedBox(height: 10),

                    // Komentar
                    Text(
                      review['comment'],
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        height: 1.5,
                        color: Colors.black87,
                      ),
                    ),

                    // Tombol Balas / Hapus (Admin Controls)
                    const SizedBox(height: 12),
                    const Divider(height: 1, thickness: 0.5),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            // Logika untuk admin membalas ulasan
                          },
                          icon: const Icon(
                            Icons.reply,
                            size: 16,
                            color: primaryPurple,
                          ),
                          label: Text(
                            'Balas',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: primaryPurple,
                            ),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            // Logika hapus ulasan toxic/spam
                          },
                          icon: const Icon(
                            Icons.delete_outline,
                            size: 16,
                            color: Colors.red,
                          ),
                          label: Text(
                            'Hapus',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
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
