import 'package:flutter/material.dart';
import 'package:smart_online_sale/components/body.dart';
import 'package:smart_online_sale/utils/size_config.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const Scaffold(
      body: Body(),
    );
  }
}
