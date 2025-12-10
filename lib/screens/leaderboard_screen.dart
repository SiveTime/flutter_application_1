import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../main_navigation.dart';
import 'report_form_screen.dart';
import 'impact_dashboard_screen.dart'; // Import halaman dashboard

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFFE0F7FA), // Background halaman biru muda
        appBar: AppBar(
          title: const Text("LEADERBOARD"),
          centerTitle: true,
          // Menambahkan tombol kembali secara eksplisit
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          elevation: 0,
          backgroundColor: AppColors.primaryDark, // Header tetap biru tua
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: Container(
              height: 50,
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: TabBar(
                indicator: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(25),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                tabs: const [
                  Tab(text: "Personal"),
                  Tab(text: "Lokal"),
                  Tab(text: "Global"),
                ],
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            _PersonalTab(),
            _LocalTab(),
            _GlobalTab(),
          ],
        ),
      ),
    );
  }
}

// --- TAB 1: PERSONAL ---
class _PersonalTab extends StatelessWidget {
  const _PersonalTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Kartu Progres Personal (Isi Form Putih)
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "PROGRES PERSONAL KAMU",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.textDark,
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                // Profil Header
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColors.primary,
                      child: Icon(Icons.person, color: Colors.white, size: 35),
                    ),
                    const SizedBox(width: 15),
                    const Text(
                      "Felix",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),

                // Level Dots
                Row(
                  children: [
                    const Text("Level: 5", style: TextStyle(fontWeight: FontWeight.w500)),
                    const Spacer(),
                    ...List.generate(7, (index) {
                      return Container(
                        margin: const EdgeInsets.only(left: 4),
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index < 5 ? Colors.green : Colors.grey[300],
                        ),
                      );
                    }),
                  ],
                ),
                const SizedBox(height: 20),

                // XP Progress
                const Text("XP Progress:", style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 5),
                const Text(
                  "450 / 600 XP",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: 0.75,
                  minHeight: 12,
                  backgroundColor: Colors.grey[200],
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text("75%", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
                  ),
                ),

                const Divider(height: 30),

                // Peringkat Lokal Info
                Row(
                  children: [
                    const Icon(Icons.location_on, color: AppColors.primaryDark),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Peringkat Lokal:", style: TextStyle(fontSize: 12, color: Colors.grey)),
                        const Text("#12 dari 248 di Jakarta", style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 15),

                // Achievements
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.stars, color: Colors.orange),
                    const SizedBox(width: 10),
                    const Text("Achievement Badges:", style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _BadgeItem(icon: Icons.local_fire_department, color: Colors.orange, text: "Konsisten 7 Hari"),
                    _BadgeItem(icon: Icons.star, color: Colors.amber, text: "10 Laporan Pertama"),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Target Berikutnya
          Row(
            children: [
              const Icon(Icons.timer_outlined, color: AppColors.primaryDark),
              const SizedBox(width: 10),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Target Berikutnya:", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("150 XP lagi untuk Level 6!", style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),

          // Button Buat Laporan Baru
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReportFormScreen()),
                );
              },
              icon: const Icon(Icons.edit_note),
              label: const Text("Buat Laporan Baru", style: TextStyle(fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryDark,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- TAB 2: LOKAL (Ditambahkan Button ke Dashboard) ---
class _LocalTab extends StatelessWidget {
  const _LocalTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // Header
        const Row(
          children: [
            Icon(Icons.location_city, color: AppColors.primary),
            SizedBox(width: 10),
            Text(
              "Peringkat di Jakarta", 
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)
            ),
          ],
        ),
        const SizedBox(height: 20),

        // List Peringkat
        _RankItem(rank: 1, name: "UserA", level: 12, xp: 2000, isMe: false),
        _RankItem(rank: 2, name: "UserB", level: 19, xp: 1700, isMe: false),
        _RankItem(rank: 3, name: "EcoWarrior", level: 8, xp: 1500, isMe: false),
        const SizedBox(height: 10),
        const Center(child: Text("...", style: TextStyle(fontSize: 20, color: Colors.grey))),
        const SizedBox(height: 10),
        
        // Kartu User Sendiri (Highlight)
        _RankItem(rank: 12, name: "Felix", level: 5, xp: 450, isMe: true),
        
        const SizedBox(height: 10),
        const Center(child: Text("...", style: TextStyle(fontSize: 20, color: Colors.grey))),
        _RankItem(rank: 15, name: "Budi", level: 4, xp: 300, isMe: false),

        const SizedBox(height: 40),

        // --- BUTTON KE DASHBOARD (BARU) ---
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              // Navigasi ke Dashboard Dampak
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ImpactDashboardScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text(
              "KE DASHBOARD", 
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
            ),
          ),
        ),
      ],
    );
  }
}

// --- TAB 3: GLOBAL ---
class _GlobalTab extends StatelessWidget {
  const _GlobalTab();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // Info Banner
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white, // Kartu info putih
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.lightbulb_outline, color: Colors.blue),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Ini hanya referensi, fokus pada progres pribadimu! 💪",
                        style: TextStyle(color: Colors.blue, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              const Text("Peringkat Global", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 15),

              _RankItem(rank: 1, name: "Champion", level: 25, xp: 5000, isMe: false, customColor: Colors.amber),
              _RankItem(rank: 2, name: "EcoHero", level: 23, xp: 4800, isMe: false, customColor: Colors.grey[400]),
              _RankItem(rank: 3, name: "GreenEarth", level: 22, xp: 4600, isMe: false, customColor: Colors.brown[300]),
              _RankItem(rank: 4, name: "PenjagaLaut", level: 21, xp: 4400, isMe: false),
              _RankItem(rank: 5, name: "SamudraHero", level: 20, xp: 4200, isMe: false),
              _RankItem(rank: 6, name: "NelayanBaik", level: 19, xp: 4000, isMe: false),
              
              const SizedBox(height: 20),
              const Center(child: Text("[Scroll untuk lihat lebih banyak]", style: TextStyle(color: Colors.grey, fontSize: 12))),
            ],
          ),
        ),
        
        // Button Kembali ke Homepage
        Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: OutlinedButton(
              onPressed: () {
                // Kembali ke halaman utama (Index 0)
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const MainNavigationWrapper()),
                  (route) => false,
                );
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.primary),
                backgroundColor: Colors.white, // Button background putih
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("KEMBALI KE HOMEPAGE", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
            ),
          ),
        ),
      ],
    );
  }
}

// --- WIDGET HELPER ---

class _BadgeItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;

  const _BadgeItem({required this.icon, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color,
          radius: 18,
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(height: 8),
        Text(text, style: const TextStyle(fontSize: 10, color: Colors.black87)),
      ],
    );
  }
}

class _RankItem extends StatelessWidget {
  final int rank;
  final String name;
  final int level;
  final int xp;
  final bool isMe;
  final Color? customColor;

  const _RankItem({
    required this.rank,
    required this.name,
    required this.level,
    required this.xp,
    required this.isMe,
    this.customColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        // Jika ranking 1-3 dan ada custom color, gunakan gradient
        gradient: customColor != null 
          ? LinearGradient(colors: [customColor!, customColor!.withOpacity(0.7)])
          : null,
        color: customColor == null 
          ? Colors.white // Default putih
          : null,
        borderRadius: BorderRadius.circular(15),
        // Border biru jika user sendiri
        border: isMe ? Border.all(color: AppColors.primary, width: 2) : null, 
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 5, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          // Peringkat (Trophy atau Angka)
          if (rank <= 3) 
            Icon(Icons.emoji_events, color: customColor == null ? Colors.amber : Colors.white, size: 30)
          else
            Container(
              width: 30,
              alignment: Alignment.center,
              child: Text("#$rank", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey)),
            ),
          
          const SizedBox(width: 15),
          
          // Nama & Level
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: customColor != null ? Colors.white : AppColors.textDark,
                  ),
                ),
                Text(
                  "Lv.$level", 
                  style: TextStyle(
                    fontSize: 12, 
                    color: customColor != null ? Colors.white70 : Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          // XP
          Text(
            "$xp XP",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: customColor != null ? Colors.white : AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }
}