//class DatabaseMethods {
  import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatebaseMethods{
  Future addUserDetail(Map<String,dynamic>UserInfoMap,String id)async{
  return await FirebaseFirestore.instance
   .collection("user")
   .doc(id)
   .set(UserInfoMap);
}
UpdateUserWellet(String id,String amount)async{
  return await FirebaseFirestore.instance
   .collection("user")
   .doc(id)
   .update({"wellet":amount});
}
Future addproductItem(Map<String,dynamic>userInfoMap,String name)async{
  return await FirebaseFirestore.instance
   .collection("name")
   .add(userInfoMap);
}
Future<Stream<QuerySnapshot>>getCategoris(String name)async{
  return await FirebaseFirestore.instance.collection(name).snapshots();
}

  Future addproducttoCart(Map<String,dynamic>UserInfoMap,String id)async{
  return await FirebaseFirestore.instance
   .collection("user")
   .doc(id)
   .collection("Cart")
   .add(UserInfoMap);
}
Future<Stream<QuerySnapshot>>getproductcart(String id)async{
  return await FirebaseFirestore.instance.collection("user").doc(id).collection("Cart").snapshots();
}
// Future addproducttolist(Map<String,dynamic>WishlistInfoMap,String id)async{
Future addproducttolist(Map<String,dynamic>WishlistInfoMap,String id,productId)async{
   return await FirebaseFirestore.instance
   .collection("user")
   .doc(id)
   //.doc(prodectid)
   .collection("Wishlist")
   .doc(productId)
   .set(WishlistInfoMap);
}
Future<Stream<QuerySnapshot>>getproductlist(String id)async{
  return await FirebaseFirestore.instance.collection("user").doc(id).collection("Wishlist").snapshots();
}
 Future deleteWishlistProduct(String userId, String productId) async {
    return await FirebaseFirestore.instance
       .collection("user")
       .doc(userId)
       .collection("Wishlist")
       .doc(productId)
       .delete();
  }
}