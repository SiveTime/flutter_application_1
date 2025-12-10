import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../utils/dashed_rect_painter.dart';
import 'success_screen.dart';

class ReportFormScreen extends StatefulWidget {
  const ReportFormScreen({super.key});
  @override
  State<ReportFormScreen> createState() => _ReportFormScreenState();
}

class _ReportFormScreenState extends State<ReportFormScreen> {
  String? _selectedCategory;
  String _selectedUnit = 'kg';
  final TextEditingController _weightController = TextEditingController();
  
  // Variabel metrik dampak
  double _impactArea = 0;
  double _impactCo2 = 0;

  // Data Kategori beserta Ikonnya
  // Menggunakan static const atau menginisialisasi di dalam build/initState bisa mencegah isu ini
  final Map<String, IconData> _categoriesWithIcons = {
    "Plastik": Icons.local_drink,
    "Organik": Icons.eco,
    "Kertas": Icons.description,
    "Logam": Icons.settings,
    "Lainnya": Icons.category,
  };

  @override
  void initState() {
    super.initState();
    _weightController.addListener(_updateMetrics);
  }

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }

  void _updateMetrics() {
    setState(() {
      double weight = double.tryParse(_weightController.text) ?? 0;
      
      // Normalisasi ke kg untuk perhitungan
      double weightInKg = weight;
      if (_selectedUnit == 'gram') weightInKg = weight / 1000;
      if (_selectedUnit == 'ton') weightInKg = weight * 1000;

      // Rumus Mock
      _impactArea = weightInKg * 2.0;
      _impactCo2 = weightInKg * 0.16;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form Pelaporan Sampah"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Center(child: Text("1/5", style: TextStyle(fontSize: 16))),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Upload Foto
            _sectionLabel("Foto Sampah *", Icons.camera_alt),
            const SizedBox(height: 10),
            Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: CustomPaint(
                painter: DashedRectPainter(color: Colors.grey, strokeWidth: 1, gap: 4),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.camera_alt, color: Colors.white, size: 28),
                      ),
                      const SizedBox(height: 10),
                      const Text("Tap untuk upload foto", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            
            // 2. Kategori Sampah (Dengan Logo/Icon)
            _sectionLabel("Kategori Sampah *", Icons.category),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: _inputDeco("Pilih kategori"),
              // Menggunakan .keys.map(...) daripada .entries.map(...) untuk kompatibilitas yang lebih aman
              items: _categoriesWithIcons.keys.map((String key) {
                return DropdownMenuItem<String>(
                  value: key,
                  child: Row(
                    children: [
                      Icon(_categoriesWithIcons[key], size: 20, color: AppColors.primary), // Logo Kategori
                      const SizedBox(width: 12),
                      Text(key),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (val) {
                setState(() => _selectedCategory = val);
              },
            ),
            const SizedBox(height: 25),

            // 3. Berat Sampah & Satuan
            _sectionLabel("Berat Sampah *", Icons.scale),
            const SizedBox(height: 10),
            Row(
              children: [
                // Input Angka Berat
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    decoration: _inputDeco("0").copyWith(
                      suffixText: _selectedUnit, // Menampilkan satuan di dalam input juga
                      suffixStyle: const TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Pilihan Satuan (Dropdown)
                Expanded(
                  flex: 1,
                  child: DropdownButtonFormField<String>(
                    value: _selectedUnit,
                    decoration: _inputDeco("Satuan").copyWith(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    ),
                    items: ["gram", "kg", "ton"].map((unit) {
                      return DropdownMenuItem(value: unit, child: Text(unit));
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() {
                          _selectedUnit = val;
                          _updateMetrics();
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),

            // 4. Deskripsi
            _sectionLabel("Deskripsi (Opsional)", Icons.description),
            const SizedBox(height: 10),
            TextFormField(
              maxLines: 3,
              decoration: _inputDeco("Tambahkan deskripsi..."),
            ),
            const SizedBox(height: 25),

            // 5. Lokasi
            _sectionLabel("Lokasi", Icons.location_on),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: AppColors.primaryDark),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Jl. Sudirman, Jakarta Pusat", style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("Lat: -6.2088, Long: 106.8456", style: TextStyle(fontSize: 10, color: Colors.grey)),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {}, 
                    child: const Text("Ubah", style: TextStyle(color: AppColors.primary))
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),

            // 6. Metrik Dampak
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFE0F7FA), // Light Cyan
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primary.withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Estimasi Dampak:", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryDark)),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _metricItem(Icons.grass, "Luas Bersih", "${_impactArea.toStringAsFixed(1)} m²"),
                      Container(height: 40, width: 1, color: Colors.grey[300]),
                      _metricItem(Icons.cloud_off, "Reduksi CO₂", "${_impactCo2.toStringAsFixed(2)} kg"),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Button Action
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const SuccessScreen()),
                  );
                },
                child: const Text("KIRIM LAPORAN", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("BATAL", style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(String label, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.textDark),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textDark)),
      ],
    );
  }

  Widget _metricItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primary),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
      ],
    );
  }

  InputDecoration _inputDeco(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.primary)),
    );
  }
}