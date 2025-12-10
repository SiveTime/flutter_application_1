import 'package:flutter/material.dart';

class ImpactDashboardScreen extends StatelessWidget {
  const ImpactDashboardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Aktivitas Dampak")),
      body: const Center(child: Text("Halaman Statistik Dampak")),
    );
  }
}