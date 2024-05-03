import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paperswift/controllers/status_data_controller.dart';

import '../../../../utils/constants.dart';


class Chart extends StatelessWidget {
  const Chart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StatusDataController statusDataController=Get.find<StatusDataController>();
    print(statusDataController.statusData[statusDataController.statusData.keys]);
    int sum=0;
    statusDataController.statusData.keys.forEach((element) {sum=sum+statusDataController.statusData[element] as int ;});
    List<PieChartSectionData> paiChartSelectionData = [
      PieChartSectionData(
        color: primaryColor,
        value: statusDataController.statusData['Request Pending']!=null?(statusDataController.statusData['Request Pending']/sum)*100.toInt():0,
        showTitle: false,
        radius: 25,
      ),
      PieChartSectionData(
        color: Color(0xFF26E5FF),
        value: statusDataController.statusData['Invite Rejected']!=null?(statusDataController.statusData['Invite Rejected']/sum)*100.toInt():0,
        showTitle: false,
        radius: 22,
      ),
      PieChartSectionData(
        color: Color(0xFFFFCF26),
        value: statusDataController.statusData['In Progress']!=null?(statusDataController.statusData['In Progress']/sum)*100.toInt():0,
        showTitle: false,
        radius: 19,
      ),
      PieChartSectionData(
        color: Color(0xFFEE2727),
        value: statusDataController.statusData['Update Requested']!=null?(statusDataController.statusData['Update Requested']/sum)*100.toInt():0,
        showTitle: false,
        radius: 16,
      ),
      PieChartSectionData(
        color: Colors.white,
        value: statusDataController.statusData['Submitted']!=null?(statusDataController.statusData['Submitted']/sum)*100.toInt():0,
        showTitle: false,
        radius: 13,
      ),
      PieChartSectionData(
        color: Colors.grey,
        value: statusDataController.statusData['Completed']!=null?(statusDataController.statusData['Completed']/sum)*100.toInt():0,
        showTitle: false,
        radius: 10,
      ),
    ];
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 70,
              startDegreeOffset: -90,
              sections: paiChartSelectionData,
            ),
          ),
          Positioned.fill(
            child: Center(
              child: Text(
                sum.toString(),
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      height: 0.5,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


