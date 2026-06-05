import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminIncomingOrdersScreen extends StatefulWidget {
  const AdminIncomingOrdersScreen({super.key});

  @override
  State<AdminIncomingOrdersScreen> createState() =>
      _AdminIncomingOrdersScreenState();
}

class _AdminIncomingOrdersScreenState extends State<AdminIncomingOrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  static const Color primaryPurple = Color(0xFF5A4CA9);
  static const Color bgLightGrey = Color(0xFFF8F8F8);

  // 1. Data Dummy Pesanan Masuk (Tab Baru)
  final List<Map<String, dynamic>> newOrders = [
    {
      'orderId': 'INV-20260531-001',
      'date': '31 Mei 2026, 14:30',
      'customer': 'Zhongli',
      'productName': 'Kagotsurube Isshin',
      'image': 'assets/images/Kagotsurube.png', // Pastikan path ini sesuai
      'quantity': 1,
      'totalPrice': 'Rp 300.000',
      'status': 'Menunggu Konfirmasi',
    },
    {
      'orderId': 'INV-20260531-002',
      'date': '31 Mei 2026, 09:15',
      'customer': 'Kamisato Ayato',
      'productName': 'Haran Geppaku Futsu',
      'image': 'assets/images/sword.png', // Sesuaikan gambar
      'quantity': 2,
      'totalPrice': 'Rp 600.000',
      'status': 'Menunggu Konfirmasi',
    },
  ];

  // 2. Data Dummy Pesanan Dikemas (Tab Dikemas)
  final List<Map<String, dynamic>> packedOrders = [
    {
      'orderId': 'INV-20260530-088',
      'date': '30 Mei 2026, 16:20',
      'customer': 'Yae Miko',
      'productName': 'Hamayumi Bow',
      'image': 'assets/images/Hamayumi.png', // Pastikan path ini sesuai
      'quantity': 1,
      'totalPrice': 'Rp 300.000',
      'status': 'Sedang Dikemas',
    },
  ];

  // 3. Data Dummy Pesanan Dikirim (Tab Dikirim) - BARU DITAMBAHKAN
  final List<Map<String, dynamic>> shippedOrders = [
    {
      'orderId': 'INV-20260529-042',
      'date': '29 Mei 2026, 10:10',
      'customer': 'Raiden Shogun',
      'productName': 'Engulfing Lightning',
      'image': 'assets/images/Winged.png', // Pastikan path ini sesuai
      'quantity': 1,
      'totalPrice': 'Rp 300.000',
      'status': 'Sedang Dikirim',
    },
  ];

  @override
  void initState() {
    super.initState();
    // UBAH LENGTH JADI 4 KARENA ADA TAB BARU
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
          'Pesanan Masuk',
          style: GoogleFonts.inter(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true, // Membuat tab bisa digeser jika kepanjangan
          tabAlignment: TabAlignment.start, // Meratakan tab ke sebelah kiri
          labelColor: primaryPurple,
          unselectedLabelColor: Colors.black45,
          indicatorColor: primaryPurple,
          indicatorWeight: 3,
          labelStyle: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            fontSize: 13,
          ),
          unselectedLabelStyle: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
          tabs: [
            Tab(text: 'Baru (${newOrders.length})'),
            Tab(text: 'Dikemas (${packedOrders.length})'),
            Tab(text: 'Dikirim (${shippedOrders.length})'), // TAB BARU
            const Tab(text: 'Selesai'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // TAB 1: PESANAN BARU (Tombol Proses)
          _buildOrderList(
            orders: newOrders,
            actionButtonText: 'Proses Pesanan',
            onActionPressed: (orderId) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Pesanan $orderId mulai dikemas!')),
              );
            },
          ),

          // TAB 2: DIKEMAS (Tombol Kirim)
          _buildOrderList(
            orders: packedOrders,
            actionButtonText: 'Kirim Pesanan',
            buttonColor: const Color(0xFFE65100), // Warna oranye
            onActionPressed: (orderId) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Pesanan $orderId telah dikirim!')),
              );
            },
          ),

          // TAB 3: DIKIRIM (Tombol Selesai) - BARU DITAMBAHKAN
          _buildOrderList(
            orders: shippedOrders,
            actionButtonText: 'Tandai Selesai',
            buttonColor: const Color(0xFF4CAF50), // Warna hijau sukses
            onActionPressed: (orderId) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Pesanan $orderId telah selesai!')),
              );
            },
          ),

          // TAB 4: SELESAI (KOSONG UNTUK CONTOH)
          _buildEmptyState(
            Icons.check_circle_outline_rounded,
            'Belum ada pesanan selesai',
          ),
        ],
      ),
    );
  }

  // WIDGET BANTUAN: LIST PESANAN
  Widget _buildOrderList({
    required List<Map<String, dynamic>> orders,
    String? actionButtonText,
    Color? buttonColor,
    Function(String)? onActionPressed,
  }) {
    if (orders.isEmpty) {
      return _buildEmptyState(Icons.inbox_rounded, 'Tidak ada pesanan');
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      physics: const BouncingScrollPhysics(),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];

        // Logika Pewarnaan Label Status Dinamis
        Color statusBgColor;
        Color statusTextColor;

        if (order['status'] == 'Sedang Dikemas') {
          statusBgColor = const Color(0xFFFFF3E0); // Background oranye muda
          statusTextColor = const Color(0xFFE65100); // Teks oranye tua
        } else if (order['status'] == 'Sedang Dikirim') {
          statusBgColor = const Color(0xFFE3F2FD); // Background biru muda
          statusTextColor = const Color(0xFF1565C0); // Teks biru tua
        } else {
          statusBgColor = const Color(0xFFFFF0F0); // Background merah muda
          statusTextColor = Colors.redAccent; // Teks merah
        }

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HEADER KARTU (ID & STATUS)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.receipt_long_rounded,
                          size: 18,
                          color: primaryPurple,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          order['orderId'],
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: statusBgColor, // Menggunakan warna dinamis
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        order['status'],
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                          color: statusTextColor, // Menggunakan warna dinamis
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Divider(height: 1, color: Colors.black12),
                ),

                // INFO PEMBELI & TANGGAL
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Pembeli: ${order['customer']}',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      order['date'],
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // INFO PRODUK
                Row(
                  children: [
                    Container(
                      width: 65,
                      height: 65,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F0ED),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          order['image'],
                          fit: BoxFit.contain,
                          errorBuilder: (c, e, s) => const Icon(
                            Icons.image_not_supported,
                            color: Colors.black26,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order['productName'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${order['quantity']}x Produk',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Divider(height: 1, color: Colors.black12),
                ),

                // TOTAL HARGA & TOMBOL AKSI
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Pesanan',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 11,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          order['totalPrice'],
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w900,
                            fontSize: 15,
                            color: primaryPurple,
                          ),
                        ),
                      ],
                    ),
                    if (actionButtonText != null)
                      ElevatedButton(
                        onPressed: () {
                          if (onActionPressed != null) {
                            onActionPressed(order['orderId']);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor ?? primaryPurple,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                        ),
                        child: Text(
                          actionButtonText,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // WIDGET BANTUAN: TAMPILAN KOSONG
  Widget _buildEmptyState(IconData icon, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 60, color: Colors.black12),
          const SizedBox(height: 16),
          Text(
            message,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.black45,
            ),
          ),
        ],
      ),
    );
  }
}
