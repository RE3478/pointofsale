import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smart_online_sale/modells/product_detials.dart';
import 'package:smart_online_sale/providers/add_product_provider.dart';
import 'package:smart_online_sale/providers/category_drop_down_provider.dart';
import 'package:smart_online_sale/providers/image_gallery_provider.dart';
import 'package:smart_online_sale/providers/login_provider.dart';
import 'package:smart_online_sale/providers/multi_image_provider.dart';
import 'package:smart_online_sale/providers/password_provider.dart';
import 'package:smart_online_sale/providers/product_updation_provider.dart';
import 'package:smart_online_sale/providers/search_provider.dart';
import 'package:smart_online_sale/providers/signup_provider.dart';
import 'package:smart_online_sale/providers/switch_list_provider.dart';
import 'package:smart_online_sale/providers/user_profile_provider.dart';
import 'package:smart_online_sale/themes/theme_data.dart';
import 'package:smart_online_sale/utils/routes_redirection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCibv1zm415XdM1y8QoVDBUGZ27V0pWVLM",
            authDomain: "pointofonlinesales.firebaseapp.com",
            projectId: "pointofonlinesales",
            storageBucket: "pointofonlinesales.appspot.com",
            messagingSenderId: "1038308329202",
            appId: "1:1038308329202:web:29fffbae9bd6a2cadd326b"));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: ((context, child) => MultiProvider(
                providers: [
                  ChangeNotifierProvider(
                    create: (_) => PasswordProvider(),
                  ),
                  ChangeNotifierProvider(
                    create: (_) => SignUpProvider(),
                  ),
                  ChangeNotifierProvider(
                    create: (_) => LoginProvider(),
                  ),
                  ChangeNotifierProvider(
                    create: (_) => SaveUserProfileProvider(),
                  ),
                  ChangeNotifierProvider(
                    create: (_) => GalleryImageProvider(),
                  ),
                  ChangeNotifierProvider(
                    create: (_) => AddProductProvider(),
                  ),
                  ChangeNotifierProvider(
                    create: (_) => ProductUpdationProvider(),
                  ),
                  ChangeNotifierProvider(
                    create: (_) => MultiImageProvider(),
                  ),
                  ChangeNotifierProvider(
                    create: (_) => CategoryProviderForDropDown(),
                  ),
                  ChangeNotifierProvider(
                    create: (_) => SwitchListTileStockProvider(),
                  ),
                  ChangeNotifierProvider(
                    create: (_) => SwitchListTilePopularProvider(),
                  ),
                  ChangeNotifierProvider(
                    create: (_) => SwitchListTileFavouriteProvider(),
                  ),
                  ChangeNotifierProvider(create: (_) => SearchProvider()),
                  StreamProvider<List<ProductDetails>>(
                      create: (_) => FirebaseFirestore.instance
                          .collection('products')
                          .snapshots()
                          .map((snapshot) => snapshot.docs
                              .map((doc) => ProductDetails.fromMap(doc))
                              .toList()),
                      initialData: const [])
                ],
                child: MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'Attendance Register',
                    theme: themeData(),
                    initialRoute: RouteGenerator.splash,
                    onGenerateRoute: RouteGenerator.generateRoute))));
  }
}
