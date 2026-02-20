## How to play:

Gerakkan ship dengan panah UP/LEFT/RIGHT untuk bergerak naik/kiri/kanan. Pergi menghampiri logo Fasilkom untuk menang, tetapi menabrak meteor atau pergi dari batas level akan me-reset level.

## Latihan: Playtest
#### Apa saja pesan log yang dicetak pada panel Output?

Output mencetak
```
Platform initialized
Reached objective!
```
karena function `_ready()` pada script `PlatformBlue.gd` dipanggil yang mencetak "Platform initialized". Setelah itu, saat pesawat (`BlueShip`) menyentuh area `ObjectiveArea`, function `_on_ObjectiveArea_body_entered()` pada script `ObjectiveArea.gd` dipanggil yang mengecek apakah objek yang memasuki area merupakan `BlueShip` atau bukan dan mencetak "Reached objective!" jika objek tersebut merupakan `BlueShip`

#### Coba gerakkan landasan ke batas area bawah, lalu gerakkan kembali ke atas hingga hampir menyentuh batas atas. Apa saja pesan log yang dicetak pada panel Output?

Output mencetak "Reached objective!" lagi dengan alasan seperti yang sudah disebutkan sebelumnya.

#### Buka scene MainLevel dengan tampilan workspace 2D. Apakah lokasi scene ObjectiveArea memiliki kaitan dengan pesan log yang dicetak pada panel Output pada percobaan sebelumnya?

Ya, lokasi dan besar dari `ObjectiveArea` menyatakan area di mana script `ObjectiveArea.gd` mengimplementasikan Observer Pattern yang menunggu adanya event yang terjadi pada area tersebut. Ketika `BlueShip` masuk ke area tersebut, Observer Pattern meng-handle event tersebut dan mencetak output "Reached objective!" sesuai script.

## Latihan: Memanipulasi Node dan Scene
#### Scene BlueShip dan StonePlatform sama-sama memiliki sebuah child node bertipe Sprite2D. Apa fungsi dari node bertipe Sprite2D?

Sprite2D adalah node yang menampilkan tekstur 2D, sesuai namanya yaitu "Sprite" yang berarti bitmap 2 dimensi (seperti gambar) yang terintegrasi pada scene yang lebih besar.

#### Root node dari scene BlueShip dan StonePlatform menggunakan tipe yang berbeda. BlueShip menggunakan tipe RigidBody2D, sedangkan StonePlatform menggunakan tipe StaticBody2D. Apa perbedaan dari masing-masing tipe node?

Menurut dokumentasi Godot, RigidBody2D mengaplikasikan simulasi fisika dan bergerak karena gaya fisika yang di-apply ke objek tersebut (tidak dapat digerakkan secara manual). Simulasi fisika akan menghitung pergerakan objek, rotasi, tabrakan dengan objek lain, dan mempengaruhi objek lain yang mengimplementasikan simulasi fisika juga.

Sedangkan, StaticBody2D tidak dapat digerakkan dengan gaya fisika objek manapun, melainkan digerakkan secara manual (dianggap langsung teleport ke posisi barunya) dan tidak mempengaruhi objek lain yang mengimplementasikan simulasi fisika. Namun, BlueShip akan tetap mencoba untuk mencegah overlap dengan StonePlatform sehingga BlueShip tetap akan "terdorong" oleh StonePlatform walaupun sebenarnya StonePlatform tidak memberi gaya fisika kepada BlueShip sama sekali.

#### Ubah nilai atribut Mass pada tipe RigidBody2D secara bebas di scene BlueShip, lalu coba jalankan scene MainLevel. Apa yang terjadi?

Tidak ada perbedaan yang terjadi karena seberapa cepat suatu RigidBody2D jatuh tidak dipengaruhi oleh massa dari objek tersebut, dan tidak ada objek RigidBody2D lain yang berinteraksi dengan BlueShip dan hanya StaticBody2D (tidak dipengaruhi oleh simulasi fisika) yang berinteraksi dengan BlueShip sehingga tidak terjadi perbedaan pada playtest.

#### Ubah nilai atribut Disabled milik node CollisionShape2D pada scene StonePlatform, lalu coba jalankan scene MainLevel. Apa yang terjadi?

Menurut dokumentasi Godot, "Disable Mode" adalah apa yang terjadi pada simulasi fisika jika node tersebut tidak diproses. Hal-hal yang berbeda terjadi pada mode "Disable Mode" yang berbeda:
- Remove: menghapus semua interaksi fisika dengan objek (akan ditambahkan kembali saat node diproses)
- Make Static: membuat objek menjadi static dan tidak dapat dipengaruhi oleh gaya fisika apapun (tidak berpengaruh karena StonePlatform memang StaticBody2D) dan akan mengatur PhysicsBody2D menjadi mode awalnya saat node diproses.
- Keep Active: tetap membiarkan simulasi dan interaksi fisika objek walaupun node tidak diproses.

Jika kita menambahkan `process_mode = Node.PROCESS_MODE_DISABLED` pada function `_ready()` di script, maka node tidak diproses dan kita dapat melihat perbedaan "Disable Mode" pada playtest yaitu:
- Remove: membuat BlueShip jatuh melewati platform
- Make Static: BlueShip tetap di atas platform
- Keep Active: BlueShip tetap di atas platform

#### Pada scene MainLevel, coba manipulasi atribut Position, Rotation, dan Scale milik node BlueShip secara bebas. Apa yang terjadi pada visualisasi BlueShip di Viewport?

BlueShip akan mempunyai posisi, kemiringan, dan skala sesuai dengan apa yang kita specify.

#### Pada scene MainLevel, perhatikan nilai atribut Position node PlatformBlue, StonePlatform, dan StonePlatform2. Mengapa nilai Position node StonePlatform dan StonePlatform2 tidak sesuai dengan posisinya di dalam scene (menurut Inspector) namun visualisasinya berada di posisi yang tepat?

Karena lokasi StonePlatform dan StonePlatform2 dilihat berdasarkan local dari parentnya (PlatformBlue), bukan global. PlatformBlue memiliki pivot persis di tengah StonePlatform, sehingga posisi StonePlatform pada Inspector adalah (0, 0). Posisi dari PlatformBlue dilihat dari posisi global (35, 565), sehingga sesuai posisinya di dalam scene.
