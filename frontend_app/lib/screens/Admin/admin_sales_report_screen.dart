import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminSalesReportScreen extends StatefulWidget {
  const AdminSalesReportScreen({super.key});

  @override
  State<AdminSalesReportScreen> createState() => _AdminSalesReportScreenState();
}

class _AdminSalesReportScreenState extends State<AdminSalesReportScreen> {
  static const Color primaryPurple = Color(0xFF5A4CA9);
  static const Color bgLightGrey = Color(0xFFF8F8F8);

  // Data Dummy Grafik Mingguan (Persentase tinggi bar 0.0 - 1.0)
  final List<Map<String, dynamic>> weeklyData = [
    {'day': 'Sen', 'value': 0.4},
    {'day': 'Sel', 'value': 0.6},
    {'day': 'Rab', 'value': 0.3},
    {'day': 'Kam', 'value': 0.8},
    {'day': 'Jum', 'value': 0.5},
    {'day': 'Sab', 'value': 1.0}, // Puncak penjualan
    {'day': 'Min', 'value': 0.7},
  ];

  // Data Dummy Produk Terlaris
  final List<Map<String, dynamic>> topProducts = [
    {
      'name': 'Kagotsurube Isshin',
      'sold': 45,
      'revenue': 'Rp 13.500.000',
      'image': 'assets/images/Kagotsurube.png', // Sesuaikan path
    },
    {
      'name': 'Haran Geppaku Futsu',
      'sold': 32,
      'revenue': 'Rp 9.600.000',
      'image': 'assets/images/sword.png', // Sesuaikan path
    },
    {
      'name': 'Hamayumi Bow',
      'sold': 28,
      'revenue': 'Rp 8.400.000',
      'image': 'assets/images/Hamayumi.png', // Sesuaikan path
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgLightGrey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black87,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Laporan Penjualan',
          style: GoogleFonts.inter(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. KARTU RINGKASAN UTAMA
              Row(
                children: [
                  // KARTU PENDAPATAN (Warna Ungu)
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: primaryPurple,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: primaryPurple.withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.account_balance_wallet_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Total Pendapatan',
                            style: GoogleFonts.inter(
                              color: Colors.white70,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Rp 24.500.000', // Dummy Pendapatan
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  // KARTU PESANAN (Warna Putih)
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0F1F5),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.local_shipping_rounded,
                              color: primaryPurple,
                              size: 20,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Pesanan',
                            style: GoogleFonts.inter(
                              color: Colors.black54,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '156', // Dummy Pesanan
                            style: GoogleFonts.inter(
                              color: Colors.black87,
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // 2. GRAFIK STATISTIK
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Statistik Minggu Ini',
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    'Detail',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: primaryPurple,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                height: 200,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: weeklyData.map((data) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Bar Grafik
                        // KODINGAN BARU YANG BENAR:
                        Container(
                          width: 28,
                          height: (120 * data['value'])
                              .toDouble(), // <--- TAMBAHKAN .toDouble() DI SINI
                          decoration: BoxDecoration(
                            color: data['value'] == 1.0
                                ? primaryPurple
                                : const Color(0xFFE8E5F4),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Label Hari
                        Text(
                          data['day'],
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: data['value'] == 1.0
                                ? primaryPurple
                                : Colors.black45,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 32),

              // 3. PRODUK TERLARIS
              Text(
                'Produk Terlaris',
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),

              // ListView untuk Produk Terlaris (shrinkWrap: true agar bisa gabung di ScrollView)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: topProducts.length,
                itemBuilder: (context, index) {
                  final product = topProducts[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Gambar Produk
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF2F0ED),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              product['image'],
                              fit: BoxFit.contain,
                              errorBuilder: (c, e, s) => const Icon(
                                Icons.broken_image,
                                color: Colors.black26,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),

                        // Info Produk
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product['name'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Terjual: ${product['sold']} Pcs',
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Pendapatan Produk
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Omzet',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                                color: Colors.black45,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              product['revenue'],
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w800,
                                fontSize: 13,
                                color: primaryPurple,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 20), // Jarak bawah
            ],
          ),
        ),
      ),
    );
  }
}
