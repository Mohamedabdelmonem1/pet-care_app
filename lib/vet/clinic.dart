import 'package:petcare_app/helper/constants.dart';
import 'package:petcare_app/helper/end_points.dart';
import 'package:petcare_app/helper/remote/dio_helper.dart';
import 'package:petcare_app/helper/snack_helper.dart';
import 'package:petcare_app/models/Vet_booking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class clinic extends StatefulWidget {
  const clinic({Key? key}) : super(key: key);

  @override
  State<clinic> createState() => _clinicState();
}

class _clinicState extends State<clinic> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVetBooking();
  }

  var x;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff182747),
        title: Text(
          "vet booking",
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            color: Color(0xffD4D2D2),
          ),
          ListView.builder(
              itemCount: vetBookings.length,
              itemBuilder: (context, i) {
                return Container(
                  margin: EdgeInsets.all(12),
                  height: 190.h,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        "User : ${vetBookings[i].user!.firstname}  ${vetBookings[i].user!.lastname}",
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        "pet : ${vetBookings[i].petName}",
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        "Day : ${vetBookings[i].date}",
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.blueGrey,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        "Hour: ${vetBookings[i].time}",
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.blueGrey,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      if (vetBookings[i].status != 'approved')
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3)),
                              color: Color(0xff28A745),
                              border: Border.all()),
                          width: 175.w,
                          height: 43.h,
                          child: MaterialButton(
                            onPressed: () {
                              approveBooking(vetBookings[i].id!.toInt());
                              x = 120;
                            },
                            child: Text(
                              "Accept",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.sp,
                                  color: Colors.white),
                            ),
                          ),
                        )
                    ],
                  ),
                );
              }),
        ],
      ),
    ));
  }

  List<VetBooking> vetBookings = [];
  getVetBooking() async {
    print('start get vet booking');
    await DioHelper.getData(
      url: AppEndPoints.vetBooking,
      token: globalUser!.token,
    ).then((value) {
      value.data['booking'].forEach((e) {
        // TODO : to appears approved booking
        // if(e['status'] != 'approved')
        vetBookings.add(VetBooking.fromJson(e));
      });
      print('get Booking Success');
      setState(() {
        vetBookings;
      });
    }).catchError((err) {
      print('start get vet booking');
      print(err.toString());
    });
  }

  approveBooking(id) async {
    print('start approve booking');
    await DioHelper.putData(
      url: AppEndPoints.approveBooking,
      data: {
        "id": id,
      },
      token: globalUser!.token,
    ).then((value) {
      print('approved booking');
      showSnackBar(
        context: context,
        text: 'success',
        clr: Colors.green,
      );
      showSnackBar(
        context: context,
        text: 'success',
        clr: Colors.green,
      );
      print('approved');
    }).catchError((err) {
      showSnackBar(
        context: context,
        text: 'error ${err.toString()}',
        clr: Colors.green,
      );
      print(err.toString());
    });
  }
}
