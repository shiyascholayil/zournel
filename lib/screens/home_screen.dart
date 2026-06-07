
import 'package:flutter/material.dart';
import 'package:zournel/const.dart';
import 'package:zournel/models/journel_entry.dart';
import 'package:zournel/screens/addentry_screen.dart';
import 'package:zournel/screens/editentry_screen.dart';
import 'package:zournel/services/auth_services.dart';
import 'package:zournel/services/firestore_services.dart';
import 'package:zournel/widget/journel_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  final AuthServices _auth = AuthServices();
  final FirestoreServices _firestoreServices = FirestoreServices();

  bool _isSearching = false;
  List<JournelEntry> _searchResults = [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// SEARCH FUNCTION
  Future<void> _performSearch(String query) async {
    if (query.trim().isEmpty) {
      setState(() => _searchResults.clear());
      return;
    }

    final result = await _firestoreServices.seachJournel(query);

    setState(() {
      _searchResults = result;
    });
  }

  /// DELETE DIALOG
  void _showDeleteDialog(String id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Delete Journal', style: boldTextStyle),
        content: const Text('Are you sure you want to delete this journal?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: redColor,
              foregroundColor: secondaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
           onPressed: () async {
              try {
                await _firestoreServices
                    .deleteJournelCollection(id)
                    .timeout(const Duration(seconds:1));

                if (!mounted) return;
                Navigator.of(context).pop();
              } catch (e) {
                if (!mounted) return;

                Navigator.of(context).pop(); 

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Delete queued. Will sync later."),
                  ),
                );
              }
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  /// EMPTY SCREEN
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: primaryColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.menu_book_rounded,
                size: 70,
                color: primaryColor,
              ),
            ),

            const SizedBox(height: 25),

            const Text("No Journals Yet", style: emptyTitleStyle),

            const SizedBox(height: 10),

            Text(
              "Start writing your thoughts,\nmemories and ideas today.",
              textAlign: TextAlign.center,
              style: emptyDescStyle,
            ),

            const SizedBox(height: 30),

            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: secondaryColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddentryScreen()),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text("Add Journal", style: buttonTextStyle),
            ),
          ],
        ),
      ),
    );
  }

  /// APP BAR
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: transparentColor,
      surfaceTintColor: transparentColor,
      title: _isSearching
          ? Container(
              height: 45,
              decoration: BoxDecoration(
                color: secondaryColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(14),
              ),
              child: TextField(
                controller: _searchController,
                autofocus: true,
                style: const TextStyle(color: secondaryColor),
                decoration: const InputDecoration(
                  hintText: "Search journals...",
                  hintStyle: TextStyle(color: secondaryColor),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: secondaryColor),
                  contentPadding: EdgeInsets.only(top: 12),
                ),
                onChanged: _performSearch,
              ),
            )
          : const Text("My Journal", style: appBarTitleStyle),
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              _isSearching = !_isSearching;

              if (!_isSearching) {
                _searchController.clear();
                _searchResults.clear();
              }
            });
          },
          icon: Icon(
            _isSearching ? Icons.close : Icons.search,
            color: secondaryColor,
          ),
        ),

        /// LOGOUT
        IconButton(
          onPressed: () async {
            await _auth.sighout();
          },
          icon: const Icon(Icons.logout_rounded, color: secondaryColor),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      /// BODY
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [gradientStartColor, gradientEndColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(),

              const SizedBox(height: 10),

              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 15),
                  decoration: const BoxDecoration(
                    color: scaffoldBgColor,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),

                  child: StreamBuilder<List<JournelEntry>>(
                    stream: _firestoreServices.getJournels(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text("Something went wrong"),
                        );
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final journals = _isSearching
                          ? _searchResults
                          : snapshot.data ?? [];

                      if (journals.isEmpty) {
                        return _buildEmptyState();
                      }

                      return ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: journals.length,
                        itemBuilder: (context, index) {
                          final journal = journals[index];

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 14),
                            child: JournelCard(
                              entry: journal,

                              onDelete: () {
                                _showDeleteDialog(journal.id);
                              },

                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        EditentryScreen(entry: journal),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      /// FLOATING BUTTON
      floatingActionButton: FloatingActionButton.extended(
        elevation: 5,
        backgroundColor: appBarColor,
        foregroundColor: secondaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddentryScreen()),
          );
        },
        icon: Icon(Icons.add),
        label: Text("New Journal", style: buttonTextStyle),
      ),
    );
  }
}
