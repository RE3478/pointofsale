import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smart_online_sale/modells/category_selection.dart';
import 'package:smart_online_sale/modells/product_detials.dart';
import 'package:smart_online_sale/providers/category_drop_down_provider.dart';
import 'package:smart_online_sale/providers/multi_image_provider.dart';
import 'package:smart_online_sale/providers/product_updation_provider.dart';
import 'package:smart_online_sale/providers/switch_list_provider.dart';

class ProductUpdationScreen extends StatefulWidget {
  final String? proDataId;
  final ProductDetails? productValue;
  const ProductUpdationScreen(
      {super.key, required this.proDataId, required this.productValue});

  @override
  State<ProductUpdationScreen> createState() => _ProductUpdationScreenState();
}

class _ProductUpdationScreenState extends State<ProductUpdationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _brandController = TextEditingController();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _serialNoController = TextEditingController();
  final _discountPriceController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      for (int i = 0; i < widget.productValue!.imageUrl.length; i++) {
        Provider.of<MultiImageProvider>(context, listen: false)
            .imageOld(widget.productValue!.imageUrl.elementAt(i));
      }
    });
    _idController.text = widget.productValue!.id;
    _serialNoController.text = widget.productValue!.serialNo;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.proDataId!.isNotEmpty == widget.productValue!.pid.isNotEmpty) {
        for (int i = 0; i <= widget.productValue!.category.length - 1; i++) {
          CategorySelection categorySelection = CategorySelection(
              cId: widget.productValue!.category[i]['cId'],
              name: widget.productValue!.category[i]['name']);
          Provider.of<CategoryProviderForDropDown>(context, listen: false)
              .onChangeDropValue(
                  categorySelection, widget.productValue!.category[i]['cId']!);
        }
        for (int i = 0; i <= widget.productValue!.subCategory.length - 1; i++) {
          SubCategorySelection subCategorySelection = SubCategorySelection(
              sCId: widget.productValue!.subCategory[i]['sCId'],
              cId: widget.productValue!.subCategory[i]['cId'],
              subName:
                  widget.productValue!.subCategory[i]['subName'].toString());

          Provider.of<CategoryProviderForDropDown>(context, listen: false)
              .onChangeDropSubValue(
                  subCategorySelection,
                  widget.productValue!.subCategory[i]['cId']!,
                  widget.productValue!.subCategory[i]['sCId']!);
        }
      }
    });

    _brandController.text = widget.productValue!.brandName;
    _nameController.text = widget.productValue!.name;
    _descriptionController.text = widget.productValue!.description;
    _priceController.text = widget.productValue!.price.toString();
    _discountPriceController.text =
        widget.productValue!.discountPrice.toString();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<SwitchListTileStockProvider>(context, listen: false)
          .previousInSale = widget.productValue!.inSale;
      Provider.of<SwitchListTilePopularProvider>(context, listen: false)
          .previousInPopular = widget.productValue!.isPopular;
      Provider.of<SwitchListTileFavouriteProvider>(context, listen: false)
          .previousFavourite = widget.productValue!.isFavorite;
    });

    super.initState();
  }

  void _updateProductOnFirebase(BuildContext context) async {
    bool isvalid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (!isvalid) {
      return;
    }
    _formKey.currentState!.save();
    Provider.of<ProductUpdationProvider>(context, listen: false)
        .updateDataOnFirebase(
      context,
      _idController.text,
      _nameController.text.trim(),
      _descriptionController.text,
      _priceController.text,
      _serialNoController.text,
      _discountPriceController.text,
      Provider.of<CategoryProviderForDropDown>(context, listen: false)
          .selectedCategory!
          .toMap(),
      Provider.of<MultiImageProvider>(context, listen: false).images,
      Provider.of<SwitchListTileStockProvider>(context, listen: false).inSale,
      Provider.of<SwitchListTilePopularProvider>(context, listen: false)
          .isPopular,
      Provider.of<SwitchListTileFavouriteProvider>(context, listen: false)
          .isFavourite,
      _brandController.text,
      widget.proDataId.toString(),
      Provider.of<CategoryProviderForDropDown>(context, listen: false)
          .subCategorySelection!
          .toMap(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<SwitchListTileStockProvider>(context, listen: false);
    Provider.of<CategoryProviderForDropDown>(context, listen: false);
    Provider.of<SwitchListTilePopularProvider>(context, listen: false);
    Provider.of<SwitchListTileFavouriteProvider>(context, listen: false);
    var multiProvider = Provider.of<MultiImageProvider>(context, listen: false);
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: const Text('Home Screen'),
      // ),
      body: SafeArea(
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
                      'Product Updation',
                      style: TextStyle(
                          color: const Color(0xFFFF7643),
                          fontWeight: FontWeight.bold,
                          fontSize: 28.sp),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Column(
                    children: [
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
                                                  File(mIp.images[index].path)
                                                      .path,
                                                  height: 160.h,
                                                  width: 160.w,
                                                  fit: BoxFit.fill)),
                                          IconButton(
                                              onPressed: () {
                                                multiProvider
                                                    .imagesDeletion(index);
                                              },
                                              icon: const Icon(Icons.delete,
                                                  color: Colors.grey)),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
                            label: Text(
                              'ProductId',
                              style: TextStyle(
                                  color: const Color(0xFFFF7643),
                                  fontSize: 14.sp),
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
                        width: 5.w,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _serialNoController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: 'abc12345',
                            label: Text(
                              'Product serial no',
                              style: TextStyle(
                                  color: const Color(0xFFFF7643),
                                  fontSize: 14.sp),
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
                  Row(
                    children: [
                      Expanded(
                        child: Consumer<CategoryProviderForDropDown>(
                          builder: (context, cSP, child) =>
                              DropdownButtonFormField<CategorySelection>(
                            value: cSP.selectedCategory,
                            items: cSP.listOfCategory
                                .map<DropdownMenuItem<CategorySelection>>((e) {
                              return DropdownMenuItem<CategorySelection>(
                                value: e.value,
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
                              label: Text(
                                'Category',
                                style: TextStyle(
                                    color: const Color(0xFFFF7643),
                                    fontSize: 14.sp),
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
                      Expanded(
                        child: Consumer<CategoryProviderForDropDown>(
                          builder: (context, sCsP, child) =>
                              DropdownButtonFormField<SubCategorySelection>(
                            value: sCsP.subCategorySelection,
                            items: sCsP.filterSubValues
                                .map<DropdownMenuItem<SubCategorySelection>>(
                                    (e) {
                              return DropdownMenuItem<SubCategorySelection>(
                                value: e.value!,
                                child: Text(e.value!.subName),
                              );
                            }).toList(),
                            onChanged: (subValue) {
                              sCsP.onChangeSubValue(subValue);
                            },
                            validator: (value) {
                              value == null ? 'select Sub category' : null;
                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.category,
                                color: Color.fromARGB(255, 153, 90, 67),
                              ),
                              hintText: "Choose Sub category",
                              label: Text(
                                'Sub Category',
                                style: TextStyle(
                                    color: const Color(0xFFFF7643),
                                    fontSize: 14.sp),
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
                            label: Text(
                              'Product name',
                              style: TextStyle(
                                  color: const Color(0xFFFF7643),
                                  fontSize: 14.sp),
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
                            } else if (!RegExp(r'^[a-zA-Z]+(?:\s[a-zA-Z]+)+$')
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
                            label: Text(
                              'Product Brand',
                              style: TextStyle(
                                  color: const Color(0xFFFF7643),
                                  fontSize: 14.sp),
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
                            } else if (!RegExp(r"^[#.0-9a-zA-Z\s,-]+$")
                                .hasMatch(value)) {
                              return 'Please enter valid brand name.';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
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
                      } else if (!RegExp(r'^[#.0-9a-zA-Z\s,-]+$')
                          .hasMatch(value)) {
                        return 'Please enter valid product detials';
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
                            label: Text(
                              'Product Price',
                              style: TextStyle(
                                  color: const Color(0xFFFF7643),
                                  fontSize: 14.sp),
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
                            label: Text(
                              'Discount price',
                              style: TextStyle(
                                  color: const Color(0xFFFF7643),
                                  fontSize: 14.sp),
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
                          style: TextStyle(fontSize: 15.sp),
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
                          style: TextStyle(fontSize: 15.sp),
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
                          style: TextStyle(fontSize: 15.sp),
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
                      onPressed: () => _updateProductOnFirebase(
                        context,
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color(0xFFFF7643),
                        ),
                      ),
                      child: Text(
                        'save',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
