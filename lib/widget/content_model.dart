class UnboardingContent{
  String title;
  String description;
  String image;
  UnboardingContent(
    {
      required this.title,required this.description, required this.image,
    }
  );
}
List<UnboardingContent> contents=[
UnboardingContent(
//image:"image/image-removebg-preview.png",
image:"images/image-removebg-preview.png",
title:"Shop from thousands\n     of products",
description:"Discover\n      Amazing \nProducts"),
UnboardingContent(
//image:"image/image-removebg-preview.png",
image:"images/3d-delivery-removebg-preview.png",
title:"         Fast delivery to\nyour doverstop",
description:"Get it\n     Deliverd \nFast"),

];