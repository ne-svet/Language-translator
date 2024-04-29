import 'package:language_translator_app/model/myUser.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  static FirebaseAuth auth = FirebaseAuth.instance;

  //подписка на изменение пользователя
  static void initializeAuthStateListener() {
    auth.userChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  //получаем userId
  static Future<String> getUserId() async {
    User? user = auth.currentUser;
    if (user != null) {
      return user.uid;
    } else {
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
