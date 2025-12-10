import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../main_navigation.dart'; // Import Main Navigation
import 'report_form_screen.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F7FA),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, size: 150, color: AppColors.success),
              const SizedBox(height: 20),
              const Text(
                "Laporan Berhasil\nDikirim!", 
                textAlign: TextAlign.center, 
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)
              ),
              const SizedBox(height: 30),
              
              const CircleAvatar(
                radius: 40, backgroundColor: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, 
                  children: [
                    Icon(Icons.explore, color: AppColors.primary), 
                    Text("Nautiport", style: TextStyle(fontSize: 10))
                  ]
                ),
              ),
              const SizedBox(height: 20),
              
              const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.emoji_events, color: Colors.amber),
                SizedBox(width: 10),
                Text("+50 XP", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ]),
              const SizedBox(height: 40),

              // PERBAIKAN NAVIGASI DI SINI
              ElevatedButton(
                onPressed: () {
                  // Menggunakan pushAndRemoveUntil untuk mereset stack navigasi
                  // dan membuka MainNavigationWrapper langsung di tab index 3 (Dashboard Dampak)
                  Navigator.pushAndRemoveUntil(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => const MainNavigationWrapper(initialIndex: 3)
                    ),
                    (route) => false, // Hapus semua halaman sebelumnya dari memori
                  );
                },
                style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
                child: const Text("LIHAT DASHBOARD", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 20),
              
              GestureDetector(
                onTap: () => Navigator.pushReplacement(
                  context, 
                  MaterialPageRoute(builder: (context) => const ReportFormScreen())
                ),
                child: const Text(
                  "[Buat Laporan Baru]", 
                  style: TextStyle(
                    color: AppColors.primaryDark, 
                    fontWeight: FontWeight.bold, 
                    decoration: TextDecoration.underline
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}