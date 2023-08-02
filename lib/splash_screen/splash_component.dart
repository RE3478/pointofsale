import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/constant.dart';
import '../../utils/size_config.dart';

class SplashContent extends StatelessWidget {
  final String text, image;
  const SplashContent({
    Key? key,
    required this.text,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Text(
          'MultiStore',
          style: TextStyle(
            fontSize: getProportionateScreenWidth(28.h),
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(text),
        const Spacer(),
        Image.asset(
          image,
          height: getProportionateScreenHeight(265.h),
          width: getProportionateScreenWidth(235.w),
        ),
      ],
    );
  }
}
