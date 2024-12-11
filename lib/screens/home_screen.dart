import 'package:flutter/material.dart';
import 'package:flutter_world_crud/screens/add_edit_product_screen.dart';
import 'package:get/get.dart';
import '../controllers/product_controller.dart';

class HomeScreen extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Center(child: Text("Flutter World Crud App",),),
        actions: [
          IconButton(onPressed: () {
            productController.fetchProducts();
          },
          icon: const Icon(Icons.update,color: Colors.white,)),
          const SizedBox(width: 16,)
        ],
      ),
      body: Obx(() {
        if (productController.products.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: productController.products.length,
            itemBuilder: (context, index) {
              final product = productController.products[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  tileColor: Colors.brown.shade50,
                  leading: SizedBox(
                      width: 100,
                      height: 80,
                      child: Image.network(product.productImage,fit: BoxFit.cover,)),
                  title: Text(product.productName),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(product.productDetails),
                      Text(product.price.toString()),
                      Text(product.quantity.toString()),
                      Text(product.totalPrice.toString()),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit,color: Colors.green.shade900,),
                        onPressed: () {
                          Get.to(() => AddEditProductScreen(product: product));
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete,color: Colors.red.shade900,),
                        onPressed: () {
                          productController.deleteProduct(product.id);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown,
        onPressed: () {
          Get.to(() => AddEditProductScreen());
        },
        child: const Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
}
