import "dart:io";

import "package:firebase_storage/firebase_storage.dart";
import "package:first_app/pages/NavigoterBar.dart";
import "package:first_app/pages/edit_profile.dart";
//import "package:first_app/pages/logIn%20.dart";
import "package:first_app/pages/login.dart";
import "package:first_app/pages/signup.dart";
import "package:first_app/pages/wishList.dart";
import "package:first_app/service/Auth.dart";
import "package:first_app/service/sharedPref.dart";
import "package:first_app/widget/widget_support.dart";
import"package:flutter/material.dart";
import "package:image_picker/image_picker.dart";
class Profile extends StatefulWidget{
  const Profile({super.key});
  @override
  State<Profile>createState()=>_ProfileState();
}
class _ProfileState extends State<Profile>{
  String? profile,name,Email;
  final ImagePicker _picker= ImagePicker();
File? selectedImage;
    Future getImage()async{
      var image=await _picker.pickImage(source:ImageSource.gallery);
      selectedImage=File(image!.path);
         setState(() {
           uploadItem();
         });
    }
uploadItem()async{
  if (selectedImage!=null){
 // String addId= randomAlphaNumeric(10);
  Reference firebaseStorageRef=
  FirebaseStorage.instance
  .ref()
  .child("blogImage");
  //.child('$addId.jpg');
  final UploadTask task= firebaseStorageRef.putFile(selectedImage!);
  var downloadUrl=await(await task).ref.getDownloadURL();
await SharedPreferenceHelper().saveUserProfile(downloadUrl);
setState(() {
  
});
 
 
}
}
  getthesharedpref()async{
profile=await SharedPreferenceHelper().getUserProfile();
name=await SharedPreferenceHelper().getUserName();
Email=await SharedPreferenceHelper().getUserEmail();
setState(() {
  
});

  }
  onthisload()async{
    await  getthesharedpref();
    setState(() {
      
    });
  }

  @override
  void initState(){
    onthisload();
    super.initState();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
    body:Container(
      height:double.infinity,
      width:double.infinity,
      decoration: BoxDecoration(
        color: Colors.purple
       /*gradient: LinearGradient(
          colors:[
        Colors.purple,
      Colors.white,
      Colors.redAccent,
    ],
  begin: Alignment.topRight,
    end:Alignment.bottomRight,
    )*/
    ),
      child: SingleChildScrollView(
        child:Stack(
          children: [
          Column(
        // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.only(left:10),
              child:   GestureDetector(
      onTap:(){
   Navigator.push(context,MaterialPageRoute(builder: (context)=>BottomNav()),);
      },
child:Icon(Icons.arrow_back,size:30,color:Colors.white),),),
            Center(
         child: Text("Profile",style:AppWidget.boldTextfieldStyle()),
          ),
         // Icon(Icons.settings,color:Colors.white)
          ],
          ),

        name==null?CircularProgressIndicator():   Column(
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
         Text( name!,
          //"AditiRajput",
         style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color:Colors.white
          ),),
         Text( Email!,
          //"@aditiRajput44gmail.comm",
         style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color:Colors.white
          ),)
            ]
          ),
          GestureDetector(
            onTap:(){
        Navigator.push(context,MaterialPageRoute(builder: (context)=> EditProfile())).then((value){
getthesharedpref();
        });
            },
        child: Padding(padding: EdgeInsets.only(top:10),
       child:   ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child:SizedBox(
              width:100,
              height:50,
              child:ColoredBox( color:Colors.purple,
             child: Row(
              children: [
             //ColoredBox( color:Colors.purple,
            Icon(Icons.edit,color:Colors.white),
          Text("Edit profile",style: TextStyle(color:Colors.white),),

             ]
             ),
            ),
          ),
          ),
          ),
          ),
          Row(
            children: [
              Padding(padding: EdgeInsets.only(left:10,bottom: 30,right:5),
         child: Container(
       height:70,
       width:110,
       decoration: BoxDecoration(color:Colors.pink,borderRadius: BorderRadius.circular(20)),
       child:Row(
        mainAxisAlignment:MainAxisAlignment.center,
       children: [
        Text("Orders",
        style: TextStyle(fontSize: 20,color:Colors.white),),
       Icon(Icons.shopping_bag_outlined,color:Colors.white),
        ],)
         ),
              ),
                 Padding(padding: EdgeInsets.only(left:20,bottom: 30),
                  child:GestureDetector(
      onTap:(){
   Navigator.push(context,MaterialPageRoute(builder: (context)=>Wishlist()));
      },
      // child: Text("WishList",style: TextStyle(fontSize: 15,color:Colors.white),),
         child: Container(
         // Container(
       height:70,
       width:100,
       decoration: BoxDecoration(color:Colors.pink,borderRadius: BorderRadius.circular(20)),
       child:Row(mainAxisAlignment:MainAxisAlignment.center,
       children: [
        Text("WishList",style: TextStyle(fontSize: 15,color:Colors.white),),
        
       Icon(Icons.shopping_bag_outlined,color:Colors.white)],)
          ),
                  )
                 ),
     Padding(padding: EdgeInsets.only(left:20,bottom: 30),
         child: Container(
           // Container(
       height:70,
       width:120,
       decoration: BoxDecoration(color:Colors.pink,borderRadius: BorderRadius.circular(20)),
       child:Row(mainAxisAlignment:MainAxisAlignment.center,children: [
        Text("Coupons",style: TextStyle(fontSize: 20,color:Colors.white),),
       Icon(Icons.shopping_bag_outlined,color:Colors.white)],)
          ),
     ),
            ]),
          Padding(padding: EdgeInsets.only(bottom: 10),
           child: Container(
           // borderRadius: BorderRadius.circular(20),
          height: 200,
          width: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color:Colors.white,
          ),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.start,
        //  crossAxisAlignment: CrossAxisAlignment.start,
          children: [
Text("My shopping",style: TextStyle(fontSize: 30,color:Colors.pink,fontFamily:"poppins",fontWeight: FontWeight.bold),),
Row(
 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
  Icon(Icons.shopping_bag,color:Colors.pink),
  Padding(padding: EdgeInsets.only(left:30,right:40),
child:Text("My orders",style: AppWidget.SemiBooldTextFeildStyle(),),),
Spacer(),
Icon(Icons.arrow_forward),

          ],),
          Row(
 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
          Icon(Icons.arrow_back_rounded,color:Colors.pink),
  Padding(padding: EdgeInsets.only(left:30,right:40),
child:Text("Return&Refunds",style: AppWidget.SemiBooldTextFeildStyle(),),),
Spacer(),
Icon(Icons.arrow_forward),
  ]
          ),
             Row(
 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
          Icon(Icons.home,color:Colors.pink),
  Padding(padding: EdgeInsets.only(left:30,right:40),
child:Text("change Addresses",style: AppWidget.SemiBooldTextFeildStyle(),),),
Spacer(),
Icon(Icons.arrow_forward),
  ]
          ),
        

          ]
        ),
        ),
          ),
          Padding(padding:EdgeInsets.only(bottom: 20),
        child: Container(
          height: 200,
          width: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color:Colors.white,
          ),
         child:  Column(
          mainAxisAlignment: MainAxisAlignment.start,
        //  crossAxisAlignment: CrossAxisAlignment.start,
          children: [
Text("Rewards&Offers",style: TextStyle(fontSize: 30,color:Colors.pink,fontFamily:"poppins",fontWeight: FontWeight.bold),),
Row(
 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
  Icon(Icons.gif_box,color:Colors.pink),
  Padding(padding: EdgeInsets.only(left:30,right:40),
child:Text("Rewards",style: AppWidget.SemiBooldTextFeildStyle(),),),
Spacer(),
Icon(Icons.arrow_forward),

          ],),
          Row(
 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
          Icon(Icons.countertops,color:Colors.pink),
  Padding(padding: EdgeInsets.only(left:30,right:40),
child:Text("Coupons&Deal",style: AppWidget.SemiBooldTextFeildStyle(),),),
Spacer(),
Icon(Icons.arrow_forward),
  ]
          ),
             Row(
 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
          Icon(Icons.cases,color:Colors.pink),
  Padding(padding: EdgeInsets.only(left:30,right:40),
child:Text("cashback&credits",style: AppWidget.SemiBooldTextFeildStyle(),),),
Spacer(),
Icon(Icons.arrow_forward),
  ]
          ),
        

          ]
        ),
        ),
          ),
          Padding(padding: EdgeInsets.only(bottom: 20),
    child:     Container(
          height: 250,
          width: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color:Colors.white,
          ),
            child:  Column(
          mainAxisAlignment: MainAxisAlignment.start,
        //  crossAxisAlignment: CrossAxisAlignment.start,
          children: [
Text("Support& Setting",style: TextStyle(fontSize: 30,color:Colors.pink,fontFamily:"poppins",fontWeight: FontWeight.bold),),
Row(
 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
  Icon(Icons.help_center,color:Colors.pink),
  Padding(padding: EdgeInsets.only(left:30,right:40),
child:Text("Help Center",style: AppWidget.SemiBooldTextFeildStyle(),),),
Spacer(),
Icon(Icons.arrow_forward),

          ],),
          Row(
 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
          Icon(Icons.payment,color:Colors.pink),
  Padding(padding: EdgeInsets.only(left:30,right:40),
child:Text("Payment Methods",style: AppWidget.SemiBooldTextFeildStyle(),),),
Spacer(),
Text("No",style: TextStyle(color:Colors.black,fontSize: 20),),
  ]
          ),
            Row(
 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
          Icon(Icons.notifications_active,color:Colors.pink),
  Padding(padding: EdgeInsets.only(left:30,right:40),
child:Text("Notification",style: AppWidget.SemiBooldTextFeildStyle(),),),
Spacer(),
Text("No",style: TextStyle(color:Colors.black,fontSize: 20),),
  ]
          ),
             Row(
 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
          Icon(Icons.home,color:Colors.pink),
  Padding(padding: EdgeInsets.only(left:30,right:40),
child:Text("invitenFriend",style: AppWidget.SemiBooldTextFeildStyle(),),),
Spacer(),
Icon(Icons.arrow_forward),
  ]
          ),
          ],
            ),
    ),
          ),
            
         GestureDetector(
  onTap: () async {
    await AuthMethods().signOut();
    await SharedPreferenceHelper().clear(); // ya tumhare sare save methods ko "" se save karo
    
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) =>  Login()), // apne Login page ka naam likho
        (route) => false,
      );
    }
  },
            child:Container(
              height: 50,
              width:400,
              decoration: BoxDecoration(
                color:Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              child:Row(
 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
          Icon(Icons.logout,color:Colors.white),
  Padding(padding: EdgeInsets.only(left:60,right:40),
child:Text("LogOut",style: TextStyle(color:Colors.white,fontSize: 30,fontWeight: FontWeight.bold,)),),
Spacer(),
Icon(Icons.logout,color:Colors.white),
  ]
              )
        
          ),
          ),
          ]
        ),
       // ),
         // ),
       // ],
        //),
          ],
        ),
      ),
    ),

    );
  }
}