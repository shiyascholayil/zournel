
import 'package:flutter/material.dart';
import 'package:zournel/const.dart';
import 'package:zournel/services/firestore_services.dart';

class AddentryScreen extends StatefulWidget {
  const AddentryScreen({super.key});

  @override
  State<AddentryScreen> createState() => _AddentryScreenState();
}

class _AddentryScreenState extends State<AddentryScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descController = TextEditingController();

  final FirestoreServices _firestore = FirestoreServices();

  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  /// SAVE JOURNAL
  Future<void> _saveJournal() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    await _firestore.addJournelEntry(
      _titleController.text.trim(),
      _descController.text.trim(),
    );

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    Navigator.pop(context);
  }

  /// INPUT DECORATION
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
           
              Padding(
                padding:  EdgeInsets.symmetric(
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
                      icon:  Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: secondaryColor,
                      ),
                    ),

                    
                     Expanded(
                      child: Text("New Journal", style: appBarTitleStyle),
                    ),

                    
                    Container(
                      decoration: BoxDecoration(
                        color: secondaryColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(14),
                      ),

                      child: IconButton(
                        onPressed: _isLoading ? null : _saveJournal,

                        icon: _isLoading
                            ?  SizedBox(
                                height: 22,
                                width: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: secondaryColor,
                                ),
                              )
                            :  Icon(
                                Icons.check_rounded,
                                color: secondaryColor,
                              ),
                      ),
                    ),
                  ],
                ),
              ),

               SizedBox(height: 20),

              Expanded(
                child: Container(
                  width: double.infinity,

                  padding:  EdgeInsets.all(24),

                  decoration:  BoxDecoration(
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
                        
                          const Text(
                            "Write your thoughts ✨",
                            style: screenHeaderStyle,
                          ),

                          const SizedBox(height: 8),

                        
                          Text(
                            "Capture your ideas, memories and feelings.",

                            style: subtitleStyle,
                          ),

                          const SizedBox(height: 35),

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

                          SizedBox(
                            width: double.infinity,
                            height: 58,

                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _saveJournal,

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
                                      "Save Journal",
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
