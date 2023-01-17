import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todo/app/core/values/values.dart';
import 'package:todo/app/modules/home/controller.dart';
import 'package:todo/app/core/utils/extensions.dart';
import 'package:todo/app/modules/detail/widgets/widgets.dart';

class TaskDetailScreen extends StatelessWidget {
  TaskDetailScreen({super.key});

  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(6.0.wp),
          child: Form(
            key: homeController.formKey,
            child: ListView(
              children: [
                IconButton(
                  alignment: Alignment.topLeft,
                  onPressed: () {
                    Get.back();
                    homeController.updateTodos();
                    homeController.editController.clear();
                    //homeController.changeTask(null);
                  },
                  icon: const Icon(
                    MyIcons.solidAngleLeftSmall,
                    color: Colors.black54,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 3.0.wp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            IconData(
                              homeController.task.value!.icon,
                              fontFamily: 'MyIcons',
                            ),
                            size: 30,
                            color: HexColor.fromHex(
                                homeController.task.value!.color),
                          ),
                          SizedBox(
                            width: 3.0.wp,
                          ),
                          Text(
                            homeController.task.value!.title,
                            style: TextStyled.h4,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Obx(
                  () {
                    var totalTodos = homeController.doingTodos.length +
                        homeController.doneTodos.length;
                    var color =
                        HexColor.fromHex(homeController.task.value!.color);
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 11.0.wp),
                      child: Row(
                        children: [
                          Text(
                            '$totalTodos  Tasks',
                            style: TextStyled.bodyLarge
                                .copyWith(color: Colors.grey),
                          ),
                          SizedBox(
                            width: 3.0.wp,
                          ),
                          totalTodos > 0
                              ? Expanded(
                                  child: StepProgressIndicator(
                                    totalSteps: totalTodos,
                                    currentStep:
                                        homeController.doneTodos.length,
                                    size: 5,
                                    padding: 0,
                                    selectedGradientColor: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [color.withOpacity(0.5), color],
                                    ),
                                    unselectedGradientColor: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.grey[300]!,
                                        Colors.grey[300]!
                                      ],
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0.wp),
                  child: TextFormField(
                    controller: homeController.editController,
                    decoration: InputDecoration(
                      hintText: 'Enter todo',
                      prefixIcon: Icon(
                        Icons.check_box_outline_blank_rounded,
                        color: Colors.grey[400],
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          if (homeController.formKey.currentState!.validate()) {
                            var success = homeController
                                .addTodos(homeController.editController.text);
                            if (success) {
                              homeController.updateTodos();
                              EasyLoading.showSuccess('Add todo success');
                            } else {
                              EasyLoading.showError('Todo is already existed');
                            }
                            homeController.editController.clear();
                          }
                        },
                        icon: const Icon(
                          MyIcons.solidCheck,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your todo';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 4.0.wp),
                  child: Divider(
                    color: Colors.grey[400],
                  ),
                ),
                DoingList(),
                DoneList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
