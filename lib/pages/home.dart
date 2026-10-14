import "package:cached_network_image/cached_network_image.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:first_app/pages/categoris.dart";
import "package:first_app/pages/details.dart";
import "package:first_app/pages/shopping_cart.dart";
import "package:first_app/pages/wishList.dart";
import "package:first_app/service/database.dart";
import "package:first_app/service/sharedPref.dart";
import "package:first_app/widget/widget_support.dart";
import"package:flutter/material.dart";
class Home extends StatefulWidget
{
   const Home ({super.key});
   @override
   State<Home>createState()=>_HomeState();
}
class _HomeState extends State<Home>{
  // Tumhare products
 bool women=false,men=false,kids=false;
 Stream?categoris;
 String? Id,productId;
 ontheload()async{
  categoris=await DatebaseMethods().getCategoris("Man");
  setState(() {
    
  });
 }
 @override
  void initState(){
    ontheload();
    super.initState();
  }
 //favorite1=false,favorite2=false;
List<bool>isFav=[];
 Widget allItem(){
    return StreamBuilder(
  stream:categoris,builder:(context,AsyncSnapshot snapshot){
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
        isFav=List.generate(snapshot.data!.docs.length,(index)=>false);
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
   String?id=await SharedPreferenceHelper().getUserId();
   if(id==null)return;
    String productId = data["Name"]; // Name ko ID banao, kyunki har product ka naam alag hai
   //String? id = snapshot.data!.docs[index].id; // har product ki unique ID
    setState(() {
    isFav[index] =!isFav[index];
  });

  if (isFav[index]) {
          Map<String,dynamic>addproducttolist={
             "detail": data["detail"],
  "Name":data["Name"],
  "price":data["price"],
  "Image":data["Image"],
          };
          await  DatebaseMethods().addproducttolist(addproducttolist,id,  productId);
           ScaffoldMessenger.of(context).showSnackBar((SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            "product added to card",
            style:TextStyle(fontSize:20.0),
            ))));
        }else{
         await DatebaseMethods().deleteWishlistProduct(id, productId);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Removed")));
  }
},
/*setState(() {
  isFav[index]=!isFav[index];
  });
},*/
child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
         shape: BoxShape.circle,
         color:Colors.white,),
    child: Icon(
    isFav[index]? Icons. favorite :Icons.favorite_outline,color:isFav[index]?Colors.red:Colors.black,size:30)
                )
              )
              ),
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
       backgroundColor: Color(0xFFFF6B8A), // puri screen ka pink background
    appBar: PreferredSize(
      preferredSize: Size.fromHeight(130), // AppBar ki height
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF9C27B0), Color(0xFFE040FB), Color(0xFFFF6B8A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                children: [
                  // FASHION + Bell icon wala row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "FASHION",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.notifications_none, color: Colors.white, size: 28),
                          SizedBox(width: 10),
                          GestureDetector(
      onTap:(){
   Navigator.push(context,MaterialPageRoute(builder: (context)=>Wishlist()));
      },
                         child: Icon(Icons.favorite_border, color: Colors.white, size: 26),),
                          GestureDetector(
      onTap:(){
   Navigator.push(context,MaterialPageRoute(builder: (context)=>ShoppingCart()));
      },
                      child:  Icon(Icons.shopping_cart, color: Colors.white, size: 26),)
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 15),
                  // Search bar
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "search for products",
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
/*body:Container(
 //height: double.infinity,
 //width:double.infinity,
 decoration: BoxDecoration(
  gradient: LinearGradient(
    
    colors:[
      Colors.white,
Colors.pinkAccent,
 Colors.white
//Colors.pink,
    ],
begin:Alignment.topRight,
end:Alignment.bottomLeft,
),
 ),
 child:SingleChildScrollView(
 child:Column(
  children: [
  //padding: EdgeInsets.only(top:30,),
 Container(
  margin: EdgeInsets.only(top:20),
  height: 150,
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
child:Column(
  children: [
Row(
 crossAxisAlignment: CrossAxisAlignment.start,
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Container(
      margin: EdgeInsets.only(left:20,),
child:Text("FASHION",
 style: TextStyle(
  fontSize: 40,
  color:Colors.white,
  fontFamily:"poppins",
  fontWeight: FontWeight.bold,
 ),
),
    ),
    Spacer(),
    Icon(Icons.notifications_active_outlined,color:Colors.white,size:40),
    SizedBox(width:20,),
    GestureDetector(
      onTap:(){
   Navigator.push(context,MaterialPageRoute(builder: (context)=>Wishlist()));
      },
   child:Icon(Icons.favorite_outline,color:Colors.white,size:40)),
  ],
   ),
   SizedBox(height: 20,),
   Container(
 // decoration: BoxDecoration(
height:60,
width: 350,
decoration: BoxDecoration(
borderRadius:BorderRadius.circular(20),
color: Colors.white,
  ),
 child: TextFormField(
decoration: InputDecoration(
  hintText: "search for products",
  hintStyle:TextStyle(fontSize: 20,color: Colors.black,),
  prefixIcon:Icon(Icons.saved_search_outlined) ,
),
 ),
 ),
    ],
   ),
),*/
 body:SingleChildScrollView(
 // child:Column(
 // children: [
child:Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
Text("Categoris",
 style: AppWidget.lightTextfieldStyle(),),
         GestureDetector(
      onTap:(){
   Navigator.push(context,MaterialPageRoute(builder: (context)=>Categoris()));
      },
child: Icon(Icons.arrow_forward,color:Colors.white,size:40,fontWeight: FontWeight.bold,),)]),
    
    Container(
      child:  showItem()
    ),
   /* Row(
      children: [
        GestureDetector(
          onTap:(){
         
setState(() { 
  //selectedCategory="women";
  women=true;
  men=false; 
  kids=false;
});
          },
  child:  Container(
      margin: EdgeInsets.only(left:20,top:10),
      height: 80,
      width:120,
      decoration: BoxDecoration(
      color:women?Colors.purple:Colors.grey.withOpacity(0.5), borderRadius: BorderRadius.circular(20),
),
child:Row(
  children: [
  Icon(Icons.woman_outlined,size:40,color:Colors.white),
  Text("Women",style:TextStyle(fontSize: 20,fontWeight:FontWeight.bold,color:Colors.white,),),
  ],
        ),
),
  ),
         GestureDetector(
          onTap:(){
setState(() {
 // selectedCategory="men";
 women=false;
men=true;
kids=false;
});
          },
    child: Container(
      margin: EdgeInsets.only(left:10,top:10),
      height: 80,
      width:120,
      decoration: BoxDecoration(
      color:men?Colors.purple:Colors.grey.withOpacity(0.5),borderRadius: BorderRadius.circular(20),
),
child:Row(
  children: [
  Icon(Icons.man_2_outlined,size:40,color:Colors.white),
  Text("Men",style:TextStyle(fontSize: 20,fontWeight:FontWeight.bold,color:Colors.white,),),
  ],
),
    ),),
      GestureDetector(
          onTap:(){
         
setState(() { 
  //selectedCategory="kids";
 women=false;
  men=false; 
  kids=true;
});
          },
   child:  Container(
      margin: EdgeInsets.only(left:10,top:10),
      height: 80,
      width:120,
      decoration: BoxDecoration(
      color:kids?Colors.purple:Colors.grey.withOpacity(0.5), borderRadius: BorderRadius.circular(20)
),
child:Row(
  children: [
  Icon(Icons.man_3,size:40,color:Colors.white),
  Text("Kids", style:TextStyle(fontSize: 20,fontWeight:FontWeight.bold,color:Colors.white,),),
  ],
),
    ),
      ),
      ],
    ),*/
    //],
//),
Row(
  children:[
Container(
  margin: EdgeInsets.only(top:30,left:20,right: 20),
  height: 150,
  width:370,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    gradient: LinearGradient(
      colors:[
  Colors.deepPurple,
  Colors.pinkAccent,
  Colors.white,
      ],
  end:Alignment.bottomRight,
      
    ),
),
child:Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
Padding(
padding: EdgeInsets.only(top:10,left:10),
child:Column(
 // mainAxisAlignment: MainAxisAlignment.start,
 crossAxisAlignment: CrossAxisAlignment.start,
  children: [
Text("New Collection",style:TextStyle(fontSize:20,color:Colors.white),),
 Text("Fall Style 2025",style:TextStyle(color:Colors.white,fontSize: 30,fontWeight: FontWeight.bold,),),
 Text("Up to 40% off.New Arrivals",style:TextStyle(fontSize: 20,color:Colors.white)),
Text("Now Live",style:TextStyle(fontSize: 20,color:Colors.white)),
  ],
),
),
Image.asset("images/shoping-removebg.png",
height:150,
        width:110,
        fit:BoxFit.fill,),
  ]
),
),
  ],
),
Padding(padding: EdgeInsets.only(top:30,left:20,right: 20),
child:Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
Text("Trending Now",style: TextStyle(color:Colors.white,fontSize:30,fontWeight: FontWeight.bold,)),

Text("See All ",style: TextStyle(color:Colors.white,fontSize:25,fontWeight: FontWeight.bold,)),
Icon(Icons.arrow_forward,color:Colors.white,size:30,fontWeight: FontWeight.bold,),
],
),
),

SingleChildScrollView(
  scrollDirection:Axis.horizontal,
 // SizedBox(height:200),
 /* Widget allItem(){
    return StreamBuilder(
  stream: FirebaseFirestore.instance.collection('Man').snapshots(),
  builder: (context, snapshot) {
    if (!snapshot.hasData) return CircularProgressIndicator();
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: snapshot.data!.docs.length,
      itemBuilder: (context, index) {
        var data = snapshot.data!.docs[index].data();
        return Container(
        //height: 700,
          //width:200,
         // padding: EdgeInsets.only(bottom: 10,top:40),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
gradient: LinearGradient(
            colors:[
              Colors.pinkAccent,
              Colors.white10,
              Colors.purple,
            ],
             begin: Alignment.topRight,
  end:Alignment.bottomRight,
),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              ClipRRect(
         borderRadius: BorderRadius.circular(20),
             // Expanded(
                child: Image.network(data['Image'], height:100,width:100,fit:BoxFit.cover,)),//),
              Text(data['Name'],style:TextStyle(color:Colors.black,fontSize:20,fontWeight: FontWeight.bold)),
              Text("₹${data['price']}",style:TextStyle(color:Colors.black,fontSize:25,fontWeight: FontWeight.bold)),
            ],
          ),
        );
      },
    );
  },
);
  },*/

/*child:Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Padding(padding: EdgeInsets.only(top:20,bottom: 30,left:10),*/
child:Container(
 // margin: EdgeInsets.all(10),
  //padding: EdgeInsets.only(top:10),
  height:300,
  width:400,
   //color:Colors.white,
  /*decoration: BoxDecoration(
    color:Colors.white,
    borderRadius: BorderRadius.circular(10),
  ),*/
  child:allItem()) ,

  /*child:Column(
  children: [
    Stack(
      children: [
   Image.asset("images/women_dress.avif",height: 150,width:170,fit:BoxFit.cover,),
 Column(
  mainAxisAlignment: MainAxisAlignment.end,
 crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
         shape: BoxShape.circle,
         color:Colors.white,),
        child:GestureDetector(
onTap:(){
setState(() {
  favorite1= !favorite1;
  });
},
    child: Icon(
    favorite1? Icons. favorite :Icons.favorite_outline,color:favorite1?Colors.red:Colors.black,size:30)),
      ),
    

Column(
  children: [
    Padding(padding: EdgeInsets.only(top:140,),
  child:  Text("Women Sarees",style:TextStyle(color:Colors.black,fontSize:20,),),),
    SizedBox(height:5.0),
     Text("Top Collection",style:TextStyle(color:Colors.black,fontSize:25,),),]),
  ],
),
  ]
    ),
  ]
  )
),
    ),
    Container(
      margin: EdgeInsets.only(top:20,bottom: 30),
      padding: EdgeInsets.only(top:5),
 height:260,
  width:200,
  decoration: BoxDecoration(
    color:Colors.white,
    borderRadius: BorderRadius.circular(10),
  ),
  child: Column(
  children: [
      Stack(
      children: [
   Image.asset("images/formal-man.avif",height: 150,width:150,fit:BoxFit.cover,),
    Column(
  mainAxisAlignment: MainAxisAlignment.end,
 crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
         shape: BoxShape.circle,
         color:Colors.white,),
    child:GestureDetector(
onTap:(){
setState(() {
  favorite2= !favorite2;
  /*if(favorite2){
wishlist.add(products[1]);
  }else{
    wishlist.remove(products[1]);
  }*/
});
},
    child: Icon(
    favorite2? Icons. favorite :Icons.favorite_outline,color:favorite2?Colors.red:Colors.black,size:30),),),
     Column(
  children: [
    Padding(padding: EdgeInsets.only(top:140,),
   child: Text("Men daress",style:TextStyle(color:Colors.black,fontSize:20,),),),
    SizedBox(height:2.0),
     Text("Top Collection",style:TextStyle(color:Colors.black,fontSize:20,),),],)
  ],
 ),
  ]
),
  ]
),*/

//),
)
  ]
),
 ),
//),
    );
  }
   Widget showItem(){
    return 
     Row(
      children: [
        GestureDetector(
          onTap:()async{
          women=true;
  men=false; 
  kids=false;
categoris=await DatebaseMethods().getCategoris("Women");
setState(() {});
          },
  child:  Container(
      margin: EdgeInsets.only(left:20,top:10),
      height: 80,
      width:120,
      decoration: BoxDecoration(
      color:women?Colors.purple:Colors.grey.withOpacity(0.5), borderRadius: BorderRadius.circular(20),
),
child:Row(
  children: [
  Icon(Icons.woman_outlined,size:40,color:Colors.white),
  Text("Women",style:TextStyle(fontSize: 20,fontWeight:FontWeight.bold,color:Colors.white,),),
  ],
        ),
),
  ),
  
         GestureDetector(
          onTap:()async{
            women=false;
men=true;
kids=false;
            categoris=await DatebaseMethods().getCategoris("Man");
setState(() {
});
          },
    child: Container(
      margin: EdgeInsets.only(left:10,top:10),
      height: 80,
      width:120,
      decoration: BoxDecoration(
      color:men?Colors.purple:Colors.grey.withOpacity(0.5),borderRadius: BorderRadius.circular(20),
),
child:Row(
  children: [
  Icon(Icons.man_2_outlined,size:40,color:Colors.white),
  Text("Men",style:TextStyle(fontSize: 20,fontWeight:FontWeight.bold,color:Colors.white,),),
  ],
),
    ),),
      GestureDetector(
          onTap:()async{
         //selectedCategory="kids";
 women=false;
  men=false; 
  kids=true;
     categoris=await DatebaseMethods().getCategoris("Kids");
setState(() { 

});
          },
   child:  Container(
      margin: EdgeInsets.only(left:10,top:10),
      height: 80,
      width:120,
      decoration: BoxDecoration(
      color:kids?Colors.purple:Colors.grey.withOpacity(0.5), borderRadius: BorderRadius.circular(20)
),
child:Row(
  children: [
  Icon(Icons.man_3,size:40,color:Colors.white),
  Text("Kids", style:TextStyle(fontSize: 20,fontWeight:FontWeight.bold,color:Colors.white,),),
  ],
),
    ),
      ),
      ],
     );
   }
}