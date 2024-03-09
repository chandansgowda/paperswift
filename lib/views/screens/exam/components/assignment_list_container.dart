import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paperswift/views/screens/dashboard/components/deletethis1.dart';

import '../../../../utils/constants.dart';


class AssignmentListContainer extends StatelessWidget {
  const AssignmentListContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Assignment Table",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            width: double.infinity,
            child: DataTable(
              columnSpacing: defaultPadding,
              // minWidth: 600,
              columns: [
                DataColumn(
                  label: Text("Subject Name"),
                ),
                DataColumn(
                  label: Text("Subject Code"),
                ),
                DataColumn(
                  label: Text("Assigned To"),
                ),
                DataColumn(
                  label: Text("Status"),
                ),
              ],
              rows: List.generate(
                demoRecentFiles.length,
                    (index) => assignmentTile(demoRecentFiles[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow assignmentTile(RecentFile fileInfo) {
  return DataRow(
    cells: [
      DataCell(
        Text(fileInfo.title!),
      ),
      DataCell(Text(fileInfo.date!)),
      DataCell(Text(fileInfo.size!)),
      DataCell(Text('NA')),
    ],
  );
}
