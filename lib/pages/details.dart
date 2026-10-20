//import "package:first_app/pages/home.dart";
import "package:first_app/pages/review_order.dart";
import "package:first_app/pages/wishList.dart";
import "package:first_app/service/database.dart";
import "package:first_app/service/sharedPref.dart";
//import "package:first_app/widget/widget_support.dart";
import"package:flutter/material.dart";
// ignore: camel_case_types, must_be_immutable
class details extends StatefulWidget{
  // ignore: non_constant_identifier_names
  String Name,price,image,detail;
  // ignore: non_constant_identifier_names, use_key_in_widget_constructors
  details({required this.Name,required this.price,required this.detail ,required this.image});
@override
  State<details>createState()=>_detailsState();
  }
// ignore: camel_case_types
class _detailsState extends State<details>{
   int a=1,total=0;
 String? id;

  // ignore: strict_top_level_inference
  getthesharedpref()async{
    id=await SharedPreferenceHelper().getUserId();
    setState(() {
      
    });
  }
  // ignore: strict_top_level_inference
  ontheload()async{
    await getthesharedpref();
    setState(() {
      
    });
  }
  @override
  void initState(){
    super.initState();
    ontheload();
    total=int.parse(widget.price);

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
 Colors.deepPurple
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
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
     GestureDetector(
              onTap:(){
                Navigator.pop(context);
              },
            
       child: Icon(Icons.arrow_back_ios_new_outlined,color:Colors.white),
            ),
            Text("product details",style:TextStyle(fontSize: 30,color: Colors.white),),
           Icon(Icons.notifications_active_outlined,color:Colors.white,size:40),
    SizedBox(width:20,),
    GestureDetector(
      onTap:(){
   Navigator.push(context,MaterialPageRoute(builder: (context)=>Wishlist()));
      },
   child:Icon(Icons.favorite_outline,color:Colors.white,size:40)  ),
  ]
 )
),
SizedBox(height: 20.0,),
Container(
  margin: EdgeInsets.all(20),
  height: 350,
  width:400,
  color: Colors.purpleAccent,
 child:  Image.network(widget.image,
 //child:Image.network ("images/women_dress.avif",
 height: 200,width:200,fit:BoxFit.cover,),
 ),
  //Spacer(),
 Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
     
                Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
     //Text(
       Text(widget.Name,
       style:TextStyle(fontSize: 30,color: Colors.white),
      // "loerm ipsum is "
       ),]),
         Spacer(),
         GestureDetector(
  onTap:(){
    if(a>1){
    --a;
   total=total-int.parse(widget.price);
    }
    setState((){

    });
  },
child:Container(
            decoration: BoxDecoration(color:Colors.deepPurple,borderRadius:BorderRadius.circular(8)),
            child:Icon(Icons.remove,color:Colors.white,),),),
            SizedBox(width:20.0),
            //Spacer(),
             Text(
        a.toString() ,style:TextStyle(fontSize: 20,color: Colors.white),),
        SizedBox(width:20.0),
            GestureDetector(
  onTap:(){
    ++a;
   total=total+int.parse(widget.price);
    setState((){

    });
  },
          child:   Container(
            decoration: BoxDecoration(color:Colors.deepPurple,borderRadius:BorderRadius.circular(8)),
            child:Icon(Icons.add,color:Colors.white,),
    ),
            ),
 ],),
  SizedBox(height:30.0,),
   Text(
        "loerm ipsum is simple dummy text of the printing and" ,style:TextStyle(fontSize: 30,color: Colors.white),),
  SizedBox(height:30.0,),
    Row(
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      Text("Delivery time",style:TextStyle(fontSize:20,color: Colors.white),),
      Icon(Icons.alarm,color:Colors.white,),
      SizedBox(width:5.0),
      Text("30 min",style:TextStyle(fontSize: 20,color: Colors.white),),
      ],
    ),
 Spacer(),
   Padding(
    padding:const EdgeInsets.only(bottom:20.0),
   child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment:CrossAxisAlignment.start,
        children: [
          GestureDetector(
        onTap: (){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>ReviewOrder(
            Name:widget.Name,
             image:widget.image,// Name,price,image
             price:widget.price
          )),);
      },
       child:  Container(
        width:MediaQuery.of(context).size.width/2,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(color:Colors.pink,borderRadius: BorderRadius.circular(20),),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
Text("Buy Now",style:TextStyle(color:Colors.white,fontSize:16.0,fontFamily: "poopins"),
),
SizedBox(width: 30.0,),
Container(
  padding: EdgeInsets.all(3),
  decoration: BoxDecoration(color:Colors.grey,borderRadius: BorderRadius.circular(8),),
  child:Icon(Icons.area_chart,color:Colors.white,),
),
          ]
        )
        )
          )
        ]
        ),
  /*Text("total price",style:TextStyle(fontSize: 20,color: Colors.white),),
  // ignore: prefer_interpolation_to_compose_strings
  Text("\$"+total.toString(),style:TextStyle(fontSize: 20,color: Colors.white)
 // Text("\$20",style:TextStyle(fontSize: 30,color: Colors.blueAccent)
),
   ],
      ),*/
       GestureDetector(
        onTap: ()async{
          Map<String,dynamic>addproducttoCart={
            "Name":widget.Name,
            "Quantity":a.toString(),
            "Total":total.toString(),
           "Image":widget.image,
          };
          await  DatebaseMethods().addproducttoCart(addproducttoCart, id!);
           // ignore: use_build_context_synchronously
           ScaffoldMessenger.of(context).showSnackBar((SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            "product added to card",
            style:TextStyle(fontSize:20.0),
            ))));
        },
      
       child: Container(
        width:MediaQuery.of(context).size.width/2,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(color:Colors.pink,borderRadius: BorderRadius.circular(20),),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
Text("Add to cart",style:TextStyle(color:Colors.white,fontSize:16.0,fontFamily: "poopins"),
),
SizedBox(width: 30.0,),
Container(
  padding: EdgeInsets.all(3),
  decoration: BoxDecoration(color:Colors.grey,borderRadius: BorderRadius.circular(8),),
  child:Icon(Icons.shopping_cart_outlined,color:Colors.white,),
),
SizedBox(width:10.0),
        ],),
      ),
       
       ),
        ]
      )
   // ]
     // )
   )
 ]
 )
    )
);
     //)
   // );
  }
}