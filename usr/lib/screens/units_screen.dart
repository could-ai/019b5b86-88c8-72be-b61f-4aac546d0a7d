import 'package:flutter/material.dart';

class UnitsScreen extends StatelessWidget {
  const UnitsScreen({super.key});

  final List<Map<String, String>> units = const [
    {'unit': 'ملعقة كبيرة', 'equivalent': '8 غم'},
    {'unit': 'ملعقة صغيرة', 'equivalent': '3 غم'},
    {'unit': 'كوب', 'equivalent': '240 مل'},
    {'unit': 'ملعقة شاي', 'equivalent': '5 مل'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الوحدات المستخدمة'),
      ),
      body: ListView.builder(
        itemCount: units.length,
        itemBuilder: (context, index) {
          final unit = units[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(unit['unit']!),
              subtitle: Text('= ${unit['equivalent']}'),
            ),
          );
        },
      ),
    );
  }
}