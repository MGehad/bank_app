import 'package:cloud_firestore/cloud_firestore.dart';

import '../../features/statistics/data/models/month_model.dart';
import 'firebase_authentication.dart';

class FirebaseMonths {
  static final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  static final CollectionReference _userCollection =
      _fireStore.collection('users');

  static final String _userId = FirebaseAuthentication.getUserId();

  static final DocumentReference _userDocument = _userCollection.doc(_userId);

  static Future<void> addNewMonth(MonthModel month) async {
    await _userDocument.collection('monthsBalance').add(
          MonthModel.toJson(month),
        );
  }

  static void addMonths(List<MonthModel> months) {
    for (var month in months) {
      addNewMonth(month);
    }
  }

  static Future<void> updateMonth(MonthModel month) async {
    // Assuming 'index' is a field in the document, you need to retrieve the correct document first
    var querySnapshot = await _userDocument
        .collection('monthsBalance')
        .where('index', isEqualTo: month.index)
        .get();

    // Update the document if it exists
    if (querySnapshot.docs.isNotEmpty) {
      // Assuming only one document matches the 'index'
      var docRef = querySnapshot.docs.first.reference;

      await docRef.set(
        MonthModel.toJson(month),
        SetOptions(
          merge: true,
        ),
      );
    }
  }

  /// Retrieve all cards from the user's 'cards' subCollection
  static Future<List<MonthModel>> getAllMonths() async {
    List<MonthModel> allMonths = [];

    // Get all documents in the 'cards' subCollection
    final QuerySnapshot cardsCollection =
        await _userDocument.collection("monthsBalance").orderBy("index").get();

    // Loop through the documents and add them to the list
    for (var cardDoc in cardsCollection.docs) {
      Map<String, dynamic> data = cardDoc.data() as Map<String, dynamic>;

      bool isDuplicate = checkMonthDuplicate(allMonths, data);

      if (!isDuplicate) {
        allMonths.add(
          MonthModel.fromJson(data),
        );
      }
    }

    return allMonths;
  }

  static bool checkMonthDuplicate(
      List<MonthModel> allMonths, Map<String, dynamic> data) {
    bool isDuplicate = false;
    for (var month in allMonths) {
      if (month.index == data['index']) {
        isDuplicate = true;
      }
    }
    return isDuplicate;
  }
}
