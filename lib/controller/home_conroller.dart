import 'dart:convert';

import 'package:get/get.dart';

import '../model/proucts_res_model.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController{
  //Rx<ProductsResModel> productsData = ProductsResModel().obs;
  RxList<ProductsResModel> productData = <ProductsResModel>[].obs;
  RxList<ProductsResModel> productsData = <ProductsResModel>[].obs;

  Future<void> onInit() async {
    super.onInit();
    await getProductdata(refresh: true);
  }

  Future getProductdata({required refresh}) async {
    final response = await http.get(
      Uri.parse("https://fakestoreapi.com/products"),
    );
    var productdata = jsonDecode(response.body);
    print(productdata);
    //productsData.value = ProductsResModel.fromJson(jsonDecode(response.body));
    productData.value = productsResModelFromJson(response.body);
    productsData.value = productsResModelFromJson(response.body);
  }
}