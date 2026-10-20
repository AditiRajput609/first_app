import "package:cloud_firestore/cloud_firestore.dart";
import "package:first_app/pages/NavigoterBar.dart";
import "package:first_app/service/database.dart";
import "package:first_app/service/sharedPref.dart";
import"package:flutter/material.dart";
class Order extends StatefulWidget{
const  Order({super.key});
@override
 State<Order>createState()=>_OrderState();
}
class _OrderState extends State<Order>{
  String? id,wellet;
   //String? id,wellet;
  //int total=0;
   getthesharedpref()async{
    id=await SharedPreferenceHelper().getUserId();
    wellet=await SharedPreferenceHelper().getUserWellet();
  setState(() {
    
  });

  }
  ontheload()async{
    await getthesharedpref();
    orderStream=await DatebaseMethods().getOrder(id!);
    setState(() {
      
    });
    }
  @override
  void initState(){
    ontheload();
    //startTimer();
    super.initState();
  }
  Stream?  orderStream;
  Widget productitem(){
    return StreamBuilder(
  stream:orderStream,builder:(context,AsyncSnapshot snapshot){
    if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
    return snapshot.hasData?
   // GridView.builder(
   ListView.builder(
    padding: EdgeInsets.symmetric(horizontal:10,vertical:15),
      shrinkWrap: true,
       scrollDirection: Axis.vertical,
      //physics: NeverScrollableScrollPhysics(),
      //gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2 ,
      //mainAxisExtent: 250,
     // crossAxisSpacing: 12,
     // mainAxisSpacing: 12),
      itemCount: snapshot.data!.docs.length,
      itemBuilder: (context, index) {
        DocumentSnapshot data=snapshot.data!.docs[index];
//total=total+int.parse(data["Total"]);
      //  var data = snapshot.data!.docs[index].data();
       //if(isFav.length!=snapshot.data!.docs.length){
       // isFav=List.generate(snapshot.data!.docs.length,(index)=>false);
       //}
        return   Container(
           margin: EdgeInsets.only(bottom: 15, left: 10, right: 10),
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
 // child:Text(data["Quantity"],style:TextStyle(fontSize: 30,color: Colors.black),),
),
),
              ClipRRect(
         borderRadius: BorderRadius.circular(10),
            child: Image.network(data['Image'], height:150,width:200,fit:BoxFit.contain,filterQuality: FilterQuality.high,)),
           // child:CachedNetworkImage(imageUrl:data['Image'], height:150,width:150,fit:BoxFit.contain,)),
             Text(data['Name'], maxLines: 1,overflow:TextOverflow.ellipsis,style:TextStyle(color:Colors.black,fontSize:19,fontWeight: FontWeight.bold,)),
           //Text("\$"+data["price"],style:TextStyle(color:Colors.black,fontSize:20,fontWeight: FontWeight.bold),
            //),
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
          height: 50,
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
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    GestureDetector(
      onTap:(){
   Navigator.push(context,MaterialPageRoute(builder: (context)=>BottomNav ()));
      },
child:Icon(Icons.arrow_back),),
Text("My Order",style:TextStyle(color:Colors.black,fontSize:25,fontWeight: FontWeight.bold,)),
          //),
  ]
        ),
      
      ),
  SizedBox(height:20.0),
     Container(
        height:MediaQuery.of(context).size.height/2,
        //color:Colors.green,
        child:productitem()
      ),
      ]
 )
  )
   )
 );
}
}