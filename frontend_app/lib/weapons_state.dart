class WeaponsState {
  // Ini adalah "Database Sementara" kita
  static List<Map<String, String>> allWeapons = [
    {
      'id': 'w1',
      'name': 'Kagotsurube Isshin',
      'price': 'RP.300.000',
      'image': 'assets/images/Kagotsurube.png',
    },
    {
      'id': 'w2',
      'name': 'Narzissenkreuz Pneuma',
      'price': 'RP.300.000',
      'image': 'assets/images/Pneuma.png',
    },
    {
      'id': 'w3',
      'name': 'Hamayumi Bow',
      'price': 'RP.300.000',
      'image': 'assets/images/Hamayumi.png',
    },
    {
      'id': 'w4',
      'name': 'Jade Winged Spear',
      'price': 'RP.300.000',
      'image': 'assets/images/Winged.png',
    },
    {
      'id': 'w5',
      'name': 'Amenoma Kageuchi',
      'price': 'RP.320.000',
      'image': 'assets/images/Amenoma.png',
    },
    {
      'id': 'w6',
      'name': 'Wolf\'s Gravestone',
      'price': 'RP.300.000',
      'image': 'assets/images/Wolf.png',
    },
  ];

  // Fungsi ini nanti dipanggil oleh Admin untuk menambah senjata baru
  static void addWeapon(Map<String, String> newWeapon) {
    allWeapons.add(newWeapon);
  }
}
