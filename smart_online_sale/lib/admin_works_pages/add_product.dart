import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smart_online_sale/modells/category_selection.dart';
import 'package:smart_online_sale/providers/add_product_provider.dart';
import 'package:smart_online_sale/providers/category_drop_down_provider.dart';
import 'package:smart_online_sale/providers/multi_image_provider.dart';
import 'package:smart_online_sale/providers/switch_list_provider.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _brandController = TextEditingController();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _serialNoController = TextEditingController();
  final _discountPriceController = TextEditingController();

  void _addProductOnFirebase(BuildContext context) async {
    bool isvalid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (!isvalid) {
      return;
    }
    _formKey.currentState!.save();
    Provider.of<AddProductProvider>(context, listen: false)
        .addProductOnFireBaseStorage(
            context,
            _idController.text,
            _nameController.text.trim(),
            _descriptionController.text,
            _priceController.text,
            _serialNoController.text,
            _discountPriceController.text,
            Provider.of<CategoryProviderForDropDown>(context, listen: false)
                .selectedCategory!
                .name
                .toString(),
            Provider.of<MultiImageProvider>(context, listen: false).images,
            Provider.of<SwitchListTileStockProvider>(context, listen: false)
                .inSale,
            Provider.of<SwitchListTilePopularProvider>(context, listen: false)
                .isPopular,
            Provider.of<SwitchListTileFavouriteProvider>(context, listen: false)
                .isFavourite,
            _brandController.text);
  }

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _serialNoController.dispose();
    _discountPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<CategoryProviderForDropDown>(context, listen: false);
    Provider.of<SwitchListTileStockProvider>(context, listen: false);
    Provider.of<SwitchListTilePopularProvider>(context, listen: false);
    Provider.of<SwitchListTileFavouriteProvider>(context, listen: false);
    var multiProvider = Provider.of<MultiImageProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
            )),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15.h,
                    ),
                    Center(
                      child: Text(
                        'Add Product Profile',
                        style: TextStyle(
                            color: const Color(0xFFFF7643),
                            fontWeight: FontWeight.bold,
                            fontSize: 28.sp),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Consumer<MultiImageProvider>(
                      builder: (context, mIp, child) => Center(
                        child: GestureDetector(
                          onTap: () {
                            mIp.uploadMultiImages();
                          },
                          child: Container(
                            height: 180.h,
                            decoration: BoxDecoration(
                              color: Colors.deepOrange.shade300,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: GridView.builder(
                                  itemCount: mIp.images.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 5),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Stack(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black)),
                                            child: Image.network(
                                              File(mIp.images[index].path).path,
                                              height: 160.h,
                                              width: 160.w,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                multiProvider
                                                    .imagesDeletion(index);
                                              },
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.grey,
                                              )),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _idController,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: 'Enter product id no.',
                              label: const Text(
                                'ProductId',
                                style: TextStyle(color: Color(0xFFFF7643)),
                              ),
                              prefixIcon: const Icon(
                                Icons.abc,
                                color: Color.fromARGB(255, 153, 90, 67),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter product id no.';
                              } else if (!RegExp(r"^[0-9]+$").hasMatch(value)) {
                                return 'Please enter valid id no.';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: 05.w,
                        ),
                        Expanded(
                          child: Consumer<CategoryProviderForDropDown>(
                            builder: (context, cSP, child) =>
                                DropdownButtonFormField<CategorySelection>(
                              value: cSP.selectedCategory,
                              items: cSP.listOfCategory
                                  .map<DropdownMenuItem<CategorySelection>>(
                                      (e) {
                                return DropdownMenuItem<CategorySelection>(
                                  value: e.value!,
                                  child: Text(e.value!.name),
                                );
                              }).toList(),
                              onChanged: (value) {
                                cSP.onChangeValue(value);
                              },
                              validator: (value) {
                                value == null ? 'select category' : null;
                                return null;
                              },
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.category,
                                  color: Color.fromARGB(255, 153, 90, 67),
                                ),
                                hintText: "Choose category",
                                label: const Text(
                                  'Category',
                                  style: TextStyle(color: Color(0xFFFF7643)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 05.w,
                        ),
                        // Expanded(
                        //   child: Consumer<CategoryProviderForDropDown>(
                        //     builder: (context, cSP, child) =>
                        //         DropdownButtonFormField<CategorySelection>(
                        //       value: cSP.selectedCategory,
                        //       items: cSP.listOfCategory
                        //           .map<DropdownMenuItem<CategorySelection>>(
                        //               (e) {
                        //         return DropdownMenuItem<CategorySelection>(
                        //           value: e,
                        //           child: Text(e),
                        //         );
                        //       }).toList(),
                        //       onChanged: (value) {},
                        //       validator: (value) {
                        //         value == null ? 'select category' : null;
                        //         return null;
                        //       },
                        //       decoration: InputDecoration(
                        //         prefixIcon: const Icon(
                        //           Icons.category,
                        //           color: Color.fromARGB(255, 153, 90, 67),
                        //         ),
                        //         hintText: "Choose category",
                        //         label: const Text(
                        //           'Category',
                        //           style: TextStyle(color: Color(0xFFFF7643)),
                        //         ),
                        //         enabledBorder: OutlineInputBorder(
                        //           borderRadius: BorderRadius.circular(10.r),
                        //         ),
                        //         focusedBorder: OutlineInputBorder(
                        //           borderRadius: BorderRadius.circular(10.r),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _nameController,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: 'Enter product name',
                              label: const Text(
                                'Product name',
                                style: TextStyle(color: Color(0xFFFF7643)),
                              ),
                              prefixIcon: const Icon(
                                Icons.production_quantity_limits_sharp,
                                color: Color.fromARGB(255, 153, 90, 67),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter product name';
                              } else if (!RegExp(r"^[a-zA-Z]+(?:\s[a-zA-Z]+)+$")
                                  .hasMatch(value)) {
                                return 'Please enter valid product name';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: 05.w,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _brandController,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: 'Enter product brand name.',
                              label: const Text(
                                'Product Brand',
                                style: TextStyle(color: Color(0xFFFF7643)),
                              ),
                              prefixIcon: const Icon(
                                Icons.abc,
                                color: Color.fromARGB(255, 153, 90, 67),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter product brand name.';
                              } else if (!RegExp(r"^[a-zA-Z]+$")
                                  .hasMatch(value)) {
                                return 'Please enter valid brand name.';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: 05.w,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _serialNoController,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: 'abc12345',
                              label: const Text(
                                'Product serial no',
                                style: TextStyle(color: Color(0xFFFF7643)),
                              ),
                              prefixIcon: const Icon(
                                Icons.numbers,
                                color: Color.fromARGB(255, 153, 90, 67),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter product serial no';
                              } else if (!RegExp(r"^[a-zA-Z0-9]+$")
                                  .hasMatch(value)) {
                                return 'Please enter valid serial no';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 5,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'Enter product details',
                        label: const Text(
                          'Product detials',
                          style: TextStyle(color: Color(0xFFFF7643)),
                        ),
                        prefixIcon: const Icon(
                          Icons.description,
                          color: Color.fromARGB(255, 153, 90, 67),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter product detials';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _priceController,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: 'Enter product price',
                              label: const Text(
                                'Product Price',
                                style: TextStyle(color: Color(0xFFFF7643)),
                              ),
                              prefixIcon: const Icon(
                                Icons.price_change,
                                color: Color.fromARGB(255, 153, 90, 67),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter product price';
                              } else if (!RegExp(
                                      r"^(\d{1,3}'(\d{3}')*\d{3}(\.\d{1,3})?|\d{1,3}(\.\d{3})?)$")
                                  .hasMatch(value)) {
                                return 'Please enter valid price';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: 05.w,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _discountPriceController,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              hintText: 'Enter discount prince',
                              label: const Text(
                                'Discount price',
                                style: TextStyle(color: Color(0xFFFF7643)),
                              ),
                              prefixIcon: const Icon(
                                Icons.price_change,
                                color: Color.fromARGB(255, 153, 90, 67),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter product discount prince';
                              } else if (!RegExp(
                                      r"^(\d{1,3}'(\d{3}')*\d{3}(\.\d{1,3})?|\d{1,3}(\.\d{3})?)$")
                                  .hasMatch(value)) {
                                return 'Please enter valid discount prince';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Consumer<SwitchListTileFavouriteProvider>(
                      builder: (context, frtP, child) => SwitchListTile(
                          shape: Border.all(
                              color: Colors.black12, style: BorderStyle.solid),
                          title: Text(
                            'is this product is favourite',
                            style: TextStyle(fontSize: 16.sp),
                          ),
                          value: frtP.isFavourite,
                          onChanged: (value) {
                            frtP.toggleFavouriteValue();
                          }),
                    ),
                    SizedBox(
                      height: 05.w,
                    ),
                    Consumer<SwitchListTileStockProvider>(
                      builder: (context, sltP, child) => SwitchListTile(
                          shape: Border.all(
                              color: Colors.black12, style: BorderStyle.solid),
                          title: Text(
                            'is this available on Sale',
                            style: TextStyle(fontSize: 16.sp),
                          ),
                          value: sltP.inSale,
                          onChanged: (value) {
                            sltP.toggleStocksValue();
                          }),
                    ),
                    SizedBox(
                      height: 05.w,
                    ),
                    Consumer<SwitchListTilePopularProvider>(
                      builder: (context, pltP, child) => SwitchListTile(
                          shape: Border.all(
                              color: Colors.black12, style: BorderStyle.solid),
                          title: Text(
                            'is this product is popular',
                            style: TextStyle(fontSize: 16.sp),
                          ),
                          value: pltP.isPopular,
                          onChanged: (value) {
                            pltP.togglePopularValue();
                          }),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    SizedBox(
                      height: 50.h,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          _addProductOnFirebase(context);
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            const Color(0xFFFF7643),
                          ),
                        ),
                        child: Text(
                          'save',
                          style: Theme.of(context).textTheme.button,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // void uploadMultiImages() async {
  //   final List<XFile> pickImages = await imagepicker.pickMultiImage();
  //   // ignore: unnecessary_null_comparison
  //   if (pickImages != null) {
  //     setState(() {
  //       images.addAll(pickImages);
  //     });
  //   } else {
  //     Fluttertoast.showToast(msg: 'images not selected');
  //   }
  // }
}
