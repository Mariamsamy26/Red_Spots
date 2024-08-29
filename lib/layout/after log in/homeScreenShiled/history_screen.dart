import 'package:flutter/material.dart';
import 'package:red_spotss/shared/firebase/firebase_function.dart';
import '../../../model/report_history.dart';
import '../../../shared/style/color_manager.dart';

class history_screen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<history_screen> {
  List<Report> _userReports = [];

  @override
  void initState() {
    super.initState();
    _fetchUserReports();
  }

  Future<void> _fetchUserReports() async {
    try {
      final reportsSnapshot =
          await firebaseFunctions.getReportsCollection().get();
      final reports = reportsSnapshot.docs
          .map((doc) => doc.data()) // Convert each document to Report instance
          .toList();

      // Update state with fetched reports
      setState(() {
        _userReports = reports.cast<Report>();
      });

      print("User Reports fetched: ${_userReports.length}");
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
        child: _userReports.isEmpty
            ? Center(child: Text('No reports found'))
            : ListView.builder(
                itemCount: _userReports.length,
                itemBuilder: (context, index) {
                  final report = _userReports[index];
                  return ListTile(
                    title: Container(
                      padding: const EdgeInsets.all(8.0),
                      color:
                          ColorManager.primaryColor, // Set the background color
                      child: Text(
                        report.description.join(', '),
                        // Join list items into a single string
                        style: TextStyle(
                            color: Colors
                                .white), // Set text color to contrast with the background
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
