import 'dart:async';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/controllers/task_controller.dart';
import 'package:myapp/models/task.dart';
import 'package:myapp/ui/pages/add_task_page.dart';
import 'package:myapp/ui/size_config.dart';
import 'package:myapp/ui/theme.dart';
import 'package:myapp/ui/widgets/button.dart';
import 'package:intl/intl.dart';
import 'package:myapp/ui/widgets/task_tile.dart';
import '../../services/theme_services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.parse(DateTime.now().toString());
  final _taskController = Get.put(TaskController());
  bool animate=false;
  double left=630;
  double top=900;
  Timer? _timer;
//  final user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        animate=true;
        left=30;
        top=top/3;
      });
    });
  }
  void signUserOut(){
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: context.theme.backgroundColor,
      body: Column(
        children: [
          _addTaskBar(),
          _dateBar(),
          const SizedBox(
            height: 12,
          ),
          _showTasks(),
        ],
      ),
    );
  }

  _dateBar() {
    return Container(
      margin: EdgeInsets.only(bottom: 10, left: 20),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20)
        ),
        child: DatePicker(
          DateTime.now(),
          height: 100.0,
          width: 80,
          initialSelectedDate: DateTime.now(),
          selectionColor: primaryClr,
          //selectedTextColor: primaryClr,
          selectedTextColor: Colors.white,
          dateTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          dayTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontSize: 16.0,
              color: Colors.grey,
            ),
          ),
          monthTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontSize: 10.0,
              color: Colors.grey,
            ),
          ),
          onDateChange: (date) {
            // New date selected
            setState(
                  () {
                _selectedDate = date;
              },
            );
          },
        ),
      ),
    );
  }

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Today is",
                style: headingTextStyle,
              ),
              Text(" ",
                style: subHeadingTextStyle,
              ),
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: headingTextStyle,
              ),
              const SizedBox(height: 20,)
            ],
          ),
          MyButton(
            label: "+",
            onTap: () async {
              await Get.to(AddTaskPage());
              _taskController.getTasks();
            },
          ),
        ],
      ),
    );
  }

  _appBar() {
    return AppBar(
        elevation: 0,
        backgroundColor: context.theme.backgroundColor,
        leading: GestureDetector(
          onTap: () {
            ThemeService().switchTheme();},
          child: Icon(
              Get.isDarkMode ? Icons.wb_sunny : Icons.shield_moon,
              color: Get.isDarkMode ? Colors.white : darkGreyClr),
        ),

        actions: [
          IconButton(
              onPressed: signUserOut, icon:  const Icon(Icons.logout,
                size: 25,
                color: primaryClr),),
              ],
        //const SizedBox(height: 20),
    );
  }

  _showTasks() {
    return Expanded(
      child: Obx(() {
        if (_taskController.taskList.isEmpty) {
          return _noTaskMsg();
        } else {
          return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: _taskController.taskList.length,
              itemBuilder: (context, index) {
                Task task = _taskController.taskList[index];
                if (task.repeat == 'Daily') {

                  var hour= task.startTime.toString().split(":")[0];
                  var minutes = task.startTime.toString().split(":")[1];
                  debugPrint("My time is " + hour);
                  debugPrint("My minute is " + minutes);
                  DateTime date= DateFormat.jm().parse(task.startTime!);
                  var myTime = DateFormat("HH:mm").format(date);
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 1375),
                    child: SlideAnimation(
                      horizontalOffset: 300.0,
                      child: FadeInAnimation(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  showBottomSheet(context, task);
                                },
                                child: TaskTile(task)),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                if (task.date == DateFormat.yMd().format(_selectedDate)) {
                  //notifyHelper.scheduledNotification();
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 1375),
                    child: SlideAnimation(
                      horizontalOffset: 300.0,
                      child: FadeInAnimation(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                                onTap: () {

                                  showBottomSheet(context, task);
                                },
                                child: TaskTile(task)),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              });
        }
      }),
    );
  }

  showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top: 4),
        height: task.isCompleted == 1
            ? SizeConfig.screenHeight * 0.24
            : SizeConfig.screenHeight * 0.32,
        width: SizeConfig.screenWidth,
        color: Get.isDarkMode ? darkHeaderClr : Colors.white,
        child: Column(children: [
          Container(
            height: 6,
            width: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300]),
          ),
          const Spacer(),
          task.isCompleted == 1
              ? Container()
              : _buildBottomSheetButton(
              label: "Task Completed",
              onTap: () {
                _taskController.markTaskCompleted(task.id);
                Get.back();
              },
              clr: primaryClr),
          _buildBottomSheetButton(
              label: "Delete Task",
              onTap: () {
                _taskController.deleteTask(task);
                Get.back();
              },
              clr: Colors.red[300]),
          const SizedBox(
            height: 20,
          ),
          _buildBottomSheetButton(
              label: "Close",
              onTap: () {
                Get.back();
              },
              isClose: true),
          const SizedBox(
            height: 20,
          ),
        ]),
      ),
    );
  }

  _buildBottomSheetButton(
      {required String label, Function? onTap, Color? clr, bool isClose = false}) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: SizeConfig.screenWidth! * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose
                ? Get.isDarkMode
                ? Colors.grey[600]!
                : Colors.grey[300]!
                : clr!,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose ? Colors.transparent : clr,
        ),
        child: Center(
            child: Text(
              label,
              style: isClose
                  ? titleTextStle
                  : titleTextStle.copyWith(color: Colors.white),
            )),
      ),
    );
  }

  _noTaskMsg() {
    return Stack(
      children:[ AnimatedPositioned(
        duration: Duration(milliseconds: 2000),
        left: left,
        top:top,
        child: Container(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                SizedBox(
                  height: 80,
                ),
              ],
            )
        ),
      )],
    );
  }
}
