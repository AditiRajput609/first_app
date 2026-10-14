import "dart:async";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:first_app/pages/NavigoterBar.dart";
import "package:first_app/service/database.dart";
import "package:first_app/service/sharedPref.dart";
import"package:flutter/material.dart";
class ShoppingCart extends StatefulWidget{
const  ShoppingCart({super.key});
@override
 State<ShoppingCart>createState()=>_ShoppingCartState();
}
class _ShoppingCartState extends State<ShoppingCart>{
  //Stream?categoris;
   String? id,wellet;
  int total=0;
  void startTimer(){
    Timer(Duration(seconds: 5),(){
      setState((){
        
      });
     });
  }
  getthesharedpref()async{
    id=await SharedPreferenceHelper().getUserId();
    wellet=await SharedPreferenceHelper().getUserWellet();
  setState(() {
    
  });

  }
  ontheload()async{
    await getthesharedpref();
    productStream=await DatebaseMethods().getproductcart(id!);
    setState(() {
      
    });
    }
  @override
  void initState(){
    ontheload();
    startTimer();
    super.initState();
  }
  Stream?  productStream;
  Widget orderitem(){
    return StreamBuilder(
  stream:productStream,builder:(context,AsyncSnapshot snapshot){
    if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
    return snapshot.hasData?
   // GridView.builder(
   ListView.builder(
    padding: EdgeInsets.zero,
      shrinkWrap: true,
       scrollDirection: Axis.vertical,
      //physics: NeverScrollableScrollPhysics(),
      //gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2 ,
     // mainAxisExtent: 250,
     // crossAxisSpacing: 12,
     // mainAxisSpacing: 12),
      itemCount: snapshot.data!.docs.length,
      itemBuilder: (context, index) {
        DocumentSnapshot data=snapshot.data!.docs[index];
total=total+int.parse(data["Total"]);
       // var data = snapshot.data!.docs[index].data();
       //if(isFav.length!=snapshot.data!.docs.length){
       // isFav=List.generate(snapshot.data!.docs.length,(index)=>false);
       //}
        return   Container(
          decoration: BoxDecoration(
            color:Colors.white,
             borderRadius: BorderRadius.circular(20),
          ),

     child: Container(
         padding: EdgeInsets.all(5),
          margin: EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child:Stack(
            children: [
           Row(
            mainAxisSize: MainAxisSize.min,
            children: [
    Container(
  height: 80,
  width: 50,
  decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(10)),
  child:Center(
  child:Text(data["Quantity"],style:TextStyle(fontSize: 30,color: Colors.black),),
),
),
              ClipRRect(
         borderRadius: BorderRadius.circular(10),
            child: Image.network(data['Image'], height:150,width:200,fit:BoxFit.contain,filterQuality: FilterQuality.high,)),
           // child:CachedNetworkImage(imageUrl:data['Image'], height:150,width:150,fit:BoxFit.contain,)),
             Text(data['Name'], maxLines: 1,overflow:TextOverflow.ellipsis,style:TextStyle(color:Colors.black,fontSize:19,fontWeight: FontWeight.bold,)),
          //   Text("\$"+data["price"],style:TextStyle(color:Colors.black,fontSize:20,fontWeight: FontWeight.bold),
           //  ),
            ]
            ),
              Positioned(
                top:8,
                right:8,
               
child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
         shape: BoxShape.circle,
         color:Colors.white,),
   
                )
              )
              //),
            ],
          ),
     )
      // )
    );
      },
   // )
    )
      : CircularProgressIndicator();
    
  });
//);
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

   child:   SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top:20),
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
child:Row(
  mainAxisAlignment: MainAxisAlignment.start,
  children: [
     GestureDetector(
      onTap:(){
   Navigator.push(context,MaterialPageRoute(builder: (context)=>BottomNav()),);
      },
     
child:Icon(Icons.arrow_back,color:Colors.white,size: 40,),),
Text("cart")
          //),
  ]
        ),
      
      ),
       SizedBox(height:20.0),
      Container(
        height:MediaQuery.of(context).size.height/2,
        //color:Colors.green,
        child:orderitem()
      ),
      Container(
        padding: EdgeInsets.only(top:300),
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.end,
          children: [
   // Spacer(),
    //  Divider(),
      Padding(padding: const EdgeInsets.only(left:10.0,right: 10.0,),
      child: Row(
        mainAxisAlignment  : MainAxisAlignment.spaceBetween,
        children:[
      Text("total price",   style:TextStyle(fontSize: 30,color: Colors.white),),
            Text(
              "\$"+total.toString(), style:TextStyle(fontSize: 30,color: Colors.white),
             // "\$50.0",   style:TextStyle(fontSize: 30,color: Colors.white),
              ),
        ],
      ),
      
      ),
      GestureDetector(
        onTap:()async{
int amount=int.parse(wellet!)-total;
//await DatebaseMethods().updateUserWellet(id!, amount.toString());
await SharedPreferenceHelper().saveUserWellet(amount.toString());
        },
      child:   Container(
        padding: EdgeInsets.symmetric(vertical: 5.0),
        width:MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
          ),
        margin: EdgeInsets.only(left:20.0,right:20.0,bottom: 20.0),
        child:Center(
        child:Text(
          "checkOut",
        style: TextStyle(
          color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold,
        ),
        ),
        ),
      ),
       ),
      ]
    )
   )
      ]
    )
   )
 )
 
 );
}
}