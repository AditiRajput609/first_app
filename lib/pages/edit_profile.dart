import "dart:io";

import "package:firebase_storage/firebase_storage.dart";
//import "package:first_app/pages/NavigoterBar.dart";
import "package:first_app/pages/profile.dart";
import "package:first_app/service/sharedPref.dart";
import "package:first_app/widget/widget_support.dart";
//import "package:flutter/foundation.dart";
import"package:flutter/material.dart";
import "package:image_picker/image_picker.dart";
import "package:random_string/random_string.dart";
class EditProfile extends StatefulWidget{
  const EditProfile ({super.key});
  @override
  State<EditProfile>createState()=>_EditProfileState();
}
class _EditProfileState extends State<EditProfile>
{
   TextEditingController namecontroller=new TextEditingController();
  TextEditingController emailcontroller=new TextEditingController();
 String? profile,name,Email;
  final ImagePicker _picker= ImagePicker();
File? selectedImage;
    Future getImage()async{
      var image=await _picker.pickImage(source:ImageSource.gallery);
      selectedImage=File(image!.path);
         setState(() {
            updateProfile();
         });
    }
 // ignore: strict_top_level_inference
 updateProfile() async {
  if (selectedImage!=null){
 String addId= randomAlphaNumeric(10);
  Reference firebaseStorageRef=
  FirebaseStorage.instance
  .ref()
 // .child("blogImage");
  .child('$addId.jpg');
  final UploadTask task= firebaseStorageRef.putFile(selectedImage!);
  var downloadUrl=await(await task).ref.getDownloadURL();
await SharedPreferenceHelper().saveUserProfile(downloadUrl);
setState(() {
  
});
 
 
}
}
 //Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>BottomNav()));
  getthesharedpref()async{
profile=await SharedPreferenceHelper().getUserProfile();
name=await SharedPreferenceHelper().getUserName();
Email=await SharedPreferenceHelper().getUserEmail();
setState(() {
    namecontroller.text = name ?? "";
   emailcontroller.text = Email ?? "";
      //phonecontroller.text = phone ?? "";
});

  }
  onthisload()async{
    await  getthesharedpref();
  }
   saveChanges() async {
    await SharedPreferenceHelper().saveUserName(namecontroller.text);
    await SharedPreferenceHelper().saveUserEmail(emailcontroller.text);
   // await SharedPreferenceHelper().saveUserPhone(phonecontroller.text);

    // Save ke baad Profile page pe jao
    if (mounted) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Profile()));
    }
  }
   @override
  Widget build(BuildContext context){
return Scaffold(
  body:Container(
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
 child: Column(
  children: [
Container(
  padding: EdgeInsets.all(20),
child:Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
     GestureDetector(
      onTap:(){
   Navigator.push(context,MaterialPageRoute(builder: (context)=>Profile()),);
      },
child:Icon(Icons.arrow_back,size:30,color:Colors.white),),
Text("Edit Profile",style: TextStyle(fontSize: 30,color:Colors.white),)
  ],
)
  ),
  Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
            height: 200,
            width:200,
            decoration: BoxDecoration(
              shape:BoxShape.circle,
              color:Colors.white,
            ),
            child:CircleAvatar(
              radius:5,
              backgroundImage:AssetImage("images/shoping-removebg.png") ,
            )
         ),

    ]),
    Text("change photo",style: TextStyle(fontSize: 30,color:Colors.pinkAccent),),

         Row(
          children: [
Container(
  margin: EdgeInsets.all(20),
  height:500,
  width: 370,
 decoration:  BoxDecoration(
  borderRadius: BorderRadius.circular(20),
  color: Colors.white,
  ),
 child: Column(
    children: [
     Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
    Container(
      margin: EdgeInsets.all(20),
      width:300,
      height: 50,
    //  color: Colors.purple,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),),
     child:  TextFormField(
       controller: namecontroller,
        decoration:InputDecoration(
          hintText:"name",
          hintStyle:AppWidget.SemiBooldTextFeildStyle() 
        ),
     ),
    ),
 ],
 ),
 
  Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
    Container(
      margin: EdgeInsets.all(20),
      width:300,
      height: 50,
      //color: Colors.purple,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),),
       // borderRadius: BorderRadius.circular(20),
     child:  TextFormField(
       controller: emailcontroller,
        decoration:InputDecoration(
        //   controller: namecontroller,
          hintText:"@gmail.com",
          hintStyle:AppWidget.SemiBooldTextFeildStyle() 
        ),
     )
    )
    ]
 ),
  Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
    Container(
      margin: EdgeInsets.all(20),
      width:300,
      height: 50,
     // color: Colors.purple,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),),
       // borderRadius: BorderRadius.circular(20),
     child:  TextFormField(
        decoration:InputDecoration(
          hintText:"phone",
          hintStyle:AppWidget.SemiBooldTextFeildStyle() 
        ),
     )
    )
    ]
  ),
     Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
    Container(
      margin: EdgeInsets.all(20),
      width:300,
      height: 50,
     // color: Colors.purple,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),),
       // borderRadius: BorderRadius.circular(20),
     child:  TextFormField(
        decoration:InputDecoration(
          hintText:"female",
          hintStyle:AppWidget.SemiBooldTextFeildStyle() 
        ),
)
          
)
          
          ]),
        
        Container(
          width: 350,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(20),
          ),
      child: GestureDetector(
          onTap:
          //(){
          saveChanges,
//Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Profile()));
          //},
       
        child: Center(
          child:Text("save change",style: TextStyle(fontSize: 30,color:Colors.white),
          ),
          ),
          ),
          ),
        
            ]
          )
  
  )
          ]
         )
  ]
 )
  )
 
); 
}
}
//ammmm@gmail.com,
