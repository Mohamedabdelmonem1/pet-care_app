import 'package:petcare_app/auth/signin.dart';
import 'package:petcare_app/helper/constants.dart';
import 'package:petcare_app/helper/end_points.dart';
import 'package:petcare_app/helper/remote/dio_helper.dart';
import 'package:petcare_app/helper/snack_helper.dart';
import 'package:petcare_app/models/cart_item.dart';
import 'package:petcare_app/pages/doctorpage/doctors.dart';
import 'package:petcare_app/pages/profile/profile.dart';
import 'package:petcare_app/pages/search.dart';
import 'package:petcare_app/pages/about.dart';
import 'package:petcare_app/pages/services.dart';
import 'package:petcare_app/pages/shop/carts.dart';
import 'package:petcare_app/pages/shop/shop.dart';
import 'package:petcare_app/vet/clinic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../trader/AddProdect.dart';
import '../trader/MyProdect.dart';
import 'categorypage/category.dart';
import 'doctorpage/my_booking.dart';
import 'doctorpage/notification.dart';
import 'home.dart';
import 'package:badges/badges.dart' as badges;

class home_management extends StatefulWidget {
  home_management({Key? key, this.type, this.index}) : super(key: key);
  var type;
  var index;

  @override
  State<home_management> createState() => _home_managementState();
}

class _home_managementState extends State<home_management> {
  final items = <Widget>[
    Icon(Icons.shopping_cart, size: 40),
    Icon(Icons.dashboard_customize_outlined, size: 40),
    Icon(
      Icons.home,
      size: 40,
    ),
    Icon(
      Icons.pets,
      size: 40,
    ),
    Icon(Icons.person_pin, size: 40),
  ];

  int index = 0;
  List<Widget> pages = [shop(), category(), home(), doctors(), Profile()];
  var name = ["My Booking", "Vet Booking", "My Booking"];

  @override
  void initState() {
    // TODO: implement initState
    getMyCart();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var value = await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  "Alert",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                content: Text(
                  "Do you want to Exit?",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                actions: [
                  Container(
                    width: 70,
                    child: MaterialButton(
                        color: Color(0xff269A41),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text(
                          "No",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ),
                  Container(
                    width: 70,
                    child: MaterialButton(
                        color: Color(0xff269A41),
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: Text(
                          "Yes",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  )
                ],
              );
            });
        if (value != null) {
          return Future.value(value);
        } else {
          return Future.value(false);
        }
      },
      child: SafeArea(
          child: Scaffold(
              appBar: AppBar(
                  backgroundColor: (Color(0xff182747)),
                  title: Container(
                    margin: EdgeInsets.only(left: 80),
                    child: SvgPicture.asset(
                      "images/4.svg",
                      width: 50,
                      height: 50,
                    ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Notifi(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.notifications,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MySearch()));
                      },
                      icon: Icon(
                        Icons.search,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => cart(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                  ]),
              drawer: Container(
                child: Drawer(
                    backgroundColor: Colors.grey[400],
                    width: 230,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 55,
                        ),
                        Container(
                          width: double.infinity,
                          color: Color(0xff182747),
                          child: ListTile(
                            title: MaterialButton(
                                onPressed: () {
                                  if (widget.type == "Customer") {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MyBooking(),
                                        ));
                                  }
                                  if (widget.type == "Trader") {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MyBooking(),
                                        ));
                                  }
                                  if (widget.type == "Vet") {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => clinic(),
                                        ));
                                  }
                                },
                                child: Text(
                                  name[widget.index],
                                  style: TextStyle(color: Colors.white),
                                )),
                            leading: Icon(
                              Icons.bookmark_added,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        if (widget.type == "Customer" || widget.type == "Vet")
                          Container()
                        else
                          Container(
                            width: double.infinity,
                            color: Color(0xff182747),
                            child: ListTile(
                              title: MaterialButton(
                                  onPressed: () {
                                    if (widget.type == "Trader") {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => AddProdect(),
                                          ));
                                    }
                                  },
                                  child: Text(
                                    "Add_prodects",
                                    style: TextStyle(color: Colors.white),
                                  )),
                              leading: Icon(
                                Icons.add_circle,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        if (widget.type == "Customer" || widget.type == "Vet")
                          SizedBox()
                        else
                          SizedBox(
                            height: 10,
                          ),
                        if (widget.type == "Customer" || widget.type == "Vet")
                          Container()
                        else
                          Container(
                            width: double.infinity,
                            color: Color(0xff182747),
                            child: ListTile(
                              title: MaterialButton(
                                  onPressed: () {
                                    if (widget.type == "Trader") {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MyProdect(),
                                          ));
                                    }
                                  },
                                  child: Text(
                                    "My_Prodect",
                                    style: TextStyle(color: Colors.white),
                                  )),
                              leading: Icon(
                                Icons.add_business_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        if (widget.type == "Customer" || widget.type == "Vet")
                          SizedBox()
                        else
                          SizedBox(
                            height: 10,
                          ),
                        Container(
                          color: Color(0xff182747),
                          child: ListTile(
                            leading: Icon(
                              Icons.miscellaneous_services,
                              color: Colors.white,
                            ),
                            title: Text(
                              "Services",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            onTap: () {
                              Navigator.of(context).push(PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        Services(),
                              ));
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          color: Color(0xff182747),
                          child: ListTile(
                            leading: Icon(
                              Icons.add_box_outlined,
                              color: Colors.white,
                            ),
                            title: Text(
                              "About",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).push(PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        About(),
                              ));
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          color: Color(0xff182747),
                          child: ListTile(
                            leading: Icon(
                              Icons.exit_to_app,
                              color: Colors.white,
                            ),
                            title: Text(
                              "Log Out",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Signin()));
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    )),
              ),
              body: CupertinoTabScaffold(
                tabBar: CupertinoTabBar(
                  height: 60,
                  backgroundColor: Colors.black,
                  inactiveColor: Colors.white,
                  activeColor: Color(0xff269A41),
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.shop_2_outlined,
                      ),
                      label: "Shop",
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.dashboard_customize_outlined),
                        label: "Category"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: "Home"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.medical_information), label: "Doctor"),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person_pin),
                      label: "Profile",
                    ),
                  ],
                ),
                tabBuilder: (BuildContext context, int index) {
                  switch (index) {
                    case 0:
                      return CupertinoTabView(
                        builder: (context) {
                          // if(widget.type=="Customer"){
                          return CupertinoPageScaffold(child: shop());
                          // }if(widget.type=="Trader")
                          // { return  CupertinoPageScaffold(child: shop_trader());}
                          // if(widget.type=="Vet"){
                          //   return CupertinoPageScaffold(child: shop());
                          // }else{return CupertinoPageScaffold(child: error());};
                        },
                      );
                    case 1:
                      return CupertinoTabView(
                        builder: (context) {
                          return CupertinoPageScaffold(child: category());
                        },
                      );
                    case 2:
                      return CupertinoTabView(
                        builder: (context) {
                          return CupertinoPageScaffold(child: home());
                        },
                      );
                    case 3:
                      return CupertinoTabView(
                        builder: (context) {
                          //    if(widget.type=="Customer"){
                          return CupertinoPageScaffold(child: doctors());
                          //    }if(widget.type=="Trader"){ return  CupertinoPageScaffold(child: doctors());}
                          //    if(widget.type=="Vet"){
                          //      return CupertinoPageScaffold(child: clinic());
                          //    }else{return CupertinoPageScaffold(child: error());};
                        },
                      );
                    case 4:
                      return CupertinoTabView(
                        builder: (context) {
                          // if(widget.type=="Customer"){
                          return CupertinoPageScaffold(child: Profile());
                          // }if(widget.type=="Trader")
                          // { return  CupertinoPageScaffold(child: profile_trader());}
                          // if(widget.type=="Vet"){
                          //   return CupertinoPageScaffold(child: profile_vet());
                          // }else{return CupertinoPageScaffold(child: error());};
                        },
                      );
                    default:
                      return CupertinoTabView(
                        builder: (context) {
                          return CupertinoPageScaffold(child: MySearch());
                        },
                      );
                  }
                },
              ))),
    );
  }

  getMyCart() async {
    CartItemsForBadges.clear();
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
}
