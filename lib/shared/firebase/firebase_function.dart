import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model/AccountData.dart';
import '../../model/reportModel.dart';
import '../../model/taskModel.dart';

class firebaseFunctions {
  static CollectionReference<AccountData> getAccCollection() {
    return FirebaseFirestore.instance
        .collection('Accounts')
        .withConverter<AccountData>(
      fromFirestore: (snapshot, _) {
        print("collection ${snapshot.data()}");
        return AccountData.fromJson(snapshot.data()!);
      },
      toFirestore: (value, options) {
        return value.toJson();
      },
    );
  }

  static Future<void> addAccToFirstore(AccountData AccountData) async {
    var Collection = getAccCollection();
    var docRef = Collection.doc(AccountData.id);
    return docRef.set(AccountData);
  }

  static Future<void> CreatUser(
      String fNAME,
      String lNAME,
      String email,
      String password,
      int age,
      String gender,
      String location,
      Function onSuccess,
      Function onError) async {
    try {
      final Credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (Credential.user?.uid != null) {
        AccountData Acc = AccountData(
            id: Credential.user!.uid,
            fNAME: fNAME,
            lNAME: lNAME,
            email: email,
            age: age,
            gender: gender,
            location: location);
        addAccToFirstore(Acc).then(
              (value) {
            onSuccess();
            if (Credential.user!.uid != null) {
              readUserFromFirebase(Credential.user!.uid);
              onSuccess();
            }
          },
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onError(e.message.toString());
      } else if (e.code == 'email-already-in-use') {
        onError(e.message.toString());
      }
    } catch (ex) {
      onError(ex.toString());
    }
  }

  static Future<void> loginUser(String email, String password,
      Function onSuccess, Function onError) async {
    try {
      final Credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (Credential.user!.uid != null) {
        readUserFromFirebase(Credential.user!.uid);
        onSuccess();
      }
    } on FirebaseAuthException catch (e) {
      onError("wrong mail or password");
    }
  }

  static Future<AccountData?> readUserFromFirebase(String id) async {
    DocumentSnapshot<AccountData> doc = await getAccCollection().doc(id).get();
    return doc.data();
  }

  static Future<void> updateAccount(
      AccountData account,
      String fNAME,
      String lNAME,
      String email,
      int age,
      String gender,
      String location,
      ) {
    Map<String, dynamic> updateData = {
      'Frist name': fNAME,
      'Last name': lNAME,
      'email': email,
      'age': age,
      'gender': gender,
      'location': location,
    };
    updateData.removeWhere((key, value) => value == null);
    return getAccCollection().doc(account.id).update(updateData);
  }

  //task
  static CollectionReference<TaskModel> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection("Tasks")
        .withConverter<TaskModel>(
      fromFirestore: (snapshot, _) {
        return TaskModel.fromJson(snapshot.data()!);
      },
      toFirestore: (taskModel, _) {
        return taskModel.toJson();
      },
    );
  }

  static Future<void> addTask(TaskModel model) async {
    var collection = getTasksCollection();
    var docRef = collection.doc();
    model.id = docRef.id;
    docRef.set(model);
  }

  static Stream<QuerySnapshot<TaskModel>> getTasks(DateTime dateTime) {
    var collection = getTasksCollection();
    return collection
        .where("userID", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .where("date",
        isEqualTo: DateUtils.dateOnly(dateTime).millisecondsSinceEpoch)
        .snapshots();
  }

  static Future<void> deleteTask(String id) {
    return getTasksCollection().doc(id).delete();
  }

  static Future<void> updateTask(TaskModel model) {
    return getTasksCollection().doc(model.id).update(model.toJson());
  }

  static Future insertReport( List report,String idUser) async {
    try {
      await FirebaseFirestore.instance.collection('reports').add({
        'description': report,
        'timestamp': FieldValue.serverTimestamp(),
        "userid":idUser,
      });
      print( 'Report saved successfully!');
    } catch (e) {
      print( 'Failed to save report: $e');
    }
  }

  static CollectionReference<Report> getReportsCollection() {
    return FirebaseFirestore.instance
        .collection("reports")
        .withConverter<Report>(
      fromFirestore: (snapshot, _) {
        final data = snapshot.data();
        if (data == null) {
          throw Exception('No data found for Report');
        }
        return Report.fromJson(data as Map<String, dynamic>);
      },
      toFirestore: (report, _) {
        return report.toJson();
      },
    );
  }


}
