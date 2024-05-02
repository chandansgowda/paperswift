import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:paperswift/controllers/examination_detail_controller.dart';
import 'package:paperswift/controllers/qp_review_controller.dart';
import 'package:paperswift/routes/app_routes.dart';
import 'package:paperswift/utils/constants.dart';

class ExaminationTile extends StatelessWidget {
  final int eid;
  final String title;
  final String examType;
  final String date;
  final String degree;

   ExaminationTile({super.key, required this.title, required this.examType, required this.date, required this.degree,required this.eid});

  ExaminationDetailController examinationDetailController=Get.find<ExaminationDetailController>();
  QuestionPaperReviewController questionPaperReviewController=Get.find<QuestionPaperReviewController>();

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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                degree+" - "+title,
                maxLines: 1,
                style: TextStyle(fontSize: 25),
                overflow: TextOverflow.ellipsis,
              ),
              Icon(Icons.more_vert, color: Colors.white54)
            ],
          ),
          Text(
            examType+" Exam",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Deadline : ",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.white70),
              ),
              Text(
                date,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.white),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: ()async{
                  examinationDetailController.examinationId=eid;
                  await questionPaperReviewController.fetchData(eid);
                  Get.toNamed(AppRoutes.qpReviewScreen,arguments: "${degree} - ${title} ( ${examType} Exam )");
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 12),
                    child: Text("Review"),
                  ),
                ),
              ),
              SizedBox(width: 5),
              GestureDetector(
                onTap: ()async{
                  examinationDetailController.examinationId=eid;
                  await examinationDetailController.fetchData(eid);
                  Get.toNamed(AppRoutes.examDetails);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 12),
                    child: Text("Assign"),
                  ),
                ),
              ),
        ],
          ),
        ],
      ),
    );
  }
}

class ProgressLine extends StatelessWidget {
  const ProgressLine({
    Key? key,
    this.color = primaryColor,
    required this.percentage,
  }) : super(key: key);

  final Color? color;
  final int? percentage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 5,
          decoration: BoxDecoration(
            color: color!.withOpacity(0.1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth * (percentage! / 100),
            height: 5,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}

