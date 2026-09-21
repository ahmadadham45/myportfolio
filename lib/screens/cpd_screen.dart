import 'package:flutter/material.dart';

class CpdScreen extends StatelessWidget {
  const CpdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text('CPD Tracker', style: TextStyle(color: Colors.black, fontSize: 22)),
      ),
      // Upgraded to a floating action button with a text label for clarity
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFFC62828),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Submit new CPD evidence coming soon!')),
          );
        },
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Log Points', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Section: The visual progress tracker
            _buildProgressCard(),
            
            const SizedBox(height: 30),
            
            // Bottom Section: History of logged points
            const Text(
              'Recent Activities',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 15),
            _buildActivityCard(context, 'Advanced Database Optimization', '15 May 2026', '+4 Points'),
            _buildActivityCard(context, 'MBOT Professional Ethics', '20 Apr 2026', '+2 Points'),
            _buildActivityCard(context, 'Cross-Platform App Seminar', '05 Mar 2026', '+6 Points'),
            const SizedBox(height: 60), // Extra padding so the FAB doesn't hide the last item
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // HELPER WIDGET: CIRCULAR PROGRESS CARD
  // ---------------------------------------------------------------------------
  Widget _buildProgressCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25.0),
      decoration: BoxDecoration(
        color: const Color(0xFFC62828), // Deep red theme background
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5)),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Current Year Progress (2026)',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 25),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 120,
                width: 120,
                child: CircularProgressIndicator(
                  value: 12 / 20, // 60% completion
                  strokeWidth: 12,
                  backgroundColor: Colors.white.withOpacity(0.2), // Faded white background ring
                  color: Colors.white, // Solid white progress ring
                ),
              ),
              Column(
                children: const [
                  Text('12', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
                  Text('/ 20 pts', style: TextStyle(fontSize: 14, color: Colors.white70)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 25),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              '8 more points needed this year',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // HELPER WIDGET: ACTIVITY LIST ITEM
  // ---------------------------------------------------------------------------
  Widget _buildActivityCard(BuildContext context, String title, String date, String points) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[50], // Very light grey to pop against the white Scaffold
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFFDEAEB), // Light red matching the Training module
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.star, color: Color(0xFFC62828), size: 24),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87),
                ),
                const SizedBox(height: 5),
                Text(
                  date,
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(
            points,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E7D32), // Green to indicate a successful addition
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}