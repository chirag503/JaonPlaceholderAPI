import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/common/common_appbar.dart';
import 'package:myapp/common/common_dropdown.dart';
import 'package:myapp/common/helper_class.dart';
import 'package:myapp/features/content_delivery/controller/content_delivery_controller.dart';
import 'package:myapp/features/content_delivery/widgets/date_time_widget.dart';

class ContentDeliveryScreen extends StatelessWidget {
  const ContentDeliveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ContentDeliveryController controller =
        Get.put(ContentDeliveryController());
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: const CommonAppbar(
        title: "Content Delivery",
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Obx(
              () => Column(children: [
                DateTimeWidget(
                  date: controller.collectionDate.value,
                  onTap: (v) {
                    controller.updateCollectionIndex(v, context);
                  },
                  title: "Select Collection Date & Time",
                  selectedIndex: controller.collectionIndex.value,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonDropDown(
                      labelTitle: "Morning",
                      onChanged: (v) {
                        if (v != null) {
                          controller.updateCollectionMorningSlot(v);
                        }
                      },
                      selectedValue: controller.collectionMorningSlot.value,
                      listofitems: HelperClass().generateMorningSlots(
                          controller.collectionDate.value ?? DateTime.now()),
                    ),
                    CommonDropDown(
                      labelTitle: "Afternoon",
                      onChanged: (v) {
                        if (v != null) {
                          controller.updateCollectionAfternoonSlot(v);
                        }
                      },
                      selectedValue: controller.collectionAfternoonSlot.value,
                      listofitems: HelperClass().generateAfternoonSlots(
                          controller.collectionDate.value ?? DateTime.now()),
                    ),
                  ],
                ),
              ]),
            ),
            const SizedBox(
              height: 30,
            ),
            Obx(
              () => Column(children: [
                DateTimeWidget(
                  date: controller.deliveryDate.value,
                  onTap: (v) {
                    controller.updateDeliveryIndex(v, context);
                  },
                  title: "Select Delivery Date & Time",
                  selectedIndex: controller.deliveryIndex.value,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonDropDown(
                      labelTitle: "Morning",
                      onChanged: (v) {
                        if (v != null) {
                          controller.updateDeliveryMorningSlot(v);
                        }
                      },
                      selectedValue: controller.deliveryMorningSlot.value,
                      listofitems: HelperClass().generateMorningSlots(
                          controller.deliveryDate.value ?? DateTime.now()),
                    ),
                    CommonDropDown(
                      labelTitle: "Afternoon",
                      onChanged: (v) {
                        if (v != null) {
                          controller.updateDeliveryAfternoonSlot(v);
                        }
                      },
                      selectedValue: controller.deliveryAfternoonSlot.value,
                      listofitems: HelperClass().generateAfternoonSlots(
                          controller.deliveryDate.value ?? DateTime.now()),
                    ),
                  ],
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 25),
              child: Obx(
                () => Text(
                  controller.errorMessage.value,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.red),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xffe0f2ff)),
              child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                      text: "Note: ",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                      children: [
                        TextSpan(
                            text:
                                "A delivery charges of €3.00 will be incurred for a full service",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black))
                      ])),
            ),
            const Spacer(),
            Obx(
              () => Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(48),
                      color: const Color(0xff3053d1).withOpacity(
                          controller.isButtonEnable.value ? 1 : 0.5)),
                  child: const Center(
                    child: Text(
                      "Continue",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
