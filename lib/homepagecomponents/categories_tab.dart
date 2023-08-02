import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    // List<Map<String, dynamic>> categories = [
    //   {"Icon": "images/glap.png", "text": "glap"},
    //   {"Icon": "images/shoes2.png", "text": "shoes"},
    //   {"Icon": "images/tshirt.png", "text": "clothes"},
    //   {"Icon": "images/glap.png", "text": "glap"},
    //   {"Icon": "images/shoes2.png", "text": "shoes"},
    //   {"Icon": "images/tshirt.png", "text": "clothes"},
    //   {"Icon": "images/glap.png", "text": "glap"},
    //   {"Icon": "images/shoes2.png", "text": "shoes"},
    //   {"Icon": "images/tshirt.png", "text": "clothes"},
    // ];
    return SizedBox(
      width: 10.h,
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFFECDF),
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
      ),
    );
  }
}
