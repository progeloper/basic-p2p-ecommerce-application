import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImgToStorage(String childName, Uint8List image)async{
    Reference ref = _storage.ref().child(childName).child(_auth.currentUser!.uid);
    String postId = const Uuid().v1();
    ref = ref.child(postId);
    UploadTask uploadTask = ref.putData(image);
    TaskSnapshot snapshot = await uploadTask;
    String photoUrl = await snapshot.ref.getDownloadURL();
    return photoUrl;
  }
}