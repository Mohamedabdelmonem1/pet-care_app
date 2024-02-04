import 'dart:io';
import 'package:dio/dio.dart';
import 'package:petcare_app/helper/constants.dart';
import 'package:petcare_app/helper/end_points.dart';
import 'package:petcare_app/helper/remote/dio_helper.dart';
import 'package:petcare_app/helper/snack_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../components.dart';

class AddProdect extends StatefulWidget {
  AddProdect({Key? key}) : super(key: key);

  @override
  State<AddProdect> createState() => _AddProdectState();
}

class _AddProdectState extends State<AddProdect> {
  var type;
  var gender;
  TextEditingController petName1 = TextEditingController();
  TextEditingController petPrice = TextEditingController();
  TextEditingController petCount = TextEditingController();
  var imagetwo;

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          color: Color(0xffD4D2D2),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              margin: EdgeInsets.only(top: 12),
              height: 600,
              decoration: BoxDecoration(color: Colors.grey[400]),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(right: 285.w, top: 5.h),
                        decoration: BoxDecoration(
                            color: Colors.orangeAccent,
                            borderRadius: BorderRadius.circular(10)),
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ))),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      width: 250.w,
                      height: 200.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              image: AssetImage("images/31.jpg"),
                              fit: BoxFit.fill)),
                      child: Center(
                          child: MaterialButton(
                        onPressed: () async {
                          var pickedImage = await ImagePicker()
                              .pickImage(source: ImageSource.camera);
                          if (pickedImage != null) {
                            setState(() {
                              imagetwo = File(pickedImage.path);
                            });
                          }
                        },
                        child: Container(
                          width: 340.w,
                          height: 200.h,
                          decoration: BoxDecoration(
                              color: Colors.white12,
                              borderRadius: BorderRadius.circular(25)),
                        ),
                      )),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 170.w,
                          height: 50.h,
                          child: defultForm(
                              Controller: petName1,
                              hintText: "Pet Name",
                              background: Colors.redAccent,
                              color: Colors.white),
                        ),
                        Container(
                          width: 170.w,
                          height: 50.h,
                          child: defultForm(
                              Controller: petPrice,
                              hintText: "price",
                              background: Colors.redAccent,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 175.w,
                          height: 50.h,
                          color: Colors.white,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              iconSize: 30,
                              hint: Text(
                                "   Type",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold),
                              ),
                              items: ["Accessories", "Pet", "Food", "Treatment"]
                                  .map((e) => DropdownMenuItem(
                                        child: Center(
                                          child: Text(
                                            "   $e",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 23.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        value: e,
                                      ))
                                  .toList(),
                              onChanged: (val) {
                                setState(() {
                                  type = val;
                                });
                              },
                              value: type,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 160.w,
                          height: 50.h,
                          color: Colors.white,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              iconSize: 30,
                              hint: Text(
                                "   Gender",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 23.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              items: ["Hamster", "Cat", "Dog", "Bird", "Fish"]
                                  .map((f) => DropdownMenuItem(
                                        child: Center(
                                          child: Text(
                                            "   $f",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 23,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        value: f,
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  gender = value;
                                });
                              },
                              value: gender,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Center(
                      child: Container(
                        width: 177.w,
                        height: 50.h,
                        child: defultForm(
                            Controller: petCount,
                            hintText: "No.product",
                            background: Colors.redAccent,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                        width: 228.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                            color: Colors.green),
                        child: MaterialButton(
                            onPressed: () {
                              addProduct(
                                category: gender.toString(),
                                type: type.toString(),
                                title: petName1.toString(),
                                price: petPrice.toString(),
                                stock: petCount.text,
                                img: imagetwo,
                              );
                            },
                            child: Text(
                              "add product",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30.sp,
                                  color: Colors.white),
                            )))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }

  addProduct({
    @required category,
    @required type,
    @required title,
    @required price,
    @required stock,
    @required img,
  }) async {
    print('start add product');

    FormData formData = FormData.fromMap({
      "category_id": categoryID(category: gender.toString()),
      "type": type.toString(),
      "title": petName1.text,
      "price": petPrice.text,
      "stock": petCount.text,
      "img": await MultipartFile.fromFile(imagetwo.path),
    });

    await DioHelper.postImage(
      url: AppEndPoints.addProduct,
      data: formData,
      token: globalUser!.token,
    ).then((value) {
      showSnackBar(context: context, text: 'Success Add', clr: Colors.green);
      Navigator.of(context).pop();
    }).catchError((err) {
      showSnackBar(
          context: context, text: 'Error To Add Product', clr: Colors.red);
      print(err.toString());
    });
    print('start add product');
  }

  String categoryID({@required String? category}) {
    if (category == 'Hamster') {
      return '5';
    }
    if (category == 'Cat') {
      return '2';
    }
    if (category == 'Dog') {
      return '1';
    }
    if (category == 'Bird') {
      return '4';
    }
    if (category == 'Fish') {
      return '3';
    }
    return '1';
  }
}
