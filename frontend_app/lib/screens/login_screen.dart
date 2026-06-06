import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// Jika UserSession error karena belum dibuat, kamu bisa komen baris ini dan logic di dalamnya
import '../user_session.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;
  late TextEditingController _emailController;
  final TextEditingController _passwordController = TextEditingController();

  static const Color primaryPurple = Color(
    0xFF5B4EB5,
  ); // Ungu sesuai desain Figma

  @override
  void initState() {
    super.initState();
    // Mengambil session jika ada (sesuai kodingan lamamu)
    _emailController = TextEditingController(text: UserSession().email);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // --- BAGIAN INI YANG KITA UBAH UNTUK LOGIKA ADMIN ---
  // --- BAGIAN INI YANG KITA UBAH UNTUK LOGIKA ADMIN & VALIDASI ---
  void _handleSignIn() {
    final session = UserSession();
    final inputEmail = _emailController.text.trim();
    final inputPassword = _passwordController.text.trim();

    // [TAMBAHAN BARU] 1. VALIDASI INPUT KOSONG
    if (inputEmail.isEmpty || inputPassword.isEmpty) {
      // Munculkan notifikasi merah di bawah layar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Email dan Password tidak boleh kosong!',
            style: GoogleFonts.inter(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.red.shade600,
          behavior: SnackBarBehavior.floating, // Agar tampilannya melayang rapi
        ),
      );
      return; // Hentikan proses eksekusi ke bawah
    }

    // 2. CEK JIKA YANG LOGIN ADALAH ADMIN
    if (inputEmail == 'admin' && inputPassword == 'admin123') {
      Navigator.pushReplacementNamed(context, '/admin');
    }
    // 3. CEK JIKA YANG LOGIN ADALAH PEMBELI BIASA
    else {
      session.email = inputEmail.toUpperCase();
      if (inputEmail.toUpperCase() != 'ANDI@GMAIL.COM' &&
          session.name == 'ANDI') {
        session.name = inputEmail.split('@')[0].toUpperCase();
      }
      // Langsung menuju menu pembeli
      Navigator.pushReplacementNamed(context, '/menu');
    }
  }
  // ----------------------------------------------------
  // ----------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6), // Background putih keabu-abuan
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 32.0,
              vertical: 24.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 1. Logo Genshin Import
                Image.asset(
                  'assets/images/LOGO.png', // Pastikan ini sudah sesuai dengan asset yang ada
                  height: 200,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.image_not_supported, size: 500),
                ),
                const SizedBox(height: 0),

                // 2. Title
                Text(
                  'WELCOME BACK',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                    color: Colors.black,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Masukan email dan password',
                  style: GoogleFonts.inter(
                    color: Colors.black87,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 32),

                // 3. Text Fields
                _buildPillTextField(
                  hint: 'email',
                  controller: _emailController,
                ),
                const SizedBox(height: 16),
                _buildPillTextField(
                  hint: 'password',
                  controller: _passwordController,
                  isObscured: true,
                ),
                const SizedBox(height: 16),

                // 4. Remember Me & Forgot Password
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Checkbox(
                            value: _rememberMe,
                            activeColor: primaryPurple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            side: const BorderSide(
                              color: Colors.black87,
                              width: 1.5,
                            ),
                            onChanged: (val) {
                              setState(() {
                                _rememberMe = val ?? false;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Remember me',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w800,
                            fontSize: 12,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap:
                          () {}, // Tambahkan navigasi forgot password jika ada
                      child: Text(
                        'Forgot password?',
                        style: GoogleFonts.inter(
                          color: primaryPurple,
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // 5. Login Button
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _handleSignIn,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryPurple,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ), // Kapsul yang sedikit kotak
                    ),
                    child: Text(
                      'LOG IN',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // 6. Divider (Or continue with)
                Text(
                  'Or continue with',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),

                // 7. Google Button
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(
                        color: Colors.black,
                        width: 1,
                      ), // Border hitam
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Gambar G dari Google (URL sementara, bisa diganti asset lokal)
                        Image.asset('assets/images/Google.png', height: 24),
                        const SizedBox(width: 12),
                        Text(
                          'Google',
                          style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 48),

                // 8. Bottom Register Link
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: Text(
                    'Belum punya akun?',
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 13,
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

  // Widget custom untuk Text Field yang melengkung dan bergaris hitam
  Widget _buildPillTextField({
    required String hint,
    required TextEditingController controller,
    bool isObscured = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black87, width: 1.2),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      child: TextField(
        controller: controller,
        obscureText: isObscured,
        style: GoogleFonts.inter(
          color: Colors.black,
          fontWeight: FontWeight.w800,
          fontSize: 14,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.inter(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: 13,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}
