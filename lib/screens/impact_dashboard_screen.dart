import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'leaderboard_screen.dart';

class ImpactDashboardScreen extends StatelessWidget {
  const ImpactDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard Dampak"),
        centerTitle: true,
        // Menambahkan tombol kembali
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Cek apakah bisa kembali (jika di-push dari halaman lain)
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // --- 1. Header Statistik (Berat, Area, CO2) ---
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StatCard(
                icon: Icons.delete_outline, 
                value: "12.5 kg", 
                label: "Total Berat\nSampah"
              ),
              StatCard(
                icon: Icons.grass, 
                value: "24 m²", 
                label: "Area\nBersih"
              ),
              StatCard(
                icon: Icons.cloud_off, 
                value: "1.8 kg", 
                label: "Reduksi\nCO₂"
              ),
            ],
          ),
          const SizedBox(height: 30),

          // --- 2. Aktivitas Mingguan (Grafik Batang) ---
          const Text(
            "Aktivitas Mingguan", 
            style: TextStyle(
              fontSize: 18, 
              fontWeight: FontWeight.bold, 
              color: AppColors.textDark
            )
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _barChartItem("S", 0.4),
                _barChartItem("S", 0.6),
                _barChartItem("R", 0.3),
                _barChartItem("K", 0.5),
                _barChartItem("J", 0.8),
                _barChartItem("S", 0.9),
                _barChartItem("M", 0.7),
              ],
            ),
          ),
          const SizedBox(height: 30),

          // --- 3. Aktivitas Terakhir List ---
          const Text(
            "Aktivitas Terakhir", 
            style: TextStyle(
              fontSize: 18, 
              fontWeight: FontWeight.bold, 
              color: AppColors.textDark
            )
          ),
          const SizedBox(height: 15),
          
          // List Item 1
          _activityItem(
            type: "Plastik", 
            date: "10 Des 2024", 
            icon: Icons.local_drink, 
            color: Colors.orange
          ),
          // List Item 2
          _activityItem(
            type: "Organik", 
            date: "09 Des 2024", 
            icon: Icons.eco, 
            color: Colors.green
          ),
          // List Item 3
          _activityItem(
            type: "Logam", 
            date: "08 Des 2024", 
            icon: Icons.settings, 
            color: Colors.grey
          ),

          const SizedBox(height: 30),

          // --- 4. Tombol Lihat Leaderboard ---
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LeaderboardScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text(
                "LIHAT LEADERBOARD", 
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // Widget Helper untuk Grafik Batang
  Widget _barChartItem(String day, double percentage) {
    return Column(
      children: [
        Container(
          height: 100 * percentage, // Tinggi dinamis berdasarkan persentase
          width: 12,
          decoration: BoxDecoration(
            color: percentage > 0.7 ? AppColors.primary : AppColors.primary.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(height: 8),
        Text(day, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  // Widget Helper untuk Item Aktivitas
  Widget _activityItem({required String type, required String date, required IconData icon, required Color color}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 5, offset: const Offset(0, 2))
        ],
      ),
      child: Row(
        children: [
          // Gambar/Icon di Kiri
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 15),
          
          // Teks di Kanan: Tipe | Tanggal
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  type,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 12, color: Colors.grey),
                    const SizedBox(width: 5),
                    Text(
                      date,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Indikator Status (Opsional)
          const Icon(Icons.check_circle, size: 16, color: Colors.green),
        ],
      ),
    );
  }
}

// Widget Helper untuk Kartu Statistik Header
class StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const StatCard({super.key, required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100, // Lebar fixed agar sejajar 3 kolom
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 8, offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primary, size: 32),
          const SizedBox(height: 12),
          Text(
            value, 
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textDark)
          ),
          const SizedBox(height: 4),
          Text(
            label, 
            textAlign: TextAlign.center, 
            style: const TextStyle(fontSize: 10, color: Colors.grey),
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}