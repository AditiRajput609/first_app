import "package:curved_navigation_bar/curved_navigation_bar.dart";
import "package:first_app/pages/categoris.dart";
//import "package:curved_navigation_rail/curved_navigation_rail.dart";
import "package:first_app/pages/home.dart";
import "package:first_app/pages/order.dart";
import "package:first_app/pages/profile.dart";
import "package:first_app/pages/wallet.dart";
import"package:flutter/material.dart";
class BottomNav extends StatefulWidget{
  const BottomNav({super.key});
  @override
  State<BottomNav>createState()=>_BottomNavState();
}
class _BottomNavState extends State<BottomNav>{
  int currentTabIndex=0;
  late List<Widget>pages;
  late Widget currntPages;
  late Home homePage;
  late Profile profile;
  late Order order;
  late Wallet wallet;
  @override
  void initState(){
   homePage=Home() ;
   order=Order();
   wallet=Wallet();
   profile=Profile();
   pages=[homePage,order,wallet,profile,];
   super.initState();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      bottomNavigationBar:CurvedNavigationBar(
        height:70,
        backgroundColor:Colors.white,
        color:Colors.purple,
        animationDuration:Duration(milliseconds: 500),
         onTap:(int index){
          setState((){
            currentTabIndex=index;
          });
         },
      
items:[

  //mainAxisAlignment: MainAxisAlignment.spaceAround,
//children:[
  Icon(Icons.home_outlined,
  color:Colors.white,),
  Icon(
    Icons.shopping_bag_outlined,
  color:Colors.white,
  ),
  Icon(
    Icons.wallet_outlined,
    color:Colors.white,
  ),
  Icon(
    Icons.person_outline,
    color:Colors.white,
  ),

],
),
      body:pages[currentTabIndex],
    );
  }
}