import 'package:petcare_app/components.dart';
import 'package:petcare_app/helper/constants.dart';
import 'package:petcare_app/helper/end_points.dart';
import 'package:petcare_app/helper/remote/dio_helper.dart';
import 'package:petcare_app/models/categories.dart';
import 'package:petcare_app/pages/categorypage/bird.dart';
import 'package:petcare_app/pages/categorypage/cat.dart';
import 'package:petcare_app/pages/categorypage/dog.dart';
import 'package:petcare_app/pages/categorypage/fish.dart';
import 'package:petcare_app/pages/categorypage/hamster.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class category extends StatefulWidget {
  const category({Key? key}) : super(key: key);

  @override
  State<category> createState() => _categoryState();
}

class _categoryState extends State<category> {
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    getCategories();
    setState(() {
      myCategories;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Color(0xffD4D2D2),
        ),
        ListView(children: [
          IconButton(
              onPressed: () {
                setState(() {
                  myCategories;
                });
              },
              icon: Icon(Icons.refresh)),

          myCategories.isNotEmpty
              ? GridView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.all(17.w),
                  itemCount: myCategories.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.87,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 25,
                  ),
                  itemBuilder: (context, index) {
                    return buildCategoryCard(myCategories[index]);
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ]),
      ],
    );
  }

  List<Category> myCategories = [];

  getCategories() async {
    print('Start Get Category');
    await DioHelper.getData(
      url: AppEndPoints.getCategories,
      token: globalUser!.token,
    ).then((value) {
      print('get Categories');
      print(value.data);
      value.data['categories'].forEach((e) {
        myCategories.add(Category.fromJson(e));
      });
      print(myCategories.length);
      print(myCategories);
      print('get Categories Success');
      setState(() {
        myCategories;
      });
    }).catchError((err) {
      print('get Categories Error');
      print(err.toString());
    });
  }

  Widget? buildCategoryCard(Category category) {
    if (category.name == 'Dogs') {
      return InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (c) => Dog(
              petId: category.id!,
            ),
          ),
        ),
        child: categ(
          name: category.name,
          image: category.img,
          context: context,
        ),
      );
    }
    if (category.name == 'Cats') {
      return InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (c) => Cat1(
              petId: category.id,
            ),
          ),
        ),
        child: categ(
          name: category.name,
          image: category.img,
          context: context,
        ),
      );
    }
    if (category.name == 'Fish') {
      return InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (c) => Fish(
              petId: category.id!,
            ),
          ),
        ),
        child: categ(
          name: category.name,
          image: category.img,
          context: context,
        ),
      );
    }
    if (category.name == 'Hamster') {
      return InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (c) => Hamster(
              petId: category.id!,
            ),
          ),
        ),
        child: categ(
          name: category.name,
          image: category.img,
          context: context,
        ),
      );
    }
    if (category.name == 'Bird') {
      return InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (c) => Bird(
              petId: category.id,
            ),
          ),
        ),
        child: categ(
          name: category.name,
          image: category.img,
          context: context,
        ),
      );
    }
    return null;
  }
}
