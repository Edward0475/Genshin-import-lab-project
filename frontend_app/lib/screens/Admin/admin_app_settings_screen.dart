import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminAppSettingsScreen extends StatefulWidget {
  const AdminAppSettingsScreen({super.key});

  @override
  State<AdminAppSettingsScreen> createState() => _AdminAppSettingsScreenState();
}

class _AdminAppSettingsScreenState extends State<AdminAppSettingsScreen> {
  static const Color primaryPurple = Color(0xFF5A4CA9);
  static const Color bgLightGrey = Color(0xFFF8F8F8);

  // State (Kondisi) untuk tombol Switch (Tiruan/Mockup)
  bool _isNotificationEnabled = true;
  bool _isDarkMode = false;

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
          'Pengaturan Aplikasi',
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. KELOMPOK AKUN & KEAMANAN
              _buildSectionTitle('AKUN & KEAMANAN'),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black12, width: 0.5),
                ),
                child: Column(
                  children: [
                    _buildNavigationTile(
                      icon: Icons.person_outline_rounded,
                      title: 'Edit Profil Admin',
                      onTap: () {},
                    ),
                    _buildDivider(),
                    _buildNavigationTile(
                      icon: Icons.lock_outline_rounded,
                      title: 'Ubah Kata Sandi',
                      onTap: () {},
                    ),
                    _buildDivider(),
                    _buildNavigationTile(
                      icon: Icons.security_rounded,
                      title: 'Keamanan Akun',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // 2. KELOMPOK PREFERENSI APLIKASI
              _buildSectionTitle('PREFERENSI'),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black12, width: 0.5),
                ),
                child: Column(
                  children: [
                    _buildSwitchTile(
                      icon: Icons.notifications_none_rounded,
                      title: 'Notifikasi Push',
                      value: _isNotificationEnabled,
                      onChanged: (val) {
                        setState(() {
                          _isNotificationEnabled = val;
                        });
                      },
                    ),
                    _buildDivider(),
                    _buildSwitchTile(
                      icon: Icons.dark_mode_outlined,
                      title: 'Mode Gelap (Dark Mode)',
                      value: _isDarkMode,
                      onChanged: (val) {
                        setState(() {
                          _isDarkMode = val;
                        });
                      },
                    ),
                    _buildDivider(),
                    _buildNavigationTile(
                      icon: Icons.language_rounded,
                      title: 'Bahasa',
                      subtitle: 'Bahasa Indonesia',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // 3. KELOMPOK INFORMASI
              _buildSectionTitle('INFORMASI'),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black12, width: 0.5),
                ),
                child: Column(
                  children: [
                    _buildNavigationTile(
                      icon: Icons.article_outlined,
                      title: 'Syarat & Ketentuan',
                      onTap: () {},
                    ),
                    _buildDivider(),
                    _buildNavigationTile(
                      icon: Icons.privacy_tip_outlined,
                      title: 'Kebijakan Privasi',
                      onTap: () {},
                    ),
                    _buildDivider(),
                    _buildNavigationTile(
                      icon: Icons.info_outline_rounded,
                      title: 'Tentang Genshin Import',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // VERSI APLIKASI
              Center(
                child: Column(
                  children: [
                    Text(
                      'Genshin Import v1.0.0',
                      style: GoogleFonts.inter(
                        color: Colors.black45,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '© 2026 BINUS University Software Laboratory',
                      style: GoogleFonts.inter(
                        color: Colors.black38,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // WIDGET BANTUAN: Judul Kelompok (Section)
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, bottom: 12),
      child: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w800,
          color: Colors.black45,
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  // WIDGET BANTUAN: Baris Menu Navigasi Biasa
  Widget _buildNavigationTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F1F5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: primaryPurple, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: Colors.black38,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }

  // WIDGET BANTUAN: Baris Menu dengan Switch/Sakelar
  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F1F5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: primaryPurple, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: primaryPurple,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.black12,
          ),
        ],
      ),
    );
  }

  // WIDGET BANTUAN: Garis Pemisah
  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Divider(height: 1, color: Colors.black12),
    );
  }
}
