import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_online_sale/components/default_button.dart';
import 'package:smart_online_sale/splash_screen/splash_component.dart';
import 'package:smart_online_sale/utils/constant.dart';
import 'package:smart_online_sale/utils/routes_redirection.dart';
import 'package:smart_online_sale/utils/size_config.dart';


class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashList = [
    {
      "text": "Welcome to MultiStore, Let’s shop!",
      "image": "images/splash_1.png"
    },
    {
      "text": "We help people conect with store \naround Pakistan N Abord",
      "image": "images/splash_2.png"
    },
    {
      "text": "We show the easy way to shop. \nJust stay at home with us",
      "image": "images/splash_3.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: PageView.builder(
              onPageChanged: ((value) {
                setState(() {
                  currentPage = value;
                });
              }),
              itemCount: splashList.length,
              itemBuilder: (context, index) => SplashContent(
                text: splashList[index]["text"].toString(),
                image: splashList[index]["image"].toString(),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20.h)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      splashList.length,
                      (index) => buildDot(index: index),
                    ),
                  ),
                  const Spacer(),
                  DefaultButton(
                      text: "Continue",
                      press: () {
                        Navigator.pushReplacementNamed(
                            context, RouteGenerator.login);
                      }),
                  const Spacer(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
          color: currentPage == index ? kPrimaryColor : const Color(0xFFD8D8D8),
          borderRadius: BorderRadius.circular(3)),
    );
  }
}
