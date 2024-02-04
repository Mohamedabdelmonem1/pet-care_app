import 'package:petcare_app/helper/constants.dart';
import 'package:petcare_app/helper/end_points.dart';
import 'package:petcare_app/helper/remote/dio_helper.dart';
import 'package:petcare_app/models/auth.dart';
import 'package:petcare_app/pages/home_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool visible = false;
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  var kind;

  @override
  void initState() {
    // TODO: implement initState
    CartItemsForBadges.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(children: [
        Container(
          height: double.infinity,
          color: Color(0xff182747),
        ),
        Container(
          padding: EdgeInsets.only(top: 30),
          child: ListView(
            children: [
              SvgPicture.asset(
                "images/4.svg",
                width: 80,
                height: 80,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Pet Care",
                      style: TextStyle(
                          color: Color(0xff269A41),
                          fontWeight: FontWeight.bold,
                          fontSize: 40)),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 10, bottom: 10, right: 25, left: 25),
                      child: TextFormField(
                        controller: firstnameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "First Name",
                          hintStyle: TextStyle(
                              fontSize: 21, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 10, bottom: 10, right: 25, left: 25),
                      child: TextFormField(
                        controller: lastnameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Last Name",
                          hintStyle: TextStyle(
                              fontSize: 21, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 10, bottom: 10, right: 25, left: 25),
                      child: TextFormField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Username",
                          hintStyle: TextStyle(
                              fontSize: 21, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 10, bottom: 10, right: 25, left: 25),
                      child: TextFormField(
                        controller: emailController,
                        obscureText: visible,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "enter your Email",
                          hintStyle: TextStyle(
                              fontSize: 21, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 10, bottom: 10, right: 25, left: 25),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: visible,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Enter your password",
                          hintStyle: TextStyle(
                              fontSize: 21, fontWeight: FontWeight.bold),
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
                    Container(
                      margin: EdgeInsets.only(
                          top: 10, bottom: 10, right: 25, left: 25),
                      child: TextFormField(
                        controller:phoneController ,
                        obscureText: visible,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "phone number",
                          hintStyle: TextStyle(
                              fontSize: 21, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 10, bottom: 10, right: 25, left: 25),
                      child: TextFormField(
                        controller:addressController ,
                        obscureText: visible,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Address",
                          hintStyle: TextStyle(
                              fontSize: 21, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      width: 360,
                      margin: EdgeInsets.only(
                          top: 10, bottom: 10, right: 25, left: 25),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          iconSize: 40,
                          hint: Text(
                            "    you are",
                            style: TextStyle(
                                fontSize: 23, fontWeight: FontWeight.bold),
                          ),
                          items: ["Customer", "Vet", "Trader"]
                              .map((e) => DropdownMenuItem(
                                    child: Text(
                                      "   $e",
                                      style: TextStyle(
                                          fontSize: 23,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              kind = val;
                              print(kind);
                            });
                          },
                          value: kind,
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Color(0xff269A41),
                      ),
                      width: 200,
                      child: MaterialButton(
                        onPressed: () {
                          signup(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                            firstname: firstnameController.text.trim(),
                            lastname: lastnameController.text.trim(),
                            username: usernameController.text.trim(),

                            // TODO : Add here the missing data
                            contact_number: phoneController.text.trim(),
                            address: addressController.text.trim(),
                            type: kind.toString().trim(),
                          );

                        },
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }

  signup({
    @required email,
    @required password,
    @required firstname,
    @required lastname,
    @required username,
    @required contact_number,
    @required address,
    @required type,
  }) async {
    await DioHelper.postData(url: AppEndPoints.register, data: {
      'email': email,
      'password': password,
      'c_password': password,
      'firstname': firstname,
      'lastname': lastname,
      'username': username,
      'contact_number': contact_number,
      'address': address,
      'type': type,
    }).then((value) {
      CartItemsForBadges.clear();

      print('Register Success');
      globalUser = Auth.fromJson(value.data);
      toggleBetweenUsers(globalUser!);
    }).catchError((err) {
      print('Register Error');
      print(err.toString());
    });
  }

  toggleBetweenUsers(Auth user) {
    if (user.user!.type == "Customer") {
      int indexKind = 0;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => home_management(
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
