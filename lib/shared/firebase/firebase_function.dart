import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../model/AccountData.dart';

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

}
