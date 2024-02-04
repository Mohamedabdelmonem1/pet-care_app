import 'package:carousel_slider/carousel_slider.dart';
import 'package:petcare_app/helper/constants.dart';
import 'package:petcare_app/helper/end_points.dart';
import 'package:petcare_app/helper/remote/dio_helper.dart';
import 'package:petcare_app/helper/snack_helper.dart';
import 'package:petcare_app/models/cart_item.dart';
import 'package:petcare_app/models/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class shop extends StatefulWidget {
  const shop({Key? key}) : super(key: key);

  @override
  State<shop> createState() => _shopState();
}

class _shopState extends State<shop> {
  String? recommendedUser;
  bool showMessage = false;
  Future<String> getRecommendedUser() async {
    return "Alice";
  }

  void showMessageWithUser(String user) {
    setState(() {
      showMessage = true;
      recommendedUser = user;
    });
    Future.delayed(const Duration(seconds: 15), () {
      setState(() {
        showMessage = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getProducts(50);
    getMyCart();
    Future.delayed(const Duration(seconds: 10), () async {
      String user = await getRecommendedUser();
      showMessageWithUser(user);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              showMessage = false;
            });
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Color(0xffD4D2D2),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      showMessage && recommendation != null
                          ? SizedBox()
                          : SizedBox(),
                      Container(
                          height: 210.h,
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
                              aspectRatio:
                                  1.7, // or any other desired aspect ratio
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 3),
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              scrollDirection: Axis.horizontal,
                            ),
                          )),
                      Container(
                        child: GridView.builder(
                          shrinkWrap: true,
                          clipBehavior: Clip.hardEdge,
                          physics: BouncingScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  mainAxisExtent: 340.h,
                                  maxCrossAxisExtent: 285,
                                  childAspectRatio: 2.76 / 5,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5),
                          itemBuilder: (context, index) => Container(
                            width: 200.w,
                            height: 150.h,
                            child: Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 7,
                              margin: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                        ),
                                        child: Image.network(
                                          '${AppEndPoints.imageBaseURL}${myProducts[index].img}',
                                          height: 150.h,
                                          width: 180.w,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5.h),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Center(
                                        child: Text(
                                            myProducts[index]
                                                .title!
                                                .toUpperCase(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 25.sp,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      SizedBox(height: 5.h),
                                      Text(
                                          "Instock : ${myProducts[index].stock.toString()}",
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 20.sp,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                  "price : ${myProducts[index].price} El",
                                                  style: TextStyle(
                                                      fontSize: 20.sp,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      TextButton.icon(
                                        onPressed: () {
                                          addToCart(myProducts[index].id);
                                        },
                                        label: Text("Add to cart",
                                            style: TextStyle(
                                                fontSize: 20.sp,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold)),
                                        icon: Icon(
                                          Icons.shopping_cart_checkout_outlined,
                                          color: Colors.red,
                                          size: 40,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          itemCount: myProducts.length,
                        ),
                      ),
                    ],
                  ),
                ),
                if (showMessage)
                  Center(
                    child: Container(
                      width: 250,
                      height: 300,
                      decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                                child: Image(
                                  image: NetworkImage(
                                      '${AppEndPoints.imageBaseURL}${recommendation!.img}'),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 140,
                                ),
                              ),
                              Positioned(
                                right: 10,
                                top: 5,
                                child: IconButton(
                                    color: Colors.red,
                                    onPressed: () {
                                      setState(() {
                                        showMessage = false;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      size: 50,
                                    )),
                              ),
                            ],
                          ),
                          Center(
                              child: Text(
                            recommendation!.title.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          )),
                          SizedBox(
                            height: 2,
                          ),
                          Text("Price : ${recommendation!.price.toString()}",
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          TextButton.icon(
                            onPressed: () {
                              addToCart(myProducts[1].id);
                            },
                            label: Text("Add to cart",
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            icon: Icon(
                              Icons.shopping_cart_checkout_outlined,
                              color: Colors.red,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        getProducts(1);
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Dog',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        getProducts(2);
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Cat',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        getProducts(3);
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Fish',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        getProducts(5);
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Bird',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        getProducts(4);
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Hamster',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          child: Icon(Icons.category_outlined),
          backgroundColor: Color(0xff182747),
        ),
      ),
    );
  }

  List<Recommendation> myProducts = [];

  Recommendation? recommendation;
  getProducts(int categoryId) async {
    myProducts.clear();
    print('getProducts');
    await DioHelper.getData(
      url: AppEndPoints.products,
    ).then((value) {
      if (categoryId == 50) {
        value.data['products'].forEach((e) {
          myProducts.add(Recommendation.fromJson(e));
        });
        recommendation = Recommendation.fromJson(value.data['recommendation']);
        print(recommendation);
      }
      // TODO : add your category with your id
      if (categoryId == 1) {
        value.data['products'].forEach((e) {
          if (e['category_id'] == 1) myProducts.add(Recommendation.fromJson(e));
        });
      }
      if (categoryId == 2) {
        value.data['products'].forEach((e) {
          if (e['category_id'] == 2) myProducts.add(Recommendation.fromJson(e));
        });
      }
      if (categoryId == 3) {
        value.data['products'].forEach((e) {
          if (e['category_id'] == 3) myProducts.add(Recommendation.fromJson(e));
        });
      }
      if (categoryId == 4) {
        value.data['products'].forEach((e) {
          if (e['category_id'] == 4) myProducts.add(Recommendation.fromJson(e));
        });
      }
      if (categoryId == 5) {
        value.data['products'].forEach((e) {
          if (e['category_id'] == 5) myProducts.add(Recommendation.fromJson(e));
        });
      }

      print(myProducts.length);
      setState(() {
        myProducts;
      });
    }).catchError((err) {});
  }

  getMyCart() async {
    print('start get my cart');
    await DioHelper.getData(
      url: AppEndPoints.getMyCart,
      token: globalUser!.token,
    ).then((value) {
      value.data['cartItems'].forEach((e) {
        CartItemsForBadges.add(CartItem.fromJson(e));
      });
      setState(() {
        CartItemsForBadges;
      });
    }).catchError((err) {
      showSnackBar(
          context: context, text: 'Erro in get My Cart', clr: Colors.red);
    });
  }

  addToCart(product_id) async {
    DioHelper.postData(
      url: AppEndPoints.addToCart,
      data: {
        "product_id": product_id,
      },
      token: globalUser!.token,
    ).then((value) {
      showSnackBar(context: context, text: 'add success', clr: Colors.green);
      getMyCart();
    }).catchError((err) {
      showSnackBar(context: context, text: 'Try Again', clr: Colors.red);
      print(err.toString());
    });
  }
}
