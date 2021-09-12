part of 'shared.dart';

void saveUser(String responseBodyUser) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString('user', responseBodyUser);
}

void removeUser() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.remove('user');
}

Future<String> getUser() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('user') ?? null;
}
