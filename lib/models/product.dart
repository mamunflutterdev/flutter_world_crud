class Product {
  final String id;
  final String productName;
  final String productDetails;
  final double price;
  final int quantity;
  final double totalPrice;
  final String productImage;

  Product({
    required this.id,
    required this.productName,
    required this.productDetails,
    required this.price,
    required this.quantity,
    required this.totalPrice,
    required this.productImage,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      productName: json['productName'],
      productDetails: json['productDetails'],
      price: json['price'].toDouble(),
      quantity: json['quantity'],
      totalPrice: json['totalPrice'].toDouble(),
      productImage: json['productImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productName': productName,
      'productDetails': productDetails,
      'price': price,
      'quantity': quantity,
      'totalPrice': totalPrice,
      'productImage': productImage,
    };
  }
}
