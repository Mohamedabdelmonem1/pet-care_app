import 'package:carousel_slider/carousel_slider.dart';
import 'package:petcare_app/components.dart';
import 'package:petcare_app/helper/constants.dart';
import 'package:petcare_app/helper/end_points.dart';
import 'package:petcare_app/helper/remote/dio_helper.dart';
import 'package:petcare_app/models/categories.dart';
import 'package:petcare_app/models/products.dart';
import 'package:petcare_app/models/vets.dart';
import 'package:petcare_app/pages/categorypage/cat.dart';
import 'package:petcare_app/pages/categorypage/category.dart';
import 'package:petcare_app/pages/categorypage/dog.dart';
import 'package:petcare_app/pages/categorypage/fish.dart';
import 'package:petcare_app/pages/shop/shop.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'doctorpage/doctors.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  bool icon = true;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    getVets();
    getCategories();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey[400],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Hello Dear",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                " Lets shop something!",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                  height: 250,
                  width: double.infinity,
                  child: CarouselSlider(
                    items: [
                      AssetImage("images/7.png"),
                      AssetImage("images/8.jpg"),
                      AssetImage("images/fish.jpg"),
                      AssetImage("images/dog1.jpg"),
                      AssetImage("images/bird.jpg"),
                    ].map((image) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Image(
                            image: image,
                            fit: BoxFit.fill,
                            width: double.infinity,
                          );
                        },
                      );
                    }).toList(),
                    options: CarouselOptions(
                      aspectRatio: 1, // or any other desired aspect ratio
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    ),
                  )),
              InkWell(
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (c) => shop())),
                child: ListTile(
                  title: Text(
                    "SHOP",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.green,
                      decorationThickness: 2,
                    ),
                  ),
                  trailing: Text("view all...",
                      style: TextStyle(
                          fontSize: 21, color: Colors.deepOrangeAccent)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 380,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,
                  ),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) => Container(
                      width: 200,
                      height: 350,
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 7,
                        margin: EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                    ),
                                    child: myProducts[index].img != null
                                        ? Image.network(
                                            "${AppEndPoints.imageBaseURL}${myProducts[index].img}",
                                            height: 215,
                                            width: 180,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            "images/doc1.jpg",
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Column(
                                children: [
                                  Center(
                                    child: Text(
                                      myProducts[index].title!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    myProducts[index].type!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 122,
                                        child: Column(
                                          children: [
                                            Text(
                                              myProducts[index].price!,
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      width: 1,
                    ),
                    itemCount: myProducts.length,
                  ),
                ),
              ),
              // SizedBox(height: 300,),
              InkWell(
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (c) => doctors())),
                child: ListTile(
                  title: Text(
                    "Doctor",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.green,
                      decorationThickness: 2,
                    ),
                  ),
                  trailing: Text("view all...",
                      style: TextStyle(
                          fontSize: 21, color: Colors.deepOrangeAccent)),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 260,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,
                  ),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) => Container(
                      width: 200,
                      height: 270,
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        elevation: 7,
                        margin: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(23),
                                    topRight: Radius.circular(18),
                                  ),
                                  child: myVets[index].img != null
                                      ? Image.network(
                                          "${AppEndPoints.imageBaseURL}${myVets[index].img}",
                                          height: 200,
                                          width: 180,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          "images/doc1.jpg",
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Center(
                              child: Text(
                                "Dr.${myVets[index].firstname} ${myVets[index].lastname}",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      width: 1,
                    ),
                    itemCount: myVets.length,
                  ),
                ),
              ),
              InkWell(
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (c) => category())),
                child: ListTile(
                  title: Text(
                    "CATEGORY",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.green,
                      decorationThickness: 2,
                    ),
                  ),
                  trailing: Text("view all...",
                      style: TextStyle(
                          fontSize: 21, color: Colors.deepOrangeAccent)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 280,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,
                  ),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) => Container(
                      width: 200,
                      height: 270,
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 7,
                        margin: EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                    ),
                                    child: Image.network(
                                      '${AppEndPoints.imageBaseURL}${myCategories[index].img}',
                                      height: 210,
                                      width: 180,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Column(
                                children: [
                                  Center(
                                    child: Text(
                                      "${myCategories[index].name}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      width: 1,
                    ),
                    itemCount: myCategories.length,
                  ),
                ),
              ),

              Container(
                decoration: BoxDecoration(
                  color: Colors.black87,
                ),
                height: 260.h,
                width: double.infinity.w,
                child: Padding(
                  padding: EdgeInsets.only(top: 25.h, left: 13.w),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pet Care",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              color: Colors.green,
                              width: 30.w,
                              height: 3.h,
                            ),
                            SizedBox(
                              height: 11.h,
                            ),
                            Text(
                              "A App for people who ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.sp,
                                  letterSpacing: 1),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              "interested in pets,you ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.sp,
                                  letterSpacing: 1),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              " can find all what you ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.sp,
                                  letterSpacing: 1),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              "need(pets,food,acce..",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.sp,
                                  letterSpacing: 1),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              "ssories,and medicine)",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.sp,
                                  letterSpacing: 1),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Have a Question?",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              color: Colors.green,
                              width: 30.w,
                              height: 3.h,
                            ),
                            SizedBox(height: 6.h),
                            Container(
                              width: 199.w,
                              child: ListTile(
                                leading: Icon(
                                  Icons.place_outlined,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                title: Text(
                                  "203 Fake St.mansouer,",
                                  style: TextStyle(color: Colors.white),
                                ),
                                subtitle: Text(
                                  "El-Dakahila,Egypt",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            Container(
                              width: 199.w,
                              child: ListTile(
                                leading: Icon(
                                  Icons.phone,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                title: Text(
                                  "+20 1234567890",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            Container(
                              width: 199.w,
                              child: ListTile(
                                leading: Icon(
                                  Icons.telegram,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                title: Text(
                                  "info@yourdomain.com",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),

                            // SizedBox(height: 2,),
                            // Text(" can find all what you ",style: TextStyle(color: Colors.white),),
                            // SizedBox(height: 2,),
                            // Text("need(pets,food,acce..",style: TextStyle(color: Colors.white),),
                            // SizedBox(height: 2,),
                            // Text("ssories,and medicine)",style: TextStyle(color: Colors.white),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }

  List<Vet> myVets = [];

  getVets() async {
    print('start get Vets');
    await DioHelper.getData(url: AppEndPoints.getVets).then((value) {
      value.data['vets'].forEach((e) {
        myVets.add(Vet.fromJson(e));
      });
      print(myVets.length);
      setState(() {
        myVets;
      });
    }).catchError((err) {
      print('get Vets Error');
      print(err.toString());
    });
  }

  List<Category> myCategories = [];

  getCategories() async {
    print('Start Get Category');
    await DioHelper.getData(
      url: AppEndPoints.getCategories,
      token: globalUser!.token,
    ).then((value) {
      print('get Categories');
      print(value.data);
      value.data['categories'].forEach((e) {
        myCategories.add(Category.fromJson(e));
      });
      print(myCategories.length);
      print(myCategories);
      print('get Categories Success');
      setState(() {
        myCategories;
      });
    }).catchError((err) {
      print('get Categories Error');
      print(err.toString());
    });
  }

  Widget? buildCategoryCard(Category category) {
    if (category.name == 'Dogs') {
      return InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (c) => Dog(
              petId: category.id!,
            ),
          ),
        ),
        child: categ(
          name: category.name,
          image: category.img,
          context: context,
        ),
      );
    }
    if (category.name == 'Cats') {
      return InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (c) => Cat1(
              petId: category.id!,
            ),
          ),
        ),
        child: categ(
          name: category.name,
          image: category.img,
          context: context,
        ),
      );
    }
    if (category.name == 'Fish') {
      return InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (c) => Fish(
              petId: category.id!,
            ),
          ),
        ),
        child: categ(
          name: category.name,
          image: category.img,
          context: context,
        ),
      );
    }
    return null;
  }

  List<Recommendation> myProducts = [];
  getProducts() async {
    print('getProducts');
    await DioHelper.getData(
      url: AppEndPoints.products,
    ).then((value) {
      value.data['products'].forEach((e) {
        myProducts.add(Recommendation.fromJson(e));
      });
      print(myProducts.length);
      setState(() {
        myProducts;
      });
    }).catchError((err) {});
  }
}
