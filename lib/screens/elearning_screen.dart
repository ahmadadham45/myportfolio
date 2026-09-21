import 'package:flutter/material.dart';

class ElearningScreen extends StatelessWidget {
  const ElearningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Learning Hub'),
        elevation: 1,
        actions: [
          // A search icon at the top right for future functionality
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Search feature coming soon!')),
              );
            },
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Recommended for You',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          
          // Using our helper widget to generate beautiful course cards
          _buildCourseCard(
            context,
            title: 'SQL Query Optimization & Database Interoperability',
            category: 'Database Engineering',
            duration: '4 Modules',
            icon: Icons.storage,
            color: Colors.blueAccent,
          ),
          _buildCourseCard(
            context,
            title: 'Building Cross-Platform Apps with Flutter & Dart',
            category: 'Mobile Development',
            duration: '6 Modules',
            icon: Icons.phone_android,
            color: Colors.green,
          ),
          _buildCourseCard(
            context,
            title: 'Official MQA APEL Portfolio Preparation Guide',
            category: 'Accreditation',
            duration: '1 Module',
            icon: Icons.school,
            color: const Color(0xFFC62828), // Your signature red theme
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // HELPER WIDGET: COURSE CARD BUILDER
  // Creates a structured, clickable card for each course in the list.
  // ---------------------------------------------------------------------------
  Widget _buildCourseCard(BuildContext context, {
    required String title,
    required String category,
    required String duration,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Opening course: $title')),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Left Side: Colored Icon Box
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 32, color: color),
              ),
              const SizedBox(width: 16),
              
              // Right Side: Course Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category,
                      style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      title,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.play_circle_outline, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(duration, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}