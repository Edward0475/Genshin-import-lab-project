import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Pastikan import UserSession tetap ada jika kamu membutuhkannya untuk menyimpan data
import '../user_session.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    final session = UserSession();
    session.name = _nameController.text.trim();
    session.email = _emailController.text.trim();

    // Mengarahkan ke menu utama karena halaman welcome sudah dihapus
    Navigator.pushReplacementNamed(context, '/menu');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFF6F6F6,
      ), // Warna abu-abu sangat terang khas background UI modern
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 32.0,
              vertical: 40.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo Genshin Import
                Image.asset(
                  'assets/images/LOGO.png', // Sesuai dengan trik aman pergantian logo sebelumnya
                  height: 200,
                ),
                const SizedBox(height: 0),

                // Judul
                Text(
                  'CREATE ACCOUNT',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 12),

                // Subjudul
                Text(
                  'Masukan email dan password',
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 40),

                // Form Inputs
                _buildRoundedTextField(
                  hint: 'Nama penguna',
                  controller: _nameController,
                ),
                const SizedBox(height: 16),
                _buildRoundedTextField(
                  hint: 'email',
                  controller: _emailController,
                  inputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                _buildRoundedTextField(
                  hint: 'password',
                  controller: _passwordController,
                  isObscured: true,
                ),
                const SizedBox(height: 16),
                _buildRoundedTextField(
                  hint: 'confirm password',
                  controller: _confirmController,
                  isObscured: true,
                ),
                const SizedBox(height: 40),

                // Tombol Register
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _handleRegister,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(
                        0xFF5D52A0,
                      ), // Warna ungu kebiruan sesuai desain Figma
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      'Register',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 60),

                // Teks Bawah
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context); // Kembali ke halaman Login
                  },
                  child: Text(
                    'sudah punya akun?',
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget khusus untuk membuat kolom teks sesuai desain Figma (Putih bergaris hitam)
  Widget _buildRoundedTextField({
    required String hint,
    required TextEditingController controller,
    bool isObscured = false,
    TextInputType inputType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Isi dalam kolom berwarna putih
        borderRadius: BorderRadius.circular(
          16,
        ), // Sudut melengkung, tapi tidak sebulat pil
        border: Border.all(color: Colors.black87, width: 1.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      child: TextField(
        controller: controller,
        obscureText: isObscured,
        keyboardType: inputType,
        style: GoogleFonts.inter(
          color: Colors.black,
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.inter(
            color: Colors.black,
            fontWeight:
                FontWeight.w800, // Teks hint sedikit lebih tebal sesuai desain
            fontSize: 13,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}
