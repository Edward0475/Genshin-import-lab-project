import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminNotificationScreen extends StatelessWidget {
  AdminNotificationScreen({super.key});

  static const Color primaryPurple = Color(0xFF5A4CA9);
  static const Color bgLightGrey = Color(0xFFF8F8F8);

  // Data Dummy Notifikasi Admin
  final List<Map<String, dynamic>> adminNotifications = [
    {
      'title': 'Pesanan Baru Masuk!',
      'message':
          'Pesanan INV-20260531-001 dari Zhongli menunggu untuk diproses.',
      'time': 'Baru saja',
      'icon': Icons.shopping_bag_rounded,
      'color': Colors.orange,
      'isRead': false,
    },
    {
      'title': 'Stok Menipis',
      'message':
          'Stok produk "Hamayumi Bow" tersisa 2 pcs. Segera lakukan restock.',
      'time': '2 jam yang lalu',
      'icon': Icons.warning_rounded,
      'color': Colors.redAccent,
      'isRead': false,
    },
    {
      'title': 'Pengguna Baru',
      'message': 'Aether Traveler baru saja mendaftar sebagai pelanggan.',
      'time': '1 hari yang lalu',
      'icon': Icons.person_add_rounded,
      'color': primaryPurple,
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
          'Notifikasi Admin',
          style: GoogleFonts.inter(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.done_all_rounded,
              color: primaryPurple,
              size: 22,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Semua notifikasi ditandai sudah dibaca'),
                ),
              );
            },
          ),
        ],
      ),
      body: adminNotifications.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              physics: const BouncingScrollPhysics(),
              itemCount: adminNotifications.length,
              itemBuilder: (context, index) {
                final notif = adminNotifications[index];
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
        color: notif['isRead']
            ? Colors.white
            : primaryPurple.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: notif['isRead']
              ? Colors.black12
              : primaryPurple.withValues(alpha: 0.3),
          width: 0.5,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: notif['color'].withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(notif['icon'], color: notif['color'], size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        notif['title'],
                        style: GoogleFonts.inter(
                          fontWeight: notif['isRead']
                              ? FontWeight.w700
                              : FontWeight.w900,
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    if (!notif['isRead'])
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.redAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
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
            'Belum ada notifikasi',
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
