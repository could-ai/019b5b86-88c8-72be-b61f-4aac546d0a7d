import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_data.dart';

class RawMaterialsScreen extends StatefulWidget {
  const RawMaterialsScreen({super.key});

  @override
  State<RawMaterialsScreen> createState() => _RawMaterialsScreenState();
}

class _RawMaterialsScreenState extends State<RawMaterialsScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المواد الخام'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: RawMaterialSearchDelegate(),
              );
            },
          ),
        ],
      ),
      body: Consumer<AppData>(
        builder: (context, appData, child) {
          final filteredMaterials = appData.rawMaterials
              .where((material) => material.name.contains(_searchQuery))
              .toList()
            ..sort((a, b) => a.name.compareTo(b.name));

          return ListView.builder(
            itemCount: filteredMaterials.length,
            itemBuilder: (context, index) {
              final material = filteredMaterials[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  title: Text(material.name),
                  subtitle: Text('₪${material.pricePerKg.toStringAsFixed(2)} / كجم'),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      // Edit material
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new material
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class RawMaterialSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Consumer<AppData>(
      builder: (context, appData, child) {
        final results = appData.rawMaterials
            .where((material) => material.name.toLowerCase().contains(query.toLowerCase()))
            .toList()
          ..sort((a, b) => a.name.compareTo(b.name));

        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            final material = results[index];
            return ListTile(
              title: Text(material.name),
              subtitle: Text('₪${material.pricePerKg.toStringAsFixed(2)} / كجم'),
              onTap: () {
                close(context, material);
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}