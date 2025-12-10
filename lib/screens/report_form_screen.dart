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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FORM PELAPORAN SAMPAH"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Upload Area
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                // Border dibuat invisible karena pakai CustomPaint
                border: Border.all(color: Colors.transparent), 
              ),
              child: CustomPaint(
                painter: DashedRectPainter(color: AppColors.primary, strokeWidth: 2, gap: 5),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Icon(Icons.camera_alt, color: AppColors.primaryDark),
                           SizedBox(width: 5),
                           Text("Upload Foto *", style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text("[Tap untuk upload foto]", style: TextStyle(color: Colors.grey[500])),
                      const SizedBox(height: 10),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt, size: 30, color: AppColors.primaryDark),
                          SizedBox(width: 20),
                          Icon(Icons.image, size: 30, color: AppColors.primaryDark),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Form Fields Container
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel("Kategori Sampah *", Icons.category),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    decoration: _inputDecoration("Pilih kategori"),
                    items: ["Plastik", "Organik", "B3", "Logam"].map((e) {
                      return DropdownMenuItem(value: e, child: Text(e));
                    }).toList(),
                    onChanged: (val) {},
                  ),
                  const SizedBox(height: 20),

                  _buildLabel("Deskripsi (opsional)", Icons.description),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: _inputDecoration("Tambahkan deskripsi..."),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 20),

                  _buildLabel("Lokasi", Icons.location_on),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
                      children: [
                        Expanded(child: Text("[GPS: Jl. Sudirman, Jakarta]")),
                        Icon(Icons.location_on, color: AppColors.primaryDark),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "[Atau pilih manual di peta]",
                      style: TextStyle(
                          color: AppColors.primaryDark,
                          decoration: TextDecoration.underline),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Button Submit
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const SuccessScreen()),
                  );
                },
                child: const Text("KIRIM LAPORAN", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            )
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
    );
  }

  Widget _buildLabel(String text, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.primaryDark),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ],
    );
  }
}