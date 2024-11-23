class Product {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final String categoryId;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.categoryId,
  });

  factory Product.fromMap(Map<String, dynamic> data, String documentId) {
    return Product(
      id: documentId,
      name: data['name'] ?? '',
      imageUrl: data['image_url'] ?? '',
      price: data['price']?.toDouble() ?? 0.0,
      categoryId: data['categoryId'] ?? '',
    );
  }
}
