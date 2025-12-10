import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F7FA), // Background biru muda
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              // --- HEADER ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Profil",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.settings, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // --- INFO USER ---
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.primary,
                      child: Icon(Icons.person, size: 60, color: Colors.white),
                      // Nanti bisa diganti NetworkImage jika ada foto
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Felix",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const Text(
                    "@felix_marine",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Bergabung sejak Desember 2023",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // --- 3 KARTU STATISTIK UTAMA ---
              Row(
                children: [
                  Expanded(
                    child: _buildMainStatCard(
                      "Total Laporan", "12", Icons.description, Colors.teal),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildMainStatCard(
                      "Total XP", "450", Icons.stars, Colors.teal.shade300),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildMainStatCard(
                      "Level", "5", Icons.bar_chart, Colors.teal.shade400),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // --- QUICK STATS ---
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Quick Stats",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textDark),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: _buildQuickStatItem(Icons.delete_outline, "12.5 kg", "Total Sampah\nTerangkut"),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildQuickStatItem(Icons.eco_outlined, "24 m²", "Area\nBersih"),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildQuickStatItem(Icons.cloud_outlined, "1.8 kg", "Emisi CO₂\nTerkurangi"),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // --- BADGE ACHIEVEMENT ---
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Pencapaian Saya", // "Pencapaian Maya" di gambar kemungkinan typo dari "Saya"
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textDark),
                ),
              ),
              const SizedBox(height: 15),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildBadgeItem("Konsisten 7 Hari", Icons.local_fire_department, Colors.orange),
                    const SizedBox(width: 10),
                    _buildBadgeItem("Kontributor Aktif", Icons.star, Colors.blue),
                    const SizedBox(width: 10),
                    _buildBadgeItem("Target Bulanan", Icons.track_changes, Colors.green),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // --- MENU BUTTONS ---
              Column(
                children: [
                  _buildMenuButton("Riwayat Laporan", Icons.history),
                  _buildMenuButton("Notifikasi", Icons.notifications_none),
                  _buildMenuButton("Hubungi Kami", Icons.phone_in_talk_outlined),
                  _buildMenuButton("Tentang Aplikasi", Icons.info_outline),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Widget Helper: Kartu Statistik Utama (Berwarna)
  Widget _buildMainStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: color.withOpacity(0.4), blurRadius: 8, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 16),
              const SizedBox(width: 4),
              Text(label, style: const TextStyle(color: Colors.white, fontSize: 10)),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Widget Helper: Quick Stat Item (Putih)
  Widget _buildQuickStatItem(IconData icon, String value, String label) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 5, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primary, size: 28),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textDark),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 9, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // Widget Helper: Badge
  Widget _buildBadgeItem(String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 5),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: Icon(icon, color: Colors.white, size: 14),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppColors.textDark),
          ),
        ],
      ),
    );
  }

  // Widget Helper: Menu Button List Tile
  Widget _buildMenuButton(String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 5, offset: const Offset(0, 2)),
        ],
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.primary, size: 20),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textDark),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: () {},
      ),
    );
  }
}