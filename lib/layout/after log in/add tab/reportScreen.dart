import 'package:flutter/material.dart';
import '../../../model/report_history.dart';
import '../../../shared/components/dialoge_utils.dart';
import '../../../shared/firebase/my_database.dart';
import '../../../shared/style/color_manager.dart';
import '../homeScreenShiled/history_screen.dart';
import 'DermatologyClinicMapScreen.dart';

class reportScreen extends StatefulWidget {
  @override
  _reportScreenState createState() => _reportScreenState();
}

class _reportScreenState extends State<reportScreen> {
  var titleControler = TextEditingController();
  var descControler = TextEditingController();
  String? _classificationResult; // Added for API result

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Image.asset('assets/images/Doctor.png'),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  color: ColorManager.colorWhit,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(height: 70, width: 40),
                            Text(
                              'Report',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ListTile(
                            title: _classificationResult == null
                                ? Text('Loading...')
                                : Text(
                              'Classification Result: $_classificationResult',
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        OutlinedButton(
                          onPressed: () {
                            insertReport();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => history_screen(),
                              ),
                            );
                          },
                          child: Text(
                            'History',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DermatologyClinicMapScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Clinic',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void insertReport() async {
    Report report = Report(
      title: titleControler.text,
      description: descControler.text,
    );

    DialogeUtils();
    await MyDatabase.insertReport(report);
  }

  @override
  void initState() {
    super.initState();
    //********* Call API when the screen loads
    _getClassificationResult();
  }

  Future<void> _getClassificationResult() async {
    setState(() {
      _classificationResult = 'Result from API';
    });
  }
}
