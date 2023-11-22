<details>
<summary>Tugas 7</summary>

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
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


<details>
<summary>Tugas 8</summary>

# Tugas 8

# Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement(), disertai dengan contoh mengenai penggunaan kedua metode tersebut yang tepat!
`Navigator.push()`: Menambahkan layar baru di atas tumpukan navigasi, memungkinkan pengguna kembali ke layar sebelumnya
`Navigator.pushReplacement()`: Menambahkan layar baru dan menggantikan layar saat ini, pengguna tidak dapat kembali ke layar sebelumnya

perbedaan `Navigator.push()` dan `Navigator.pushReplacement()` terletak pada apa yang dilakukan kepada route yang berada pada atas stack. push() akan menambahkan route baru diatas route yang sudah ada pada atas stack, sedangkan pushReplacement() menggantikan route yang sudah ada pada atas stack dengan route baru tersebut. Contoh penggunaan `Navigator.push()` adalah saat melakukan navigasi ke halaman `Daftar Item` dari button `Lihat Item` pada halaman utama, sedangkan contoh penggunaan `Navigator.pushReplacement()` adalah adalah saat melakukan navigasi ke suatu halaman dari sidebar pada tugas individu. Selain itu, situasi yang cocok untuk menggunakan pushReplacement adalah saat pengguna.

# Jelaskan masing-masing layout widget pada Flutter dan konteks penggunaannya masing-masing!
* Container: mengatur tata letak dan memberikan styling pada elemen, seperti padding, margin, dan warna latar belakang
* ListView: menampilkan daftar item yang dapat di-scroll
* GridView: menampilkan widget dalam tata letak grid
* Column: mengatur elemen secara vertikal
* Row: mengatur elemen secara horizontal
* Padding: menambahkan padding di sekeliling elemen child
* Stack: menumpuk widget di atas satu sama lain
* SizedBox: memberikan widget dimensi yang tetap
* Card: menampung elemen-elemen lain untuk membuat tampilan seperti kartu
* Align: mengatur posisi align dari child terhadap elemen parentnya
* Table: menyusun widget dalam bentuk tabel

# Sebutkan apa saja elemen input pada form yang kamu pakai pada tugas kali ini dan jelaskan mengapa kamu menggunakan elemen input tersebut!
Elemen input pada form yang saya gunakan adalah TextFormField. Elemen ini digunakan untuk mengumpulkan input nama item, amount, dan deskripsi dari user. TextFormField juga memungkinkan validasi input (misalnya memastikan bahwa nama tidak kosong) dan penyesuaian input teks (seperti hint dan label) sehingga sangat cocok untuk input teks sederhana.

# Bagaimana penerapan clean architecture pada aplikasi Flutter?
Penerapan clean architecture pada Flutter adalah prinsip dalam pengembangan aplikasi yang memisahkan kepentingan dengan membagi aplikasi menjadi beberapa lapisan, yakni:
* Domain : Mengatur logika bagaimana entitas atau elemen dalam aplikasi berinteraksi dan berperilaku
* Presentation : Mengatur penggunaan widget untuk tampilan antarmuka, seperti widget, layar, dan tampilan dan bertanggung jawab untuk menangani interaksi pengguna dan merender antarmuka pengguna
* Data : Mengatur pengambilan dan penyimpanan data

# Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step! (bukan hanya sekadar mengikuti tutorial)
## Membuat Halaman Formulir
Membuat berkas baru `inventorylist_form.dart` dalam direktori `lib/screens` lalu mengimplementasikan meminta input name, amount, dan description kepada pengguna serta dilengkapi dengan validator. Contoh untuk input nama:
```
Padding(
  padding: const EdgeInsets.all(8.0),
  child: TextFormField(
    decoration: InputDecoration(
      hintText: "Nama Item",
      labelText: "Nama Item",
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
    ),
    onChanged: (String? value) {
      setState(() {
        _name = value!;
      });
    },
    validator: (String? value) {
      if (value == null || value.isEmpty) {
        return "Nama tidak boleh kosong!";
      }
      return null;
    },
  ),
),
```
Lalu, mengarahkan pengguna ke halaman form ketika button `tambah item` ditekan. Implementasinya pada berkas `item_card.dart` seperti ini:
```
if(item.name == "Tambah Item"){
  Navigator.push(context,
  MaterialPageRoute(builder: (context) => const InventoryFormPage()));
}
```
Selanjutnya, menambahkan kode berikut agar ringkasan data input yang dimasukkan oleh user ter-pop-up ketika button save ditekan
```
onPressed: () {
  if (_formKey.currentState!.validate()) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Item berhasil tersimpan'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text('Name: $_name'),
                Text('Amount: $_amount'),
                Text('Deskripsi: $_description')
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  _formKey.currentState!.reset();
  }
},
```
Selanjutnya, mengarahkan pengguna ke halaman daftar item dummy ketika user memencet button `Lihat Item`. Implementasinya seperti ini:
```
if (item.name == "Lihat Item") {
  List<InventoryListItem> getDummyItems() {
    return [
      InventoryListItem("Laptop", 2, "Bagus"),
      InventoryListItem("Earphone", 1, "Canggih"),
    ];
  }
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ItemListPage(items: getDummyItems()),
      ),
    );
}
```
## Membuat Drawer
Mengimplementasikan drawer untuk mengarahkan ke halaman utama dan tambah item. Contoh implementasi untuk halaman utama:
```
ListTile(
  leading: const Icon(Icons.home_outlined),
  title: const Text('Halaman Utama'),
  onTap: () {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(),
        ));
  },
),
```
</details>

<details>
<summary>Tugas 9</summary>

# Tugas 9
## Apakah bisa kita melakukan pengambilan data JSON tanpa membuat model terlebih dahulu? Jika iya, apakah hal tersebut lebih baik daripada membuat model sebelum melakukan pengambilan data JSON?
Sebenarnya kita bisa melalukan pengambilan data JSON tanpa membuat model terlebih dahulu, namun lebih baik jika membuat model dahulu sebelum melakukan pengambilan data JSON terutama pada proyek-proyek besar yang kompleks. Pengambilan data JSON tanpa membuat model terlebih dahulu bisa lebih cepat untuk proyek kecil, namun disarankan untuk tetap membuat model dahulu untuk mendapatkan keuntungan type safety, memudahkan pemeliharaan kode, dan memudahkan untuk modifikasi dan skalabilitas (jika struktur data berubah, kita hanya perlu memodifikasi mode, bukan setiap instance di mana data tersebut digunakan).

## Jelaskan fungsi dari CookieRequest dan jelaskan mengapa instance CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter.
CookieRequest biasanya digunakan untuk mengelola cookies dalam aplikasi Flutter, terutama dalam konteks autentikasi dengan membantu menyimpan, mengambil, dan mengelola cookie sesi dari server. Instance CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter untuk memastikan bahwa setiap request ke server menggunakan informasi sesi yang sama serta untuk mencegah pembuatan multiple instances yang melakukan hal yang sama sehingga lebih efisien.

## Jelaskan mekanisme pengambilan data dari JSON hingga dapat ditampilkan pada Flutter.
* Mengambil Data: Proses mendapatkan data melibatkan penggunaan permintaan HTTP, seperti menggunakan paket http, untuk mengambil informasi dari EndPoint JSON yang spesifik.

* Parsing JSON: Setelah menerima respons, data JSON diuraikan atau di-parse menjadi struktur Dart yang dapat diinterpretasikan, seringkali berupa Map atau objek sesuai dengan model yang telah didefinisikan sebelumnya.

* Menampilkan Data: Data yang telah di-parse dapat digunakan untuk membangun widget di Flutter, contohnya melalui penggunaan ListView untuk menyajikan daftar item secara visual.

## Jelaskan mekanisme autentikasi dari input data akun pada Flutter ke Django hingga selesainya proses autentikasi oleh Django dan tampilnya menu pada Flutter.
1. Input Data Akun di Flutter:
* Pengguna memasukkan informasi akun seperti nama pengguna dan kata sandi melalui antarmuka pengguna di aplikasi Flutter.

2. Pengiriman Permintaan Ke Server Django:
* Aplikasi Flutter mengirim permintaan HTTP (biasanya POST request) ke server Django.
* Permintaan ini berisi informasi otentikasi pengguna, seperti nama pengguna dan kata sandi.

3. Pengolahan Permintaan di Server Django:
* Django menerima permintaan dan memprosesnya menggunakan sistem autentikasi bawaan atau pustaka seperti Django REST Framework.
* Django memeriksa kevalidan informasi otentikasi yang diberikan, seperti memverifikasi apakah nama pengguna dan kata sandi sesuai dengan yang ada di sistem.

4. Penghasilan Token Otentikasi:
* Jika informasi otentikasi valid, Django menghasilkan token otentikasi baru.
* Token ini kemudian dikirimkan kembali ke aplikasi Flutter sebagai respons dari permintaan.

5. Penanganan Token di Aplikasi Flutter:
* Aplikasi Flutter menyimpan token otentikasi yang diterima secara lokal, misalnya di penyimpanan lokal perangkat atau dalam variabel yang diatur secara global.
* Token ini nantinya digunakan untuk setiap permintaan yang memerlukan otorisasi di masa mendatang.

6. Penggunaan Token untuk Permintaan Selanjutnya:
* Saat pengguna membuat permintaan ke sumber daya yang memerlukan otorisasi (misalnya, mengambil data pengguna), aplikasi Flutter menyertakan token otentikasi dalam header permintaan HTTP.
* Django memeriksa token ini untuk memberikan akses atau menolak akses ke sumber daya yang diminta.

## Sebutkan seluruh widget yang kamu pakai pada tugas ini dan jelaskan fungsinya masing-masing.
1. Textfield: Input text
2. Column : mengatur child secara vertical
3. Provider : Paket manajemen state yang digunakan untuk mengelola data di berbagai bagian aplikasi.
4. Sizedbox: dapat digunakan untuk memberikan jarak antar widget
5. ElevatedButton: button dengan tampilan elevated yg dapat bereaksi ketika di tekan
6. CircularProgressIndicator: Menampilkan indikator loading sirkuler, biasanya digunakan saat menunggu data dimuat.
7. ListView.builder: membuat daftar item scrollable yang dibangun secara dinamis. Digunakan untuk menampilkan daftar produk/item.

##  Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step! (bukan hanya sekadar mengikuti tutorial).
# Membuat halaman login
1. Melakukan install package yang akan digunakan untuk proses autentikasi user dengan menjalankan perintah berikut di terminal
```
flutter pub add provider
flutter pub add pbp_django_auth
```
2. Memodifikasi berkas `main.dart` agar dapat menyediakan `CookieRequest` library ke semua child widgets dengan menggunakan `Provider`.
````
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
    const MyApp({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Provider(
            create: (_) {
                CookieRequest request = CookieRequest();
                return request;
            },
            child: MaterialApp(
                title: 'Flutter App',
                theme: ThemeData(
                    colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
                    useMaterial3: true,
                ),
                home: LoginPage()),
        );
    }
}
````
3. Membuat file baru bernama `login.dart` dalam folder `screens` dan mengisinya dengan kode berikut
```
import 'package:inventory/screens/menu.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

void main() {
    runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
const LoginApp({super.key});

@override
Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Login',
        theme: ThemeData(
            primarySwatch: Colors.blue,
    ),
    home: const LoginPage(),
    );
    }
}

class LoginPage extends StatefulWidget {
    const LoginPage({super.key});

    @override
    _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    @override
    Widget build(BuildContext context) {
        final request = context.watch<CookieRequest>();
        return Scaffold(
            appBar: AppBar(
                title: const Text('Login'),
            ),
            body: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        TextField(
                            controller: _usernameController,
                            decoration: const InputDecoration(
                                labelText: 'Username',
                            ),
                        ),
                        const SizedBox(height: 12.0),
                        TextField(
                            controller: _passwordController,
                            decoration: const InputDecoration(
                                labelText: 'Password',
                            ),
                            obscureText: true,
                        ),
                        const SizedBox(height: 24.0),
                        ElevatedButton(
                            onPressed: () async {
                                String username = _usernameController.text;
                                String password = _passwordController.text;

                                // Cek kredensial
                                // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                                // Untuk menyambungkan Android emulator dengan Django pada localhost,
                                // gunakan URL http://10.0.2.2/
                                final response = await request.login("https://jocelyn-nathanie-tugas.pbp.cs.ui.ac.id/auth/login/", {
                                'username': username,
                                'password': password,
                                });
                    
                                if (request.loggedIn) {
                                    String message = response['message'];
                                    String uname = response['username'];
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) => MyHomePage()),
                                    );
                                    ScaffoldMessenger.of(context)
                                        ..hideCurrentSnackBar()
                                        ..showSnackBar(
                                            SnackBar(content: Text("$message Selamat datang, $uname.")));
                                    } else {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                            title: const Text('Login Gagal'),
                                            content:
                                                Text(response['message']),
                                            actions: [
                                                TextButton(
                                                    child: const Text('OK'),
                                                    onPressed: () {
                                                        Navigator.pop(context);
                                                    },
                                                ),
                                            ],
                                        ),
                                    );
                                }
                            },
                            child: const Text('Login'),
                        ),
                    ],
                ),
            ),
        );
    }
}
```
# Membuat Fitur Logout
1. Mengimplementasikan fungsi `logout` pada berkas `views.py` pada aplikasi `authentication`.
```
@csrf_exempt
def logout(request):
    username = request.user.username

    try:
        auth_logout(request)
        return JsonResponse({
            "username": username,
            "status": True,
            "message": "Logout berhasil!"
        }, status=200)
    except:
        return JsonResponse({
        "status": False,
        "message": "Logout gagal."
        }, status=401)
```
2. Membuat path untuk fungsi `logout`
````
from authentication.views import logout

path('logout/', logout, name='logout'),
````
3. Mengimplementasikan fungsional button `logout` pada `item_card.dart`
```
else if (item.name == "Logout") {
  final response = await request.logout(
      // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
      "https://jocelyn-nathanie-tugas.pbp.cs.ui.ac.id/auth/logout/");
  String message = response["message"];
  if (response['status']) {
    String uname = response["username"];
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("$message Sampai jumpa, $uname."),
    ));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("$message"),
    ));
  }
}
```
# Mengintegrasikan Authentication Django dengan Flutter
1. Membuat aplikasi Django baru bernama `authentication` pada proyek tugas Django
2. Menambahkan `authentication` dalam `INSTALLED_APPS` pada `settings.py`di main project Django.
3. Menambahkan `django-cors-headers` di dalam `requirements.txt` dan menjalankan perintah `pip install -r requirements.txt` untuk menginstall dependencies.
4. Menambahkan `corsheaders` ke dalam `INSTALLED_APPS` pada `settings.py` di main project Django.
5. Menambahkan `corsheaders.middleware.CorsMiddleware` pada `MIDDLEWARE` di
`settings.py` di main project Django.
6. Menambahkan variabel-variabel berikut pada `settings.py`
```
CORS_ALLOW_ALL_ORIGINS = True
CORS_ALLOW_CREDENTIALS = True
CSRF_COOKIE_SECURE = True
SESSION_COOKIE_SECURE = True
CSRF_COOKIE_SAMESITE = 'None'
SESSION_COOKIE_SAMESITE = 'None'
```
7. Membuat fungsi `login` pada berkas `views.py` di dalam folder `authentication`
```
@csrf_exempt
def login(request):
    username = request.POST['username']
    password = request.POST['password']
    user = authenticate(username=username, password=password)
    if user is not None:
        if user.is_active:
            auth_login(request, user)
            # Status login sukses.
            return JsonResponse({
                "username": user.username,
                "status": True,
                "message": "Login sukses!"
                # Tambahkan data lainnya jika ingin mengirim data ke Flutter.
            }, status=200)
        else:
            return JsonResponse({
                "status": False,
                "message": "Login gagal, akun dinonaktifkan."
            }, status=401)

    else:
        return JsonResponse({
            "status": False,
            "message": "Login gagal, periksa kembali email atau kata sandi."
        }, status=401)
```
8. Menambahkan path untuk aplikasi `authentication` yang telah dibuat pada `urls.py` direktori proyek.
```
path('auth/', include('authentication.urls')),
```
9. Menambahkan path untuk fungsi `login` yang sudah dibuat pada `urls.py` direktori aplikasi `authentication`.
```
from authentication.views import login
path('login/', login, name='login'),
```

# Membuat Model Kustom Sesuai Proyek Django
1. Buka endpoint JSON yang telah dibuat sebelumnya, lalu salinlah datanya pada Quicktype dan sesuaikan pengaturan setup name, source type, dan language hasil konversi.
2. Menyalin hasil konversi ke dalam file baru `item.dart` di dalam folder `lib/models/`.
```
// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
    String model;
    int pk;
    Fields fields;

    Product({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    int user;
    String name;
    DateTime dateAdded;
    int amount;
    String description;

    Fields({
        required this.user,
        required this.name,
        required this.dateAdded,
        required this.amount,
        required this.description,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        name: json["name"],
        dateAdded: DateTime.parse(json["date_added"]),
        amount: json["amount"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "name": name,
        "date_added": "${dateAdded.year.toString().padLeft(4, '0')}-${dateAdded.month.toString().padLeft(2, '0')}-${dateAdded.day.toString().padLeft(2, '0')}",
        "amount": amount,
        "description": description,
    };
}
```
# Membuat Halaman yang Menampilkan Daftar Semua Item
1. Buat file baru di `lib/screens/` dengan nama berkas `item_list.dart` lalu isi dengan kode di bawah
```
// item_list.dart
import 'package:flutter/material.dart';

class InventoryListItem {
  final String name;
  final int amount;
  final String description;

  InventoryListItem(this.name, this.amount, this.description);
}

class ItemList extends StatelessWidget {
  final List<InventoryListItem> items;

  const ItemList({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          title: Text(item.name),
          subtitle: Text('Jumlah: ${item.amount}, Deskripsi: ${item.description}'),
        );
      },
    );
  }
}
```
# Membuat Halaman Detail untuk Setiap Produk
1. Buat file baru pada `lib/screens/` dengan nama `detail_item_page.dart`
2. Mengisi file tersebut dengan kode berikut
```
import 'package:flutter/material.dart';
import 'package:inventory/models/item.dart';
class DetailItemPage extends StatelessWidget {
  final Product item;
  const DetailItemPage({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Padding(
          padding: EdgeInsets.all(16),
          child:Column(
            
            children: [
              Text('Name: ${item.fields.name}', style: TextStyle(fontSize: 20)),
              Text('Amount: ${item.fields.amount}', style: TextStyle(fontSize: 18)),
              Text('Description: ${item.fields.description}', style: TextStyle(fontSize: 16)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Back'),
              ),
            ],
          )

        )
      ),
    );
  }
}
```
3. Menambahkan `onTap: ()` pada tiap produk agar mengarahkan ke halaman `detail_item_page.dart` tiap judul item ditekan. Implementasinya adalah sebagai berikut
```
onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => DetailItemPage(item: snapshot.data![index]),
    ),
  );
},
```
</details>