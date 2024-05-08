import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kodion_projects/Screens/AuthLogin/chat_user/chat_user.dart';

class APIs {
  static FirebaseAuth auth = FirebaseAuth.instance;

  // for access cloud fireStore database
  static FirebaseFirestore fireStore = FirebaseFirestore.instance;

  static User get user => auth.currentUser!;

  // user exist or not in flutter
  static Future<bool> userExist() async {
    return (await fireStore.collection('client').doc(user.uid).get()).exists;
  }

  //for create a new user
  static Future<void> createUser() async {
    final time = DateTime.now().microsecondsSinceEpoch.toString();
    final chatUser = ClientData(
        image: user.photoURL.toString(),
        lastActive: time,
        name: user.displayName.toString(),
        id: user.uid,
        message: 'Hey i"m using We Chat',
        isActive: false,
        email: user.email.toString(),
        pushToken: '');
    print(chatUser.email);
    return await fireStore
        .collection('client')
        .doc(user.uid)
        .set(chatUser.toJson());
  }

  //get all users
}
