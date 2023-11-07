<details>
<summary>Tugas 2</summary>

# Tugas 7
## Apa perbedaan utama antara stateless dan stateful widget dalam konteks pengembangan aplikasi Flutter?
Dalam pengembangan aplikasi Flutter, terdapat dua jenis utama untuk widgets, yakni stateless dan stateful. Perbedaan utama antara  dan keduanya terletak pada kemampuan untuk mengelola dan merender perubahan dalam keadaan (state) komponen. 
* Stateless Widget
   * Tidak memiliki keadaan (stateless): 
   Stateless widget adalah widget yang tidak memiliki data yang berubah. Artinya, tampilan (build) dari stateless widget tidak bergantung pada data yang bisa berubah. Kita dapat memanfaatkan stateless widget jika bagian dari UI tidak memerlukan perubahan atau interaksi dinamis dengan pengguna (tampilan yang statis).
   * Immutability: Komponen stateless widget bersifat immutable, artinya setelah dibuat, mereka tidak dapat berubah. Jika perlu mengubah tampilan widget, harus membuat instance baru dari stateless widget.
   * Contoh penggunaan: teks, icon, gambar, dan sebagainya
* Stateful Widget
  *  Mengelola keadaan (stateful): 
  Stateful widget memungkinkan widget untuk memiliki keadaan internal yang dapat berubah (dinamis). Dengan menggunakan widget ini, kita dapat merender ulang tampilan ketika keadaan berubah. Contoh keadaan yang dapat berubah melibatkan input pengguna, data dari database, atau kondisi lainnya yang berubah selama masa hidup widget.
  * Mutable State:
  Stateful widget memiliki objek (State) terpisah yang dapat diubah. Objek State ini dapat menyimpan data yang diperlukan oleh widget dan diupdate selama masa hidup widget. Perubahan dalam objek State memicu pemanggilan kembali fungsi build sehingga tampilan widget dapat diperbarui.
  * Contoh penggunaan: form, update item, dan sebagainya

## Sebutkan seluruh widget yang kamu gunakan untuk menyelesaikan tugas ini dan jelaskan fungsinya masing-masing
* `MaterialApp`: Widget yang membungkus seluruh aplikasi dan memberikan berbagai konfigurasi, seperti tema, navigasi, dan lain sebagainya
* `title`: Menetapkan judul aplikasi
* `theme`: Menetapkan tema aplikasi, termasuk warna dan gaya
* `home`: Menetapkan widget yang akan ditampilkan saat aplikasi pertama kali dijalankan
* `MyHomePage` (stateless widget): Halaman utama aplikasi
* `Scaffold`: Template dasar yang digunakan untuk membuat tampilan seperti aplikasi pada umumnya. Salah satu parameternya adalah `AppBar`
* `AppBar`: Menampilkan bagian atas layar aplikasi dengan judul "Inventory"
* `SingleChildScrollView`: Memungkinkan kontennya dapat discroll jika terlalu besar untuk ditampilkan di layar. Digunakan untuk membungkus konten utama
* `Column`: Menyusun widget `children` secara vertikal
* `Padding`: Memberikan jarak antara widget dan tepi layar
* `GridView.count`: Menampilkan daftar ShopItem dalam bentuk grid
* `ShopCard` (statelss widget): Menampilkan setiap `ShopItem` dalam bentuk kartu. Ini merespons ketika pengguna menekan kartu dan menampilkan SnackBar
* `ShopItem`: Kelas model yang merepresentasikan item dalam inventory
* `name`: Nama item
* `icon`: Ikona yang mewakili item
* `color`: Warna latar belakang item
* `ShopCard` (stateless widget):  Menampilkan setiap `ShopItem` dalam bentuk kartu
* `InkWell`: Merespon sentuhan (interaksi) pengguna
* `ScaffoldMessenger`: Menampilkan SnackBar ketika kartu ditekan
* `Text`: Menampilkan text
* `SnackBar`: Menampilkan pop up pesan singkat di bagian bawah layar

## Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step (bukan hanya sekadar mengikuti tutorial)
1. Membuat proyek Flutter baru
Membuat proyek Flutter baru dengan nama `inventory` dengan menjalankan perintah
```
flutter create inventory
```
2. Memisahkan menjadi `menu.dart` dan `main.dart`
Buat file baru bernama `menu.dart` pada `inventory\lib`. Tujuannya adalah untuk menerapkan pemisahan fokus. Ubah isi berkas `main.dart` menjadi seperti di bawah ini agar `main.dart` mereturn widget yang ada pada `menu.dart`:
```
import 'package:flutter/material.dart';
import 'package:inventory/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: MyHomePage()
    );
  }
}
```
3. Menyusun widget pada `menu.dart`
Pertama-tama, pada `menu.dart`, kita akan mengimplementasikan widget `AppBar` yang nantinya akan terdapat text `Inventory`. Implementasinya adalah sebagai berikut:
```
class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  final List<ShopItem> items = [
    ShopItem("Lihat Item", Icons.checklist, Colors.pinkAccent),
    ShopItem("Tambah Item", Icons.add_shopping_cart, Colors.purpleAccent),
    ShopItem("Logout", Icons.logout, Colors.amberAccent),
  ];

  @override
    Widget build(BuildContext context) {
        return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Inventory',
        ),
      ),
      body: ...
    );
    }
}
```
Selanjutnya, halaman `MyHomePage` akan dibuat dapat discroll. Bagian `body` dari widget `Scaffold` akan dibungkus dengan `SingleChildScrollView`. Di dalam `SingleChildScrollView`, akan ada grid layout yang berisi tiga menu utama (ShopItem) yang dilengkapi dengan icon, text, dan warna yang berbeda pada setiap opsi sebagai implementasi bonus. Implementasi grid layout ini akan menggunakan widget `GridView`. Kurang lebih implementasinya seperti di bawah ini

```
final List<ShopItem> items = [
    ShopItem("Lihat Item", Icons.checklist, Colors.pinkAccent),
    ShopItem("Tambah Item", Icons.add_shopping_cart, Colors.purpleAccent),
    ShopItem("Logout", Icons.logout, Colors.amberAccent),
  ];
...
body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top:10,bottom:10),
                child:  Text(
                  'My Inventory',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GridView.count(
                primary: true,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                shrinkWrap: true,
                children: items.map((ShopItem item){
                  return ShopCard(item);
                }).toList(),
              ),
            ],
          ),
        ),
      ) ,
```

Widget `GridView` akan memiliki child berupa widget `ShopCard`. Implementasinya akan seperti berikut
```
class ShopItem {
  final String name;
  final IconData icon;
  final Color color;

  ShopItem(this.name, this.icon, this.color);
}

class ShopCard extends StatelessWidget {
  final ShopItem item;

  const ShopCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!")));
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```
`ShopCard` adalah sebuah elemen tampilan yang berfungsi mirip dengan tombol yang memiliki tiga opsi menu, yaitu "Lihat Item", "Tambah Item", dan "Logout". Ketika salah satu opsi tersebut ditekan, fungsi `onTap` akan dijalankan, yang akan menampilkan pop up pesan "Kamu telah menekan tombol X!", di mana X adalah opsi yang ditekan.
</details>