import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:zournel/models/journel_entry.dart';

class FirestoreServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addJournelEntry(String title, String description) async {
    try {
      await _journelCollection.add({
        'title': title,
        'description': description,
        'date': DateTime.now(),
      });
    } catch (e) {
      debugPrint('Error adding Journel $e');
    }
  }

  Future<void> updateJournalEntry(
    String id,
    String title,
    String desciption,
  ) async {
    try {
      await _journelCollection.doc(id).update({
        'title': title,
        'description': desciption,
        'date': DateTime.now(),
      });
    } catch (e) {
      debugPrint('Error updating journal: $e');
    }
  }

  Future<List<JournelEntry>> seachJournel(String searchTerm) async {
    try {
      if (searchTerm.isEmpty) return [];

      final snapshot = await _journelCollection.get();
      final allEntries = snapshot.docs.map((doc) {
        return JournelEntry.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();

      return allEntries.where((entry) {
        return entry.title.toLowerCase().contains(searchTerm.toLowerCase()) ||
            entry.description.toLowerCase().contains(searchTerm.toLowerCase());
      }).toList();
    } catch (e) {
      debugPrint('Error searching journals: $e');
      return [];
    }
  }

  Future<void> deleteJournelCollection(String id) async {
    try {
      await _journelCollection.doc(id).delete();
    } catch (e) {
      debugPrint('Error deleting journal: $e ');
    }
  }

  Stream<List<JournelEntry>> getJournels() {
    return _journelCollection.orderBy('date', descending: true).snapshots().map(
      (snapshot) {
        return snapshot.docs.map((doc) {
          return JournelEntry.fromMap(
            doc.id,
            doc.data() as Map<String, dynamic>,
          );
        }).toList();
      },
    );
  }

  CollectionReference get _journelCollection {
    return _firestore
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .collection('journels');
  }
}
