import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:splitzy/Model/expense_modal.dart';

import '../Firebase Services/firebase_firestore_services.dart';
import '../Firebase Services/google_auth_services.dart';

class GroupController extends GetxController {
  RxInt userLength = 0.obs;
  var personalTotal = 0.obs;
  var globalKey = GlobalKey<FormState>();
  var uniqueFriends = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadUniqueFriends();
  }

  Future<void> loadUniqueFriends() async {
    isLoading.value = true;
    final friendsSet = <String, Map<String, dynamic>>{};

    // Get the current user's email
    String? currentUserEmail = GoogleAuthServices.googleAuthServices.currentUser()?.email;

    // Fetch all groups user is part of and get each group's users
    List<String>? groupCodes = await FirebaseFireStoreServices.firebaseFireStoreServices.storeGroupInApp();
    if (groupCodes != null) {
      for (String groupCode in groupCodes) {
        List<Map<String, dynamic>> groupFriends = await FirebaseFireStoreServices.firebaseFireStoreServices.getGroupUsers(groupCode);

        // Add friends to the friendsSet, excluding the current user
        for (var friend in groupFriends) {
          if (friend['email'] != currentUserEmail) {  // Exclude current user
            friendsSet[friend['email']] = friend;
          }
        }
      }
    }

    // Convert the map of unique friends to a list
    uniqueFriends.value = friendsSet.values.toList();
    isLoading.value = false;
  }

  void calculateTotalAmount(List<ExpenseModal> expenses) {
    personalTotal.value = expenses.fold(0, (sum, item) => sum + int.parse(item.amount));
    update();
  }

}