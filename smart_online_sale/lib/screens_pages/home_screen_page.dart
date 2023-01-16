import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_online_sale/components/btn_icon_incre.dart';
import 'package:smart_online_sale/components/search_bar.dart';
import 'package:smart_online_sale/utils/wigets/carousal_wigdet.dart';
import 'package:smart_online_sale/utils/wigets/text_wigdets.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({super.key});

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage>
    with TickerProviderStateMixin {
  final List images = [
    "https://images.unsplash.com/photo-1585565804112-f201f68c48b4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NzR8fHByb2R1Y3R8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1539185441755-769473a23570?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OTV8fHByb2R1Y3R8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1611186871348-b1ce696e52c9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTAyfHxwcm9kdWN0fGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1610395219791-21b0353e43cb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=869&q=80",
    "https://images.unsplash.com/photo-1614169020226-0881cc29d64f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8Mnw2MDA4MzE4OHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1584590069631-1c180f90a54c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTU5fHxwcm9kdWN0fGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
    "https://plus.unsplash.com/premium_photo-1664283229426-4d10dae7cd08?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTkzfHxwcm9kdWN0fGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1602810316498-ab67cf68c8e1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1yZWxhdGVkfDh8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60"
  ];

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
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 15.w,
                right: 15.w,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SearchingBar(
                    searchController: searchController,
                  ),
                  Row(
                    children: [
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
                ],
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
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
                                fontStyle: FontStyle.italic))),
                  ]),
            ),
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
                            CarouselSilderWigdet(images: images),
                            const TextWidgetAll(leftText: 'New Arrival'),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('products')
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.data == null) {
                                    return const Center(
                                        child: Text(" Data Doesn't exist"));
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
                                          margin: EdgeInsets.all(10.h),
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(05.r),
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
                                                  alignment: Alignment.topRight,
                                                  decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.r),
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                        proData[index]
                                                            ['imageUrl'][0],
                                                      ),
                                                    ),
                                                  ),
                                                  child: IconButton(
                                                      onPressed: () {},
                                                      icon: const Icon(Icons
                                                          .favorite_border)),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 05.h,
                                              ),
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
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(
                                                        proData[index]
                                                                ['brandName']
                                                            .toString(),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
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
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20.w,
                                                            ),
                                                            Text(
                                                              '\$ ${proData[index]['discountPrice']}',
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
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
                            Divider(
                              indent: 16,
                              endIndent: 16,
                              height: 2.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Text("Hello World $index");
                          },
                        ),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Text("Hello World $index");
                          },
                        ),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Text("Hello World $index");
                          },
                        ),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Text("Hello World $index");
                          },
                        ),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Text("Hello World $index");
                          },
                        ),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Text("Hello World $index");
                          },
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
