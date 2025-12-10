import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Background Peta (Mockup Image)
          // Menggunakan Container full screen sebagai simulasi Google Maps
          Container(
            height: double.infinity,
            width: double.infinity,
            color: const Color(0xFFE3F2FD), // Warna air laut
            child: Stack(
              children: [
                // Simulasi daratan/pulau sederhana dengan CustomPaint atau Image
                // Kita pakai Center text placeholder untuk mock yang lebih clean
                Center(
                  child: Opacity(
                    opacity: 0.1,
                    child: Icon(Icons.map, size: 300, color: Colors.blue[900]),
                  ),
                ),
                // Pin Lokasi (Mockup)
                _buildPin(100, 150, Colors.red),
                _buildPin(250, 300, Colors.orange),
                _buildPin(50, 400, Colors.green),
                _buildPin(300, 100, Colors.red),
              ],
            ),
          ),

          // 2. Search Bar Floating
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10),
                ],
              ),
              child: const Row(
                children: [
                  Icon(Icons.search, color: Colors.grey),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text("Cari lokasi...", style: TextStyle(color: Colors.grey)),
                  ),
                  Icon(Icons.filter_list, color: AppColors.primary),
                ],
              ),
            ),
          ),

          // 3. Legend / Info di Bawah
          Positioned(
            bottom: 20,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLegendItem(Colors.red, "Sangat Kotor"),
                const SizedBox(height: 5),
                _buildLegendItem(Colors.orange, "Perlu Perhatian"),
                const SizedBox(height: 5),
                _buildLegendItem(Colors.green, "Sudah Bersih"),
              ],
            ),
          ),
          
          // 4. Tombol My Location
          Positioned(
            bottom: 30,
            right: 20,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: Colors.white,
              onPressed: (){},
              child: const Icon(Icons.my_location, color: AppColors.textDark),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPin(double top, double left, Color color) {
    return Positioned(
      top: top,
      left: left,
      child: Icon(Icons.location_on, color: color, size: 40),
    );
  }

  Widget _buildLegendItem(Color color, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(backgroundColor: color, radius: 5),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}