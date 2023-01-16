import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_online_sale/utils/constant.dart';

class SearchingBar extends StatelessWidget {
  const SearchingBar({
    Key? key,
    required this.searchController,
  }) : super(key: key);

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240.w,
      height: 40.h,
      decoration: BoxDecoration(
        color: kSecondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: TextFormField(
        onChanged: (value) {},
        controller: searchController,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: "Product Searching.....",
          prefixIcon: const Icon(Icons.search),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 15.w, vertical: 11.h),
        ),
      ),
    );
  }
}
