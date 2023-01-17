import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todo/app/core/values/values.dart';
import 'package:todo/app/data/models/task.dart';
import 'package:todo/app/modules/home/controller.dart';
import 'package:todo/app/core/utils/extensions.dart';
import 'package:todo/app/widgets/input.dart';

class AddCard extends StatelessWidget {
  AddCard({super.key});

  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final squareWidth = Get.width - 12.0.wp;
    const icons = [
      Icon(
        MyIcons.solidUser,
        color: purple,
      ),
      Icon(
        MyIcons.solidBriefcase,
        color: pink,
      ),
      Icon(
        MyIcons.solidVideoPlay,
        color: green,
      ),
      Icon(
        MyIcons.solidBackpack,
        color: yellow,
      ),
      Icon(
        MyIcons.solidNoteList,
        color: deekPink,
      ),
    ];

    return Container(
      width: squareWidth / 2,
      height: squareWidth / 2,
      margin: EdgeInsets.all(4.0.wp),
      child: InkWell(
        onTap: () async {
          await Get.defaultDialog(
            contentPadding:
                EdgeInsets.only(left: 8.0.wp, right: 8.0.wp, bottom: 10.0.wp),
            titlePadding: EdgeInsets.symmetric(vertical: 8.0.wp),
            radius: 5,
            title: 'Task Type',
            titleStyle: TextStyled.h4,
            content: Form(
              key: homeController.formKey,
              child: Column(
                children: [
                  Input(
                    label: 'Title',
                    controller: homeController.editController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your task type title';
                      }
                      return null;
                    },
                  ),
                  Wrap(
                    spacing: 2.0.wp,
                    children: icons
                        .map(
                          (e) => Obx(
                            (() {
                              final index = icons.indexOf(e);
                              return ChoiceChip(
                                label: e,
                                pressElevation: 0,
                                padding: EdgeInsets.symmetric(vertical: 2.0.wp),
                                selectedColor: e.color!.withOpacity(0.2),
                                backgroundColor: Colors.white,
                                selected:
                                    homeController.chipIndex.value == index,
                                onSelected: (bool selected) {
                                  homeController.chipIndex.value =
                                      selected ? index : 0;
                                },
                              );
                            }),
                          ),
                        )
                        .toList(),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      maximumSize: const Size(150, 40),
                    ),
                    onPressed: () {
                      if (homeController.formKey.currentState!.validate()) {
                        int icon = icons[homeController.chipIndex.value]
                            .icon!
                            .codePoint;
                        String color = icons[homeController.chipIndex.value]
                            .color!
                            .toHex();

                        var task = Task(
                          title: homeController.editController.text,
                          icon: icon,
                          color: color,
                        );
                        Get.back();
                        homeController.addTask(task)
                            ? EasyLoading.showSuccess('Create success')
                            : EasyLoading.showError('Duplicated task');
                      }
                    },
                    child: Text(
                      'Confirm',
                      style: TextStyled.bodyMedium
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          );
          homeController.editController.clear();
          homeController.changeChipIndex(0);
        },
        child: DottedBorder(
          color: Colors.grey[400]!,
          dashPattern: const [8, 4],
          child: Center(
            child: Icon(
              MyIcons.solidPlus,
              size: 10.0.wp,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
