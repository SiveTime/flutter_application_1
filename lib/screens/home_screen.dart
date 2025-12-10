import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'report_form_screen.dart';
import 'login_screen.dart'; // Import halaman login

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock Data untuk Aktivitas Terakhir
    final List<Map<String, dynamic>> activities = [
      {
        "type": "Plastik",
        "date": "10 Des 2024",
        "location": "Pantai Kuta, Bali",
        "image": "https://placehold.co/600x400/00ACC1/ffffff?text=Plastik",
        "icon": Icons.local_drink,
        "color": Colors.orange,
      },
      {
        "type": "Logam",
        "date": "09 Des 2024",
        "location": "Pelabuhan Ratu",
        "image": "https://placehold.co/600x400/5D4037/ffffff?text=Logam",
        "icon": Icons.settings,
        "color": Colors.grey,
      },
      {
        "type": "Organik",
        "date": "08 Des 2024",
        "location": "Taman Kota",
        "image": "https://placehold.co/600x400/4CAF50/ffffff?text=Organik",
        "icon": Icons.grass,
        "color": Colors.green,
      },
    ];

    return Scaffold(
      // Background sedikit abu agar kartu terlihat menonjol
      backgroundColor: Colors.grey[50], 
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          children: [
            // --- 1. HEADER & LOG OUT ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Halo, Felix! 👋",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Total Laporan dipindahkan ke sini
                    Text(
                      "Total Laporan Kamu: 12",
                      style: TextStyle(
                        color: Colors.grey[700], 
                        fontSize: 14,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ],
                ),
                // Tombol Log Out
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.logout, color: Colors.red),
                    tooltip: "Keluar",
                    onPressed: () {
                      // Arahkan kembali ke LoginScreen dan hapus stack navigasi
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                        (route) => false,
                      );
                    },
                  ),
                )
              ],
            ),
            
            const SizedBox(height: 30),

            // --- 2. TOMBOL LAPORKAN SAMPAH ---
            Container(
              width: double.infinity,
              height: 120, // Tinggi disesuaikan agar proporsional
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF26C6DA), Color(0xFF00ACC1)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.4),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  )
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    // Navigasi ke halaman pelaporan
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ReportFormScreen()),
                    );
                  },
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.delete_outline, // Logo Sampah
                          size: 32,
                          color: Colors.white,
                        ),
                        SizedBox(width: 12),
                        Text(
                          "LAPORKAN SAMPAH",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 30),

            // --- 3. AKTIVITAS TERAKHIR ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Aktivitas Terakhir",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text("Lihat Semua"),
                )
              ],
            ),
            const SizedBox(height: 10),

            // List Horizontal Aktivitas
            SizedBox(
              height: 260, // Tinggi area scroll
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none, // Agar shadow tidak terpotong
                itemCount: activities.length,
                itemBuilder: (context, index) {
                  final item = activities[index];
                  return Container(
                    width: 200,
                    margin: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Gambar Sampah
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                          child: Image.network(
                            item['image'],
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              height: 120,
                              color: Colors.grey[200],
                              child: const Center(child: Icon(Icons.broken_image, color: Colors.grey)),
                            ),
                          ),
                        ),
                        
                        // Detail Info
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Row Logo Tipe & Nama Tipe
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: item['color'].withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(item['icon'], size: 16, color: item['color']),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    item['type'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: item['color'],
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              
                              // Tanggal
                              Row(
                                children: [
                                  Icon(Icons.calendar_today, size: 12, color: Colors.grey[400]),
                                  const SizedBox(width: 4),
                                  Text(
                                    item['date'],
                                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              
                              // Lokasi
                              Row(
                                children: [
                                  Icon(Icons.location_on, size: 12, color: Colors.grey[400]),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      item['location'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textDark,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}