import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todo/app/core/utils/extensions.dart';
import 'package:todo/app/core/values/colors.dart';
import 'package:todo/app/core/values/icons.dart';
import 'package:todo/app/modules/home/controller.dart';

class AddDialog extends StatelessWidget {
  AddDialog({super.key});

  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Form(
          key: homeController.formKey,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(2.0.wp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                        homeController.editController.clear();
                        homeController.changeTask(null);
                      },
                      icon: const Icon(
                        MyIcons.solidTimes,
                        size: 20,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (homeController.formKey.currentState!.validate()) {
                          if (homeController.task.value == null) {
                            EasyLoading.showError('Please choose task type');
                          } else {
                            var success = homeController
                                .updateTask(homeController.editController.text);
                            if (success) {
                              EasyLoading.showSuccess('Add todo success');
                              Get.back();
                              homeController.editController.clear();
                              homeController.changeTask(null);
                            } else {
                              EasyLoading.showError('Todo is already existed');
                            }
                          }
                        }
                      },
                      child: Text(
                        'Done',
                        style: TextStyled.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.0.wp),
                child: Text(
                  'New Task',
                  style: TextStyled.h4,
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 6.0.wp, vertical: 3.0.wp),
                child: TextFormField(
                  controller: homeController.editController,
                  autofocus: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your task title';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 6.0.wp, right: 6.0.wp, top: 5.0.wp, bottom: 4.0.wp),
                child: Text(
                  'Add to',
                  style: TextStyled.bodyLarge.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ),
              ...homeController.tasks
                  .map(
                    (element) => Obx(
                      () => InkWell(
                        onTap: () {
                          homeController.changeTask(element);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.0.wp, vertical: 3.0.wp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    IconData(
                                      element.icon,
                                      fontFamily: 'MyIcons',
                                    ),
                                    color: HexColor.fromHex(element.color),
                                  ),
                                  SizedBox(
                                    width: 3.0.wp,
                                  ),
                                  Text(
                                    element.title,
                                    style: TextStyled.bodyLarge.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              if (homeController.task.value == element)
                                const Icon(
                                  MyIcons.solidCheck,
                                  color: green,
                                )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}
