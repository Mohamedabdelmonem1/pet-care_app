import 'package:petcare_app/helper/end_points.dart';
import 'package:petcare_app/helper/remote/dio_helper.dart';
import 'package:petcare_app/models/auth.dart';
import 'package:petcare_app/models/cart_item.dart';
import 'package:petcare_app/models/pets.dart';
import 'package:petcare_app/models/sub_categories.dart';
import 'package:petcare_app/models/vets.dart';

//Object for user data
Auth? globalUser;

SubCategory? globalPet;

Vet? globalVet;

List<CartItem> CartItemsForBadges = [];

String? userPassword;

deleteUserPet(Pet pet) async {
  print('start Delete');
  await DioHelper.deleteData(
    url: AppEndPoints.deleteUserPet,
    token: globalUser?.token,
    data: {
      "id": pet.id,
    },
  ).then((value) {
    print('success delete');
  }).catchError((err) {
    print(err.toString());
  });
}
