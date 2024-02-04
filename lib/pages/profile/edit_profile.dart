import 'dart:io';
import 'package:dio/dio.dart';
import 'package:petcare_app/components.dart';
import 'package:petcare_app/helper/constants.dart';
import 'package:petcare_app/helper/end_points.dart';
import 'package:petcare_app/helper/remote/dio_helper.dart';
import 'package:petcare_app/helper/snack_helper.dart';
import 'package:petcare_app/models/pets.dart';
import 'package:petcare_app/pages/profile/add_animal.dart';
import 'package:petcare_app/pages/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:slide_countdown/slide_countdown.dart';

class edit_profile extends StatefulWidget {
  edit_profile(
      {Key? key,
      this.petimage,
      this.petName,
      this.time,
      this.nameed,
      this.phoneed,
      this.addressed})
      : super(key: key);
  var petimage;
  var petName;
  var time;
  var nameed;
  var phoneed;
  var addressed;

  @override
  State<edit_profile> createState() => _edit_profileState();
}

class _edit_profileState extends State<edit_profile> {
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    getMyAnimals();
  }

  var image;
  var nameController;
  var addressController;
  var phoneController;
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffD4D2D2),
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(
              "images/pro4.jpg",
              height: 180,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Profile()));
                          },
                          icon: Icon(Icons.arrow_back))),
                  Container(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () {
                            var formdata = formKey.currentState;
                            if (formdata!.validate()) {
                              formdata.save();
                              print("valid");
                              updateProfile(
                                firstname: nameController.toString(),
                                lastname: '',
                                address: addressController.toString(),
                              );
                            } else {
                              print("not valid");
                            }
                          },
                          icon: Icon(
                            Icons.task_alt_outlined,
                            size: 40,
                          ))),
                  // upload image
                  Container(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () async {
                            if (image != null) {
                              uploadImage(image);
                            } else {
                              print("not valid");
                            }
                          },
                          icon: Icon(
                            Icons.task_alt_outlined,
                            size: 40,
                          ))),
                  Center(
                      child: Stack(
                    children: [
                      image == null
                          ? Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("images/photo.jpg"),
                                      fit: BoxFit.cover),
                                  border:
                                      Border.all(color: Colors.black, width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(140))),
                              width: 190,
                              height: 190)
                          : CircleAvatar(
                              radius: 95,
                              backgroundImage: FileImage(image),
                            ),
                      Positioned(
                        bottom: 1,
                        top: 144,
                        left: 120,
                        child: IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      height: 200,
                                      child: Column(
                                        children: [
                                          Container(
                                            child: Text(
                                              "Choose photo from",
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          MaterialButton(
                                            onPressed: () async {
                                              var pickedImage =
                                                  await ImagePicker().pickImage(
                                                      source:
                                                          ImageSource.camera);
                                              if (pickedImage != null) {
                                                setState(() {
                                                  image =
                                                      File(pickedImage.path);
                                                });
                                                Navigator.pop(context);
                                              }
                                            },
                                            child: Row(
                                              children: [
                                                Icon(Icons.camera),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  " camera",
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          MaterialButton(
                                            onPressed: () async {
                                              var pickedImage =
                                                  await ImagePicker().pickImage(
                                                      source:
                                                          ImageSource.gallery);
                                              if (pickedImage != null) {
                                                setState(() {
                                                  image = pickedImage;
                                                  // File(pickedImage.path);
                                                });

                                                Navigator.pop(context);
                                              }
                                            },
                                            child: Row(
                                              children: [
                                                Icon(Icons.photo_outlined),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  " gallery",
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  });
                            },
                            icon: Icon(
                              Icons.camera_alt,
                              size: 43,
                              color: Colors.white,
                            )),
                      ),
                    ],
                  )),
                  SizedBox(
                    height: 15,
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            "@${globalUser!.user!.username}",
                            style: TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                            alignment: Alignment.topLeft,
                            height: 60,
                            child: defultForm(
                                initialvalue: globalUser!.user!.firstname! +
                                    globalUser!.user!.lastname!,
                                onsaved: (val) {
                                  nameController = val;
                                },
                                validator: (value) =>
                                value.isEmpty ? "enter a valid Name" : null)),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            " Phone",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            alignment: Alignment.topLeft,
                            child: defultForm(
                              initialvalue: globalUser!.user!.contactNumber,
                              onsaved: (val) {
                                phoneController = val;
                              },
                              validator: (value) =>
                                  value.isEmpty ? "enter a valid Phone" : null,
                            )),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            " Address",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                            alignment: Alignment.topLeft,
                            child: defultForm(
                              initialvalue: globalUser!.user!.address,
                              onsaved: (val) {
                                addressController = val;
                              },
                              validator: (value) => value.isEmpty
                                  ? "enter a valid Address"
                                  : null,
                            )),
                        SizedBox(
                          height: 12,
                        ),
                        Center(
                            child: Container(
                          width: 370.w,
                          height: 300.h,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 2, color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 12.h,
                              ),
                              SizedBox(
                                width: 75.w,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    width: 75,
                                  ),
                                  Center(
                                      child: Text("My animals",
                                          style: TextStyle(
                                              wordSpacing: 2,
                                              decorationThickness: 3,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold))),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (c) =>
                                                        add_animal()));
                                          },
                                          icon: Icon(
                                            Icons.add_circle_outline,
                                            size: 30,
                                          )),
                                      Text(
                                        "add",
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                width: 90.w,
                                height: 5.h,
                                color: Colors.green,
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              myPets.length > 0
                                  ? Container(
                                      height: 250,
                                      child: ListView.builder(
                                        itemCount: myPets.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return buildAnimalCard(myPets[index]);
                                        },
                                      ),
                                    )
                                  : SizedBox(),
                            ],
                          ),
                        )),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Pet> myPets = [];

  getMyAnimals() async {
    print('start get my pets');
    await DioHelper.getData(
      url: AppEndPoints.getUserPets,
      token: globalUser!.token,
    ).then((value) {
      print(value.data);
      value.data['pets'].forEach((e) {
        myPets.add(Pet.fromJson(e));
      });
      print(myPets.length);
      print(myPets);
      setState(() {
        myPets;
      });
    }).catchError((err) {
      print('error in get my pets');
      print(err.toString());
    });
  }

  Widget buildAnimalCard(Pet pet) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        height: 100,
        width: 50,
        color: Colors.red,
        child: Icon(
          Icons.delete,
          size: 60.h,
          color: Colors.white,
        ),
      ),
      // vertical
      direction: DismissDirection.vertical,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: 13, top: 10, bottom: 10),
            width: 199,
            height: 210,
            alignment: Alignment.topRight,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image:
                        NetworkImage('${AppEndPoints.imageBaseURL}${pet.img}'),
                    fit: BoxFit.cover),
                border: Border.all(width: 2, color: Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Padding(
              padding: EdgeInsets.all(1.0),
              child: SlideCountdown(
                duration: Duration(days: calcSlideDown(pet)),
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                calcSlideDown(pet);
              },
              icon: Icon(Icons.add_business)),
          Positioned(
            bottom: 11,
            right: 1,
            left: 15,
            child: Center(
              child: Container(
                height: 35,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                      )
                    ],
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15))),
                width: 197,
                child: Center(
                  child: Text(
                    pet.name!,
                    style: TextStyle(
                        color: Colors.red,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.green,
                        decorationThickness: 2,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  int calcSlideDown(Pet pet) {
    DateTime now = DateTime.now();
    DateTime yourDate = DateTime.parse(
        pet.vaccines.toString()); // تحتاج إلى توفير قيمة pet.vaccines

    Duration difference = yourDate.difference(now);
    int daysDiff = difference.inDays + 2;
    print(' daysDiff  The number of days between the two dates is: $daysDiff');
    return daysDiff;

    //   // print(pet.vaccines.day.toInt() - DateTime.now().day.toInt());
    //   int res = pet.vaccines.day.toInt() - DateTime.now().day.toInt();
    //   if (res < 0) {
    //     res *= -1;
    //   }
    //   return res;
  }


  updateProfile({
    @required firstname,
    @required lastname,
    @required address,
  }) async {
    print('start update profile');
    print(firstname.toString());
    print('my token : ${globalUser!.token}');
    print(lastname.toString());
    print(address.toString());
    await DioHelper.putData(
      url: AppEndPoints.updateProfile,
      data: {
        "firstname": firstname.toString(),
        "lastname": '',
        "address": address.toString(),
      },
      token: globalUser!.token,
    ).then((value) {
      // login(email: globalUser.user.email, password: userPassword);
      showSnackBar(
          context: context, text: 'updated success', clr: Colors.green);
      Navigator.of(context).pop();
    }).catchError((err) {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => Profile(),));
      // showSnackBar(context: context, text: 'updated Error', clr: Colors.red);
      print(err.toString());
    });
  }

  uploadImage(File file) async {
    print('start upload');
    final res = await MultipartFile.fromFile(file.path, filename: 'file.jpg');
    print(file.path);
    var formData = FormData.fromMap({
      'img': await MultipartFile.fromFile(file.path, filename: 'fileName'),
    });
    print(file.path);
    var fileName = file.path.split('/').last;

    var finalResult = await MultipartFile.fromFile(file.path);
    // FormData formData = FormData.fromMap({
    //   "img": finalResult,
    // });

    await DioHelper.postImage(
      url: AppEndPoints.changeImage,
      token: globalUser!.token,
      data: formData,
    ).then((value) {
      showSnackBar(
          context: context, text: 'upload image success', clr: Colors.green);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Profile()));
    }).catchError((err) {
      showSnackBar(
          context: context, text: 'upload image failed', clr: Colors.red);
      print(err.toString());
    });
  }
}
