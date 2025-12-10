import 'package:flutter/material.dart';
import 'theme/app_colors.dart';
import 'screens/home_screen.dart';
import 'screens/impact_dashboard_screen.dart';
import 'screens/leaderboard_screen.dart';
import 'screens/report_form_screen.dart';

class MainNavigationWrapper extends StatefulWidget {
  const MainNavigationWrapper({super.key});
  @override
  State<MainNavigationWrapper> createState() => _MainNavigationWrapperState();
}

class _MainNavigationWrapperState extends State<MainNavigationWrapper> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const Center(child: Text("Halaman Peta (Segera Hadir)")),
    const SizedBox(), // Placeholder untuk index 2 (Lapor)
    const ImpactDashboardScreen(),
    const LeaderboardScreen(),
  ];

  void _onItemTapped(int index) {
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ReportFormScreen()),
      );
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: const Color(0xFF1E2832),
        height: 80, // Diperbesar agar tidak overflow (sebelumnya 70 atau default)
        padding: EdgeInsets.zero, // Reset padding bawaan agar Row bisa full width/height
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(Icons.home_filled, "Home", 0),
            _navItem(Icons.map_outlined, "Peta", 1),
            _navItem(Icons.campaign, "Lapor", 2),
            _navItem(Icons.bar_chart_rounded, "Aktivitas", 3),
            _navItem(Icons.person_outline, "Profil", 4),
          ],
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    final isSelected = _currentIndex == index;
    
    return InkWell(
      onTap: () => _onItemTapped(index),
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        // Mengurangi padding vertikal agar muat dalam tinggi 80px
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), 
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: index == 2 ? 30 : 24, // Sedikit disesuaikan ukurannya (30 untuk Lapor)
              color: isSelected ? AppColors.primary : Colors.grey,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: isSelected ? AppColors.primary : Colors.grey,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}