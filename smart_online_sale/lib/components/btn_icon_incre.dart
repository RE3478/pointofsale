import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_online_sale/utils/constant.dart';

class BtnIconWithIncrement extends StatelessWidget {
  final String imagePng;
  final int noOfIncre;
  final GestureTapCallback press;
  const BtnIconWithIncrement({
    Key? key,
    required this.noOfIncre,
    required this.imagePng,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      borderRadius: BorderRadius.circular(50.h),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(09),
            height: 35.h,
            width: 35.w,
            decoration: BoxDecoration(
              color: kSecondaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Image.asset(imagePng),
          ),
          if (noOfIncre != 0)
            Positioned(
              top: 4.h,
              right: -2.h,
              child: Container(
                height: 10.h,
                width: 10.h,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(width: 1.5.h, color: Colors.white),
                ),
                child: Center(
                  child: Text(
                    "$noOfIncre",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 06.h,
                      height: 1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
