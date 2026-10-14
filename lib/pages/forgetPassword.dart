//import 'package:first_app/widget/widget_support.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/pages/login.dart';
import 'package:first_app/pages/signup.dart';
import 'package:first_app/widget/widget_support.dart';
import 'package:flutter/material.dart';
class Forgetpassword extends StatefulWidget
{
   const Forgetpassword({super.key});
   @override
   State<Forgetpassword>createState()=>_ForgetpasswordState();
}
class _ForgetpasswordState extends State<Forgetpassword>{

String email="";
final _formKey=GlobalKey<FormState>();
TextEditingController mailController=new TextEditingController();
resrtpassword()async{
  try{
    await FirebaseAuth.instance.sendPasswordResetEmail(email:email);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:Text("password reset email has been sent ",
        style: TextStyle(
          fontSize:30,
          color:Colors.blue,
        ),
        ),

      ));

  }
  on FirebaseAuthException catch(e){
    if(e.code=="user-not-found"){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content:Text("no use found for that email",
        style: TextStyle(
        fontSize:20,
        color:Colors.red,  
        ),)));
    }
  }
}
  @override
  Widget build(BuildContext context){
    return Scaffold(
body:Stack(
// mainAxisAlignment:MainAxisAlignment.center,
  children: [
Container(
 // children:[
  width:double.infinity,
  height:double.infinity,
  decoration: BoxDecoration(
   gradient:  LinearGradient(
    begin: Alignment.topRight,
  end:Alignment.bottomRight,
    colors:[
      Colors.red,
      Colors.purple,
    ],
    ),
  ),
),
Padding(
padding: EdgeInsets.only(top:60,),
 child: Row(
    mainAxisAlignment:MainAxisAlignment.center,
   crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
       height: 150,
        width:150,
decoration: BoxDecoration(
color:Colors.deepPurple,
shape:BoxShape.circle,
),
child:Icon(Icons.lock_reset,
color:Colors.white,
//fontWeight: FontWeight.bold,
size: 100,
  ),

      ),
          ],
 ),
  ),
  Padding(
    padding:EdgeInsets.only(top:245,left:30,right:30),
 child: Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
       Text("Forgot Password",
       style:TextStyle(
        color:Colors.white,
        fontSize: 45,
        fontWeight: FontWeight.bold,
       )
       ),
  ],
      ),
  ),
  Padding(
    padding: EdgeInsets.only(top:330,left:30,right: 20,),
    child:Row(
      mainAxisAlignment: MainAxisAlignment.center,
          children: [
        Text(" Enter your email and we'll\n           send a reset link",
        style:TextStyle(
          fontSize: 30,
          color:Colors.white
        ),
       ),
      ],
    ),
       ),
       Expanded(
      child: Form(
        key:_formKey,
    child:  Padding(
        padding: EdgeInsets.only(top:440,left:20,right:20),
      child: Container(
        height: 80,
        width:400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue,
          border: Border.all(color: Colors.white,),
        ),
      child:  TextFormField(
        controller:mailController,
        style:TextStyle(color:Colors.white,fontSize: 30,),
        validator: (value){
          if(value==null||value.isEmpty){
          return"please enter email";
}
     return null;
  },
  //style:TextStyle(color:Colors.white,),
        decoration: InputDecoration(
          hintText:"@gmail",
          hintStyle:AppWidget.lightTextfieldStyle(),
          prefixIcon:Icon(Icons.email_outlined,color:Colors.white,size:20),
          errorStyle: TextStyle(color:Colors.white,fontSize:20),
        ),
       ),
      ),
       ),
      ),
       ),
       //SizedBox(height: 20,),
       GestureDetector(
        onTap:(){
          if(_formKey.currentState!.validate()){
            setState((){
              email=mailController.text;
            });
resrtpassword();
          }
        },
       child: Align(
 alignment:Alignment.centerRight,
    child:Padding(
    // alignment:Alignment.centerLeft,
        padding: EdgeInsets.only(top:250,left:30,),
       child:Container(
        height:50,
        width:300,
        decoration: BoxDecoration(
          border: Border.all(color:Colors.white),
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [
Colors.pinkAccent,
Colors.blue,
          ],
          ),
        ),
     child:   Center(
         child: Text("Send Reset Link",
         style:AppWidget.lightTextfieldStyle(),
         ),
     ),
       ),
       ),
       ),
       ),
       Padding(
        padding:EdgeInsets.only(top:650,),
    child: Text("Don't have an account?",style:TextStyle(fontSize:25.0,color:Colors.white,
     ),
     ),
       ),
       GestureDetector(
        onTap:(){
          Navigator.push(context,MaterialPageRoute(builder:(context)=>SignUp()));
        },
      child: Align(
        alignment: Alignment.centerRight,
       child: Padding(
        padding:EdgeInsets.only(top:450,right:30),
      child: Text("create",style:TextStyle(color:Colors.green,fontSize:40,))))),
       GestureDetector(
        onTap:(){
Navigator.push(context,MaterialPageRoute(builder:(context)=>Login()));
        },

      child: Padding(
        padding:EdgeInsets.only(top:750,left:30,right: 30),
        child:Row(
          children: [
            Icon(Icons.arrow_back,
            color:Colors.white,
            size:30,
            ),
       Text(" Back to Login",
        style: TextStyle(
          fontSize: 30,
          color: Colors.white,
        )
        //Icon(Icons.arrow_circle_down_outlined),
        ),
          ],
        ),
        ),
       ),

  ],
),
    );
  }
}
/*import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
 // TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE53935), Color(0xFF8E24AA), Color(0xFF7B1FA2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 1. BLUE CIRCLE
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: Color(0xFF2962FF),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.lock_reset,
                  color: Colors.white,
                  size: 70,
                ),
              ),
              SizedBox(height: 30),

              // 2. TITLE
              Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 12),

              // 3. SUBTITLE
              Text(
                "Enter your email and we'll\nsend a reset link",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.9),
                  height: 1.4,
                ),
              ),
              SizedBox(height: 40),

              // 4. EMAIL FIELD - ab sahi dikhega
              TextField(
                //controller: emailController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "@gmail",
                  hintStyle: TextStyle(color: Colors.white70),
                  prefixIcon: Icon(Icons.email_outlined, color: Colors.white),
                 // filled: true,
                  fillColor: Colors.lightBlueAccent.withOpacity(0.9),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 40),

              // 5. BUTTON
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.white, width: 2)
                    ),
                  ),
                  child: Text(
                    "Send Reset Link",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25),

              // 6. BACK TO LOGIN
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Text(
                  "Back to Login",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/