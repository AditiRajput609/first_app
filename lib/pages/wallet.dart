import"package:flutter/material.dart";
class Wallet extends StatefulWidget{
const Wallet ({super.key});
@override
State<Wallet>createState()=>_WalletState();
}
class _WalletState extends State<Wallet>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
 appBar: AppBar(
    backgroundColor: Color(0xFFDCCFFF),
   title: Text("Wallet", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF4A1E9D))),
        leading: Icon(Icons.arrow_back, color: Color(0xFF4A1E9D)),
        actions: [Icon(Icons.settings, color: Color(0xFF4A1E9D)), SizedBox(width: 15)],
        elevation: 0,
 ),
   body:   SingleChildScrollView(
    child: Column(
        children: [
       Container(
         // margin: EdgeInsets.only(top:20,left:30,right: 30),
          height: 250,
          width:400,
           margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(20),
          ),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
            Icon(Icons.wallet,color:Colors.white,fontWeight: FontWeight.bold,size:20),
            Text("Wallet",style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize:20),),
            Text("FASHION • REWARDS",style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize:10),)
              ]
            ),
            SizedBox(height:15),
            Text("₹0", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),
           SizedBox(height:8),
             Text(  "Available for fashion purchases • Cashback & refunds", style: TextStyle(color: Colors.white70, fontSize: 12)),
              Padding(padding: EdgeInsets.only(top:30),
             child: Container(
                height:50,
                width:300,
                decoration: BoxDecoration(
                  color:Colors.white,
                  borderRadius: BorderRadius.circular(20)
                ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
               Icon(Icons.add, color: Color(0xFF6A3DFF)),
               Text("Add Money", style: TextStyle(color: Color(0xFF6A3DFF), fontWeight: FontWeight.bold)),
           ] )),
              ),
          ],
        )
        ),
           Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))),
             child:Column(
                children: [
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                    Text("Transaction History", 
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                       fontSize: 18)), 
                       Text("See all >", style: TextStyle(color: Color(0xFF6A3DFF)))
                       ]
                       ),
                  SizedBox(height: 15),
                  transactionTile("Purchased - Oversized Hoodie", "-₹899", Colors.purple, Icons.shopping_bag),
                  transactionTile("Refund - Denim Jacket", "+₹500", Colors.green, Icons.download),
                  transactionTile("Purchased - Running Sneakers", "-₹1,200", Colors.purple, Icons.directions_run),
                  transactionTile("Cashback Reward", "+₹50", Colors.orange, Icons.card_giftcard),
                ],
              ),
            ),
          //),
        ]
      ),
//]
    ),
    );
  }
   Widget transactionTile(String title, String amount, Color iconColor, IconData icon){
    bool isCredit = amount.startsWith("+");
    return ListTile(
      leading: CircleAvatar(backgroundColor: iconColor, child: Icon(icon, color: Colors.white, size: 20)),
      title: Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      subtitle: Text("Order #FAS78492 • ZARA", style: TextStyle(fontSize: 11)),
      trailing: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Text(amount, style: TextStyle(color: isCredit ? Colors.green : Colors.red, fontWeight: FontWeight.bold)),
        Text("Paid • 10:24 AM", style: TextStyle(fontSize: 10))
      ]),
    );
   }
}