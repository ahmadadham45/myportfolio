import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      backgroundColor: Colors.grey[100],
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
          String role = userData['role'] ?? 'Student';
          String studentId = userData['student_id'] ?? 'N/A';

          return SingleChildScrollView(
            child: Column(
              children: [
                // ==========================================
                // SECTION 1: TNG-INSPIRED HEADER & PROFILE CARD
                // ==========================================
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topCenter,
                  children: [
                    // The Curved Red Background (Height increased)
                    Container(
                      height: 260,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0xFFC62828),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(35),
                          bottomRight: Radius.circular(35),
                        ),
                      ),
                      child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 25.0, right: 15.0, top: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Overview',
                                style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                icon: const Icon(Icons.logout, color: Colors.white, size: 28),
                                onPressed: () async {
                                  await FirebaseAuth.instance.signOut();
                                  if (context.mounted) {
                                    Navigator.pushReplacementNamed(context, '/');
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    
                    // The Overlapping Profile Card (Pushed down)
                    Positioned(
                      top: 140,
                      left: 20,
                      right: 20,
                      child: Card(
                        elevation: 8,
                        shadowColor: Colors.black26,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                        child: Padding(
                          padding: const EdgeInsets.all(22.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 35,
                                backgroundColor: Colors.grey[100],
                                child: const Icon(Icons.person, size: 40, color: Color(0xFFC62828)),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      name, 
                                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      role, 
                                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'ID: $studentId', 
                                      style: TextStyle(fontSize: 13, color: Colors.grey[500], fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 100), // Adjusted spacing below the card

                // ==========================================
                // SECTION 2: QUICK ACTION GRID
                // ==========================================
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Quick Actions', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 25),
                      // Row 1
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildActionIcon(context, Icons.folder_special, 'Vault', '/portfolio'),
                          _buildActionIcon(context, Icons.model_training, 'Training', '/training'),
                          _buildActionIcon(context, Icons.computer, 'eLearning', '/elearning'),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Row 2 (Balanced with a spacer)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildActionIcon(context, Icons.assessment, 'CPD', '/cpd'),
                          _buildActionIcon(context, Icons.forum, 'Forum', '/forum'),
                          // Invisible placeholder to keep the alignment identical to Row 1
                          const SizedBox(width: 70, height: 70), 
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // ==========================================
                // SECTION 3: AI RESUME BUILDER BANNER
                // ==========================================
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF283593), Color(0xFF3949AB)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5)),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.auto_awesome, color: Colors.white, size: 40),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'AI Resume Builder',
                                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 6),
                              Text(
                                'Generate a professional CV instantly',
                                style: TextStyle(color: Colors.white70, fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // HELPER WIDGET: ACTION ICON BUILDER
  // ---------------------------------------------------------------------------
  Widget _buildActionIcon(BuildContext context, IconData icon, String label, String route) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Column(
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3)),
              ],
            ),
            child: Icon(icon, color: const Color(0xFFC62828), size: 32),
          ),
          const SizedBox(height: 10),
          Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87)),
        ],
      ),
    );
  }
}