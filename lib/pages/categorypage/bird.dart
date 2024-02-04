import 'package:petcare_app/helper/constants.dart';
import 'package:petcare_app/helper/end_points.dart';
import 'package:petcare_app/helper/remote/dio_helper.dart';
import 'package:petcare_app/models/sub_categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'birddata.dart';

class Bird extends StatefulWidget {
  int? petId;
  Bird({@required this.petId});
  @override
  State<Bird> createState() => _BirdState();
}

class _BirdState extends State<Bird> {
  @override
  void initState() {
    // TODO: implement initState
    getSubCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Color(0xffD4D2D2),
        ),
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: IconButton(
                  onPressed: () {
                    setState(
                      () {
                        mySubCategory;
                      },
                    );
                  },
                  icon: Icon(Icons.refresh),
                ),
              ),
              Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                    color: Colors.white12,
                    border: Border.all(width: 1.5),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                margin: EdgeInsets.all(10),
                child: IconButton(
                    padding: EdgeInsets.only(right: 1.5, bottom: 1.5),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      size: 25,
                    )),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: mySubCategory.length,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  mainAxisExtent: 230,
                  maxCrossAxisExtent: 230,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, i) {
                  return InkWell(
                      onTap: () {
                        setState(() {
                          globalPet = mySubCategory[i];
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BirdData(),
                          ),
                        );
                      },
                      child: Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25)),
                          child: Column(
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    topRight: Radius.circular(25),
                                  ),
                                  child: Image.network(
                                    '${AppEndPoints.imageBaseURL}${mySubCategory[i].img}',
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Center(
                                child: Text("${mySubCategory[i].name}",
                                    style: TextStyle(
                                        fontSize: 27.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                            ],
                          )));
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<SubCategory> mySubCategory = [];

  getSubCategories() async {
    print('start Get SubCategory');
    await DioHelper.getData(
      url: '${AppEndPoints.getSubCategories}/5',
      token: globalUser!.token,
    ).then((value) {
      print('Get SubCategory');
      value.data['subCategories'].forEach((e) {
        mySubCategory.add(SubCategory.fromJson(e));
      });
      print('Get SubCategory Success');
      print(mySubCategory.length);
      print(mySubCategory);
    }).catchError((err) {
      print('Get SubCategory Error');
      print(err.toString());
    });
  }
}
