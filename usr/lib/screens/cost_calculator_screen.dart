import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../models/app_data.dart';

class CostCalculatorScreen extends StatefulWidget {
  const CostCalculatorScreen({super.key});

  @override
  State<CostCalculatorScreen> createState() => _CostCalculatorScreenState();
}

class _CostCalculatorScreenState extends State<CostCalculatorScreen> {
  Blend? selectedBlend;
  double requiredWeight = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('حاسبة التكلفة'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<Blend>(
              decoration: const InputDecoration(
                labelText: 'اختر الخلطة',
                border: OutlineInputBorder(),
              ),
              value: selectedBlend,
              items: context.watch<AppData>().blends.map((blend) {
                return DropdownMenuItem(
                  value: blend,
                  child: Text(blend.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedBlend = value;
                });
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'الوزن المطلوب (كجم)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  requiredWeight = double.tryParse(value) ?? 0;
                });
              },
            ),
            const SizedBox(height: 16),
            if (selectedBlend != null && requiredWeight > 0)
              Expanded(
                child: Column(
                  children: [
                    const Text(
                      'الأوزان المطلوبة من المواد الخام:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('المادة')),
                          DataColumn(label: Text('الوزن المطلوب (كجم)')),
                        ],
                        rows: selectedBlend!.ingredients.map((ingredient) {
                          final requiredIngredientWeight =
                              (ingredient.weight / selectedBlend!.totalWeight) * requiredWeight;
                          return DataRow(cells: [
                            DataCell(Text(ingredient.material.name)),
                            DataCell(Text(requiredIngredientWeight.toStringAsFixed(2))),
                          ]);
                        }).toList(),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        final shareText = '''
الخلطة: ${selectedBlend!.name}
الوزن المطلوب: $requiredWeight كجم

المواد المطلوبة:
${selectedBlend!.ingredients.map((ing) {
                          final weight = (ing.weight / selectedBlend!.totalWeight) * requiredWeight;
                          return '${ing.material.name}: ${weight.toStringAsFixed(2)} كجم';
                        }).join('\n')}
                        ''';
                        Share.share(shareText, subject: 'حساب تكلفة الخلطة');
                      },
                      icon: const Icon(Icons.share),
                      label: const Text('مشاركة عبر واتساب'),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}