import 'package:petcare_app/helper/constants.dart';
import 'package:petcare_app/helper/end_points.dart';
import 'package:petcare_app/helper/remote/dio_helper.dart';
import 'package:petcare_app/models/pets.dart';
import 'package:petcare_app/pages/profile/edit_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slide_countdown/slide_countdown.dart';

class Profile extends StatefulWidget {
  Profile({
    Key? key,
    this.images,
    this.name,
    this.phone,
    this.address,
  }) : super(key: key);

  var name;
  var phone;
  var address;
  var images;
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var na = "Mohamed Ahmed";
  var ph = "012233445556";
  var ad = "30 homs st, mansora";

  @override
  void initState() {
    // TODO: implement initState
    getMyAnimals();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
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
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (c) => edit_profile(
                                  nameed: na,
                                  phoneed: ph,
                                  addressed: ad,
                                ),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.settings,
                            size: 40,
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                myPets;
                                globalUser;
                              });
                              print(globalUser!.user!.address);
                            },
                            icon: Icon(Icons.refresh)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: globalUser!.user!.img != null
                        ? Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        '${AppEndPoints.imageBaseURL}${globalUser!.user!.img}'),
                                    fit: BoxFit.cover),
                                border:
                                    Border.all(color: Colors.black, width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(140))),
                            width: 190,
                            height: 190,
                          )
                        : Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("images/photo.jpg"),
                                    fit: BoxFit.cover),
                                border:
                                    Border.all(color: Colors.black, width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(140))),
                            width: 190,
                            height: 190,
                          ),
                  ),
                  Center(
                    child: Text(
                      "${globalUser!.user!.firstname} ${globalUser!.user!.lastname}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25.sp),
                    ),
                  ),
                  Center(
                    child: Text(
                      "@${globalUser!.user!.username}",
                      style: TextStyle(
                          color: Colors.black45,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(left: 5),
                          child: Text(
                            "Phone",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25.sp),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(left: 15),
                          child: Text(
                            "${globalUser!.user!.contactNumber}",
                            style: TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.spMax),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(left: 5),
                          child: Text(
                            "Address",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25.sp),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(left: 15),
                          child: Text(
                            "${globalUser!.user!.address}",
                            style: TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Center(
                            child: Container(
                          width: 370.w,
                          height: 280.h,
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
                              Center(
                                  child: Text("My animals",
                                      style: TextStyle(
                                          wordSpacing: 2,
                                          decorationThickness: 3,
                                          fontSize: 25.sp,
                                          fontWeight: FontWeight.bold))),
                              Container(
                                width: 70.w,
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
              )
            ],
          ),
        ),
      ),
    ));
  }

  Widget buildAnimalCard(Pet pet) {
    return Dismissible(
      onDismissed: (dir) {
        deleteUserPet(pet);
      },
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
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.green,
                        decorationThickness: 2,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                ),
              ),
            ),
          )
        ],
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
        // print('e[vaccines] : ');
        // print(e['vaccines']);
        // print(e['vaccines']);
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

  int calcSlideDown(Pet pet) {
    DateTime now = DateTime.now();
    DateTime yourDate = DateTime.parse(
        pet.vaccines.toString()); // تحتاج إلى توفير قيمة pet.vaccines

    Duration difference = yourDate.difference(now);
    int daysDiff = difference.inDays + 2;
    print(' daysDiff  The number of days between the two dates is: $daysDiff');
    return daysDiff;

    // int res = pet.vaccines.day.toInt() - DateTime.now().day.toInt();
    // if (res < 0) {
    //   res *= -1;
    // }
    // return res;

    //
    //   print(pet.vaccines.day.toInt() - DateTime.now().day.toInt());
    //   // 1 - 18
    //   int res = pet.vaccines.day.toInt() - DateTime.now().day.toInt();
    //   if (res < 0) {
    //     res *= -1;
    //   }
    //   return res;
  }
}

// final now = DateTime.now();
// final futureDate = now.add(Duration(days: x.day ));
// print(futureDate);
