import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:amazon_clone/models/user.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = 'An error has occurred';
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> createUser({
    required String name,
    required String address,
    required String email,
    required String password,
  }) async {
    String res = 'An error has occurred';
    try {
      UserCredential? cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String uid = cred.user!.uid;
      final model.User user =
          model.User(name: name, address: address, email: email, uid: uid);
      await _firestore.collection('users').doc(uid).set(user.toMap());
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<model.User> getUserDetails()async{
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snapshot = await _firestore.collection('users').doc(currentUser.uid).get();
    return model.User.fromSnap(snapshot);
  }

  Future<String> signOutUser() async {
    String res = "An error occurred";
    try{
      await _auth.signOut();
      res = 'success';
    }catch(e){
      res = e.toString();
    }
    return res;
  }
}
