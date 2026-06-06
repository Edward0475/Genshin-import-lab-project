import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerNotificationScreen extends StatelessWidget {
  CustomerNotificationScreen({super.key});

  static const Color primaryPurple = Color(0xFF5A4CA9);
  static const Color bgLightGrey = Color(0xFFF8F8F8);

  // Data Dummy Notifikasi Customer
  final List<Map<String, dynamic>> customerNotifications = [
    {
      'title': 'Pesanan Sedang Dikirim 🚚',
      'message':
          'Pesanan senjata "Kagotsurube Isshin" milikmu sedang dalam perjalanan menuju lokasi.',
      'time': '30 menit yang lalu',
      'icon': Icons.local_shipping_rounded,
      'color': Colors.blueAccent,
      'isRead': false,
    },
    {
      'title': 'Promo Spesial Untukmu! 🎉',
      'message':
          'Gunakan kode DISKONGENSHIN untuk mendapatkan potongan Rp 50.000 pada pembelian berikutnya.',
      'time': '5 jam yang lalu',
      'icon': Icons.card_giftcard_rounded,
      'color': primaryPurple,
      'isRead': false,
    },
    {
      'title': 'Pesanan Selesai',
      'message':
          'Pesanan "Haran Geppaku Futsu" telah berhasil diterima. Jangan lupa berikan ulasan ya!',
      'time': '2 hari yang lalu',
      'icon': Icons.check_circle_rounded,
      'color': Colors.green,
      'isRead': true,
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
          'Notifikasi Saya',
          style: GoogleFonts.inter(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: customerNotifications.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              physics: const BouncingScrollPhysics(),
              itemCount: customerNotifications.length,
              itemBuilder: (context, index) {
                final notif = customerNotifications[index];
                return _buildNotificationCard(notif);
              },
            ),
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> notif) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: notif['color'].withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(notif['icon'], color: notif['color'], size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notif['title'],
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  notif['message'],
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  notif['time'],
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                    color: Colors.black38,
                  ),
                ),
              ],
            ),
          ),
          if (!notif['isRead'])
            Container(
              margin: const EdgeInsets.only(top: 4),
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: Colors.redAccent,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.notifications_off_outlined,
            size: 60,
            color: Colors.black12,
          ),
          const SizedBox(height: 16),
          Text(
            'Tidak ada notifikasi baru',
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
