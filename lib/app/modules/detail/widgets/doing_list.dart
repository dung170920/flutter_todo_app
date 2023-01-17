import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/app/core/utils/extensions.dart';
import 'package:todo/app/core/values/images.dart';
import 'package:todo/app/modules/home/controller.dart';

class DoingList extends StatelessWidget {
  DoingList({super.key});

  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>
          homeController.doingTodos.isEmpty && homeController.doneTodos.isEmpty
              ? Column(
                  children: [
                    Image.asset(noTodos),
                    Text(
                      'Add Tasks',
                      style: TextStyled.h5,
                    )
                  ],
                )
              : ListView(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  children: [
                    ...homeController.doingTodos
                        .map(
                          (element) => Padding(
                            padding: EdgeInsets.symmetric(vertical: 3.0.wp),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: Checkbox(
                                    activeColor: Colors.grey[700],
                                    value: element['done'],
                                    onChanged: (value) {
                                      homeController.doneTodo(element['title']);
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 3.0.wp),
                                  child: Text(
                                    element['title'],
                                    style: TextStyled.bodyLarge
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                    if (homeController.doingTodos.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.0.wp),
                        child: Divider(
                          color: Colors.grey[400],
                        ),
                      ),
                  ],
                ),
    );
  }
}
