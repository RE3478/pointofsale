import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarouselSilderWigdet extends StatelessWidget {
  const CarouselSilderWigdet({
    Key? key,
    required this.images,
  }) : super(key: key);

  final List images;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: images
          .map(
            (e) => Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.r),
                    child: Image.network(
                      e,
                      width: double.infinity.w,
                      height: 180.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Container(
                    height: 180.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        gradient: LinearGradient(colors: [
                          Colors.amber.shade400.withOpacity(0.4),
                          Colors.blue.shade400.withOpacity(0.4)
                        ])),
                  ),
                ),
                Positioned(
                  bottom: 37.h,
                  left: 10.h,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "TITLE",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
          .toList(),
      options: CarouselOptions(
        height: 215.h,
        autoPlay: true,
      ),
    );
  }
}
