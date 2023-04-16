import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smart_online_sale/providers/search_provider.dart';
import 'package:smart_online_sale/utils/constant.dart';

class SearchingBar extends StatelessWidget {
  const SearchingBar({
    Key? key,
    required this.searchController,
  }) : super(key: key);

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    Provider.of<SearchProvider>(context, listen: false);
    return Container(
      width: 240.w,
      height: 45.h,
      decoration: BoxDecoration(
        color: kSecondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: TextFormField(
        onChanged: (value) {
          // Provider.of<SearchProvider>(context, listen: false).setQuery(value);
        },
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
