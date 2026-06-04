import 'package:flutter/material.dart';
import 'package:zournel/const.dart';
import 'package:zournel/models/journel_entry.dart';
import 'package:zournel/services/firestore_services.dart';

class EditentryScreen extends StatefulWidget {
  final JournelEntry entry;

  const EditentryScreen({super.key, required this.entry});

  @override
  State<EditentryScreen> createState() => _EditentryScreenState();
}

class _EditentryScreenState extends State<EditentryScreen> {
  final FirestoreServices _firestoreServices = FirestoreServices();

  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _descController;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController(text: widget.entry.title);

    _descController = TextEditingController(text: widget.entry.description);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  /// UPDATE JOURNAL
  Future<void> _updateJournal() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    await _firestoreServices.updateJournalEntry(
      widget.entry.id,
      _titleController.text.trim(),
      _descController.text.trim(),
    );

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    Navigator.pop(context);
  }

  InputDecoration _inputDecoration({
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      filled: true,
      fillColor: textFieldFillColor,

      labelText: label,
      labelStyle: textFieldLabelStyle,

      prefixIcon: Icon(icon, color: primaryColor),

      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: primaryColor, width: 1.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      /// BODY
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [gradientStartColor, gradientEndColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: SafeArea(
          child: Column(
            children: [
              /// APP BAR
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),

                child: Row(
                  children: [
                    /// BACK BUTTON
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },

                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: secondaryColor,
                      ),
                    ),

                    /// TITLE
                    const Expanded(
                      child: Text("Edit Journal", style: appBarTitleStyle),
                    ),

                    /// SAVE ICON
                    Container(
                      decoration: BoxDecoration(
                        color: secondaryColor.withValues(alpha: 0.15),

                        borderRadius: BorderRadius.circular(14),
                      ),

                      child: IconButton(
                        onPressed: _isLoading ? null : _updateJournal,

                        icon: _isLoading
                            ? const SizedBox(
                                height: 22,
                                width: 22,

                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: secondaryColor,
                                ),
                              )
                            : const Icon(
                                Icons.check_rounded,
                                color: secondaryColor,
                              ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: Container(
                  width: double.infinity,

                  padding: const EdgeInsets.all(24),

                  decoration: const BoxDecoration(
                    color: scaffoldBgColor,

                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(35),
                    ),
                  ),

                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          /// HEADER
                          const Text(
                            "Update your thoughts ✨",
                            style: screenHeaderStyle,
                          ),

                          const SizedBox(height: 8),

                          /// SUBTITLE
                          Text(
                            "Edit your journal and save your memories.",

                            style: subtitleStyle,
                          ),

                          const SizedBox(height: 35),

                          /// TITLE FIELD
                          TextFormField(
                            controller: _titleController,

                            style: textFieldTextStyle,

                            textCapitalization: TextCapitalization.sentences,

                            decoration: _inputDecoration(
                              label: "Title",
                              icon: Icons.title_rounded,
                            ),

                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Please enter a title";
                              }

                              return null;
                            },
                          ),

                          const SizedBox(height: 25),

                          /// DESCRIPTION FIELD
                          TextFormField(
                            controller: _descController,

                            style: textFieldTextStyle,

                            maxLines: 10,

                            textCapitalization: TextCapitalization.sentences,

                            decoration: _inputDecoration(
                              label: "Description",
                              icon: Icons.edit_note_rounded,
                            ),

                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Please enter a description";
                              }

                              return null;
                            },
                          ),

                          const SizedBox(height: 40),

                          /// SAVE BUTTON
                          SizedBox(
                            width: double.infinity,
                            height: 58,

                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _updateJournal,

                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,

                                foregroundColor: secondaryColor,

                                elevation: 0,

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),

                              child: _isLoading
                                  ? const SizedBox(
                                      height: 24,
                                      width: 24,

                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.5,

                                        color: secondaryColor,
                                      ),
                                    )
                                  : const Text(
                                      "Save Changes",
                                      style: buttonTextStyle,
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
