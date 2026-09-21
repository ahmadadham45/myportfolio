import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // --- PART 1: The App Bar and CV Download Icon ---
      appBar: AppBar(
        title: const Text('My Profile'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.file_download),
            tooltip: 'Download CV',
            onPressed: () {
              // This creates a small popup message at the bottom of the screen
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Downloading CV...')),
              );
            },
          ),
        ],
      ),
      
      // SingleChildScrollView prevents the screen from breaking on small phones
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Aligns text to the left
          children: [
            
            // --- PART 2: Personal Details Section ---
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blueAccent,
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Ahmad Adham',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Computer Science Student',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            const Divider(), // Adds a clean line to separate sections
            const SizedBox(height: 16),

            // --- PART 3: Education Summary ---
            const Text(
              'Education Summary',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: const ListTile(
                leading: Icon(Icons.school, color: Colors.blueAccent),
                title: Text('Universiti Teknologi MARA (UiTM)'),
                subtitle: Text('Degree in Computer Science (CDCS230)'),
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
              ),
            ),
            
            const SizedBox(height: 24),

            // --- PART 4: Career Summary ---
            const Text(
              'Career Summary',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: const ListTile(
                leading: Icon(Icons.work, color: Colors.orangeAccent),
                title: Text('Warehouse Picker and Packer'),
                subtitle: Text('Inventory Management & Logistics'),
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}