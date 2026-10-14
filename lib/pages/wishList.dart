import "dart:async";

import "package:first_app/pages/NavigoterBar.dart";
import "package:first_app/pages/details.dart";
import "package:first_app/service/database.dart";
import "package:first_app/service/sharedPref.dart";
//import "package:first_app/pages/home.dart";
import"package:flutter/material.dart";
class Wishlist extends StatefulWidget{
  const  Wishlist({super.key});
  @override
  State<Wishlist>createState()=>_WishlistState();
}
class _WishlistState extends State<Wishlist>{
   String? id, productId,wellet;
  getthesharedpref()async{
    id=await SharedPreferenceHelper().getUserId();
    wellet=await SharedPreferenceHelper().getUserWellet();
  setState(() {
    
  });

  }
  ontheload()async{
    await getthesharedpref();
    wishStream=await DatebaseMethods().getproductlist(id!);
    setState(() {
      
    });
    }
  @override
  void initState(){
    ontheload();
    super.initState();
  }
  Stream?  wishStream;
  List<bool>isFav=[];
  Widget widgetwislist(){
    return StreamBuilder(
  stream:wishStream,builder:(context,AsyncSnapshot snapshot){
    if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
    return snapshot.hasData?
    GridView.builder(
      shrinkWrap: true,
       scrollDirection: Axis.vertical,
      //physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
      mainAxisExtent: 250,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12),
      itemCount: snapshot.data!.docs.length,
      itemBuilder: (context, index) {
        var data = snapshot.data!.docs[index].data();
       if(isFav.length!=snapshot.data!.docs.length){
        isFav=List.generate(snapshot.data!.docs.length,(index)=>true);
       }
        return GestureDetector(
  onTap:(){
Navigator.push(context,MaterialPageRoute(builder:(context)=>details(
 detail: data["detail"],
  Name:data["Name"],
  price:data["price"],
  image:data["Image"],
 ),
  ));
  },
      child:  Container(
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
           Column(
            mainAxisSize: MainAxisSize.min,
            children: [
    //
              ClipRRect(
         borderRadius: BorderRadius.circular(10),
            child: Image.network(data['Image'], height:150,width:200,fit:BoxFit.contain,filterQuality: FilterQuality.high,)),
           // child:CachedNetworkImage(imageUrl:data['Image'], height:150,width:150,fit:BoxFit.contain,)),
             Text(data['Name'], maxLines: 1,overflow:TextOverflow.ellipsis,style:TextStyle(color:Colors.black,fontSize:19,fontWeight: FontWeight.bold,)),
             Text("\$"+data["price"],style:TextStyle(color:Colors.black,fontSize:20,fontWeight: FontWeight.bold),
             ),
            ]
            ),
              Positioned(
                top:8,
                right:8,
                child:GestureDetector(
onTap:()async{
     try {
        String docId = snapshot.data!.docs[index].id;
        print("Deleting: userId=$id, docId=$docId"); // check ke liye

        if (id!= null) {
          await DatebaseMethods().deleteWishlistProduct(id!, docId);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Removed from Wishlist")),
          );
          // StreamBuilder khud list update kar dega, setState ki zarurat nahi
        }
      } catch (e) {
        print("Delete error: $e");
      }
    },
    child: Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Icon(Icons.favorite, color: Colors.red, size: 30),
    ),
                )
              )
  /* String id = snapshot.data!.docs[index].id; // har product ki unique ID
    setState(() {
    isFav[index] =!isFav[index];
  });
   String docId = snapshot.data!.docs[index].id;
  await DatebaseMethods().deleteWishlistProduct(id!, docId);
  // setState ki zarurat nahi, StreamBuilder khud update ho jayega
},

if (isFav[index]) {
          Map<String,dynamic>addproducttolist={
             "detail": data["detail"],
  "Name":data["Name"],
  "price":data["price"],
  "Image":data["Image"],
          };
          await  DatebaseMethods().addproducttolist(addproducttolist,  productId!,id);
           ScaffoldMessenger.of(context).showSnackBar((SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            "product added to card",
            style:TextStyle(fontSize:20.0),
            ))));
        }
},
setState(() {
  isFav[index]=!isFav[index];
  });
},
child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
         shape: BoxShape.circle,
         color:Colors.white,),
    child: Icon(
     // child: Icon(
  Icons.favorite, // hamesha filled wala
  color: Colors.red,
  size: 30
)
    //isFav[index]? Icons. favorite :Icons.favorite_outline,color:isFav[index]?Colors.red:Colors.black,size:30)
                )
              )
              ),*/
            ],
          ),
     )
       )
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
    body:
    Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors:[Colors.white,Colors.pinkAccent,Colors.white],
begin:Alignment.topRight,
end:Alignment.bottomLeft,
        )
      ),
     child:SingleChildScrollView(
   child:   Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        height: 100,
        width:410,
      decoration  :BoxDecoration(
        gradient: LinearGradient(colors: [
        Colors.blue,
        Colors.blueGrey,
        Colors.blueGrey,
        Colors.white,],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
child:Row(
  mainAxisAlignment: MainAxisAlignment.start,
  children: [
    GestureDetector(
      onTap:(){
   Navigator.push(context,MaterialPageRoute(builder: (context)=>BottomNav()),);
      },
child:Icon(Icons.arrow_back,color:Colors.white,size: 40,),),

Text("Wishlist&Collecions",style: TextStyle(fontSize:30,fontFamily:"poppins",fontWeight: FontWeight.bold,color:Colors.white),),
  ]
),
      ),
      Container(
        child:widgetwislist()
      )
    ]
   ),
     ),
    ),
    );
  }
}
