import 'package:petcare_app/helper/constants.dart';
import 'package:petcare_app/helper/end_points.dart';
import 'package:petcare_app/helper/remote/dio_helper.dart';
import 'package:petcare_app/models/auth.dart';
import 'package:petcare_app/pages/home_management.dart';
import 'package:petcare_app/auth/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  bool visible = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override
  void initState() {
    CartItemsForBadges.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            color: Color(0xff182747),
          ),
          Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SvgPicture.asset(
                    "images/4.svg",
                    width: 90,
                    height: 90,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Pet Care",
                      style: TextStyle(
                        //color: Colors.green,
                          color: Color(0xff269A41),
                          fontWeight: FontWeight.bold,
                          fontSize: 45)),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 60,
                          margin: EdgeInsets.only(
                              top: 10, bottom: 10, right: 20, left: 20),
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "enter your email",
                              hintStyle: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.green,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 60,
                          margin:
                          EdgeInsets.only(bottom: 10, right: 20, left: 20),
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: visible,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "enter your password",
                              hintStyle: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              prefixIcon: Icon(Icons.lock,
                                  color: Colors.green, size: 30),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  visible = !visible;
                                  setState(() {});
                                },
                                icon: visible == false
                                    ? Icon(
                                  Icons.visibility,
                                  color: Colors.black,
                                )
                                    : Icon(
                                  Icons.visibility_off,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            color: Color(0xff269A41),
                          ),
                          width: 200,
                          child: MaterialButton(
                            onPressed: () {
                              // print('press1');
                              login(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              );
                              // print('press3');
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              " Don't have account?",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  // color: Colors.black87
                                  color: Colors.white),
                            ),
                            MaterialButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Signup(),
                                  ),
                                );},
                              child: Text(
                                "Register",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Color(0xff269A41)),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  login({@required email, @required password}) async {
    // print('press2');
    // print(email);
    // print(password);
    await DioHelper.postData(url: AppEndPoints.login, data: {
      'email':email,
      'password':password,
    }).then((value) {
      CartItemsForBadges.clear();
      userPassword = password.toString();

      print('login Success');
      print(value.toString());
      setState(() {
        globalUser = Auth.fromJson(value.data);

      });
      print("data from Json");
      print(globalUser);
      toggleBetweenScreens(globalUser!);
    }).catchError((err) {
      print('login Error : ');
      print(err.toString());
    });
    // print('press4');
  }

  toggleBetweenScreens(Auth user) {
    if (user.user!.type == "Customer") {
      int indexKind = 0;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              home_management(
                type: "Customer",
                index: indexKind,
              ),
        ),
      );
    }
    if (user.user!.type == "Vet") {
      int indexKind = 1;
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                home_management(type: "Vet", index: indexKind),
          ));
    }
    if (user.user!.type == "Trader") {
      int indexKind = 2;
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                home_management(type: "Trader", index: indexKind),
          ));
    }
  }
}
// test REQ
/// http://192.168.1.5/api/register?email=ahmfdfsdfsdfsdedxm@gmail.com&password=123456789fsdfsdfsdf&firstname=ahmeddfsdfsdf&lastname=xmfsdfsdfsdf&username=fsdfsdffsdfsdfsd&contact_number=fdsfsdfsdfsfsdf&address=sdfsdfsdfsdfsdf&type=Customer&c_password=fdfsdfsdfsdfsdfsdf