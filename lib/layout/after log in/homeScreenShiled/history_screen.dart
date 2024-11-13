import 'package:flutter/material.dart';
import 'package:red_spotss/shared/firebase/firebase_function.dart';
import '../../../model/reportModel.dart';
import '../../../shared/style/color_manager.dart';

class history_screen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<history_screen> {
  List<Report> userReports = [];

  @override
  void initState() {
    super.initState();
    _fetchUserReports();
  }

  Future<void> _fetchUserReports() async {
    try {
      final reportsSnapshot =
          await firebaseFunctions.getReportsCollection().get();
      final reports = reportsSnapshot.docs.map((doc) {
        final data = doc.data();
        print('Fetched report data: $data');
        return data;
      }).toList();

      setState(() {
        userReports = reports.cast<Report>();
      });

      print("User Reports fetched: ${userReports.length}");
    } catch (e) {
      print("Error fetching user reports: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'History',
          style: TextStyle(fontSize: 23, color: Colors.black),
        ),
        backgroundColor: ColorManager.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: userReports.isEmpty
            ? Center(child: Text('No reports found'))
            : ListView.builder(
                itemCount: userReports.length,
                itemBuilder: (context, index) {
                  final report = userReports[index];
                  final descriptionText = report.description
                      .map((desc) => desc.toString())
                      .join(', ');
                  return  ListTile(
                      title: Card(
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          color:
                              ColorManager.primaryColor,
                          child: Text(
                              descriptionText,
                            style: TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                      subtitle: Text(report.formattedTimestamp),
                      contentPadding: const EdgeInsets.all(16.0),
                  );
                },
              ),
      ),
    );
  }
}
