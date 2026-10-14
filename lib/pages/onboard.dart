import "package:first_app/pages/signup.dart";
import "package:first_app/widget/content_model.dart";
import "package:first_app/widget/widget_support.dart";
import"package:flutter/material.dart";
class  Onboard extends StatefulWidget
 {
  const  Onboard({super.key});
  @override
 State< Onboard>createState()=>_OnboardState();
}
class _OnboardState extends State<Onboard> {
  int currentIndex=0;
  late PageController _controller=PageController();
  @override
  void intiState()
  {
    super.initState();
    _controller=PageController (initialPage:0);
  }
  @override
  void Discover(){
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
body:Container(
 // margin: EdgeInsets.only(top:20),
 // width:double.infinity,
  //height:double.infinity,
  //child:Text("Hello aditi"),
  decoration: BoxDecoration(
    gradient: LinearGradient(
    colors:[
    Colors.purple,
    Colors.pinkAccent,
    ],
    begin:Alignment.topLeft,
    end:Alignment.topRight,
),
  ),
 child:Column(
  children: [
  Expanded(
    child:PageView.builder(
      controller: _controller,
      itemCount: contents.length,
      onPageChanged:(int index){
        setState((){
          currentIndex=index;
        });
      },
      itemBuilder: (_,i){
        return
   Padding(
      padding:EdgeInsets.only(bottom:50),
  //crossAxisAlignment:CrossAxisAlignment.start,
  child:Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      SizedBox(height:20.0),
      Image.asset(
        contents[i].image,
        height:300,
        width:MediaQuery.of(context).size.width,
        fit:BoxFit.fill,),
      SizedBox(height:10.0,),
 Text(
    contents[i].description,
  style:AppWidget.boldTextfieldStyle(),
  ),
   SizedBox(height:20.0,),
  Text(
    contents[i].title ,
  style:AppWidget.lightTextfieldStyle(),
  ),
    ],
  ),
  );
      },
    ),
  ),
   

  GestureDetector(
    onTap:(){
if(currentIndex==contents.length-1){
  Navigator.push(context,
 MaterialPageRoute(builder:(context)=>SignUp()),
  );
}else{
  _controller.nextPage(
   duration: Duration(milliseconds: 300),
   curve:Curves.ease,
  );
}
    },
  child: Container(
 decoration: BoxDecoration(
  color:Colors.lightBlue,
  borderRadius: BorderRadius.circular(20)),
  height:50,
margin: EdgeInsets.all(60),
width:double.infinity,
child:Center(
  child: Text(

   currentIndex==contents.length-1?"Get Started":"Start",
  style: TextStyle(
    color:Colors.white,
    fontSize: 30,
    fontWeight: FontWeight.bold,
  ),
  ),
 ),
  ),
  ),
    ],
  ),
   // );
    //  }
   ) ,
  );
  }
}