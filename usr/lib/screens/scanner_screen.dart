import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf_text/pdf_text.dart';
import 'dart:io';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  File? _image;
  String _extractedText = '';

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      // TODO: Analyze image for blend components
      // For now, just set a placeholder
      setState(() {
        _extractedText = 'تم استخراج المكونات من الصورة (ميزة تجريبية)';
      });
    }
  }

  Future<void> _pickPDF() async {
    // TODO: Implement PDF picker
    // For now, just set a placeholder
    setState(() {
      _extractedText = 'تم استخراج المكونات من ملف PDF (ميزة تجريبية)';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الماسح الضوئي'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.image),
                  label: const Text('اختر صورة'),
                ),
                ElevatedButton.icon(
                  onPressed: _pickPDF,
                  icon: const Icon(Icons.picture_as_pdf),
                  label: const Text('اختر PDF'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (_image != null)
              Image.file(_image!, height: 200, fit: BoxFit.cover),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SingleChildScrollView(
                  child: Text(_extractedText.isEmpty ? 'النص المستخرج سيظهر هنا' : _extractedText),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _extractedText.isNotEmpty ? () {
                // TODO: Save extracted components to blends
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم حفظ الخلطة')),
                );
              } : null,
              child: const Text('حفظ الخلطة'),
            ),
          ],
        ),
      ),
    );
  }
}