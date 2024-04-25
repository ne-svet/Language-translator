import 'package:language_translator_app/model/myUser.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  static FirebaseAuth auth = FirebaseAuth.instance;

  //получаем userId
  static Future<String> getUserId() async {
    User? user = auth.currentUser;
    if(user != null) {
      return user.uid;
    }
    else {
      throw Exception('User is not authenticated');
    }
  }

  //анонимная аутентификация пользователя
  static Future<MyUser> anonymousLogin() async {
  UserCredential credentials = await auth.signInAnonymously();
  MyUser user = MyUser();
  user.userId = credentials.user!.uid;
  return user;
  }



}
