import 'package:flutter/material.dart';

class ResumeBuilderScreen extends StatelessWidget {
  const ResumeBuilderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: const Text('AI Resume Builder', style: TextStyle(color: Colors.white, fontSize: 18)),
        backgroundColor: const Color(0xFFD31A21),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFFD31A21).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.document_scanner, size: 80, color: Color(0xFFD31A21)),
              ),
              const SizedBox(height: 32),
              const Text(
                'AI Generation Engine',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 12),
              const Text(
                'The automated CV generation algorithm is currently under construction. Check back soon!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.black54, height: 1.4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}