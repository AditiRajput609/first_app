import "package:firebase_auth/firebase_auth.dart";
import "package:first_app/pages/NavigoterBar.dart";
import "package:first_app/pages/details.dart";
import "package:first_app/pages/order.dart";
import "package:first_app/service/database.dart";
import "package:first_app/service/sharedPref.dart";
import"package:flutter/material.dart";
class ReviewOrder extends StatefulWidget{
  String Name,price,image;
    ReviewOrder({super.key, required this. Name,required this .price,required this .image});
//const  ReviewOrder({super.key});
@override
 State<ReviewOrder>createState()=>_ReviewOrderState();
}
class _ReviewOrderState extends State<ReviewOrder>{
   String? id;
 getthesharedpref()async{
    id=await SharedPreferenceHelper().getUserId();
    setState(() {
      
    });
  }
 // get productId => null;
 ontheload()async{
    await getthesharedpref();
    setState(() {
      
    });
  }
  @override
  void initState(){
    super.initState();
    ontheload();
    //total=int.parse(widget.price);

  }
@override
Widget build(BuildContext context){
 return Scaffold(
   body:Container(
 height: double.infinity,
 width:double.infinity,
 decoration: BoxDecoration(
  gradient: LinearGradient(
    
    colors:[
      Colors.white,
Colors.pinkAccent,
 Colors.purpleAccent
//Colors.pink,
    ],
begin:Alignment.topRight,
end:Alignment.bottomLeft,
),
 ),
 child: Column(
  children: [
Container(
 height: 100,
  width:410,
decoration: BoxDecoration(
  gradient: LinearGradient(
    colors:[
       Colors.pinkAccent,
      //  Colors.pinkAccent,
       Colors.purpleAccent,
       Colors.purpleAccent,
      // Colors.pinkAccent,
       ],
       begin: Alignment.topRight,
       end:Alignment.bottomLeft,
       ),
       borderRadius: BorderRadius.circular(40),
),
  padding: EdgeInsets.all(20),
child:Row(
 // mainAxisAlignment: MainAxisAlignment.start,
 //crossAxisAlignment: CrossAxisAlignment.start,
 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
     GestureDetector(
      onTap:(){
   Navigator.pop(context);//,MaterialPageRoute(builder: (context)=>details()),);
      },
       child: Icon(Icons.arrow_back_ios_new_outlined,color:Colors.white),
            ),
            Text("view order details",style:TextStyle(fontSize: 30,color: Colors.white),),
  ]
 )
),
SizedBox(height: 30,),
Container(
height: 150,
width:400,
decoration: BoxDecoration(
  color:Colors.white,
  borderRadius: BorderRadius.circular(20),
),
child:Row(
  children: [
//Image.asset("images/women_dress.avif"
 Image.network(widget.image,
height: 150,width:170,fit:BoxFit.cover,),
 Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
Text(widget.Name,
       style:TextStyle(fontSize: 30,color: Colors.black),
      // "loerm ipsum is "
      ),
Text(widget.price ,style:TextStyle(fontSize: 30,color: Colors.black)
 )
              ]
 )
  ]
)
  
   ),
   Padding(padding: EdgeInsets.only(top:500),
   //SizedBox(height: 100,),
  child: Container(
height: 100,
width:400,
decoration: BoxDecoration(color: Colors.white),
child:Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Column(
      children: [
    Text("view price details",style:TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold)),
  Text(widget.price ,style:TextStyle(fontSize: 30,color: Colors.black)
 ),
 ]),
   // Container()
    GestureDetector(
        onTap: ()async{
         // String id
         // =FirebaseAuth.instance.currentUser!.uid;
          Map<String,dynamic>addOrder={
            "Name":widget.Name,
           // "Quantity":a.toString(),
        //   "Total":total.toString(),
           "Image":widget.image,
           "price":widget.price,
          };
          //await  DatebaseMethods().addOrder(addOrder, id!);
           await  DatebaseMethods().addOrder(addOrder, id!);
           // ignore: use_build_context_synchronously
           ScaffoldMessenger.of(context).showSnackBar((SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            "order conform",
            style:TextStyle(fontSize:20.0),
            ))));
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>BottomNav ()));
        },
   child: Container(
        width:MediaQuery.of(context).size.width/2,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(color:Colors.pink,borderRadius: BorderRadius.circular(20),),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
Text("Continue",style:TextStyle(color:Colors.white,fontSize:20.0,fontFamily: "poopins",fontWeight: FontWeight.bold),
),
        
        ],),
      ),
     )
  ],
)
   )
   )
  ]
 )
   )
 );
}
}