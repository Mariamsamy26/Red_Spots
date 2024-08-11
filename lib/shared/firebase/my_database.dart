import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/report_history.dart';

class MyDatabase{
  static CollectionReference<Report> getreportsCollection(){
    var historyCollection= FirebaseFirestore.instance
        .collection('history')
        .withConverter<Report>(
        fromFirestore:(snapshot,options)=>  Report.fromFireStore(snapshot.data()!),
        toFirestore: (report,options)=>report.toFireStore());
    return historyCollection;
  }
  static Future <void> insertReport(Report report){
    var historyCollection= getreportsCollection();
  var doc= historyCollection.doc();
  report.id=doc.id;
  return  doc.set(report);
  }
}