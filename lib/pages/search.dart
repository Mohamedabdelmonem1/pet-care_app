import 'package:petcare_app/helper/end_points.dart';
import 'package:petcare_app/helper/remote/dio_helper.dart';
import 'package:petcare_app/models/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MySearch extends StatefulWidget {
  const MySearch({Key? key}) : super(key: key);

  @override
  State<MySearch> createState() => _SearchState();
}

class _SearchState extends State<MySearch> {
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                    hintText: 'Search Tech Talk',
                  ),
                  // onTap: ()=>mySearch(search.text),
                  onSubmitted: (s) => mySearch(s),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: myResult.isEmpty
                      ? SizedBox()
                      : Container(
                          height: 600,
                          width: double.infinity,
                          child: ListView.builder(
                            itemCount: myResult.length,
                            itemBuilder: (context, index) => Container(
                              width: 200.w,
                              height: 300.h,
                              child: Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 7,
                                margin: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 12,
                                        ),
                                        ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15),
                                          ),
                                          child: Image.network(
                                            '${AppEndPoints.imageBaseURL}${myResult[index].img}',
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
                                              myResult[index]
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
                                            "Instock : ${myResult[index].stock.toString()}",
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 20.sp,
                                              color: Colors.black,
                                            )),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              child: Text(
                                                  "Price : ${myResult[index].price}",
                                                  style: TextStyle(
                                                      fontSize: 20.sp,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 25.h,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )),
            ],
          ),
        ),
      ),
    );
  }

  List<Recommendation> myResult = [];

  mySearch(search) async {
    myResult.clear();
    await DioHelper.getData(
      url: AppEndPoints.search,
      query: {
        "search": search.toString(),
      },
    ).then((value) {
      value.data['products'].forEach((e) {
        myResult.add(Recommendation.fromJson(e));
      });
      setState(() {
        myResult;
      });
      print('success');
    }).catchError((err) {
      print('error');
      print(err.toString());
    });
  }
}
