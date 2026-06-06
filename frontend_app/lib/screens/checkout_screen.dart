import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'orders_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final String productName;
  final String price;
  final String imageUrl;
  final int quantity;

  const CheckoutScreen({
    super.key,
    required this.productName,
    required this.price,
    required this.imageUrl,
    required this.quantity,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  static const Color primaryPurple = Color(0xFF5A4CA9);
  static const Color bgLightPurple = Color(0xFFECEAE6);

  // Variabel untuk menyimpan data yang bisa diubah
  String currentAddress =
      'Jl. Alam Sutera Boulevard No.1,\nTangerang, Banten 15325';
  String selectedPayment = 'Transfer Bank';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgLightPurple,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top Header
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 20.0,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      behavior: HitTestBehavior.opaque,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.black,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'CHECKOUT',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2,
                      color: primaryPurple,
                    ),
                  ),
                ],
              ),
            ),

            // White rounded details panel
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 32.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle('ALAMAT PENGIRIMAN'),
                      const SizedBox(height: 12),
                      _buildAddressCard(),
                      const SizedBox(height: 28),

                      _buildSectionTitle('RINGKASAN PESANAN'),
                      const SizedBox(height: 12),
                      _buildProductItemCard(
                        '${widget.productName} (x${widget.quantity})',
                        widget.price,
                        widget.imageUrl,
                      ),
                      const SizedBox(height: 28),

                      _buildSectionTitle('METODE PEMBAYARAN'),
                      const SizedBox(height: 12),
                      _buildPaymentSelector(),
                      const SizedBox(height: 28),

                      _buildSectionTitle('RINCIAN PEMBAYARAN'),
                      const SizedBox(height: 12),
                      _buildPaymentDetails(),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  // --- FUNGSI POP-UP EDIT ALAMAT ---
  void _showEditAddressModal() {
    TextEditingController addressController = TextEditingController(
      text: currentAddress,
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 24,
            right: 24,
            top: 32,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Edit Alamat',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: primaryPurple,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: addressController,
                maxLines: 4,
                autofocus: true,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
                decoration: InputDecoration(
                  hintText: 'Masukkan alamat pengiriman...',
                  filled: true,
                  fillColor: const Color(0xFFF2F3F8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: primaryPurple,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      currentAddress = addressController.text;
                    });
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'SIMPAN ALAMAT',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  // --- FUNGSI POP-UP PILIH PEMBAYARAN ---
  void _showPaymentMethodModal() {
    final List<String> paymentMethods = [
      'Transfer Bank',
      'blu by BCA Digital',
      'ShopeePay',
      'Cash on Delivery (COD)',
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
          ),
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Metode Pembayaran',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: primaryPurple,
                ),
              ),
              const SizedBox(height: 16),
              ...paymentMethods.map((method) {
                return ListTile(
                  leading: const Icon(
                    Icons.account_balance_wallet,
                    color: primaryPurple,
                  ),
                  title: Text(
                    method,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  trailing: selectedPayment == method
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : null,
                  onTap: () {
                    setState(() {
                      selectedPayment = method;
                    });
                    Navigator.pop(context);
                  },
                );
              }),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  // --- WIDGET HELPER ---

  Widget _buildProductItemCard(String name, String price, String imageUrl) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFDFDFD),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFF3F4F6)),
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: bgLightPurple,
              borderRadius: BorderRadius.circular(16),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: imageUrl.startsWith('http')
                  ? Image.network(imageUrl, fit: BoxFit.cover)
                  : Image.asset(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.image, color: Colors.black26),
                    ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    color: primaryPurple,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) => Text(
    title,
    style: GoogleFonts.poppins(
      fontSize: 13,
      fontWeight: FontWeight.w900,
      color: primaryPurple,
      letterSpacing: 1.0,
    ),
  );

  Widget _buildAddressCard() {
    return GestureDetector(
      onTap: _showEditAddressModal,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: primaryPurple.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: primaryPurple.withOpacity(0.05),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.location_on, color: primaryPurple, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ALAMAT RUMAH',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      color: Colors.black45,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    currentAddress,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.edit_outlined, color: primaryPurple, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentSelector() {
    return GestureDetector(
      onTap: _showPaymentMethodModal,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.account_balance_wallet, color: primaryPurple),
                const SizedBox(width: 12),
                Text(
                  selectedPayment,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const Icon(Icons.chevron_right_rounded, color: Colors.black45),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentDetails() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFDFDFD),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFF3F4F6)),
      ),
      child: Column(
        children: [
          _buildDetailRow('Subtotal Produk', widget.price, false),
          const SizedBox(height: 12),
          _buildDetailRow('Biaya Layanan', 'Gratis', false),
          const SizedBox(height: 16),
          const Divider(color: Color(0xFFF3F4F6), height: 1),
          const SizedBox(height: 16),
          _buildDetailRow('Total Pembayaran', widget.price, true),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, bool isTotal) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: isTotal ? 12 : 11,
            fontWeight: isTotal ? FontWeight.w900 : FontWeight.w600,
            color: isTotal ? Colors.black : Colors.black54,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: isTotal ? 14 : 12,
            fontWeight: FontWeight.w900,
            color: isTotal ? primaryPurple : Colors.black87,
          ),
        ),
      ],
    );
  }

  // --- BAGIAN YANG DIRUBAH: FUNGSI BUAT PESANAN POP-UP ---
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, -10),
          ),
        ],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Pembayaran',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.price,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: primaryPurple,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                // ==========================================
                // 1. TAMPILKAN POP-UP LOADING DI TENGAH LAYAR
                // ==========================================
                showDialog(
                  context: context,
                  barrierDismissible:
                      false, // Tidak bisa ditutup dengan asal tap di luar
                  builder: (context) {
                    return Dialog(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 32.0,
                          horizontal: 24.0,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const CircularProgressIndicator(
                              color: primaryPurple,
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'Memproses Pembayaran...',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryPurple,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );

                // ==========================================
                // 2. SIMULASI JEDA PROSES (2 DETIK)
                // ==========================================
                await Future.delayed(const Duration(seconds: 2));

                if (!mounted) return;

                // ==========================================
                // 3. TUTUP POP-UP LOADING
                // ==========================================
                Navigator.pop(context); // Tutup dialog loading

                // ==========================================
                // 4. BUAT PESANAN BARU DAN SIMPAN KE DATA GLOBAL
                // ==========================================
                final newOrder = FlutterOrder(
                  id: 'o_${DateTime.now().millisecondsSinceEpoch}',
                  orderId:
                      'ORD-${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}',
                  date: 'HARI INI',
                  status: 'DIPROSES', // Masuk ke tab DIPROSES
                  productName: widget.productName,
                  productPrice: widget.price,
                  productImage: widget.imageUrl,
                  quantity: widget.quantity,
                  shippingAddress: currentAddress,
                  paymentMethod: selectedPayment,
                  shippingCost: 'Gratis',
                  totalPrice: widget.price,
                );
                globalOrders.add(newOrder); // Add to orders_screen.dart data

                // ==========================================
                // 5. TAMPILKAN POP-UP "PEMBAYARAN BERHASIL"
                // ==========================================
                if (!mounted) return;
                showDialog(
                  context: context,
                  barrierDismissible: false, // Wajib tekan tombol OK
                  builder: (context) {
                    return Dialog(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.check_circle_rounded,
                              color: Colors.green,
                              size: 80,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Pembayaran Berhasil!',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Pesanan Anda telah masuk dan sedang diproses.',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),
                            // TOMBOL OK
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Tutup Pop-Up Success
                                  Navigator.pop(context);

                                  // Pindah ke Halaman Orders Screen
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const OrdersScreen(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryPurple,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: Text(
                                  'OK',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryPurple,
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'BUAT PESANAN',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
