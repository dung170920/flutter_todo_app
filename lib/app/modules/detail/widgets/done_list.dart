import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/app/core/utils/extensions.dart';
import 'package:todo/app/core/values/colors.dart';
import 'package:todo/app/core/values/icons.dart';
import 'package:todo/app/core/values/images.dart';
import 'package:todo/app/modules/home/controller.dart';

class DoneList extends StatelessWidget {
  DoneList({super.key});

  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => homeController.doneTodos.isNotEmpty
        ? ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              Text(
                'Completed (${homeController.doneTodos.length})',
                style: TextStyled.bodyXLarge.copyWith(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 4.0.wp,
              ),
              ...homeController.doneTodos
                  .map(
                    (element) => Dismissible(
                      key: ObjectKey(element),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) =>
                          homeController.deleteDoneTodos(element),
                      background: Container(
                        color: Colors.red.withOpacity(0.8),
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 4.0.wp),
                          child: const Icon(MyIcons.solidTrash,
                              color: Colors.white),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 3.0.wp),
                        child: Row(
                          children: [
                            const Icon(
                              MyIcons.solidCheck,
                              color: blue,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 3.0.wp),
                              child: Text(
                                element['title'],
                                style: TextStyled.bodyLarge.copyWith(
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.lineThrough),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ],
          )
        : Container());
  }
}
