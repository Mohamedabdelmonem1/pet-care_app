import 'package:petcare_app/helper/constants.dart';
import 'package:petcare_app/helper/end_points.dart';
import 'package:petcare_app/helper/remote/dio_helper.dart';
import 'package:petcare_app/models/vets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'doctorone.dart';

class doctors extends StatefulWidget {
  const doctors({Key? key}) : super(key: key);

  @override
  State<doctors> createState() => _doctorsState();
}

class _doctorsState extends State<doctors> {
  @override
  void initState() {
    // TODO: implement initState
    getVets();
    myVets.forEach((element) {
      print(element.img);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          color: Color(0xffD4D2D2),
          child: ListView(
            shrinkWrap: true,
            children: [
              Stack(
                children: [
                  Container(
                    height: 200.h,
                    // height: MediaQuery.of(context).size.height*0.75,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30)),
                        image: DecorationImage(
                          image: AssetImage("images/66.jpg"),
                          fit: BoxFit.cover,
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      myVets;
                    });
                  },
                  icon: Icon(Icons.refresh)),
              SizedBox(
                height: 11,
              ),
              Text(
                " Choose the doctor who you like",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 11,
              ),
              GridView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisExtent: 300,
                    maxCrossAxisExtent: 222,
                    childAspectRatio: 1.5 / 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5),
                itemBuilder: (context, index) => Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1.8),
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  margin: EdgeInsets.all(10),
                  width: 222.w,
                  child: MaterialButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      setState(() {
                        globalVet = myVets[index];
                      });
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => One()));
                    },
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 190.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(width: 0.5),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(24),
                                    topRight: Radius.circular(24)),
                                //                                  "${AppEndPoints.imageBaseURL}${myVets[index].img}",
                                image: myVets[index].img == null
                                    ? DecorationImage(
                                        image: AssetImage("images/doc1.jpg"),
                                        fit: BoxFit.cover,
                                      )
                                    : DecorationImage(
                                        image: NetworkImage(
                                            "${AppEndPoints.imageBaseURL}${myVets[index].img}"),
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Center(
                          child: Text(
                            '${myVets[index].firstname} ${myVets[index].lastname}',
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                itemCount: myVets.length,
              ),
              SizedBox(
                height: 20.h,
              )
            ],
          )),
    );
  }

  List<Vet> myVets = [];

  getVets() async {
    print('start get Vets');
    await DioHelper.getData(url: AppEndPoints.getVets).then((value) {
      value.data['vets'].forEach((e) {
        myVets.add(Vet.fromJson(e));
      });
      print(myVets.length);
      setState(() {
        myVets;
      });
    }).catchError((err) {
      print('get Vets Error');
      print(err.toString());
    });
  }
}
