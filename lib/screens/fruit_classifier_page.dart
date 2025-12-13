import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class FruitClassifierPage extends StatefulWidget {
  const FruitClassifierPage({Key? key}) : super(key: key);

  @override
  State<FruitClassifierPage> createState() => _FruitClassifierPageState();
}

class _FruitClassifierPageState extends State<FruitClassifierPage> {
  String? _modelInfo;
  bool _loading = false;


  Future<void> _showModelInfo() async {
    setState(() => _loading = true);
    try {
      final data = await rootBundle.load('assets/model/model.tflite');
      setState(() {
        _modelInfo = 'model.tflite\nSize: ${data.lengthInBytes} bytes';
      });
    } catch (e) {
      setState(() {
        _modelInfo = 'Error loading model: $e';
      });
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Model Info',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5),
        ),
        backgroundColor: Colors.teal.shade700,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _loading ? null : _showModelInfo,
              child: const Text('Show model.tflite info'),
            ),
            const SizedBox(height: 20),
            if (_loading) const CircularProgressIndicator(),
            if (_modelInfo != null) Text(_modelInfo!),
          ],
        ),
      ),
    );
  }
}
