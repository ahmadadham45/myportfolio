import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'edit_profile_screen.dart';

// -----------------------------------------------------------------------------
// DASHBOARD SCREEN
// -----------------------------------------------------------------------------
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  Future<DocumentSnapshot> _getUserProfile() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      return await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();
    }
    throw Exception("No user logged in");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9), // Very light grey/white background
      body: FutureBuilder<DocumentSnapshot>(
        future: _getUserProfile(),
        builder: (context, snapshot) {
          
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFFC62828)));
          }

          if (snapshot.hasError || !snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text("Error: Could not load profile."));
          }

          var userData = snapshot.data!.data() as Map<String, dynamic>;
          String name = userData['name'] ?? 'Unknown User';
          String role = userData['role'] ?? 'Professional Portfolio Platform';
          
          return SingleChildScrollView(
            child: Column(
              children: [
                // ==========================================
                // SECTION 1: HEADER & PROFILE CARD
                // ==========================================
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topCenter,
                  children: [
                    // Deep Red Header
                    Container(
                      height: 260,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0xFFD31A21), 
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Logo & Title
                              Row(
                                children: [
                                  // APP LOGO BESIDE HEADER TITLE
                                  Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.white, width: 1.5),
                                      image: const DecorationImage(
                                        image: AssetImage('assets/appLogo.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Text(
                                        'MyPortfolio',
                                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Professional Portfolio Platform',
                                        style: TextStyle(color: Colors.white70, fontSize: 10),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              // Notification & Logout Actions
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Stack(
                                    children: [
                                      const Icon(Icons.notifications_none, color: Colors.white, size: 28),
                                      Positioned(
                                        right: 0,
                                        top: 0,
                                        child: Container(
                                          padding: const EdgeInsets.all(3),
                                          decoration: const BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
                                          child: const Text('3', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(width: 15),
                                  GestureDetector(
                                    onTap: () async {
                                      await FirebaseAuth.instance.signOut();
                                      if (context.mounted) {
                                        Navigator.pushReplacementNamed(context, '/');
                                      }
                                    },
                                    child: const Icon(Icons.logout, color: Colors.white, size: 28),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    
                    // The Overlapping Profile Card (Now acts as a button)
                    Positioned(
                      top: 100,
                      left: 20,
                      right: 20,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const EditProfileScreen()),
                          );
                        },
                        child: Card(
                          elevation: 8,
                          shadowColor: Colors.black.withOpacity(0.1),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // GENERIC PROFESSIONAL USER AVATAR
                                    Container(
                                      width: 70,
                                      height: 70,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey[300],
                                      ),
                                      child: const Icon(Icons.person, size: 45, color: Colors.white),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Hello,', 
                                            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            name, 
                                            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Colors.black87),
                                            maxLines: 1, 
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            role, 
                                            style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                // Premium Member Badge
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFD31A21),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Icon(Icons.workspace_premium, color: Colors.white, size: 16),
                                      SizedBox(width: 6),
                                      Text('Premium Member', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 90), 

                // ==========================================
                // SECTION 2: QUICK ACTIONS (3x2 GRID)
                // ==========================================
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Quick Actions', 
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                          ),
                          Row(
                            children: const [
                              Text('Customise', style: TextStyle(color: Color(0xFFD31A21), fontSize: 13, fontWeight: FontWeight.bold)),
                              SizedBox(width: 4),
                              Icon(Icons.edit, color: Color(0xFFD31A21), size: 14),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      
                      // Row 1
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildMockupAction(context, Icons.business_center, 'My Portfolio', '/portfolio'),
                          _buildMockupAction(context, Icons.format_list_bulleted, 'Training Log', '/training'),
                          _buildMockupAction(context, Icons.ondemand_video, 'E-Learning', '/elearning'),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Row 2
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildMockupAction(context, Icons.stars, 'CPD Records', '/cpd'),
                          _buildMockupAction(context, Icons.document_scanner, 'Resume Builder AI', '/resume'),
                          _buildMockupAction(context, Icons.forum, 'Discussion Forum', '/forum'),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // ==========================================
                // SECTION 3: AI RESUME BUILDER BANNER
                // ==========================================
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF0F0), // Light pink/red background
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Build your professional profile with AI Resume Builder.',
                                style: TextStyle(color: Colors.black87, fontSize: 15, fontWeight: FontWeight.bold, height: 1.3),
                              ),
                              const SizedBox(height: 12),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/resume');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFD31A21),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  elevation: 0,
                                ),
                                child: const Text('Try Now', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 80,
                            decoration: const BoxDecoration(
                              color: Color(0xFFD31A21),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(Icons.description, color: Colors.white, size: 36),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Extra space at bottom to account for standard scrolling
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
      
      // ==========================================
      // ADD THIS NEW BOTTOM NAVIGATION BAR BLOCK
      // ==========================================
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5)),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFFD31A21),
          unselectedItemColor: Colors.grey[500],
          selectedFontSize: 11,
          unselectedFontSize: 11,
          currentIndex: 0, // 0 means 'Home' is currently highlighted
          onTap: (index) {
            // Map the taps to your newly registered routes
            if (index == 1) Navigator.pushNamed(context, '/portfolio');
            if (index == 2) Navigator.pushNamed(context, '/training');
            if (index == 3) Navigator.pushNamed(context, '/resume');
            if (index == 4) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfileScreen()));
            }
          },
          items: [
            const BottomNavigationBarItem(
              icon: Padding(padding: EdgeInsets.only(bottom: 4), child: Icon(Icons.home, size: 24)), 
              label: 'Home',
            ),
            const BottomNavigationBarItem(
              icon: Padding(padding: EdgeInsets.only(bottom: 4), child: Icon(Icons.work_outline, size: 24)), 
              label: 'Portfolio',
            ),
            const BottomNavigationBarItem(
              icon: Padding(padding: EdgeInsets.only(bottom: 4), child: Icon(Icons.menu_book, size: 24)), 
              label: 'Training',
            ),
            // Custom styling to mimic the prominent AI button from the mockup
            BottomNavigationBarItem(
              icon: Container(
                margin: const EdgeInsets.only(bottom: 4),
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color(0xFFD31A21),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.auto_awesome, color: Colors.white, size: 20),
              ),
              label: 'AI Builder',
            ),
            const BottomNavigationBarItem(
              icon: Padding(padding: EdgeInsets.only(bottom: 4), child: Icon(Icons.person_outline, size: 24)), 
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // HELPER WIDGET: MOCKUP ACTION CARD
  // ---------------------------------------------------------------------------
  Widget _buildMockupAction(BuildContext context, IconData icon, String label, String route) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (route.isNotEmpty) {
            Navigator.pushNamed(context, route);
          } else {
             ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Module coming soon!")));
          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02), 
                blurRadius: 5, 
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: const Color(0xFFD31A21), size: 32),
              const SizedBox(height: 10),
              Text(
                label, 
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}