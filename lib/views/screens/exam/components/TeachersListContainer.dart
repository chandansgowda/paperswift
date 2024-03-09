import 'package:flutter/material.dart';
import 'package:paperswift/views/screens/dashboard/components/chart.dart';
import 'package:paperswift/views/screens/dashboard/components/storage_info_card.dart';
import 'package:paperswift/views/screens/exam/components/teacher_tile.dart';

import '../../../../utils/constants.dart';

class TeachersListContainer extends StatelessWidget {
  const TeachersListContainer({
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
            "Teachers List",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          TeacherTile(
            name: "Akash"
          ),
          TeacherTile(
            name: "Chandan",
          ),
          TeacherTile(
           name: "Nakul",
          ),
          TeacherTile(
            name: "Brahma",
          ),
          TeacherTile(
              name: "Akash"
          ),
          TeacherTile(
            name: "Chandan",
          ),
          TeacherTile(
            name: "Nakul",
          ),
          TeacherTile(
            name: "Brahma",
          ),TeacherTile(
              name: "Akash"
          ),
          TeacherTile(
            name: "Chandan",
          ),
          TeacherTile(
            name: "Nakul",
          ),
          TeacherTile(
            name: "Brahma",
          ),
        ],
      ),
    );
  }
}
