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
        // We add 1 to the length to make room for the video placeholder at the top
        itemCount: trainings.length + 1,
        itemBuilder: (context, index) {
          // If it's the very first item, show the video placeholder
          if (index == 0) {
            return _buildVideoPlaceholder();
          }
          // Otherwise, show the training cards (offset index by 1)
          final item = trainings[index - 1];
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
  // HELPER WIDGET: VIDEO PLACEHOLDER
  // ---------------------------------------------------------------------------
  Widget _buildVideoPlaceholder() {
    return Container(
      margin: const EdgeInsets.only(bottom: 24), // Space between video and first training card
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 15, offset: const Offset(0, 8)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Dark background representing the unloaded video
            Container(
              height: 210,
              width: double.infinity,
              color: const Color(0xFF1E1E1E),
              child: const Icon(Icons.ondemand_video, size: 80, color: Colors.white12),
            ),
            // Gradient overlay for text readability
            Container(
              height: 210,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.85)],
                ),
              ),
            ),
            // Play Button
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFC62828).withOpacity(0.95),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: const Color(0xFFC62828).withOpacity(0.4), blurRadius: 10, spreadRadius: 2),
                ],
              ),
              child: const Icon(Icons.play_arrow, color: Colors.white, size: 40),
            ),
            // Video Title and Duration Text
            Positioned(
              bottom: 16,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Intro RPEL/APEL & How To Use MyPortfolio',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, height: 1.3),
                  ),
                  SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.timer, color: Colors.white70, size: 14),
                      SizedBox(width: 4),
                      Text(
                        '5 mins • Required Viewing',
                        style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
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