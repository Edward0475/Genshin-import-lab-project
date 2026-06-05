# 🗡️ Genshin Import - E-Commerce App

**Genshin Import** adalah aplikasi mobile e-commerce eksklusif yang menyediakan berbagai replika senjata dan artefak dari benua Teyvat (Genshin Impact) berskala 1:1. Produk-produk ini dirancang khusus untuk keperluan koleksi pajangan premium dan properti *cosplay*.

Aplikasi ini dibangun menggunakan **Flutter** dan mengimplementasikan sistem pembagian peran (Admin & User) beserta fitur CRUD (*Create, Read, Update, Delete*) sesuai dengan spesifikasi persyaratan sistem.

---

## 👥 Role & Fitur Utama (Berdasarkan Spesifikasi Persyaratan)

Aplikasi ini memiliki 2 peran (*role*) pengguna dengan batasan akses yang berbeda:

### 1. Role Admin (Sistem Manajemen Inventaris)
Admin memiliki kontrol penuh terhadap katalog produk yang ada di dalam aplikasi.
* **Insert (Create):** Menambahkan data senjata atau artefak baru ke dalam katalog.
* **Update:** Memperbarui data produk yang sudah ada (misalnya mengubah harga, menambah stok, atau merevisi deskripsi).
* **Delete:** Menghapus senjata atau artefak dari aplikasi.

### 2. Role Pengguna / User (Sistem Belanja)
Pengguna dapat menjelajahi dan bertransaksi di dalam aplikasi.
* **Read / Katalog:** Melihat daftar seluruh senjata dan artefak yang tersedia.
* **Detail Produk:** Melihat informasi spesifik dari senjata/artefak.
* **Pembelian Bebas Limit:** Pengguna dapat memasukkan barang ke keranjang dan membeli senjata/artefak sebanyak yang mereka inginkan (diatur melalui tombol *quantity* `+` dan `-`), selama stok barang masih mencukupi.

---

## 🗄️ Model Data Produk

Setiap item (Senjata maupun Artefak) di dalam aplikasi ini memuat atribut wajib sebagai berikut:

1. **`id`** : Identifier unik untuk setiap barang.
2. **`nama`** : Nama senjata atau artefak (contoh: *Staff of Homa*, *Wolf's Gravestone*).
3. **`jenis`** : Kategori klasifikasi barang (**Senjata** atau **Artefak**).
4. **`deskripsi`** : Penjelasan detail mengenai barang, material, dan lore.
5. **`stok`** : Jumlah barang yang tersedia (integer). Akan berkurang jika dibeli.
6. **`gambar`** : Representasi visual (path asset/URL) dari produk.
7. **`harga`** : Harga barang yang dijual (integer/string terformat).

*(Model data ini diimplementasikan di dalam class `GenshinItem` pada source code)*

---

## 🎨 Tampilan Antarmuka (UI/UX)

Aplikasi ini mengusung tema warna **Premium Purple (Ungu)** yang elegan, dipadukan dengan aksen krem/putih untuk menjaga kenyamanan mata pengguna (*readability*). Beberapa layar utama meliputi:

* **Menu Screen:** Dashboard utama bagi pengguna untuk mencari (*search*), melihat kategori, dan melihat ringkasan seluruh senjata.
* **Category Screen:** Tampilan *Grid* yang memisahkan senjata (Sword, Bow, Claymore, Polearm, Catalyst) dan Artefak fisik.
* **Product Detail Screen:** Menampilkan gambar produk yang besar, deksripsi lengkap, tombol *favorites*, pengatur jumlah pembelian (*quantity*), dan tombol *Checkout*.
* **Help & Support Screen:** FAQ dinamis dengan fitur *accordion* dan *search bar* yang interaktif.

---

## 🚀 Cara Menjalankan Project

1. Pastikan Flutter SDK sudah terinstal di komputer Anda.
2. Clone repository ini.
3. Buka terminal di direktori project dan jalankan perintah:
   ```bash
   cd "Project-Genshin import-MobileHybridSolution-main"
   cd frontend_app
   flutter pub get

