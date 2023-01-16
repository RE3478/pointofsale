import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_online_sale/admin_works_pages/product_updation.dart';
import 'package:smart_online_sale/modells/product_detials.dart';

class UpdateProduct extends StatefulWidget {
  const UpdateProduct({super.key});

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [
          Center(
            child: Text(
              'Product List',
              style: TextStyle(
                  color: const Color(0xFFFF7643),
                  fontWeight: FontWeight.bold,
                  fontSize: 28.sp),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('products').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.data == null) {
                  return const Center(child: Text(" Data Doesn't exist"));
                }
                final proData = snapshot.data!.docs;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Card(
                        elevation: 08,
                        color: Colors.deepOrange.shade400,
                        child: ListTile(
                          leading: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: Colors.yellow.shade500,
                                shape: BoxShape.rectangle),
                            child: Center(child: Text(proData[index]['id'])),
                          ),
                          title: Text(proData[index]['name']),
                          trailing: Container(
                            color: Colors.deepOrange.shade400,
                            height: 50.h,
                            width: 100.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    productDeletion(proData[index].id);
                                  },
                                  icon: const Icon(
                                    Icons.delete_forever,
                                    color: Colors.black,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ProductUpdationScreen(
                                          proDataId: proData[index].id,
                                          productValue: ProductDetails(
                                            category: proData[index]
                                                ['category'],
                                            id: proData[index]['id'],
                                            brandName: proData[index]
                                                ['brandName'],
                                            name: proData[index]['name'],
                                            description: proData[index]
                                                ['description'],
                                            price: proData[index]['price'],
                                            serialNo: proData[index]
                                                ['serialNo'],
                                            inSale: proData[index]['inSale'],
                                            imageUrl: proData[index]
                                                ['imageUrl'],
                                            isPopular: proData[index]
                                                ['isPopular'],
                                            isFavorite: proData[index]
                                                ['isFavorite'],
                                            discountPrice: proData[index]
                                                ['discountPrice'],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ]),
      ),
    );
  }

  Future<void> productDeletion(String id) async {
    CollectionReference cR = FirebaseFirestore.instance.collection('products');
    await cR.doc(id).delete();
  }
}
