import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class ContentDeliveryController extends GetxController {
  Rx<int?> collectionIndex = Rx<int?>(null);
  Rx<int?> deliveryIndex = Rx<int?>(null);
  Rx<String?> collectionMorningSlot = Rx<String?>(null);
  Rx<String?> collectionAfternoonSlot = Rx<String?>(null);
  Rx<String?> deliveryMorningSlot = Rx<String?>(null);
  Rx<String?> deliveryAfternoonSlot = Rx<String?>(null);
  Rx<DateTime?> collectionDate = Rx<DateTime?>(null);
  Rx<DateTime?> deliveryDate = Rx<DateTime?>(null);

  RxString errorMessage = "".obs;

  var isButtonEnable = false.obs;

// update the collection date
  void updateCollectionIndex(int index, BuildContext context) async {
    collectionIndex.value = index;
    collectionAfternoonSlot = RxnString();
    collectionMorningSlot = RxnString();
    if (index == 2) {
      collectionDate.value = await pickDate(context);
    } else {
      collectionDate.value = DateTime.now().add(Duration(days: index));
    }
    checkButtonEnable();
  }

// update the delivery date
  void updateDeliveryIndex(int index, BuildContext context) async {
    deliveryIndex.value = index;
    deliveryAfternoonSlot = RxnString();
    deliveryMorningSlot = RxnString();
    if (index == 2) {
      deliveryDate.value = await pickDate(context);
    } else {
      deliveryDate.value = DateTime.now().add(Duration(days: index));
    }
    checkButtonEnable();
  }

// update the collection morning slots
  void updateCollectionMorningSlot(String slot) {
    collectionMorningSlot.value = slot;
    if (collectionAfternoonSlot.value != null) {
      collectionAfternoonSlot = RxnString();
    }
    checkButtonEnable();
  }

// update the collection afternoon slots
  void updateCollectionAfternoonSlot(String slot) {
    collectionAfternoonSlot.value = slot;
    if (collectionMorningSlot.value != null) {
      collectionMorningSlot = RxnString();
    }
    checkButtonEnable();
  }

  // update the delivery morning slots
  void updateDeliveryMorningSlot(String slot) {
    deliveryMorningSlot.value = slot;
    if (deliveryAfternoonSlot.value != null) {
      deliveryAfternoonSlot = RxnString();
    }
    checkButtonEnable();
  }

// update the delivery afternoon slots
  void updateDeliveryAfternoonSlot(String slot) {
    deliveryAfternoonSlot.value = slot;
    if (deliveryMorningSlot.value != null) {
      deliveryMorningSlot = RxnString();
    }
    checkButtonEnable();
  }

// check continue button is enable or not
  void checkButtonEnable() {
    // checks date validation
    if (deliveryDate.value != null && collectionDate.value != null) {
      errorMessage.value =
          validateDates(collectionDate.value!, deliveryDate.value!);
    }

    // check button validation
    if ((collectionMorningSlot.value != null ||
            collectionAfternoonSlot.value != null) &&
        (deliveryMorningSlot.value != null ||
            deliveryAfternoonSlot.value != null) &&
        collectionDate.value != null &&
        deliveryDate.value != null &&
        validateDates(collectionDate.value!, deliveryDate.value!).isEmpty) {
      isButtonEnable.value = true;
    } else {
      isButtonEnable.value = false;
    }
  }

// pick the date
  Future<DateTime?> pickDate(BuildContext context) async {
    final val = await showDatePicker(
        context: context,
        firstDate: DateTime.now().add(const Duration(days: 2)),
        lastDate: DateTime.now().add(const Duration(days: 365)));

    return val;
  }

// check validation on date
  String validateDates(DateTime a, DateTime b) {
    if (b.isBefore(a)) {
      return "The delivery date cannot be before the collection date. Please choose a valid delivery date.";
    } else if (b.day == a.day) {
      return "The delivery date cannot be the same as the collection date. Please select a different delivery date.";
    } else if (b.day < a.day) {
      return "The delivery day cannot be before the collection day. Please select a valid delivery day.";
    }
    return "";
  }
}
