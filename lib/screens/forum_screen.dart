import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ForumScreen extends StatelessWidget {
  const ForumScreen({super.key});

  Future<void> _launchURL(BuildContext context, String url) async {
    final Uri uri = Uri.parse(url);
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not open the community link. Please check your connection.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // DefaultTabController automatically manages the tab state for us
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F7FA),
        appBar: AppBar(
          title: const Text('Community Groups'),
          backgroundColor: const Color(0xFFC62828),
          elevation: 0,
          // The TabBar sits at the bottom of the AppBar
          bottom: const TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 4,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            tabs: [
              Tab(icon: Icon(Icons.chat), text: 'WhatsApp'),
              Tab(icon: Icon(Icons.send), text: 'Telegram'),
              Tab(icon: Icon(Icons.share), text: 'Others'),
            ],
          ),
        ),
        // TabBarView contains the actual screens for each tab in order
        body: TabBarView(
          children: [
            // ==========================================
            // TAB 1: WHATSAPP
            // ==========================================
            _buildTabContent(
              context: context,
              title: 'MyPortfolio Innovation',
              subtitle: 'Official WhatsApp Channel\nGet the latest APEL/RPEL updates directly on WhatsApp.',
              icon: Icons.chat,
              color: const Color(0xFF25D366),
              url: 'https://whatsapp.com/channel/0029VbE4s71IN9ifgZXNVq1g',
            ),

            // ==========================================
            // TAB 2: TELEGRAM
            // ==========================================
            _buildTabContent(
              context: context,
              title: 'MyPortfolio Innovation',
              subtitle: 'Official Telegram Channel\nJoin the discussion and share resources with peers.',
              icon: Icons.send,
              color: const Color(0xFF0088cc),
              url: 'https://t.me/+47T1XAEk9yxlOGZl',
            ),

            // ==========================================
            // TAB 3: OTHERS (FUTURE DEVELOPMENT)
            // ==========================================
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.public, size: 64, color: Colors.grey[400]),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'More Platforms Coming Soon',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueGrey[700]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Future updates will include additional\nsocial media channels.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.blueGrey[400], height: 1.4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget to build the content inside the active tabs
  Widget _buildTabContent({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required String url,
  }) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Join the Conversation',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF2C3E50)),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap the card below to open the external application and join the community group.',
            style: TextStyle(fontSize: 15, color: Colors.blueGrey[600], height: 1.4),
          ),
          const SizedBox(height: 32),
          InkWell(
            onTap: () => _launchURL(context, url),
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.15),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
                border: Border.all(color: color.withOpacity(0.3), width: 1.5),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: Colors.white, size: 36),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2C3E50)),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          subtitle,
                          style: TextStyle(fontSize: 13, color: Colors.blueGrey[600], height: 1.3),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}