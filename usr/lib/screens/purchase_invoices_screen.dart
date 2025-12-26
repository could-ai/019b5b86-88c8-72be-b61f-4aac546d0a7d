import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_data.dart';

class PurchaseInvoicesScreen extends StatelessWidget {
  const PurchaseInvoicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('فواتير الشراء'),
      ),
      body: Consumer<AppData>(
        builder: (context, appData, child) {
          return ListView.builder(
            itemCount: appData.invoices.length,
            itemBuilder: (context, index) {
              final invoice = appData.invoices[index];
              return Card(
                margin: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('المورد: ${invoice.supplierName}'),
                          Text('التاريخ: ${invoice.date.toString().split(' ')[0]}'),
                        ],
                      ),
                      Text('رقم الفاتورة: ${invoice.invoiceNumber}'),
                      const SizedBox(height: 16),
                      const Text('محتويات الفاتورة:', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      DataTable(
                        columns: const [
                          DataColumn(label: Text('رقم')),
                          DataColumn(label: Text('المادة')),
                          DataColumn(label: Text('الوزن')),
                          DataColumn(label: Text('السعر')),
                          DataColumn(label: Text('المبلغ')),
                        ],
                        rows: invoice.items.map((item) {
                          return DataRow(cells: [
                            DataCell(Container(
                              width: 30,
                              height: 30,
                              color: Colors.blue,
                              child: Center(
                                child: Text(
                                  '${invoice.items.indexOf(item) + 1}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            )),
                            DataCell(Text(item.material.name)),
                            DataCell(Text('${item.weight} كجم')),
                            DataCell(Text('₪${item.pricePerKg.toStringAsFixed(2)}')),
                            DataCell(Text('₪${(item.weight * item.pricePerKg).toStringAsFixed(2)}')),
                          ]);
                        }).toList(),
                      ),
                      const Divider(),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'المجموع: ₪${invoice.totalAmount.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new invoice
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}