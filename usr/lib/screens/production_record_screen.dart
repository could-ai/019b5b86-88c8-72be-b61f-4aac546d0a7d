import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_data.dart';

class ProductionRecordScreen extends StatelessWidget {
  const ProductionRecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سجل الإنتاج'),
      ),
      body: Consumer<AppData>(
        builder: (context, appData, child) {
          final sortedProductions = appData.productionRecords
            ..sort((a, b) => b.date.compareTo(a.date));

          return ListView.builder(
            itemCount: sortedProductions.length,
            itemBuilder: (context, index) {
              final record = sortedProductions[index];
              return Card(
                margin: const EdgeInsets.all(16),
                child: ListTile(
                  title: Text(record.blend.name),
                  subtitle: Text(
                    '${record.date.toString().split(' ')[0]} - ${record.quantity} كجم',
                  ),
                  trailing: Text('₪${record.totalCost.toStringAsFixed(2)}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}