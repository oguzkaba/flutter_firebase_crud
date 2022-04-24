import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_firebase_crud/app/data/remote/controllers/todo_controller.dart';
import 'package:flutter_firebase_crud/app/global/constants/constants.dart';
import 'package:flutter_firebase_crud/app/global/controllers/internet_controller.dart';
import 'package:flutter_firebase_crud/app/widgets/indicator_widget.dart';
import 'package:get/get.dart';
import '../controllers/reports_controller.dart';

// ignore: must_be_immutable
class ReportsView extends GetView<ReportsController> {
  double totalTodo = 0.0;
  double complatedTodo = 0.0;
  double notComplatedTodo = 0.0;

  @override
  Widget build(BuildContext context) {
    final ReportsController controller = Get.put(ReportsController());

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Obx(() => Text(
                NetController.instance.isOnline
                    ? "Todo List - Reports"
                    : "Todo List - Reports (Offline) ",
                style: TextStyle(fontSize: 20),
              )),
        ),
        body: Obx(() => _chartBuild(controller)));
  }

  AspectRatio _chartBuild(ReportsController controller) {
    return AspectRatio(
            aspectRatio: 1.1,
            child: Card(
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  const SizedBox(
                    height: 18,
                  ),
                  Expanded(
                    child: AspectRatio(
                        aspectRatio: 1,
                        child: TodoController.instance.todos.isEmpty
                            ? Center(child: Text("No Data"))
                            : PieChart(
                                PieChartData(
                                    pieTouchData: PieTouchData(touchCallback:
                                        (FlTouchEvent event,
                                            pieTouchResponse) {
                                      if (!event
                                              .isInterestedForInteractions ||
                                          pieTouchResponse == null ||
                                          pieTouchResponse.touchedSection ==
                                              null) {
                                        controller.touchedIndex.value = -1;
                                        return;
                                      }
                                      controller.touchedIndex.value =
                                          pieTouchResponse.touchedSection!
                                              .touchedSectionIndex;
                                    }),
                                    borderData: FlBorderData(
                                      show: false,
                                    ),
                                    sectionsSpace: 0,
                                    centerSpaceRadius: 40,
                                    sections: showingSections(
                                        TodoController.instance)),
                              )),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Indicator(
                        color: myGreenColor,
                        text: 'Complated',
                        isSquare: true,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Indicator(
                        color: myRedColor,
                        text: 'Not Complated',
                        isSquare: true,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 28,
                  ),
                ],
              ),
            ),
          );
  }

  List<PieChartSectionData> showingSections(TodoController todoController) {
    return List.generate(2, (i) {
      todoCalculate(todoController);
      final isTouched = i == controller.touchedIndex.value;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: myGreenColor,
            value: complatedTodo,
            title: "%${(100 / totalTodo * complatedTodo).round()}",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: myRedColor,
            value: notComplatedTodo,
            title:
                "%${(100 / totalTodo * notComplatedTodo).round()}".toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          throw Error();
      }
    });
  }

  void todoCalculate(TodoController todoController) {
    complatedTodo = 0.0;
    notComplatedTodo = 0.0;
    totalTodo = todoController.todos.length.toDouble();
    for (var item in todoController.todos) {
      if (item.complated) {
        complatedTodo++;
      } else {
        notComplatedTodo++;
      }
    }
  }
}
