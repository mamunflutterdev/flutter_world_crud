import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs;
  final String baseUrl = "https://flutterworld-red.vercel.app/api";

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  Future<void> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/products"));
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        if (jsonResponse.containsKey('data')) {
          final List<dynamic> data = jsonResponse['data'];
          products.value = data.map((e) => Product.fromJson(e)).toList();
        } else {
          Get.snackbar("Error", "Unexpected data format");
        }
      } else {
        Get.snackbar("Error", "Failed to fetch products");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }


  Future<void> addProduct(Product product) async {
    try {
      final response = await http.post(Uri.parse("$baseUrl/product"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(product.toJson()),
      );
      if (response.statusCode == 200) {
        fetchProducts();
        Get.snackbar("Success", "Product added successfully");
      } else {
        Get.snackbar("Error", "Failed to add product");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> updateProduct(String id, Product product) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/product/$id"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(product.toJson()),
      );
      if (response.statusCode == 200) {
        fetchProducts();
        Get.snackbar("Success", "Product updated successfully");
      } else {
        Get.snackbar("Error", "Failed to update product");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      final response = await http.delete(Uri.parse("$baseUrl/product/$id"));
      if (response.statusCode == 200) {
        fetchProducts();
        Get.snackbar("Success", "Product deleted successfully");
      } else {
        Get.snackbar("Error", "Failed to delete product");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
