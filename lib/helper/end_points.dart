import 'dart:io';

import 'package:dio/dio.dart';

class AppEndPoints {
  // static String baseURL = 'http://192.168.1.5/api/';
  // static String imageBaseURL = 'http://192.168.1.5/assets/images/';

  // 10th of ramadan
  // static String baseURL = 'http://192.168.1.19/api/';
  // static String imageBaseURL = 'http://192.168.1.19/assets/images/';

  // obour
  static String baseURL = 'http://192.168.1.10:80/api/';
  static String imageBaseURL = 'http://192.168.1.10:80/assets/images/';

  static String login = '${baseURL}${'login?'}';
  static String register = '${baseURL}${'register?'}';


  //take token
  static String getUserPets = '${baseURL}${'user-pets'}';
  static String getCategories = '${baseURL}${'categories'}';
  static String getSubCategories = '${baseURL}${'subcategories'}';
  static String getVets = '${baseURL}${'vets'}';
  static String updateProfile = '${baseURL}${'update-profile?'}';
  static String changeImage = '${baseURL}${'change-image'}';
  static String booking = '${baseURL}${'booking?'}';
  static String myBooking = '${baseURL}${'my-booking'}';
  static String check = '${baseURL}${'check?'}';
  static String products = '${baseURL}${'products?'}';
  static String addUserAnimal = '${baseURL}${'store-user-pet'}';
  static String addProduct = '${baseURL}${'store-product'}';
  static String getMyProducts = '${baseURL}${'my-products'}';
  static String notifications = '${baseURL}${'notifications'}';
  static String approveBooking = '${baseURL}${'approve-booking?'}';
  static String getMyCart = '${baseURL}${'cart'}';
  static String delete = '${baseURL}${'delete-product?'}';
  static String confirm = '${baseURL}${'confirm'}';
  static String deleteUserPet = '${baseURL}${'delete-user-pet?'}';

  /// ?
  static String search = '${baseURL}${'products?'}';
  static String addToCart = '${baseURL}${'add-to-cart?'}';

  // static String delete = '${baseURL}${'delete?'}';

  static String increase = '${baseURL}${'increase-items?'}';
  static String decrease = '${baseURL}${'decrease-items?'}';

  static String vetBooking = '${baseURL}${'vet-booking'}';

  // static uploadImage(File file) async {
  //   String fileName = file.path.split('/').last;
  //   FormData formData = new FormData.fromMap({
  //     "name": 'hospitalNameEng',
  //     "Services": 'servicejson',
  //     "Image": {
  //       "image": await MultipartFile.fromFile(file.path,
  //           filename: fileName),
  //       "type": "image/png"
  //     },
  //   });
  //   return formData;
  // }
}
