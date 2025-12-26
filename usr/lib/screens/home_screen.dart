import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {'title': 'المواد الخام', 'icon': Icons.inventory, 'color': Colors.red, 'route': '/raw_materials'},
      {'title': 'الخلطات', 'icon': Icons.blender, 'color': Colors.blue, 'route': '/blends'},
      {'title': 'حاسبة التكلفة', 'icon': Icons.calculate, 'color': Colors.green, 'route': '/cost_calculator'},
      {'title': 'سجل الإنتاج', 'icon': Icons.history, 'color': Colors.purple, 'route': '/production_record'},
      {'title': 'فواتير الشراء', 'icon': Icons.receipt, 'color': Colors.orange, 'route': '/purchase_invoices'},
      {'title': 'الماسح الضوئي', 'icon': Icons.scanner, 'color': Colors.teal, 'route': '/scanner'},
      {'title': 'الوحدات', 'icon': Icons.straighten, 'color': Colors.pink, 'route': '/units'},
      {'title': 'التقارير', 'icon': Icons.bar_chart, 'color': Colors.indigo, 'route': '/reports'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('سجل خلطات البهارات'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1,
          ),
          itemCount: menuItems.length,
          itemBuilder: (context, index) {
            final item = menuItems[index];
            return Card(
              color: item['color'],
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, item['route']),
                borderRadius: BorderRadius.circular(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(item['icon'], size: 48, color: Colors.white),
                    const SizedBox(height: 8),
                    Text(
                      item['title'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}