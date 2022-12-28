import 'dart:convert';

import 'package:get/get.dart';

import '../model/proucts_res_model.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController{
  Rx<ProductsResModel> productsData = ProductsResModel().obs;
  //RxList<CoDocData> filterdata = <CoDocData>[].obs;

  Future getProductdata({required refresh}) async {
    final response = await http.get(
      Uri.parse("https://fakestoreapi.com/products"),
    );
    var productdata = jsonDecode(response.body);
    print(productdata);
    productsData.value = ProductsResModel.fromJson(jsonDecode(response.body));
    //filterdigdata.value = productsData.value.data!;
  }
}