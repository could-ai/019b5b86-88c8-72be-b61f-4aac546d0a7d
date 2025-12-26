import 'package:flutter/material.dart';

class RawMaterial {
  final String name;
  final double pricePerKg;

  RawMaterial({required this.name, required this.pricePerKg});
}

class Ingredient {
  final RawMaterial material;
  final double weight;

  Ingredient({required this.material, required this.weight});
}

class Blend {
  final String name;
  final List<Ingredient> ingredients;
  late final double totalWeight;
  late final double totalCost;

  Blend({required this.name, required this.ingredients}) {
    totalWeight = ingredients.fold(0, (sum, item) => sum + item.weight);
    totalCost = ingredients.fold(0, (sum, item) => sum + (item.weight * item.material.pricePerKg));
  }
}

class ProductionRecord {
  final Blend blend;
  final double quantity;
  final DateTime date;
  late final double totalCost;

  ProductionRecord({required this.blend, required this.quantity, required this.date}) {
    totalCost = quantity * (blend.totalCost / blend.totalWeight);
  }
}

class InvoiceItem {
  final RawMaterial material;
  final double weight;
  final double pricePerKg;

  InvoiceItem({required this.material, required this.weight, required this.pricePerKg});
}

class Invoice {
  final String supplierName;
  final DateTime date;
  final int invoiceNumber;
  final List<InvoiceItem> items;
  late final double totalAmount;

  Invoice({
    required this.supplierName,
    required this.date,
    required this.invoiceNumber,
    required this.items,
  }) {
    totalAmount = items.fold(0, (sum, item) => sum + (item.weight * item.pricePerKg));
  }
}