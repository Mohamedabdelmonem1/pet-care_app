import 'package:petcare_app/helper/constants.dart';
import 'package:petcare_app/helper/end_points.dart';
import 'package:petcare_app/helper/remote/dio_helper.dart';
import 'package:petcare_app/models/booking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyBooking extends StatefulWidget {
  const MyBooking({Key? key}) : super(key: key);

  @override
  State<MyBooking> createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBooking> {
  @override
  void initState() {
    // TODO: implement initState
    getMyBooking();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Color(0xff182747),
          title: Text(
            "my booking",
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  myBookings;
                });
              },
              icon: Icon(
                Icons.refresh,
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                color: Color(0xffD4D2D2),
              ),
              ListView.builder(
                  itemCount: myBookings.length,
                  itemBuilder: (context, i) {
                    return Container(
                      margin: EdgeInsets.all(12),
                      height: 215.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                top: 20.h, left: 15.w, bottom: 10.h),
                            child: Text(
                              "Doctor name : ${myBookings[i].doctorName}",
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.black,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                top: 3.h, left: 15.w, bottom: 10.h),
                            child: Text(
                              "Pet name : ${myBookings[i].petName}",
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.black,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                top: 3.h, left: 15.w, bottom: 10.h),
                            child: Text(
                              "Date : ${myBookings[i].date}",
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.black,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                top: 3.h, left: 15.w, bottom: 10.h),
                            child: Text(
                              "Time : ${myBookings[i].time}",
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.black,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3)),
                              ),
                              padding: EdgeInsets.only(
                                top: 9.h,
                                left: 15.w,
                              ),
                              child: Text(
                                "Status: ${myBookings[i].status} ",
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    color: Colors.blue,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ],
          ),
        ));
  }

  List<BookingElement> myBookings = [];

  getMyBooking() async {
    print('start get my booking');
    await DioHelper.getData(
      url: AppEndPoints.myBooking,
      token: globalUser!.token,
    ).then((value) {
      value.data['booking'].forEach((e) {
        myBookings.add(BookingElement.fromJson(e));
      });
      print(myBookings.length);
      setState(() {
        myBookings;
      });
    }).catchError((err) {
      print('error in get my booking');
      print(err.toString());
    });
  }
}
