import "package:first_app/pages/NavigoterBar.dart";
import "package:first_app/pages/details.dart";
import "package:first_app/pages/wishList.dart";
import "package:first_app/service/database.dart";
import "package:first_app/service/sharedPref.dart";
//ort "package:first_app/widget/widget_support.dart";
import"package:flutter/material.dart";
class Categoris extends StatefulWidget{
const Categoris({super.key});
@override
 State<Categoris>createState()=>_CategorisState();
}
class _CategorisState extends State<Categoris>{
  bool foryou=false,women=false,men=false,kids=false,womenparse=false;
  Stream?categoris;
  String? id;
 // ignore: strict_top_level_inference
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
 Widget allcategoris(){
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
        child:Container(
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
             // ignore: prefer_interpolation_to_compose_strings
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
    String productId = data["Name"]; 
setState(() {
  isFav[index]=!isFav[index];
  });
   if (isFav[index]) {
          Map<String,dynamic>addproducttolist={
             "detail": data["detail"],
  "Name":data["Name"],
  "price":data["price"],
  "Image":data["Image"],
          };
          await  DatebaseMethods().addproducttolist(addproducttolist,id,  productId);
           // ignore: use_build_context_synchronously
           ScaffoldMessenger.of(context).showSnackBar((SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            "product added to card",
            style:TextStyle(fontSize:20.0),
            ))));
        }else{
         await DatebaseMethods().deleteWishlistProduct(id, productId);
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Removed")));
  }

},
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
                       GestureDetector(
      onTap:(){
   Navigator.push(context,MaterialPageRoute(builder: (context)=>BottomNav()),);
      },
child:Icon(Icons.arrow_back,color:Colors.white,size: 40,),),
                      Text(
                        "All Categories",
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
                         child: Icon(Icons.favorite_border, color: Colors.white, size: 26),)
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
 /* body:Container(
 height: double.infinity,
 width:double.infinity,
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
    child:  Row(
        children: [
          GestureDetector(
      onTap:(){
   Navigator.push(context,MaterialPageRoute(builder: (context)=>BottomNav()),);
      },
child:Icon(Icons.arrow_back,color:Colors.white,size: 40,),),
Text("All Categories",
 style: TextStyle(
  fontSize: 30,
  color:Colors.white,
  fontFamily:"poppins",
  fontWeight: FontWeight.bold,
 ),
),
        ]
)

    ),
    Spacer(),
    Icon(Icons.notifications_active_outlined,color:Colors.white,size:40),
    SizedBox(width:20,),
   /* GestureDetector(
      onTap:(){
   Navigator.push(context,MaterialPageRoute(builder: (context)=>()));
      },*/
   Icon(Icons.favorite_outline,color:Colors.white,size:40)
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
  prefixIcon:Icon(Icons.saved_search_outlined),
),
 ),
 ),
    ],
   ),
),*/
body:SingleChildScrollView(
  child:Column(
  children: [
Row(
  children: [
    
Container(
  height:950,
  width: 150,
  decoration: BoxDecoration(
    gradient: LinearGradient(colors:[Colors.purple,Colors.pinkAccent])
  ),
  child:allCategories(),
  
 // color:Colors.white,
/*  child:Column(
    children: [
  Container(
width:100,
color:Colors.white,
   child:Column(
    children: [
 Image.asset("images/image-removebg-preview.png",
  height:100,
        width:100,
       // fit:BoxFit.fill,),
 ),
 Text("For You",style:TextStyle(fontSize:20,fontWeight: FontWeight.bold),)])),
 Container(
     margin: EdgeInsets.all(20),
  height:150,
  width:200,
  color: Colors.white,
  child:Column(
    children: [
 Image.asset("images/women_dress.avif",
height:100,
        width:100,
       // fit:BoxFit.fill,),
 ),
 Text("gown,frock",style:TextStyle(fontSize:20,fontWeight: FontWeight.bold),)])
),
  Container(
     margin: EdgeInsets.all(20),
  height:180,
  width:200,
  color: Colors.white,
   child:Column(
    children: [
 Image.asset("images/shoping-removebg.png",
height:100,
        width:100,
       // fit:BoxFit.fill,),
 ),
 Text("women parse",style:TextStyle(fontSize:20,fontWeight: FontWeight.bold),)])),
 Container(
   margin: EdgeInsets.all(20),
  height:150,
  width:150,
  color: Colors.white,
   child:Column(
    children: [
 Image.asset("images/formal-man.avif",
height:100,
        width:100,
       // fit:BoxFit.fill,),
 ),
 Text("man",style:TextStyle(fontSize:20,fontWeight: FontWeight.bold),)])
 ),
 Container(
   margin: EdgeInsets.all(20),
  height:150,
  width:150,
  color: Colors.white,
   child:Column(
    children: [
 Image.asset("images/formal-man.avif",
height:100,
        width:100,
       // fit:BoxFit.fill,),
 ),
 Text("Kids",style:TextStyle(fontSize:20,fontWeight: FontWeight.bold),)])
 ),
    ]
  ),*/
),

Padding(padding: EdgeInsets.only(left:30,top:10),
child:Container(
height: 950,
  width: 230,
  color:Colors.white,
  child:Column(
    children: [
 Row(
  mainAxisAlignment: MainAxisAlignment.start,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Padding(
      padding: EdgeInsets.only(top:10,left:10),
    
child:Text("Popular Fabrics",style:TextStyle(fontSize: 20,color: Colors.deepPurple)),)
  ],),
  Container(
    child:allcategoris()
),
 



    ]
  )
)
),
//),
  ]
)
//),
  ]
//
 )

  ),
);
  }
  Widget  allCategories() {
    return  Column(
    children: [
       GestureDetector(
          onTap:()async{
            foryou=true;
          women=false;
  men=false; 
  kids=false;

categoris=await DatebaseMethods().getCategoris("foryou");
setState(() {});
          },
 child: Container(
width:100,
 // ignore: deprecated_member_use
 color:foryou?Colors.white:Colors.grey.withOpacity(0.5),//borderRadius: BorderRadius.circular(20),
   child:Column(
    children: [
 Image.asset("images/image-removebg-preview.png",
  height:100,
        width:100,
       // fit:BoxFit.fill,),
 ),
 Text("For You",style:TextStyle(fontSize:20,fontWeight: FontWeight.bold),)
 ]
 )
  ),
       ),
   GestureDetector(
          onTap:()async{
            foryou=false;
          women=true;
          womenparse=false;
  men=false; 
  kids=false;
categoris=await DatebaseMethods().getCategoris("Women");
setState(() {});
          },
child:  Container(
     margin: EdgeInsets.all(20),
  height:150,
  width:200,
  // ignore: deprecated_member_use
  color:women?Colors.white:Colors.grey.withOpacity(0.5),
  child:Column(
    children: [
 Image.asset("images/women_dress.avif",
height:100,
        width:100,
       // fit:BoxFit.fill,),
 ),
 Text("gown,frock",style:TextStyle(fontSize:20,fontWeight: FontWeight.bold),)])
),
   ),
    GestureDetector(
          onTap:()async{
            foryou=false;
          women=false;
          //Womenparse=false;
          womenparse=true;
  men=false; 
  kids=false;
categoris=await DatebaseMethods().getCategoris("Women");
setState(() {});
          },
 child: Container(
     margin: EdgeInsets.all(20),
  height:180,
  width:200,
  // ignore: deprecated_member_use
  color:womenparse?Colors.white:Colors.grey.withOpacity(0.5),
   child:Column(
    children: [
 Image.asset("images/shoping-removebg.png",
height:100,
        width:100,
       // fit:BoxFit.fill,),
 ),
 Text("women parse",style:TextStyle(fontSize:20,fontWeight: FontWeight.bold),)])),),
  GestureDetector(
          onTap:()async{
            foryou=false;
          women=false;
          womenparse=false;
           men=true; 
          kids=false;
categoris=await DatebaseMethods().getCategoris("Man");
setState(() {});
          },
 child:Container(
   margin: EdgeInsets.all(20),
  height:150,
  width:150,
  // ignore: deprecated_member_use
  color:men?Colors.white:Colors.grey.withOpacity(0.5),
   child:Column(
    children: [
 Image.asset("images/formal-man.avif",
height:100,
        width:100,
       // fit:BoxFit.fill,),
 ),
 Text("man",style:TextStyle(fontSize:20,fontWeight: FontWeight.bold),)])
 ),
  ),
   GestureDetector(
          onTap:()async{
            foryou=false;
          women=false;
          womenparse=false;
              men=false; 
              kids=true;
categoris=await DatebaseMethods().getCategoris("Kids");
setState(() {});
          },
 child:Container(
   margin: EdgeInsets.all(20),
  height:150,
  width:150,
  // ignore: deprecated_member_use
  color:kids?Colors.white:Colors.grey.withOpacity(0.5),
   child:Column(
    children: [
 Image.asset("images/formal-man.avif",
height:100,
        width:100,
       // fit:BoxFit.fill,),
 ),
 Text("Kids",style:TextStyle(fontSize:20,fontWeight: FontWeight.bold),)])
 ),
   ),
    ]
 );
  }
}