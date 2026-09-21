import 'package:flutter/material.dart';

class ForumScreen extends StatelessWidget {
  const ForumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // DefaultTabController is required to manage the state of the tabs
    return DefaultTabController(
      length: 2, // We have 2 tabs: WhatsApp and Telegram
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Community Groups'),
          elevation: 1,
          backgroundColor: const Color(0xFFC62828), // The red theme
          // The TabBar sits at the bottom of the AppBar
          bottom: const TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 3.0,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(
                icon: Icon(Icons.chat), // Generic chat icon for WhatsApp
                text: 'WhatsApp',
              ),
              Tab(
                icon: Icon(Icons.send), // Generic send icon for Telegram
                text: 'Telegram',
              ),
            ],
          ),
        ),
        // TabBarView contains the actual screens for each tab.
        // The order here must match the order of the Tabs above.
        body: TabBarView(
          children: [
            // --- TAB 1: WHATSAPP ---
            _buildPlatformList(
              context,
              platformName: 'WhatsApp',
              iconColor: Colors.green,
              platformIcon: Icons.chat,
              groups: [
                {
                  'title': 'APEL.C Preparation Group',
                  'desc': 'Discussion for compiling experiential learning portfolios and sharing evidence templates.',
                  'members': '128 Members',
                },
                {
                  'title': 'CDCS230 Study Group',
                  'desc': 'General discussion and peer support for computer science subjects.',
                  'members': '56 Members',
                },
              ],
            ),

            // --- TAB 2: TELEGRAM ---
            _buildPlatformList(
              context,
              platformName: 'Telegram',
              iconColor: Colors.blue,
              platformIcon: Icons.send,
              groups: [
                {
                  'title': 'MQA Official Announcements',
                  'desc': 'One-way channel for the latest updates on APEL guidelines and CPD requirements.',
                  'members': '2.5k Subscribers',
                },
                {
                  'title': 'Dev Community Malaysia',
                  'desc': 'Networking and professional development events for IT professionals.',
                  'members': '8.2k Members',
                },
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // HELPER WIDGET: PLATFORM LIST BUILDER
  // Builds a standardized list of external links for whichever tab is active.
  // ---------------------------------------------------------------------------
  Widget _buildPlatformList(
    BuildContext context, {
    required String platformName,
    required Color iconColor,
    required IconData platformIcon,
    required List<Map<String, String>> groups,
  }) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: groups.length,
      itemBuilder: (context, index) {
        final group = groups[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16.0),
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              // In the final app, you would use the 'url_launcher' package here
              // to actually open the WhatsApp or Telegram link.
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Redirecting to ${group['title']} on $platformName...'),
                  backgroundColor: iconColor,
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // Platform Icon Indicator
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: iconColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(platformIcon, color: iconColor, size: 28),
                  ),
                  const SizedBox(width: 16),
                  // Group Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text(
                          group['title']!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          group['desc']!,
                          style: TextStyle(color: Colors.grey[700], fontSize: 13),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          group['members']!,
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  // External Link Icon to show it leaves the app
                  Icon(Icons.open_in_new, color: Colors.grey[400]),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}