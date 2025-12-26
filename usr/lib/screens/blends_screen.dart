import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_data.dart';

class BlendsScreen extends StatelessWidget {
  const BlendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الخلطات'),
      ),
      body: Consumer<AppData>(
        builder: (context, appData, child) {
          return ListView.builder(
            itemCount: appData.blends.length,
            itemBuilder: (context, index) {
              final blend = appData.blends[index];
              return Card(
                margin: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      color: Colors.orange,
                      child: Column(
                        children: [
                          Text(
                            'وزن الخلطة: ${blend.totalWeight} كجم',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'تكلفة الخلطة: ₪${blend.totalCost.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'تكلفة 1 كجم: ₪${(blend.totalCost / blend.totalWeight).toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    DataTable(
                      columns: const [
                        DataColumn(label: Text('المادة')),
                        DataColumn(label: Text('الوزن (كجم)')),
                      ],
                      rows: blend.ingredients.map((ingredient) {
                        return DataRow(cells: [
                          DataCell(Text(ingredient.material.name)),
                          DataCell(Text(ingredient.weight.toString())),
                        ]);
                      }).toList(),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new blend
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}