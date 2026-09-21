import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
// TRAINING LOG SCREEN (Acts as the Non-Formal Learning Module)
// -----------------------------------------------------------------------------
class TrainingScreen extends StatelessWidget {
  const TrainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Hardcoded data matching the supervisor's exact screenshot design
    final List<Map<String, dynamic>> trainings = [
      {
        'title': 'Inventory Management & Logistics Workshop',
        'provider': 'Supply Chain Pro Academy',
        'date': '12 Apr 2026',
        'duration': '8 Hours',
        'status': 'Completed',
      },
      {
        'title': 'Cross-Platform Mobile Development',
        'provider': 'Tech Innovators Society',
        'date': '05 Mar 2026',
        'duration': '12 Hours',
        'status': 'Completed',
      },
      {
        'title': 'Warehouse Occupational Safety (OSHA)',
        'provider': 'National Safety Board',
        'date': '20 Feb 2026',
        'duration': '4 Hours',
        'status': 'Completed',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text('Training Log', style: TextStyle(color: Colors.black, fontSize: 22)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: trainings.length,
        itemBuilder: (context, index) {
          final item = trainings[index];
          return _buildTrainingCard(item);
        },
      ),
      // The floating "+" button matching the screenshot
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Add Training Function coming soon!')),
          );
        },
        backgroundColor: const Color(0xFFC62828),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // HELPER WIDGET: TRAINING CARD BUILDER
  // ---------------------------------------------------------------------------
  Widget _buildTrainingCard(Map<String, dynamic> item) {
    return Card(
      color: const Color(0xFFFDEAEB), // Light red/pinkish background from the image
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row 1: Title and Status Badge
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    item['title'],
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFC8E6C9), // Light green background
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    item['status'],
                    style: const TextStyle(color: Color(0xFF2E7D32), fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            
            // Row 2: Provider (Building Icon)
            Row(
              children: [
                const Icon(Icons.domain, size: 18, color: Colors.grey),
                const SizedBox(width: 8),
                Text(item['provider'], style: TextStyle(color: Colors.grey[700], fontSize: 14)),
              ],
            ),
            const SizedBox(height: 10),
            
            // Row 3: Date and Duration
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(item['date'], style: TextStyle(color: Colors.grey[700], fontSize: 14)),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 16, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(item['duration'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}