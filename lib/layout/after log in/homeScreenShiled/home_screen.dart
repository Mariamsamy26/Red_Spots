import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:red_spotss/shared/firebase/firebase_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Providers/my_provider.dart';
import '../../../shared/components/Cuustom_taskitem.dart';
import '../../../shared/components/categary.dart';
import '../../../shared/style/color_manager.dart';
import 'addRemmberScreen.dart';
import 'history_screen.dart';
import 'notification.dart';

class Home_Screen extends StatefulWidget {
  static const String rountName = 'home';

  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  DateTime _SelectedDate = DateTime.now();

  //final TaskController _taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    DateTime today = DateTime.now();
    void _onDaySelected(DateTime day, DateTime focusedDay) {
      setState(() {
        today = day;
      });
    }

    return Scaffold(
        backgroundColor: ColorManager.colorWhit,
        appBar: AppBar(
          title: Text(
            'welcom back ${pro.accountData!.fNAME?? "User"}',
            style: const TextStyle(fontSize: 25, color: ColorManager.colorWhit),
          ),
          centerTitle: false,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationScreen()),
                );
              },
              icon: const Icon(
                Icons.notifications_active_outlined,
                color: ColorManager.colorWhit,
              ),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          backgroundColor: ColorManager.primaryColor,
          elevation: 50,
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  DateFormat('dd MMM yyyy').format(_SelectedDate),
                  style: TextStyle(fontSize: 25, color: Colors.black45),
                ),
                MaterialButton(
                  color: ColorManager.scondeColor,
                  child: Text(
                    "add note",
                    style: TextStyle(color: Colors.black38, fontSize: 18),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddRemmberScreen()));
                  },
                ),
              ],
            ),
            AddDateBar(),
            const SizedBox(height: 18),

            Expanded(
              child: Container(
                width: double.infinity,
                color: ColorManager.scondeColor.withOpacity(0.2),
                child: StreamBuilder(
                  stream: firebaseFunctions.getTasks(_SelectedDate),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Column(
                        children: [
                          Text("Something went wrong"),
                          ElevatedButton(
                              onPressed: () {}, child: Text("try again"))
                        ],
                      );
                    }
                    var tasks =
                        snapshot.data?.docs.map((doc) => doc.data()).toList();

                    if (tasks == null || tasks.isEmpty ) {
                      return const Text("No notes to day");
                    } else {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return Cuustomtaskitem(model: tasks[index]);
                        },
                        itemCount: tasks!.length,
                      );
                    }
                  },
                ),
              ),
            ),


            // Category
            SizedBox(height: 15),
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 40, height: 50),
                        Text('Category',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomIconBottom(
                          height: 50,
                          width: 140,
                          radius: 30,
                          heightIcon: 100,
                          widthIcon: 100,
                          iconPath: 'assets/images/pr.png',
                          text: 'Psoriasis',
                          //***page google url**//
                          OnPressed: () {
                            _launchURL("www.psoriasis.com");
                          },
                        ),
                        SizedBox(width: 30, height: 35),
                        CustomIconBottom(
                          height: 50,
                          width: 140,
                          radius: 30,
                          heightIcon: 100,
                          widthIcon: 100,
                          iconPath: 'assets/images/history.png',
                          text: 'History ',
                          OnPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => history_screen()));
                          },
                        ),
                      ],
                    ),
                    SizedBox(width: 30, height: 60),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  dynamic AddDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: ColorManager.primaryColor,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black12,
          ),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black12,
          ),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black12,
          ),
        ),
        onDateChange: (date) {
          setState(() {
            _SelectedDate = date;
          });
        },
      ),
    );
  }

  Widget showTasks() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('tasks').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          var tasks = snapshot.data!.docs;
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              var task = tasks[index].data() as Map<String, dynamic>;
              return ListTile(
                title: Text(task['title']),
                subtitle: Text(task['description']),
                trailing: Checkbox(
                  value: task['isCompleted'],
                  onChanged: (bool? value) {
                    FirebaseFirestore.instance
                        .collection('tasks')
                        .doc(tasks[index].id)
                        .update({'isCompleted': value});
                  },
                ),
              );
            },
          );
        }
      },
    );
  }
}

Future<void> _launchURL(String url) async {
  final Uri uri = Uri(scheme: "http", host: url);
  if (!await launchUrl(
    uri,
    mode: LaunchMode.externalApplication,
  )) {
    throw "can not lunch url";
  }
}
