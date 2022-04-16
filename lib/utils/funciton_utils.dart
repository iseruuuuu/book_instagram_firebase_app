import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share/share.dart';

class FunctionUtils {
  static Future<dynamic> getImageFromGallery() async {
    ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    return pickedFile;
  }

  static Future<dynamic> getImageFromCamera() async {
    ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    return pickedFile;
  }

  static Future<String> uploadImage(String uid, File image) async {
    final FirebaseStorage storageInstance = FirebaseStorage.instance;
    final Reference reference = storageInstance.ref();
    await reference.child(uid).putFile(image);
    String downloadUrl = await storageInstance.ref(uid).getDownloadURL();
    return downloadUrl;
  }

  static Future<dynamic> share(String contents) async {
    final share = Share.share(contents);
    return share;
  }
}
