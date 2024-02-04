import 'package:petcare_app/helper/constants.dart';
import 'package:petcare_app/helper/end_points.dart';
import 'package:petcare_app/helper/remote/dio_helper.dart';
import 'package:petcare_app/helper/snack_helper.dart';
import 'package:petcare_app/models/products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyProdect extends StatefulWidget {
  var Pname;
  var Pprice;
  var Pcount;
  var Pimage;

  MyProdect({
    Key? key,
    this.dataone,
    this.datatwo,
    this.datathree,
    this.datafour,
    this.Pname,
    this.Pprice,
    this.Pcount,
    this.Pimage,
  }) : super(key: key);

  var dataone;
  var datatwo;
  var datathree;
  var datafour;

  @override
  State<MyProdect> createState() => _MyProdectState();
}

class _MyProdectState extends State<MyProdect> {
  @override
  void initState() {
    // TODO: implement initState
    getMyProducts();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                "My_Prodect",
                style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
              ),
            ),
            body: Container(
              color: myProducts.length == 0
                  ? Colors.transparent
                  : Color(0xffD4D2D2),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Row(
                    //       children: [
                    //         IconButton(
                    //             onPressed: () {
                    //               Navigator.of(context).push(
                    //                   MaterialPageRoute(builder: (c) => AddProdect()));
                    //             },
                    //             icon: Icon(
                    //               Icons.add_circle_outline,
                    //               size: 30,
                    //             )),
                    //         Text(
                    //           "Add prodect",
                    //           style:
                    //               TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
                    //         )
                    //       ],
                    //     ),
                    //   ],
                    // ),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.only(top: 6, bottom: 6),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1)),
                        child: myProducts.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemCount: myProducts.length,
                                itemBuilder: (context, index) {
                                  return Stack(
                                    children: [
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Container(
                                              width: double.infinity,
                                              height: 250.h,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width: 150.w,
                                                          height: 233.h,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            image:
                                                                DecorationImage(
                                                              image: NetworkImage(
                                                                  "${AppEndPoints.imageBaseURL}${myProducts[index].img}"),
                                                              // image: AssetImage(
                                                              //     "images/cat.jpg"),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Name :  ${myProducts[index].title}",
                                                          style: TextStyle(
                                                              fontSize: 20.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(
                                                          height: 25.h,
                                                        ),
                                                        Text(
                                                          "price :  ${myProducts[index].price}  LE",
                                                          style: TextStyle(
                                                              fontSize: 18.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(height: 25.h),
                                                        Text(
                                                          "Instock :  ${myProducts[index].stock}",
                                                          style: TextStyle(
                                                              fontSize: 18.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(height: 25.h),
                                                        Center(
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      10,
                                                                    ),
                                                                    color: Colors
                                                                        .red),
                                                            child:
                                                                MaterialButton(
                                                              onPressed: () {
                                                                deleteProduct(
                                                                    myProducts[
                                                                            index]
                                                                        .id!);
                                                              },
                                                              child: Text(
                                                                "Delete",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              )
                            : Center(
                                child: CircularProgressIndicator(),
                              ),
                      ),
                    )
                  ],
                ),
              ),
            )));
  }

  List<Recommendation> myProducts = [];

  getMyProducts() async {
    print('start get my products');
    await DioHelper.getData(
      url: AppEndPoints.getMyProducts,
      token: globalUser!.token,
    ).then((value) {
      value.data['products'].forEach((e) {
        myProducts.add(Recommendation.fromJson(e));
      });
      print(myProducts.length);
      setState(() {
        myProducts;
      });
    }).catchError((err) {
      showSnackBar(context: context, text: err.toString(), clr: Colors.red);
    });
    print('start get my products');
  }

  deleteProduct(int id) async {
    print('start delete');
    await DioHelper.deleteData(
      url: AppEndPoints.delete,
      token: globalUser!.token,
      data: {
        'id': id,
      },
    ).then((value) {
      showSnackBar(
          context: context, text: 'Success Deleted', clr: Colors.green);
    }).catchError((err) {
      print(err.toString());
    });
  }
}
