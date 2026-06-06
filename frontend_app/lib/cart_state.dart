import 'package:flutter/material.dart';

class CartState {
  static ValueNotifier<List<Map<String, dynamic>>> items = ValueNotifier([]);

  // Fungsi menambah barang ke keranjang
  static void addToCart(
    String id,
    String name,
    String price,
    String image,
    int qty,
  ) {
    var currentCart = List<Map<String, dynamic>>.from(items.value);
    int existingIndex = currentCart.indexWhere((item) => item['id'] == id);

    if (existingIndex >= 0) {
      currentCart[existingIndex]['qty'] += qty;
    } else {
      currentCart.add({
        'id': id,
        'name': name,
        'price': price,
        'image': image,
        'qty': qty,
      });
    }
    items.value = currentCart;
  }

  // Fungsi mengubah jumlah barang (+ atau -)
  static void updateQuantity(String id, int delta) {
    var currentCart = List<Map<String, dynamic>>.from(items.value);
    int index = currentCart.indexWhere((item) => item['id'] == id);

    if (index >= 0) {
      int newQty = currentCart[index]['qty'] + delta;
      if (newQty > 0) {
        currentCart[index]['qty'] = newQty;
      } else {
        currentCart.removeAt(index); // Jika qty jadi 0, otomatis hapus
      }
      items.value = currentCart; // Simpan pembaruan
    }
  }

  // Fungsi menghapus barang sepenuhnya dari keranjang
  static void removeFromCart(String id) {
    var currentCart = List<Map<String, dynamic>>.from(items.value);
    currentCart.removeWhere((item) => item['id'] == id);
    items.value = currentCart; // Simpan pembaruan
  }

  // Fungsi menghitung total harga
  static String calculateTotal() {
    double total = 0;
    for (var item in items.value) {
      String rawPrice = item['price'].toString().replaceAll(
        RegExp(r'[^0-9]'),
        '',
      );
      double priceVal = double.tryParse(rawPrice) ?? 0;
      total += (priceVal * (item['qty'] as int));
    }
    return 'Rp ${total.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }
}
//test