import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todo/app/core/values/colors.dart';
import 'package:todo/app/core/values/images.dart';
import 'package:todo/app/core/utils/extensions.dart';
import 'package:todo/app/modules/home/controller.dart';

class ReportScreen extends StatelessWidget {
  ReportScreen({super.key});

  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          var createdTasks = homeController.getTotalTasks();
          var completedTasks = homeController.getTotalDoneTasks();
          var liveTasks = createdTasks - completedTasks;
          var percent =
              (completedTasks / createdTasks * 100).toStringAsFixed(0);
          return ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(6.0.wp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          logo,
                          height: 10.0.wp,
                          width: 10.0.wp,
                        ),
                        SizedBox(
                          width: 2.0.wp,
                        ),
                        Text(
                          'Report',
                          style: TextStyled.h4,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 6.0.wp,
                    ),
                    Text(
                      '${DateTime.now().day.toString()}/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}',
                      style: TextStyled.bodyLarge.copyWith(
                          color: Colors.grey, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.0.wp),
                child: Divider(
                  color: Colors.grey[400],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 6.0.wp, vertical: 4.0.wp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatus(
                      green,
                      liveTasks,
                      'Live Tasks',
                    ),
                    _buildStatus(
                      pink,
                      completedTasks,
                      'Completed',
                    ),
                    _buildStatus(
                      blue,
                      createdTasks,
                      'Created',
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0.wp),
                child: UnconstrainedBox(
                  child: SizedBox(
                    height: 70.0.wp,
                    width: 70.0.wp,
                    child: CircularStepProgressIndicator(
                      totalSteps: createdTasks == 0 ? 1 : createdTasks,
                      padding: 0,
                      currentStep: completedTasks,
                      stepSize: 20,
                      selectedColor: green,
                      unselectedColor: Colors.grey[200],
                      width: 150,
                      height: 150,
                      roundedCap: (p0, p1) => true,
                      selectedStepSize: 22,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('$percent %', style: TextStyled.h3),
                          SizedBox(
                            height: 2.0.wp,
                          ),
                          Text(
                            'Efficiency',
                            style: TextStyled.bodyLarge.copyWith(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}

Row _buildStatus(Color color, int number, String title) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        height: 3.0.wp,
        width: 3.0.wp,
        margin: EdgeInsets.symmetric(vertical: 2.0.wp),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 0.5.wp,
            color: color,
          ),
        ),
      ),
      SizedBox(
        width: 3.0.wp,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$number', style: TextStyled.h5),
          SizedBox(
            height: 2.0.wp,
          ),
          Text(
            title,
            style: TextStyled.bodyMedium
                .copyWith(color: Colors.grey, fontWeight: FontWeight.w500),
          ),
        ],
      )
    ],
  );
}
