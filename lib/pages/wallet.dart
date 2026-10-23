import "dart:convert";
import "package:first_app/service/database.dart";
import "package:first_app/service/sharedPref.dart";
import "package:first_app/widget/app_consttant.dart";
import "package:first_app/widget/widget_support.dart";
import"package:flutter/material.dart";
import "package:flutter_stripe/flutter_stripe.dart";
import 'package:http/http.dart'as http;
class Wallet extends StatefulWidget{
  const Wallet({super.key}); 
  @override
  State<Wallet>createState()=>_WelletState();
}
class _WelletState extends State<Wallet>{
  String? wallet,Id;
  int? add;
  TextEditingController amountcontroller=new TextEditingController();
  getthesharedpref()async{
  wallet=await SharedPreferenceHelper().getUserWallet();
  Id= await SharedPreferenceHelper().getUserId();
  setState((){

  });
  }

  ontheload()async{
    await getthesharedpref();
    setState(() {
      
    });
  }
  @override
  void initState(){
    ontheload();
    super.initState();
  }
  Map <String,dynamic>?paymentIntent;
  
 //get secretKey => null;
  @override
  Widget build(BuildContext context){
    return Scaffold(
   body:wallet==null?CircularProgressIndicator():
    Container(
    margin:EdgeInsets.only(top:50.0),
    child:Column(
      crossAxisAlignment:CrossAxisAlignment.start,
      children: [
      Material(
        elevation: 2.0,
        child:Container(
           height: 50,
          padding: EdgeInsets.only(bottom: 10.0),
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
     child: Center(
        child:Text(
          "Wallet",
          style:TextStyle(color:Colors.black,fontSize:25,fontWeight: FontWeight.bold,)
         // style: AppWidget.HeadLineTextFeildStyle(),
          ),
          ),
        ),
      ),
      SizedBox(height:30.0),
      Container(
        padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
        width:MediaQuery.of(context).size.width,
        decoration: BoxDecoration (color:Color.fromRGBO(242, 242, 242, 1)),
      child:Row(children: [
        Icon(
    Icons.wallet_outlined,
    color:Colors.black,size:40
  ),
//Image.asset("images/wellet.jpg",height:80,width:80,fit:BoxFit.cover,),
SizedBox(width:40.0),
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text("your welllet",
    style:TextStyle(color:Colors.black,fontSize:25,fontWeight: FontWeight.bold,)
),
SizedBox(height:5.0),
Text("\$"+ wallet!,
  
 style: TextStyle(fontSize:30,fontFamily:"poppins",fontWeight: FontWeight.bold,color:Colors.black),
 ),
],
),
      ],),
      ),
      SizedBox(height:20.0),
      Padding(
        padding: const EdgeInsets.only(left:20.0),
        child:Text("Add Money",
       style: TextStyle(fontSize:30,fontFamily:"poppins",fontWeight: FontWeight.bold,color:Colors.black),
        ),
      ),
      SizedBox(height:20.0),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap:(){
         makePayment("100");
            },
     child:  Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            border:Border.all(
color:Colors.greenAccent,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child:Text(
           "\$"+"100", 
     style: TextStyle(fontSize:30,fontFamily:"poppins",fontWeight: FontWeight.bold,color:Colors.black),
          ),
        ),
      ),
        GestureDetector(
            onTap:(){
          makePayment("500");
            },
     child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            border:Border.all(
color:Color(0xFFE9E2E2),
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child:Text(
            "\$"+"500", 
            style: TextStyle(fontSize:30,fontFamily:"poppins",fontWeight: FontWeight.bold,color:Colors.black),
          ),
        ),
        ),
          GestureDetector(
            onTap:(){
          makePayment("1000");
            },
     child:
         Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            border:Border.all(
color:Color(0xFFE9E2E2),
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child:Text(
            "\$"+"1000", 
            style: TextStyle(fontSize:30,fontFamily:"poppins",fontWeight: FontWeight.bold,color:Colors.black),
          ),
        ),),
          GestureDetector(
            onTap:(){
         makePayment("2000");
            },
     child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            border:Border.all(
color:Color(0xFFE9E2E2),
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child:Text(
            "\$"+"2000", 
            style: TextStyle(fontSize:30,fontFamily:"poppins",fontWeight: FontWeight.bold,color:Colors.black),
          ),
        ),
          ),
      ],
      ),
      SizedBox(height:50.0),
      GestureDetector(
        onTap:(){
         openEdit();
  },
     child:Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        padding: EdgeInsets.symmetric(vertical: 12.0),
        width:MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color:Color(0xFF008080),
        borderRadius: BorderRadius.circular(8),
        ),
        child:Center(
          child:Text(
            "Add money",
style: TextStyle(
  color: Colors.black,fontSize: 30.0,fontWeight: FontWeight.bold,fontFamily:"poppins",
),
        ),
        ),
      ),
      ),
    ],
    ),
   ),
    );
  }
  Future<void>makePayment(String amount)async{
try{
//paymentIntent
 paymentIntent=await createPaymentIntent(amount,'INR');
await Stripe.instance
.initPaymentSheet (
  paymentSheetParameters:SetupPaymentSheetParameters(
paymentIntentClientSecret: paymentIntent!["client_secret"],
style:ThemeMode.dark,
merchantDisplayName:"Adnan"))
.then((value){});

displayPaymentSheet(amount);
}catch(e,s){
  print('exception:$e$s');
}
  }
  displayPaymentSheet(String amount)async{
    try{
    await Stripe.instance.presentPaymentSheet()
    .then((value)async{
      add =int.parse(wallet!)+int.parse(amount);
      await SharedPreferenceHelper().saveUserWallet(add.toString());
      await DatebaseMethods().UpdateUserWellet(Id!,add.toString());
      showDialog(
        context: context,
         builder:(_)=>AlertDialog(
        content: Column(
          children: [
            Row(children: [
              Icon(Icons.check_circle,color:Colors.green,),
              Text("payment successfully"),
            ],
            ),
          ],
        ),
         ),
    );
    await getthesharedpref();
      paymentIntent=null;
    }).onError((error,stackTrace){
      print('Error is--->$error $stackTrace');
    });
}
on StripeException catch(e){
  print('Error is--->$e');
  showDialog(context: context, 
  builder: (_)=> const AlertDialog(
    content: Text("Cancelled"),
 ));
}catch(e){
  print('$e');
}
}
createPaymentIntent(String amount,String currency) async {
  try{
    Map<String,dynamic>body={
      'amount':calculateAmount(amount),
      'currency':currency,
      'payment_method_types[]':'card',
    };
    var response = await http.post(
      Uri.parse('https://api.stripe.com/v1/payment_intents'),
      headers:{
         'Authorization':'Bearer $Secretkey',
      'Content-Type':'application/x-www-form-urlencoded'
      },
      body:body,
    );
    print("Payment Intent Body->>> ${response.body.toString()}");
    return jsonDecode(response.body);
  }catch(err) {
    print('err charging user:${err.toString()}');
  }
}
calculateAmount(String amount){
  final calculatedAmount=(int.parse(amount)*100);
  return calculatedAmount.toString();
  }
  Future openEdit()=>showDialog(context: context, builder:(context)=> AlertDialog(
  content: SingleChildScrollView(
    child:Container(
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
    Row(children: [
      GestureDetector(
        onTap:(){
          Navigator.pop(context);
        },
        child:Icon(Icons.cancel),
      ),
      SizedBox(width:60.0,),
      Center(
        child: Text("add money",
        style:TextStyle(
          color:Color(0xFF008080),
          fontWeight: FontWeight.bold,
        ),
        ),
      ),
    ],
    ),
    SizedBox(height:20.0,),
    Text("Amount"),
    SizedBox(height:10.0,),
    Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        border:Border.all(color:Colors.black,width:2.0,),
        borderRadius: BorderRadius.circular(10)),
        child:TextField(
          controller: amountcontroller,
          decoration: InputDecoration(border: InputBorder.none,hintText:"Enter amount"),
        ),
      ),
      SizedBox(height: 20.0,),
      GestureDetector(
        onTap:(){
Navigator.pop(context);
makePayment(amountcontroller.text);
        },
    child:  Container(
        width:100,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color:Color(0xff008080),
          borderRadius: BorderRadius.circular(10),
        ),
        child:Center(
          child:Text(
            "Pay",
            style: TextStyle(color:Colors.black),
          ),
        ),
      ),
      ),
        ],
    ),
      ),
    ),
  ),
  );
  }