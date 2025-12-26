import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'models/app_data.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppData(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'سجل خلطات البهارات',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
        fontFamily: 'Cairo',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/raw_materials': (context) => const RawMaterialsScreen(),
        '/blends': (context) => const BlendsScreen(),
        '/cost_calculator': (context) => const CostCalculatorScreen(),
        '/production_record': (context) => const ProductionRecordScreen(),
        '/purchase_invoices': (context) => const PurchaseInvoicesScreen(),
        '/scanner': (context) => const ScannerScreen(),
        '/units': (context) => const UnitsScreen(),
        '/reports': (context) => const ReportsScreen(),
      },
    );
  }
}