import 'dart:async';
import 'dart:math';

// import 'package:rxdart/rxdart.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:splitzy/Firebase%20Services/google_auth_services.dart';

import '../Model/expense_modal.dart';
import '../Model/group_expense_model.dart';

class FirebaseFireStoreServices {
  static FirebaseFireStoreServices firebaseFireStoreServices =
      FirebaseFireStoreServices._();

  FirebaseFireStoreServices._();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void createGroupAccount(String name) {
    Random random = Random();
    int groupCode = 100000 + random.nextInt(900000);
    CollectionReference collectionReference = firestore.collection('group');
    collectionReference
        .doc(groupCode.toString())
        .collection('user')
        .doc(GoogleAuthServices.googleAuthServices.currentUser()!.email)
        .set({
      'name': GoogleAuthServices.googleAuthServices.currentUser()!.displayName,
      'email': GoogleAuthServices.googleAuthServices.currentUser()!.email,
      'photoUrl': GoogleAuthServices.googleAuthServices.currentUser()!.photoURL,
    });
    collectionReference
        .doc(groupCode.toString())
        .collection('group')
        .doc(groupCode.toString())
        .set({
      'groupName': name,
      'groupCode': groupCode,
    });
    showGroup(groupCode.toString());
  }

  void joinToAccount(String groupCode) {
    try {
      CollectionReference collectionReference = firestore.collection('group');
      collectionReference
          .doc(groupCode)
          .collection('user')
          .doc(GoogleAuthServices.googleAuthServices.currentUser()!.email)
          .set({
        'name':
            GoogleAuthServices.googleAuthServices.currentUser()!.displayName,
        'email': GoogleAuthServices.googleAuthServices.currentUser()!.email,
        'photoUrl':
            GoogleAuthServices.googleAuthServices.currentUser()!.photoURL,
      });
      showGroup(groupCode);
    } catch (e) {
      print(e.toString());
    }
  }

  void showGroup(String groupCode) {
    CollectionReference collectionReference = firestore.collection('user');

    // Use FieldValue.arrayUnion to add groupCode to the groupCodes array
    collectionReference
        .doc(GoogleAuthServices.googleAuthServices.currentUser()!.email)
        .set({
      'groupCodes': FieldValue.arrayUnion([groupCode]),
      // Add groupCode to the array
    }, SetOptions(merge: true)) // Merge to avoid overwriting other fields
        .then((_) {
      print("Group code added successfully!");
    }).catchError((error) {
      print("Failed to add group code: $error");
    });

    dataShow();
  }

  Future<List<String>?> storeGroupInApp() async {
    try {
      DocumentSnapshot documentSnapshot = await firestore
          .collection('user')
          .doc(GoogleAuthServices.googleAuthServices.currentUser()!.email)
          .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic>? userData =
            documentSnapshot.data() as Map<String, dynamic>?;

        if (userData != null && userData.containsKey('groupCodes')) {
          List<dynamic> groupCodes = userData['groupCodes'];
          print("Group codes: $groupCodes");
          return groupCodes
              .cast<String>(); // Return the group codes as List<String>
        } else {
          print("No group codes found for this user.");
          return null; // Return null if no group codes exist
        }
      } else {
        print("User document does not exist.");
        return null; // Return null if the user document does not exist
      }
    } catch (e) {
      print("Failed to retrieve user data: $e");
      return null; // Return null on error
    }
  }

  Stream<List<QuerySnapshot>> dataShow() async* {
    List<String>? groupCodes = await storeGroupInApp();
    List<Stream<QuerySnapshot>> groupList = [];

    if (groupCodes != null && groupCodes.isNotEmpty) {
      for (String groupCode in groupCodes) {
        try {
          Stream<QuerySnapshot> groupStream = firestore
              .collection('group')
              .doc(groupCode)
              .collection('group')
              .snapshots();
          groupList.add(groupStream);
        } catch (e) {
          print(
              "Error fetching group data for groupCode $groupCode: ${e.toString()}");
        }
      }
    } else {
      print("No group codes found for the user.");
    }

    // Combine all group streams into a single stream of List<QuerySnapshot>
    yield* Stream.periodic(Duration(milliseconds: 500)).asyncMap((_) async {
      final results = await Future.wait(
        groupList.map((stream) => stream.first),
      );
      return results;
    });
  }

  Stream<QuerySnapshot> userDataGet(String code) {
    return firestore
        .collection('group')
        .doc(code)
        .collection('user')
        .snapshots();
  }

  void setDataExpense(String code, GroupExpenseModal expense) {
    CollectionReference collectionReference = firestore.collection('group');
    collectionReference
        .doc(code)
        .collection('expense')
        .add(expense.modalToMap());
  }

  Stream<QuerySnapshot> expenseDataGet(String code) {
    return firestore
        .collection('group')
        .doc(code)
        .collection('expense')
        .snapshots();
  }

  void deleteExpense(String code, String deleteCodeId) {
    firestore
        .collection('group')
        .doc(code)
        .collection('expense')
        .doc(deleteCodeId)
        .delete();
  }

  void userAmount(
      String code, String deleteCodeId, String email, String amount) {
    firestore
        .collection('group')
        .doc(code)
        .collection('expense')
        .doc(deleteCodeId)
        .update({
      'user': [email, amount]
    });
  }

  void setDataPersonExpense(ExpenseModal expense) {
    CollectionReference collectionReference = firestore.collection('personal');
    collectionReference
        .doc(GoogleAuthServices.googleAuthServices.currentUser()!.email)
        .collection('expanse')
        .add(expense.modalToMap());
  }

  Stream<QuerySnapshot> expenseDataPersonGet() {
    return firestore
        .collection('personal')
        .doc(GoogleAuthServices.googleAuthServices.currentUser()!.email)
        .collection('expanse')
        .snapshots();
  }

  void setDataPersonExpenseDelete(String id) {
    firestore
        .collection('personal')
        .doc(GoogleAuthServices.googleAuthServices.currentUser()!.email)
        .collection('expanse')
        .doc(id)
        .delete();
  }

  Future<List<Map<String, dynamic>>> getGroupUsers(String groupCode) async {
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('group')
          .doc(groupCode)
          .collection('user')
          .get();

      return querySnapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();
    } catch (e) {
      print("Error fetching group users: $e");
      return [];
    }
  }

  // Helper method to retrieve all groups a specific user is part of
  Future<List<String>?> _getUserGroupCodes(String email) async {
    try {
      DocumentSnapshot documentSnapshot =
          await firestore.collection('user').doc(email).get();

      if (documentSnapshot.exists) {
        Map<String, dynamic>? userData =
            documentSnapshot.data() as Map<String, dynamic>?;
        if (userData != null && userData.containsKey('groupCodes')) {
          return List<String>.from(userData['groupCodes']);
        }
      }
      return null;
    } catch (e) {
      print("Failed to retrieve group codes for $email: $e");
      return null;
    }
  }

  Future<void> leaveGroup(String groupCode) async {
    String? userEmail =
        GoogleAuthServices.googleAuthServices.currentUser()!.email;

    try {
      // Remove the user from the specified group
      await firestore
          .collection('group')
          .doc(groupCode)
          .collection('user')
          .doc(userEmail)
          .delete();

      // Remove the group code from the user's 'groupCodes' array
      await firestore.collection('user').doc(userEmail).update({
        'groupCodes': FieldValue.arrayRemove([groupCode])
      });

      print("Successfully left the group.");
    } catch (e) {
      print("Failed to leave group: $e");
    }
  }

  // Delete a group and its data
  Future<void> deleteGroup(String groupCode) async {
    try {
      // Delete all users in the group
      CollectionReference userCollection =
          firestore.collection('group').doc(groupCode).collection('user');

      QuerySnapshot userSnapshot = await userCollection.get();
      for (DocumentSnapshot doc in userSnapshot.docs) {
        await doc.reference.delete();
      }

      // Delete all expenses in the group
      CollectionReference expenseCollection =
          firestore.collection('group').doc(groupCode).collection('expense');

      QuerySnapshot expenseSnapshot = await expenseCollection.get();
      for (DocumentSnapshot doc in expenseSnapshot.docs) {
        await doc.reference.delete();
      }

      // Finally, delete the group document itself
      await firestore.collection('group').doc(groupCode).delete();

      // Optionally, you may want to remove this groupCode from each user’s 'groupCodes' array
      await _removeGroupCodeFromAllUsers(groupCode);

      print("Group deleted successfully.");
    } catch (e) {
      print("Failed to delete group: $e");
    }
  }

  // Helper method to remove group code from all users who are in the group
  Future<void> _removeGroupCodeFromAllUsers(String groupCode) async {
    try {
      QuerySnapshot userSnapshot = await firestore.collection('user').get();
      for (DocumentSnapshot doc in userSnapshot.docs) {
        List<dynamic> groupCodes = doc.get('groupCodes') ?? [];
        if (groupCodes.contains(groupCode)) {
          await doc.reference.update({
            'groupCodes': FieldValue.arrayRemove([groupCode])
          });
        }
      }
    } catch (e) {
      print("Failed to remove group code from all users: $e");
    }
  }
}
