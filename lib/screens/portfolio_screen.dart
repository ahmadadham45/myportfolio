import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  // Get the current logged-in user
  final User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, 
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Portfolio Vault', style: TextStyle(color: Colors.black)),
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          bottom: const TabBar(
            labelColor: Color(0xFFC62828), 
            unselectedLabelColor: Colors.grey,
            indicatorColor: Color(0xFFC62828),
            tabs: [
              Tab(text: 'Formal'),
              Tab(text: 'Informal'),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: const Color(0xFFC62828),
          onPressed: () => _showAddLinkDialog(context),
          icon: const Icon(Icons.add_link, color: Colors.white),
          label: const Text('Add Link', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        body: TabBarView(
          children: [
            // --- TAB 1: FORMAL LEARNING STREAM ---
            _buildFirestoreList('Formal'),

            // --- TAB 2: INFORMAL LEARNING STREAM ---
            _buildFirestoreList('Informal'),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // FIRESTORE STREAM BUILDER: Listens to database changes in real-time
  // ---------------------------------------------------------------------------
  Widget _buildFirestoreList(String category) {
    if (currentUser == null) {
      return const Center(child: Text('Please log in to view your portfolio.'));
    }

    return StreamBuilder<QuerySnapshot>(
      // Removed the orderBy line so Firebase doesn't require a composite index!
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .collection('portfolio')
          .where('category', isEqualTo: category)
          .snapshots(),
      builder: (context, snapshot) {
        // NEW: Show exact database errors on the screen if they happen
        if (snapshot.hasError) {
          return Center(child: Text('Database Error: ${snapshot.error}', textAlign: TextAlign.center));
        }
        
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              'No $category documents found.\nTap "Add Link" to get started.',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            ),
          );
        }

        final docs = snapshot.data!.docs;

        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final data = docs[index].data() as Map<String, dynamic>;
            final title = data['title'] ?? 'Untitled';
            final url = data['url'] ?? '';
            final Timestamp? t = data['timestamp'] as Timestamp?;
            final dateString = t != null 
                ? '${t.toDate().day}/${t.toDate().month}/${t.toDate().year}' 
                : 'Just now';

            return Card(
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 12.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.link, color: Colors.blueAccent, size: 28),
                ),
                title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('Added: $dateString'),
                trailing: const Icon(Icons.open_in_new, color: Colors.grey), 
                onTap: () async {
                  final Uri uri = Uri.parse(url);
                  try {
                    // Force the launch and bypass Android's canLaunchUrl security block
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Could not open link. Check URL format.'), backgroundColor: Colors.red),
                      );
                    }
                  }
                },
              ),
            );
          },
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // ADD LINK DIALOG: Pushes data to Firestore
  // ---------------------------------------------------------------------------
  void _showAddLinkDialog(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController urlController = TextEditingController();
    String selectedCategory = 'Formal';
    bool isSaving = false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              title: const Text('Add Document Link', style: TextStyle(fontWeight: FontWeight.bold)),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Paste a view-only Google Drive link to ensure PDPA compliance.',
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: 'Document Title (e.g. SPM Certificate)',
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: urlController,
                      decoration: InputDecoration(
                        labelText: 'Google Drive URL',
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                      ),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      initialValue: selectedCategory,
                      decoration: InputDecoration(
                        labelText: 'Category',
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                      ),
                      items: const [
                        DropdownMenuItem(value: 'Formal', child: Text('Formal Learning')),
                        DropdownMenuItem(value: 'Informal', child: Text('Informal Learning')),
                      ],
                      onChanged: (value) => setStateDialog(() => selectedCategory = value!),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: isSaving ? null : () => Navigator.pop(context),
                  child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC62828),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: isSaving
                      ? null
                      : () async {
                          if (titleController.text.isEmpty || urlController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Please fill in all fields.')),
                            );
                            return;
                          }

                          setStateDialog(() => isSaving = true);

                          try {
                            // Write the new link to the user's specific Firestore portfolio collection
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(currentUser!.uid)
                                .collection('portfolio')
                                .add({
                              'title': titleController.text.trim(),
                              'url': urlController.text.trim(),
                              'category': selectedCategory,
                              'timestamp': FieldValue.serverTimestamp(),
                            });

                            if (context.mounted) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Link saved securely!'), backgroundColor: Colors.green),
                              );
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
                              );
                            }
                          } finally {
                            if (context.mounted) setStateDialog(() => isSaving = false);
                          }
                        },
                  child: isSaving
                      ? const SizedBox(height: 15, width: 15, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                      : const Text('Save Link', style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          },
        );
      },
    );
  }
}