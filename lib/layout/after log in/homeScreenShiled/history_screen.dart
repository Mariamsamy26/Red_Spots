import 'package:flutter/material.dart';

import '../../../model/report_history.dart';
import '../../../shared/components/dialoge_utils.dart';
import '../../../shared/components/time_line.dart';
import '../../../shared/firebase/my_database.dart';
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
    // _fetchUserReports();
  }

  // void _fetchUserReports() async {
  //   final reports = await MyDatabase.getUserReports();
  //   setState(() {
  //     _userReports = reports;
  //   });
  //   print("User Reports fetched: ${_userReports.length}");
  //   for (var report in _userReports) {
  //     print("Report: ${report.classificationResult}");
  //   }
  // }

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
            return TimeLine(
              isFirst: index == 0,
              isLast: index == _userReports.length - 1,
              isPast: true,
              report: report,
            );
          },
        ),
      ),
    );
  }
}
