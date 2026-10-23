import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/pages/NavigoterBar.dart';
import 'package:first_app/pages/forgetPassword.dart';
import 'package:first_app/pages/home.dart';
import 'package:first_app/pages/signup.dart';
import 'package:first_app/service/sharedPref.dart';
import 'package:first_app/widget/widget_support.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
class Login extends StatefulWidget
{
   const Login ({super.key});
   @override
   State<Login>createState()=>_LoginState();
}
class _LoginState extends State<Login>{
  final _formKey=GlobalKey<FormState>();
  String email="",password="";
  TextEditingController useremailController=new TextEditingController();
  TextEditingController userpasswordController=new TextEditingController();
  userLogin()async{
    try{
       UserCredential userCredential=
       await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.trim(), 
      password: password.trim());
     // String Id=randomAlphaNumeric(10);
       /* var currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser!= null) {
        // Naam = displayName nahi hai to email se naam bana lo
        String finalName = currentUser.displayName?? useremailController.text.split('@')[0];
        await SharedPreferenceHelper().saveUserName(finalName);
          await SharedPreferenceHelper().saveUserEmail(useremailController.text);
      }*/
       var snapshot = await FirebaseFirestore.instance
       .collection("user")
       .where("Email", isEqualTo: useremailController.text.trim())
       .get();

    if (snapshot.docs.isNotEmpty) {
      String oldId = snapshot.docs[0].id; // Wahi CtIw... wali ID mil gayi
      String oldName = snapshot.docs[0].data()["Name"];

      await SharedPreferenceHelper().saveUserId(oldId); // SABSE JARURI LINE
      await SharedPreferenceHelper().saveUserName(oldName);
      await SharedPreferenceHelper().saveUserEmail(useremailController.text.trim());
      await SharedPreferenceHelper().saveUserWallet(snapshot.docs[0].data()["Wellet"].toString());
    }
        if (mounted) {
Navigator.pushReplacement(context,MaterialPageRoute(builder:(context)=>BottomNav ()));
    }
    }
    on FirebaseAuthException catch(e){
      if(e.code=="user-not-found"){
       // print("FIREBSE ERROR CODE:${e.code}");
        // print("FIREBSE ERROR MSG:${e.message}");
        ScaffoldMessenger.of(context).showSnackBar(
SnackBar(
  content:Text("no user found that email",
  ),
),
        );
      }
      else if (e.code=="wrong-passsword"){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
backgroundColor:Colors.pink,
content:Text("wrong password",
style: TextStyle(
  color:Colors.red,
  fontSize: 30),
),
        ),
      );
    }
  }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
body:Stack(
  children: [
    Container(
    //  margin:EdgeInsets.only(bottom: 60,) ,
width: double.infinity,
height: double.infinity,
  decoration: BoxDecoration(
    gradient:LinearGradient(
      begin:Alignment.topRight,
      end:Alignment.bottomRight,
      colors:[
      Colors.purple,
      Colors.white,
      Colors.redAccent,
    ],
      ),
  ),
  ),
  Padding(
   padding:EdgeInsets.only(top:40),
 child: Row(
   //  padding:EdgeInsets.only(top:40),
    mainAxisAlignment: MainAxisAlignment.center,
   //
    children: [
Text("Welcome Back",
style: TextStyle(
  fontSize: 50,
  color: Colors.white,
  fontWeight: FontWeight.bold,
),
),
    ],
 ),
    ),
     Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
    Center(
      child:Container(
height: 450,
width: 300,
decoration: BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(10),
),
child:Form(
  key:_formKey,
child:Column(
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
Text("Login",
style: TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.bold,
),
),
SizedBox(height: 30.0,),
TextFormField( 
   controller: useremailController,
      validator: (value){
        if(value==null|| value.isEmpty){
return'please enter EMAIL';
        }
        return null;
      },

  decoration: InputDecoration(
    hintText:"@gmail.com",
    hintStyle:AppWidget.SemiBooldTextFeildStyle() ,
    prefixIcon: Icon(Icons.email),
  ),
),
TextFormField(
  controller: userpasswordController,
      validator: (value){
        if(value==null|| value.isEmpty){
return'please enter password';
        }
        return null;
      },
  decoration: InputDecoration(
    hintText:"password",
    hintStyle: AppWidget.SemiBooldTextFeildStyle(),
    prefixIcon: Icon( Icons.password),
  ),
),
SizedBox(height: 30.0,),
GestureDetector(
        onTap:(){
         // Navigator.push(context,MaterialPageRoute(builder: (context)=>Forgotpassword()));
          Navigator.push(context,MaterialPageRoute(builder:(context)=>Forgetpassword()));
        },
child:Container(
   alignment: Alignment.topRight,
child:Text("forget Password",
style: TextStyle(
  color: Colors.black,
  fontSize: 20,
),
),
),
),
SizedBox(height:40.0),//RishavSingh@gmail.com,334455
GestureDetector(
  onTap:(){
 if(_formKey.currentState!.validate()){
   //userLogin();
 setState((){
  email=useremailController.text;
  password=userpasswordController.text;
});
  userLogin();
 }
  },

child:Container(
  height: 40,
  width:double.infinity ,
  margin: EdgeInsets.all(30),
  decoration: BoxDecoration(
    color: Colors.deepPurple,
    borderRadius: BorderRadius.circular(10),
  ),
 child: Center(
  child:Text("Login ",
  style:TextStyle(
    fontSize: 20,
    color: Colors.white,
  )
  ),
  ),
),
),
],
//),
  //],
),
),
      ),
    ),
      ],
     ),
 //SizedBox(width:30.0,),
 GestureDetector(
  onTap: (){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
  },
 child:
Padding(
  padding: EdgeInsets.only(top:750,),
      child:Row(
      //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
     crossAxisAlignment:  CrossAxisAlignment.end,
     children: [
         Text(
        "\n   Don't have an account?\n              sign Up",
        style: AppWidget.lightTextfieldStyle(),
           ),
        ],
      ),
 //), 
   // ),
   ),
 ),
  ],
),
    );
  }
}
