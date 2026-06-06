import 'package:flutter/material.dart';

class FavoritesState {
  // Menyimpan data produk favorit secara lengkap dan dinamis
  static ValueNotifier<List<Map<String, dynamic>>> items = ValueNotifier([]);

  // Fungsi cek apakah produk ada di favorit
  static bool isFavorite(String id) {
    return items.value.any((item) => item['id'] == id);
  }

  // Fungsi Like / Unlike (Sekarang menerima data utuh!)
  static void toggleFavorite(Map<String, dynamic> product) {
    var currentFavs = List<Map<String, dynamic>>.from(items.value);
    int index = currentFavs.indexWhere((item) => item['id'] == product['id']);

    if (index >= 0) {
      currentFavs.removeAt(index); // Jika sudah ada, Hapus (Unlike)
    } else {
      currentFavs.add(product); // Jika belum ada, Tambah (Like)
    }
    items.value = currentFavs; // Simpan pembaruan
  }
}
