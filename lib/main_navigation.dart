import 'package:flutter/material.dart';
import 'theme/app_colors.dart';
import 'screens/home_screen.dart';
import 'screens/impact_dashboard_screen.dart';
import 'screens/leaderboard_screen.dart';
import 'screens/report_form_screen.dart';
import 'screens/map_screen.dart'; // Import halaman peta
import 'screens/profil_screen.dart'; // Import halaman profil

class MainNavigationWrapper extends StatefulWidget {
  final int initialIndex; // Parameter untuk menentukan tab awal

  const MainNavigationWrapper({super.key, this.initialIndex = 0});

  @override
  State<MainNavigationWrapper> createState() => _MainNavigationWrapperState();
}

class _MainNavigationWrapperState extends State<MainNavigationWrapper> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex; // Set tab awal sesuai parameter
  }

  // Daftar halaman untuk Bottom Navigation
  final List<Widget> _pages = [
    const HomeScreen(),            // Index 0: Home
    const MapScreen(),             // Index 1: Peta (Sudah diimplementasikan)
    const SizedBox(),              // Index 2: Placeholder Lapor (Button khusus)
    const ImpactDashboardScreen(), // Index 3: Aktivitas/Dampak
    const ProfileScreen(),         // Index 4: Profil (Sebelumnya Leaderboard, diperbaiki)
  ];

  void _onItemTapped(int index) {
    if (index == 2) {
      // Logika khusus untuk tombol tengah (Lapor)
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
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: const Color(0xFF1E2832),
        height: 80,
        padding: EdgeInsets.zero,
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
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), 
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: index == 2 ? 30 : 24,
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