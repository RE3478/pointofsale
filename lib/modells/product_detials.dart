class ProductDetails {
  final String pid;
  final List<dynamic> category;
  final List<dynamic> subCategory;
  final String id;
  final String brandName;
  final String name;
  final String description;
  final int price;
  final String serialNo;
  final bool inSale;
  final List<dynamic> imageUrl;
  final bool isPopular;
  final bool isFavorite;
  final int discountPrice;

  ProductDetails(
      {required this.pid,
      required this.category,
      required this.subCategory,
      required this.id,
      required this.brandName,
      required this.name,
      required this.description,
      required this.price,
      required this.serialNo,
      required this.inSale,
      required this.imageUrl,
      required this.isPopular,
      required this.isFavorite,
      required this.discountPrice});

  factory ProductDetails.fromMap(map) => ProductDetails(
      pid: map['pid'] ?? '',
      category: map['category'],
      subCategory: map['subCategory'],
      id: map['id'] ?? '',
      brandName: map['brandName'],
      name: map['name'],
      description: map['description'],
      price: map['price'],
      serialNo: map['serialNo'],
      inSale: map['inSale'],
      imageUrl: map['imageUrl'],
      isPopular: map['isPopular'],
      isFavorite: map['isFavorite'],
      discountPrice: map['discountPrice']);

  Map<String, dynamic> toMap() {
    return {
      "pid": pid,
      "category": category,
      "subCategory": subCategory,
      "id": id,
      "brandName": brandName,
      "name": name,
      "description": description,
      "price": price,
      "serialNo": serialNo,
      "inSale": inSale,
      "imageUrl": imageUrl,
      "isPopular": isPopular,
      "isFavorite": isFavorite,
      "discountPrice": discountPrice
    };
  }
}
