import "package:shared_preferences/shared_preferences.dart";

class SharedPreferenceHelper {
  static String userIdKey="USERKEY";
  static String userNameKey="USERNameKEY";
  static String userEmailKey="USEREmailKEY";
  static String userWelletKey="USERWELLETKEY";
  //static
   static String userProfileKey="USERPROFILEKEY";
    static String usereditprofileKey="USEREDITPROFILEKEY";

  Future<bool>saveUserId(String getUserId)async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.setString(userIdKey,getUserId);
  }
Future<bool>saveUserName(String getUserName)async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.setString(userNameKey,getUserName);
  }
  Future<bool>saveUserEmail(String getUserEmail)async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.setString(userEmailKey,getUserEmail);
  }
  /*Future<bool>saveUsereditprofile(String getUsereditprofile )async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.setString(usereditprofileKey,getUsereditprofile  );
  }*/
 Future<bool>saveUserWellet(String getUserWellet)async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.setString(userWelletKey,getUserWellet);
  }
  Future<bool>saveUserProfile(String getUserProfile)async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.setString(userProfileKey,getUserProfile);
  }
  Future<String?>getUserId()async{
  SharedPreferences prefs=await SharedPreferences.getInstance();
  return prefs.getString(userIdKey);

  }
   Future<String?>getUserName()async{
  SharedPreferences prefs=await SharedPreferences.getInstance();
  return prefs.getString(userNameKey);

  }
   Future<String?>getUserEmail()async{
  SharedPreferences prefs=await SharedPreferences.getInstance();
  return prefs.getString(userEmailKey);

  }
   Future<String?>getUserWellet()async{
  SharedPreferences prefs=await SharedPreferences.getInstance();
  return prefs.getString(userWelletKey);

  }
  Future<String?>getUserProfile()async{
  SharedPreferences prefs=await SharedPreferences.getInstance();
  return prefs.getString(userProfileKey);

  }
   Future<String?>getUsereditprofile ()async{
  SharedPreferences prefs=await SharedPreferences.getInstance();
  return prefs.getString(usereditprofileKey);
}
//saveUserName(String name) => prefs.setString("userNameKey", name);
//saveUserEmail(String email) => prefs.setString("userEmailKey", email);
Future<void> clear() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}
}