import 'package:flutter/material.dart';
import 'data_models.dart';

class AppData extends ChangeNotifier {
  final List<RawMaterial> _rawMaterials = [
    RawMaterial(name: 'فلفل أسود', pricePerKg: 50.00),
    RawMaterial(name: 'كمون', pricePerKg: 40.00),
    RawMaterial(name: 'كركم', pricePerKg: 35.00),
    RawMaterial(name: 'قرفة', pricePerKg: 60.00),
  ];

  final List<Blend> _blends = [
    Blend(
      name: 'خلطة كاري',
      ingredients: [
        Ingredient(material: RawMaterial(name: 'كركم', pricePerKg: 35.00), weight: 0.5),
        Ingredient(material: RawMaterial(name: 'كمون', pricePerKg: 40.00), weight: 0.3),
        Ingredient(material: RawMaterial(name: 'فلفل أسود', pricePerKg: 50.00), weight: 0.2),
      ],
    ),
  ];

  final List<ProductionRecord> _productionRecords = [
    ProductionRecord(
      blend: Blend(
        name: 'خلطة كاري',
        ingredients: [
          Ingredient(material: RawMaterial(name: 'كركم', pricePerKg: 35.00), weight: 0.5),
        ],
      ),
      quantity: 10.0,
      date: DateTime.now(),
    ),
  ];

  final List<Invoice> _invoices = [
    Invoice(
      supplierName: 'مورد التوابل',
      date: DateTime.now(),
      invoiceNumber: 1,
      items: [
        InvoiceItem(
          material: RawMaterial(name: 'فلفل أسود', pricePerKg: 50.00),
          weight: 5.0,
          pricePerKg: 50.00,
        ),
      ],
    ),
  ];

  List<RawMaterial> get rawMaterials => _rawMaterials;
  List<Blend> get blends => _blends;
  List<ProductionRecord> get productionRecords => _productionRecords;
  List<Invoice> get invoices => _invoices;

  void addRawMaterial(RawMaterial material) {
    _rawMaterials.add(material);
    notifyListeners();
  }

  void addBlend(Blend blend) {
    _blends.add(blend);
    notifyListeners();
  }

  void addProductionRecord(ProductionRecord record) {
    _productionRecords.add(record);
    notifyListeners();
  }

  void addInvoice(Invoice invoice) {
    _invoices.add(invoice);
    notifyListeners();
  }
}