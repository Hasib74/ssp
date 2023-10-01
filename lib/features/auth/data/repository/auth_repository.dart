import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthRepository {
  Future<bool?> isSignIn();
  signIn();
}

class AuthRepositoryImpl extends AuthRepository {
  @override
  isSignIn() async {
    bool? isSignIn = await SharedPreferences.getInstance()
        .then((value) => value.getBool("isSignIn"));
    return isSignIn;
  }

  @override
  signIn() async {
    // TODO: implement signIn

    await SharedPreferences.getInstance()
        .then((value) => value.setBool("isSignIn", true));
  }
}
