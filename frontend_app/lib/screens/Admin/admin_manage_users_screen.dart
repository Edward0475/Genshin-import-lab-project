import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminManageUsersScreen extends StatefulWidget {
  const AdminManageUsersScreen({super.key});

  @override
  State<AdminManageUsersScreen> createState() => _AdminManageUsersScreenState();
}

class _AdminManageUsersScreenState extends State<AdminManageUsersScreen> {
  static const Color primaryPurple = Color(0xFF5A4CA9);
  static const Color bgLightGrey = Color(0xFFF8F8F8);

  // Data Dummy Pengguna
  final List<Map<String, dynamic>> users = [
    {
      'id': 'USR-001',
      'name': 'Aether Traveler',
      'email': 'aether@genshin.com',
      'joinDate': '12 Mei 2026',
      'status': 'Aktif',
      'avatarColor': const Color(0xFFE8E5F4),
    },
    {
      'id': 'USR-002',
      'name': 'Lumine Abyss',
      'email': 'lumine@genshin.com',
      'joinDate': '15 Mei 2026',
      'status': 'Aktif',
      'avatarColor': const Color(0xFFFFF0F0),
    },
    {
      'id': 'USR-003',
      'name': 'Tartaglia Childe',
      'email': 'childe@fatui.com',
      'joinDate': '20 Mei 2026',
      'status': 'Diblokir',
      'avatarColor': const Color(0xFFE3F2FD),
    },
    {
      'id': 'USR-004',
      'name': 'Kamisato Ayaka',
      'email': 'ayaka@yashiro.com',
      'joinDate': '25 Mei 2026',
      'status': 'Aktif',
      'avatarColor': const Color(0xFFE8F5E9),
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
          'Kelola Pengguna',
          style: GoogleFonts.inter(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // SEARCH BAR
            Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: Container(
                decoration: BoxDecoration(
                  color: bgLightGrey,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.black12, width: 0.5),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search_rounded,
                      color: Colors.black45,
                      size: 22,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Cari nama atau email pengguna...',
                          hintStyle: GoogleFonts.inter(
                            color: Colors.black45,
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                          border: InputBorder.none,
                        ),
                        style: GoogleFonts.inter(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // LIST PENGGUNA
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                physics: const BouncingScrollPhysics(),
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  final bool isBlocked = user['status'] == 'Diblokir';

                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // AVATAR PENGGUNA
                        Container(
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                            color: user['avatarColor'],
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              user['name']
                                  .substring(0, 1)
                                  .toUpperCase(), // Inisial Nama
                              style: GoogleFonts.inter(
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                color: primaryPurple,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),

                        // INFO PENGGUNA
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user['name'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15,
                                  color: Colors.black87,
                                  decoration: isBlocked
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                user['email'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  // LABEL STATUS
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isBlocked
                                          ? const Color(0xFFFFF0F0)
                                          : const Color(0xFFE8F5E9),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      user['status'],
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 10,
                                        color: isBlocked
                                            ? Colors.redAccent
                                            : Colors.green,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  // TANGGAL BERGABUNG
                                  Text(
                                    'Gabung: ${user['joinDate']}',
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10,
                                      color: Colors.black38,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // TOMBOL MENU (TITIK TIGA)
                        PopupMenuButton<String>(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          icon: const Icon(
                            Icons.more_vert_rounded,
                            color: Colors.black54,
                          ),
                          onSelected: (String value) {
                            if (value == 'detail') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Melihat detail ${user['name']}',
                                  ),
                                ),
                              );
                            } else if (value == 'block') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Status blokir ${user['name']} diubah',
                                  ),
                                ),
                              );
                            } else if (value == 'delete') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${user['name']} dihapus dari sistem',
                                  ),
                                ),
                              );
                            }
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                                PopupMenuItem<String>(
                                  value: 'detail',
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.person_outline,
                                        color: Colors.black87,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        'Detail Pengguna',
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const PopupMenuDivider(),
                                PopupMenuItem<String>(
                                  value: 'block',
                                  child: Row(
                                    children: [
                                      Icon(
                                        isBlocked
                                            ? Icons.lock_open_rounded
                                            : Icons.block_flipped,
                                        color: Colors.orange,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        isBlocked
                                            ? 'Buka Blokir'
                                            : 'Blokir Pengguna',
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                          color: Colors.orange,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const PopupMenuDivider(),
                                PopupMenuItem<String>(
                                  value: 'delete',
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.delete_outline,
                                        color: Colors.red,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        'Hapus Pengguna',
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
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
          ],
        ),
      ),
    );
  }
}
