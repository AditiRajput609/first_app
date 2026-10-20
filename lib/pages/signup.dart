//import "dart:nativewrappers/_internal/vm/lib/internal_patch.dart";

import "package:firebase_auth/firebase_auth.dart";
import "package:first_app/pages/NavigoterBar.dart";
import "package:first_app/pages/home.dart";
import "package:first_app/pages/login.dart";
import "package:first_app/service/database.dart";
import "package:first_app/service/sharedPref.dart";
import "package:first_app/widget/widget_support.dart";
import"package:flutter/material.dart";
import "package:random_string/random_string.dart";
class SignUp extends StatefulWidget{
  const SignUp({super.key});
  @override
  State <SignUp>createState()=> _SignUpState();
}

class _SignUpState extends State<SignUp>{
  String name="",email="",password="";
  TextEditingController namecontroller=new TextEditingController();
  TextEditingController emailcontroller=new TextEditingController();
  TextEditingController passwordController=new TextEditingController();
  final _formkey=GlobalKey<FormState>();
  registration()async{
    if(password!=null){
      try{
        UserCredential userCredential=//ese fire base me ek user colltion bnanayega jisa me cart save hoga 
         await FirebaseAuth.instance.createUserWithEmailAndPassword(email:email,password:password);
        ScaffoldMessenger.of(context).showSnackBar((SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            "registerred successfull",
            style:TextStyle(fontSize:20.0),
          ))));
           String Id=randomAlphaNumeric(10);
            Map<String,dynamic>addUserInfo={
        "Name":namecontroller.text,
        "Email":emailcontroller.text,
        "Wellet":"0",
        //"id":Id,
      };
       await DatebaseMethods().addUserDetail(addUserInfo,Id);
         await SharedPreferenceHelper().saveUserName(namecontroller.text);
          await SharedPreferenceHelper().saveUserEmail(emailcontroller.text);
           await SharedPreferenceHelper().saveUserWellet('0');
            await SharedPreferenceHelper().saveUserId(Id);

          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>BottomNav()));
    }on FirebaseException catch(e){
      if(e.code=="weak-password"){
         ScaffoldMessenger.of(context).showSnackBar((SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            "password provided is too weak",
            style:TextStyle(fontSize:20.0),
            ))));
      }
      else if(e.code=="email-already-in-use"){
         ScaffoldMessenger.of(context).showSnackBar((SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            "Account Already exis",
            style:TextStyle(fontSize:18.0),
            ))));
      }
    } 

  }
}
@override
Widget build(BuildContext context ){
  return Scaffold(
body:Stack(
  children: [
  Container(
  decoration: BoxDecoration(
   //  begin: Alignment.topRight,
  //end:Alignment.bottomRight,
    gradient: LinearGradient(
       begin: Alignment.topRight,
  end:Alignment.bottomRight,
    colors:[Colors.purpleAccent,Colors.white,
    Colors.pink,
    ],
    ),
  ), 
  ),
  Row(
    mainAxisAlignment:MainAxisAlignment.center,
    children: [
      Padding(padding:EdgeInsets.only(top:30),
      //SizedBox(height: 30,),
      // margin:EdgeInsets.only(top:10),
 child:Text(
"Create Account",
style: TextStyle(
  fontSize: 50,
  fontWeight:FontWeight.bold,
),
),
      ),
    ],
  ),
  SizedBox(height:40.0,),
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Padding(
      padding:EdgeInsets.only(top:110,),
 child: Text("Welcome",
style:TextStyle(
  fontSize: 50,
  fontWeight: FontWeight.bold,
  color:Colors.white60,
),
  ),
    ),
  ],
),

  SizedBox(height: 10.0,),
Center(
child: Container(
width:300,
height:500,
decoration: BoxDecoration(
color:Colors.white,
borderRadius: BorderRadius.circular(10),
),
child:Form(
  key:_formkey,
child:Column(
  children: [
    Text("Sign up",
style:TextStyle(
color:Colors.black,
fontSize: 20,
fontWeight: FontWeight.bold,//aditiRajput2233,aditirajput
),
),
SizedBox(height:20.0,),
TextFormField(
  controller: namecontroller,
  validator: (value){
    if(value==null||value.isEmpty){
      return'please enter name';
    }
    return null;
},
decoration: InputDecoration(
        hintText: "Name",
        hintStyle: AppWidget.SemiBooldTextFeildStyle(),
        prefixIcon: Icon(Icons.person_outlined),
        ),
),
SizedBox(height: 20.0,),
TextFormField(
  controller: emailcontroller,
      validator: (value){
        if(value==null|| value.isEmpty){
return'please enter E-mail';
        }
        return null;
      },
 decoration: InputDecoration(
  hintText:"@gmail.com",
  hintStyle:AppWidget.SemiBooldTextFeildStyle(),
  prefixIcon:Icon(Icons.email_outlined),
),
),
SizedBox(height: 20.0,),
TextFormField(
  controller:  passwordController,
      validator: (value){
        if(value==null|| value.isEmpty){
return'please enter password';
        }
        return null;
      },
decoration: InputDecoration(
  hintText:"password",
  hintStyle:AppWidget.SemiBooldTextFeildStyle(),
  prefixIcon:Icon(Icons.password_outlined),
),
),
SizedBox(height: 20.0,),
GestureDetector(
  onTap:()async{
if(_formkey.currentState!.validate()){
setState(() {
  email=emailcontroller.text;
  name=namecontroller.text;
  password=passwordController.text;
});
          }
          registration();
        },
child:Container(
  height:50,
  width: double.infinity,
  margin: EdgeInsets.all(40),
  decoration: BoxDecoration(
    color:Colors.blue,
    borderRadius: BorderRadius.circular(20),
  ),
  child:Center(
child:Text("sing Up",
style: AppWidget.lightTextfieldStyle(),
),
  ),
),
),
  ],
),
),
  ),
),
GestureDetector(
  onTap:(){
Navigator.push(context,MaterialPageRoute(builder:(context)=>Login()));
  },
   child: Padding(
      padding: EdgeInsets.only(top:750,),
      child:Center(
    child:Text(
      " Already have an account ?\n                 login",
      style: TextStyle(
        fontSize: 30,
        color:Colors.white,
      ),
  ),
      ),
),
),
   // ),
    //],
//),
  ],
  ),
  );
}
}
