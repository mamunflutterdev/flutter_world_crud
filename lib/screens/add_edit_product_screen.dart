import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/product_controller.dart';
import '../models/product.dart';

class AddEditProductScreen extends StatelessWidget {
  final ProductController productController = Get.find();
  final Product? product; // If this is null, it's "Add", otherwise it's "Edit"

  AddEditProductScreen({this.product});

  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productDetailsController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController productImageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Pre-fill the fields if editing an existing product
    if (product != null) {
      productNameController.text = product!.productName;
      productDetailsController.text = product!.productDetails;
      priceController.text = product!.price.toString();
      quantityController.text = product!.quantity.toString();
      productImageController.text = product!.productImage;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(product == null ? "Add Product" : "Edit Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: productNameController,
                decoration: const InputDecoration(labelText: "Product Name"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: productDetailsController,
                decoration: const InputDecoration(labelText: "Product Details"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Price"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: quantityController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Quantity"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: productImageController,
                decoration: const InputDecoration(labelText: "Product Image URL"),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    final String productName = productNameController.text.trim();
                    final String productDetails = productDetailsController.text.trim();
                    final double? price = double.tryParse(priceController.text.trim());
                    final int? quantity = int.tryParse(quantityController.text.trim());
                    final String productImage = productImageController.text.trim();

                    if (productName.isEmpty ||
                        productDetails.isEmpty ||
                        price == null ||
                        quantity == null ||
                        productImage.isEmpty) {
                      return;
                    }

                    final double totalPrice = price * quantity;

                    if (product == null) {
                      // Add new product
                      productController.addProduct(Product(
                        id: "",
                        productName: productName,
                        productDetails: productDetails,
                        price: price,
                        quantity: quantity,
                        totalPrice: totalPrice,
                        productImage: productImage,
                      )).then((_){
                        Get.snackbar("Success", "All Success");
                      });
                    } else {
                      // Update existing product
                      productController.updateProduct(
                        product!.id,
                        Product(
                          id: product!.id,
                          productName: productName,
                          productDetails: productDetails,
                          price: price,
                          quantity: quantity,
                          totalPrice: totalPrice,
                          productImage: productImage,
                        ),).then((_){
                        Get.snackbar("Success", "All Success");
                      });
                    }

                    Get.back();
                  },
                  child: Text(product == null ? "Add Product" : "Update Product"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
