import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todo/app/core/values/values.dart';
import 'package:todo/app/data/models/task.dart';
import 'package:todo/app/modules/home/controller.dart';
import 'package:todo/app/core/utils/extensions.dart';
import 'package:todo/app/modules/home/widgets/widgets.dart';
import 'package:todo/app/modules/report/view.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.tabIndex.value,
          children: [
            SafeArea(
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.all(6.0.wp),
                    child: Row(
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
                          'My List',
                          style: TextStyled.h4,
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () => GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      children: [
                        ...controller.tasks
                            .map(
                              (e) => LongPressDraggable(
                                data: e,
                                onDragStarted: () {
                                  controller.changeDeleting(true);
                                },
                                onDraggableCanceled: (velocity, offset) {
                                  controller.changeDeleting(false);
                                },
                                onDragEnd: (details) {
                                  controller.changeDeleting(false);
                                },
                                feedback: Opacity(
                                  opacity: 0.8,
                                  child: TaskCard(task: e),
                                ),
                                child: TaskCard(task: e),
                              ),
                            )
                            .toList(),
                        AddCard(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ReportScreen(),
          ],
        ),
      ),
      floatingActionButton: DragTarget<Task>(
        onAccept: (Task task) {
          controller.deleteTask(task);
          EasyLoading.showSuccess('Delete success');
        },
        builder: (BuildContext context, List<Object?> candidateData,
                List<dynamic> rejectedData) =>
            Obx(
          () => FloatingActionButton(
            backgroundColor: controller.deleting.value ? Colors.red : blue,
            onPressed: () {
              if (controller.tasks.isNotEmpty) {
                Get.to(AddDialog(), transition: Transition.downToUp);
              } else {
                EasyLoading.showInfo('Task type is empty');
              }
            },
            child: Icon(
              !controller.deleting.value
                  ? MyIcons.solidPlus
                  : MyIcons.solidTrash,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Obx(
          () => BottomNavigationBar(
            onTap: (value) => controller.changeTabIndex(value),
            currentIndex: controller.tabIndex.value,
            showSelectedLabels: false,
            selectedItemColor: blue,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(right: 15.0.wp),
                    child: const Icon(MyIcons.solidGrid_2),
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(left: 15.0.wp),
                    child: const Icon(MyIcons.solidMoreHorizontal),
                  ),
                  label: ''),
            ],
          ),
        ),
      ),
    );
  }
}
