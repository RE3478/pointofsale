import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_online_sale/components/btn_icon_incre.dart';
import 'package:smart_online_sale/components/search_bar.dart';
import 'package:smart_online_sale/utils/routes_redirection.dart';
import 'package:smart_online_sale/utils/wigets/carousal_wigdet.dart';
import 'package:smart_online_sale/utils/wigets/text_wigdets.dart';
import '../utils/constant.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({
    super.key,
  });

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage>
    with TickerProviderStateMixin {
  // ignore: prefer_typing_uninitialized_variables
  var tabController;

  @override
  void initState() {
    tabController = TabController(length: 7, vsync: this);
    super.initState();
  }

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Home Screen',
          style: TextStyle(
              color: Colors.black,
              fontSize: 25.sp,
              fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, RouteGenerator.addProduct);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
                elevation: 1,
                child: TabBar(
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Colors.deepOrange.shade400),
                    controller: tabController,
                    isScrollable: true,
                    labelPadding: EdgeInsets.symmetric(horizontal: 20.w),
                    tabs: const [
                      Tab(
                          child: Text('All',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontStyle: FontStyle.italic))),
                      Tab(
                          child: Text('Clothes',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontStyle: FontStyle.italic))),
                      Tab(
                          child: Text('Gadgets',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontStyle: FontStyle.italic))),
                      Tab(
                          child: Text('Grocery',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontStyle: FontStyle.italic))),
                      Tab(
                          child: Text('Electronics',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontStyle: FontStyle.italic))),
                      Tab(
                          child: Text('Shoes',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontStyle: FontStyle.italic))),
                      Tab(
                          child: Text('Cosmetics',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontStyle: FontStyle.italic)))
                    ])),
            Flexible(
              fit: FlexFit.loose,
              child: TabBarView(
                  viewportFraction: 7,
                  controller: tabController,
                  children: [
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            SizedBox(height: 05.h),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 15.w,
                                right: 15.w,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SearchingBar(
                                    searchController: searchController,
                                  ),
                                  BtnIconWithIncrement(
                                    noOfIncre: 3,
                                    press: () {},
                                    imagePng: 'images/shopcart.png',
                                  ),
                                  BtnIconWithIncrement(
                                    noOfIncre: 3,
                                    press: () {},
                                    imagePng: 'icons/bell.png',
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 05.h),
                            CarouselSilderWigdet(images: images),
                            const TextWidgetAll(leftText: 'New Arrival'),
                            Container(
                              height: 260.h,
                              decoration: const BoxDecoration(
                                  color: Colors.transparent),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection("products")
                                      .snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (!snapshot.hasData) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    } else if (snapshot.data == null) {
                                      return const Center(
                                          child: Text(" Data Doesn't exists"));
                                    }
                                    final proData = snapshot.data!.docs;
                                    return GridView.builder(
                                      shrinkWrap: true,
                                      primary: true,
                                      itemCount: proData
                                          .where((e) => e['isFavorite'] == true)
                                          .length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              childAspectRatio: 0.7),
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                top: 5.h,
                                                bottom: 5.h,
                                                left: 10.h,
                                                right: 10.h),
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                    child: Container(
                                                        width: double.infinity,
                                                        alignment:
                                                            Alignment.topRight,
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .transparent,
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    10.r),
                                                            image: DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image: NetworkImage(
                                                                    proData[index]
                                                                            ['imageUrl']
                                                                        [0]))),
                                                        child: IconButton(
                                                            onPressed: () {},
                                                            icon: const Icon(
                                                                Icons.favorite_border)))),
                                                SizedBox(height: 05.h),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10.w),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            proData[index]
                                                                    ['name']
                                                                .toString(),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        Text(
                                                            proData[index][
                                                                    'brandName']
                                                                .toString(),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      8.w),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                  '\$ ${proData[index]['price']}',
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                              SizedBox(
                                                                  width: 20.w),
                                                              Text(
                                                                  '\$ ${proData[index]['discountPrice']}',
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                            Divider(indent: 16, endIndent: 16, height: 2.h),
                            const TextWidgetAll(leftText: 'Popular Products'),
                            Container(
                              height: 150.h,
                              decoration: const BoxDecoration(
                                  color: Colors.transparent),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 05.h, horizontal: 10.w),
                                child: StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection("products")
                                        .snapshots(),
                                    builder: (context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (!snapshot.hasData) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      } else if (snapshot.data == null) {
                                        return const Center(
                                            child: Text("Data Doesn't exits"));
                                      }
                                      final popularData = snapshot.data!.docs;
                                      return ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemCount: popularData
                                              .where(
                                                  (e) => e['isPopular'] == true)
                                              .toList()
                                              .length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {},
                                              child: Row(
                                                children: [
                                                  Container(
                                                      width: 100.h,
                                                      alignment:
                                                          Alignment.topRight,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  Colors.grey),
                                                          color: Colors
                                                              .transparent,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  10.r),
                                                          image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: NetworkImage(
                                                                  popularData[index]
                                                                          ['imageUrl']
                                                                      [0]))),
                                                      child: IconButton(
                                                          onPressed: () {},
                                                          icon: const Icon(
                                                              Icons.favorite_border))),
                                                  SizedBox(width: 05.w),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                            popularData[index]
                                                                    ['name']
                                                                .toString()
                                                                .substring(
                                                                    0, 10),
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        SizedBox(height: 02.h),
                                                        Text(
                                                            popularData[index][
                                                                    'brandName']
                                                                .toString(),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        SizedBox(height: 02.h),
                                                        Text(
                                                            popularData[index]
                                                                ['serialNo'],
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        SizedBox(height: 02.h),
                                                        Text(
                                                            '\$ ${popularData[index]['price']}',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        SizedBox(height: 02.h),
                                                        Text(
                                                            '\$ ${popularData[index]['discountPrice']}',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          });
                                    }),
                              ),
                            ),
                            Divider(indent: 16, endIndent: 16, height: 2.h),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ListView(
                          children: [
                            SizedBox(height: 05.h),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 15.w,
                                right: 15.w,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SearchingBar(
                                    searchController: searchController,
                                  ),
                                  BtnIconWithIncrement(
                                    noOfIncre: 3,
                                    press: () {},
                                    imagePng: 'images/shopcart.png',
                                  ),
                                  BtnIconWithIncrement(
                                    noOfIncre: 3,
                                    press: () {},
                                    imagePng: 'icons/bell.png',
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 05.h),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('products')
                                    .where('category', isEqualTo: 'Clothes')
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.data == null) {
                                    return const Center(
                                        child: Text(" Data Doesn't exists"));
                                  }
                                  final proData = snapshot.data!.docs;

                                  return GridView.builder(
                                    shrinkWrap: true,
                                    primary: true,
                                    itemCount: proData.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 0.7),
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              top: 5.h,
                                              bottom: 5.h,
                                              left: 10.h,
                                              right: 10.h),
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                  child: Container(
                                                      width: double.infinity,
                                                      alignment:
                                                          Alignment.topRight,
                                                      decoration: BoxDecoration(
                                                          color: Colors
                                                              .transparent,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  10.r),
                                                          image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: NetworkImage(
                                                                  proData[index]
                                                                          ['imageUrl']
                                                                      [0]))),
                                                      child: IconButton(
                                                          onPressed: () {},
                                                          icon: const Icon(
                                                              Icons.favorite_border)))),
                                              SizedBox(height: 05.h),
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.w),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          proData[index]['name']
                                                              .toString(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      Text(
                                                          proData[index]
                                                                  ['brandName']
                                                              .toString(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    8.w),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                                '\$ ${proData[index]['price']}',
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                            SizedBox(
                                                                width: 20.w),
                                                            Text(
                                                                '\$ ${proData[index]['discountPrice']}',
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ListView(
                          children: [
                            SizedBox(height: 05.h),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 15.w,
                                right: 15.w,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SearchingBar(
                                    searchController: searchController,
                                  ),
                                  BtnIconWithIncrement(
                                    noOfIncre: 3,
                                    press: () {},
                                    imagePng: 'images/shopcart.png',
                                  ),
                                  BtnIconWithIncrement(
                                    noOfIncre: 3,
                                    press: () {},
                                    imagePng: 'icons/bell.png',
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 05.h),
                            SizedBox(height: 05.h),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('products')
                                    .where('category', isEqualTo: 'Gadgets')
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.data == null) {
                                    return const Center(
                                        child: Text(" Data Doesn't exists"));
                                  }
                                  final proData = snapshot.data!.docs;

                                  return GridView.builder(
                                    shrinkWrap: true,
                                    primary: true,
                                    itemCount: proData.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 0.7),
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              top: 5.h,
                                              bottom: 5.h,
                                              left: 10.h,
                                              right: 10.h),
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                  child: Container(
                                                      width: double.infinity,
                                                      alignment:
                                                          Alignment.topRight,
                                                      decoration: BoxDecoration(
                                                          color: Colors
                                                              .transparent,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  10.r),
                                                          image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: NetworkImage(
                                                                  proData[index]
                                                                          ['imageUrl']
                                                                      [0]))),
                                                      child: IconButton(
                                                          onPressed: () {},
                                                          icon: const Icon(
                                                              Icons.favorite_border)))),
                                              SizedBox(height: 05.h),
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.w),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          proData[index]['name']
                                                              .toString(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      Text(
                                                          proData[index]
                                                                  ['brandName']
                                                              .toString(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    8.w),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                                '\$ ${proData[index]['price']}',
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                            SizedBox(
                                                                width: 20.w),
                                                            Text(
                                                                '\$ ${proData[index]['discountPrice']}',
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ListView(
                          children: [
                            SizedBox(height: 05.h),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 15.w,
                                right: 15.w,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SearchingBar(
                                    searchController: searchController,
                                  ),
                                  BtnIconWithIncrement(
                                    noOfIncre: 3,
                                    press: () {},
                                    imagePng: 'images/shopcart.png',
                                  ),
                                  BtnIconWithIncrement(
                                    noOfIncre: 3,
                                    press: () {},
                                    imagePng: 'icons/bell.png',
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 05.h),
                            SizedBox(height: 05.h),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('products')
                                    .where('category', isEqualTo: 'Grocery')
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.data == null) {
                                    return const Center(
                                        child: Text(" Data Doesn't exists"));
                                  }
                                  final proData = snapshot.data!.docs;

                                  return GridView.builder(
                                    shrinkWrap: true,
                                    primary: true,
                                    itemCount: proData.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 0.7),
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              top: 5.h,
                                              bottom: 5.h,
                                              left: 10.h,
                                              right: 10.h),
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                  child: Container(
                                                      width: double.infinity,
                                                      alignment:
                                                          Alignment.topRight,
                                                      decoration: BoxDecoration(
                                                          color: Colors
                                                              .transparent,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  10.r),
                                                          image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: NetworkImage(
                                                                  proData[index]
                                                                          ['imageUrl']
                                                                      [0]))),
                                                      child: IconButton(
                                                          onPressed: () {},
                                                          icon: const Icon(
                                                              Icons.favorite_border)))),
                                              SizedBox(height: 05.h),
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.w),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          proData[index]['name']
                                                              .toString(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      Text(
                                                          proData[index]
                                                                  ['brandName']
                                                              .toString(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    8.w),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                                '\$ ${proData[index]['price']}',
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                            SizedBox(
                                                                width: 20.w),
                                                            Text(
                                                                '\$ ${proData[index]['discountPrice']}',
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ListView(
                          children: [
                            SizedBox(height: 05.h),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 15.w,
                                right: 15.w,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SearchingBar(
                                    searchController: searchController,
                                  ),
                                  BtnIconWithIncrement(
                                    noOfIncre: 3,
                                    press: () {},
                                    imagePng: 'images/shopcart.png',
                                  ),
                                  BtnIconWithIncrement(
                                    noOfIncre: 3,
                                    press: () {},
                                    imagePng: 'icons/bell.png',
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 05.h),
                            SizedBox(height: 05.h),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('products')
                                    .where('category', isEqualTo: 'Electronics')
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.data == null) {
                                    return const Center(
                                        child: Text(" Data Doesn't exists"));
                                  }
                                  final proData = snapshot.data!.docs;

                                  return GridView.builder(
                                    shrinkWrap: true,
                                    primary: true,
                                    itemCount: proData.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 0.7),
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              top: 5.h,
                                              bottom: 5.h,
                                              left: 10.h,
                                              right: 10.h),
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                  child: Container(
                                                      width: double.infinity,
                                                      alignment:
                                                          Alignment.topRight,
                                                      decoration: BoxDecoration(
                                                          color: Colors
                                                              .transparent,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  10.r),
                                                          image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: NetworkImage(
                                                                  proData[index]
                                                                          ['imageUrl']
                                                                      [0]))),
                                                      child: IconButton(
                                                          onPressed: () {},
                                                          icon: const Icon(
                                                              Icons.favorite_border)))),
                                              SizedBox(height: 05.h),
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.w),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          proData[index]['name']
                                                              .toString(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      Text(
                                                          proData[index]
                                                                  ['brandName']
                                                              .toString(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    8.w),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                                '\$ ${proData[index]['price']}',
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                            SizedBox(
                                                                width: 20.w),
                                                            Text(
                                                                '\$ ${proData[index]['discountPrice']}',
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ListView(
                          children: [
                            SizedBox(height: 05.h),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 15.w,
                                right: 15.w,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SearchingBar(
                                    searchController: searchController,
                                  ),
                                  BtnIconWithIncrement(
                                    noOfIncre: 3,
                                    press: () {},
                                    imagePng: 'images/shopcart.png',
                                  ),
                                  BtnIconWithIncrement(
                                    noOfIncre: 3,
                                    press: () {},
                                    imagePng: 'icons/bell.png',
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 05.h),
                            SizedBox(height: 05.h),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('products')
                                    .where('category', isEqualTo: 'Shoes')
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.data == null) {
                                    return const Center(
                                        child: Text(" Data Doesn't exists"));
                                  }
                                  final proData = snapshot.data!.docs;

                                  return GridView.builder(
                                    shrinkWrap: true,
                                    primary: true,
                                    itemCount: proData.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 0.7),
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              top: 5.h,
                                              bottom: 5.h,
                                              left: 10.h,
                                              right: 10.h),
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                  child: Container(
                                                      width: double.infinity,
                                                      alignment:
                                                          Alignment.topRight,
                                                      decoration: BoxDecoration(
                                                          color: Colors
                                                              .transparent,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  10.r),
                                                          image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: NetworkImage(
                                                                  proData[index]
                                                                          ['imageUrl']
                                                                      [0]))),
                                                      child: IconButton(
                                                          onPressed: () {},
                                                          icon: const Icon(
                                                              Icons.favorite_border)))),
                                              SizedBox(height: 05.h),
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.w),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          proData[index]['name']
                                                              .toString(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      Text(
                                                          proData[index]
                                                                  ['brandName']
                                                              .toString(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    8.w),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                                '\$ ${proData[index]['price']}',
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                            SizedBox(
                                                                width: 20.w),
                                                            Text(
                                                                '\$ ${proData[index]['discountPrice']}',
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ListView(
                          children: [
                            SizedBox(height: 05.h),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 15.w,
                                right: 15.w,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SearchingBar(
                                    searchController: searchController,
                                  ),
                                  BtnIconWithIncrement(
                                    noOfIncre: 3,
                                    press: () {},
                                    imagePng: 'images/shopcart.png',
                                  ),
                                  BtnIconWithIncrement(
                                    noOfIncre: 3,
                                    press: () {},
                                    imagePng: 'icons/bell.png',
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 05.h),
                            SizedBox(height: 05.h),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('products')
                                    .where('category', isEqualTo: 'Cosmetics')
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.data == null) {
                                    return const Center(
                                        child: Text(" Data Doesn't exists"));
                                  }
                                  final proData = snapshot.data!.docs;

                                  return GridView.builder(
                                    shrinkWrap: true,
                                    primary: true,
                                    itemCount: proData.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 0.7),
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              top: 5.h,
                                              bottom: 5.h,
                                              left: 10.h,
                                              right: 10.h),
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                  child: Container(
                                                      width: double.infinity,
                                                      alignment:
                                                          Alignment.topRight,
                                                      decoration: BoxDecoration(
                                                          color: Colors
                                                              .transparent,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  10.r),
                                                          image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: NetworkImage(
                                                                  proData[index]
                                                                          ['imageUrl']
                                                                      [0]))),
                                                      child: IconButton(
                                                          onPressed: () {},
                                                          icon: const Icon(
                                                              Icons.favorite_border)))),
                                              SizedBox(height: 05.h),
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.w),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          proData[index]['name']
                                                              .toString(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      Text(
                                                          proData[index]
                                                                  ['brandName']
                                                              .toString(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    8.w),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                                '\$ ${proData[index]['price']}',
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                            SizedBox(
                                                                width: 20.w),
                                                            Text(
                                                                '\$ ${proData[index]['discountPrice']}',
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
