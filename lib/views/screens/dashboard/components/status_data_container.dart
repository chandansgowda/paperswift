import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paperswift/controllers/status_data_controller.dart';
import 'package:paperswift/views/screens/dashboard/components/status_data_tile.dart';

import '../../../../utils/constants.dart';
import 'chart.dart';

class StatusDataContainer extends StatelessWidget {
  StatusDataController statusDataController = Get.find<StatusDataController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Obx(
            () {
              return statusDataController.isLoading.value
                  ? Center(
                child: CircularProgressIndicator(),
              )
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Status",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: defaultPadding),
                  Chart(),
                  StatusDataTile(
                    svgSrc: "assets/icons/Documents.svg",
                    title: "Request Pending",
                    color: primaryColor,
                    numOfFiles: statusDataController.statusData.value["Request Pending"]??0,
                  ),
                  StatusDataTile(
                    svgSrc: "assets/icons/Documents.svg",
                    title: "Invite Rejected",
                    color: Colors.lightBlueAccent,
                    numOfFiles: statusDataController.statusData.value["Invite Rejected"]??0,
                  ),
                  StatusDataTile(
                    svgSrc: "assets/icons/Documents.svg",
                    title: "In Progress",
                    color: Colors.red,
                    numOfFiles: statusDataController.statusData.value["In Progress"]??0,
                  ),
                  StatusDataTile(
                    svgSrc: "assets/icons/Documents.svg",
                    title: "Update Requested",
                    color: Colors.orange,
                    numOfFiles: statusDataController.statusData.value["Update Requested"]??0,
                  ),
                  StatusDataTile(
                    svgSrc: "assets/icons/Documents.svg",
                    title: "Submitted",
                    color: Colors.yellow,
                    numOfFiles: statusDataController.statusData.value["Submitted"]?? 0,
                  ),
                  StatusDataTile(
                    svgSrc: "assets/icons/Documents.svg",
                    title: "Completed",
                    color: Colors.white,
                    numOfFiles: statusDataController.statusData.value["Completed"]?? 0,
                  ),
                ],
              );
            }
      ),
    );
  }
}
