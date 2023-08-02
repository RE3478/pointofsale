import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smart_online_sale/providers/login_provider.dart';
import 'package:smart_online_sale/screens_pages/signup_page.dart';

import '../providers/password_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool showLoader = false;

  void _submitLoginForm(BuildContext context) async {
    bool isvalid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (!isvalid) {
      return;
    }
    _formKey.currentState!.save();
    toggleLoader();
    Provider.of<LoginProvider>(context, listen: false).inLoginForm(
      context,
      _emailController.text,
      _passwordController.text,
      toggleLoader,
    );
  }

  void toggleLoader() {
    setState(() {
      showLoader = !showLoader;
    });
  }

  @override
  Widget build(BuildContext context) {
    final passwordProvider =
        Provider.of<PasswordProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: const Color.fromARGB(243, 241, 242, 242),
      body: showLoader
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 25, right: 25, bottom: 20),
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 150.h,
                      ),
                      Center(
                        child: Text(
                          'Welcome for Login',
                          style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Login with Email',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: 'Enter email',
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Color.fromARGB(255, 153, 90, 67),
                          ),
                          label: Text('Email',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  color: const Color(0xFFFF7643))),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          } else if (!RegExp(
                                  r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                              .hasMatch(value)) {
                            return 'Please enter valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Consumer<PasswordProvider>(
                        builder: ((context, pp, child) => TextFormField(
                              obscureText: pp.isObscure,
                              controller: _passwordController,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                hintText: 'Enter password',
                                label: Text('Passowrd',
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        color: const Color(0xFFFF7643))),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                prefixIcon: const Icon(Icons.vpn_key,
                                    color: Color.fromARGB(255, 153, 90, 67)),
                                suffixIcon: IconButton(
                                  onPressed: () =>
                                      passwordProvider.isToggleObscure(),
                                  icon: Icon(
                                    pp.isObscure
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  color: pp.isObscure
                                      ? const Color.fromARGB(255, 199, 98, 61)
                                      : const Color.fromARGB(255, 106, 100, 98),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter passoword';
                                } else if (value.length < 7) {
                                  return 'required eight digit passoword';
                                } else if (value.length > 12) {
                                  return 'Please enter only twelve digit passoword';
                                }
                                return null;
                              },
                            )),
                      ),
                      SizedBox(height: 07.h),
                      // Align(
                      //   alignment: Alignment.bottomRight,
                      //   child: TextButton(
                      //     onPressed: () {
                      //       Navigator.pushReplacementNamed(
                      //           context, RouteGenerator.forgetPassword);
                      //     },
                      //     child: Text(
                      //       'Forget Password',
                      //       style: TextStyle(
                      //         color: const Color(0xFFFF6743),
                      //         fontWeight: FontWeight.bold,
                      //         fontSize: 15.sp,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: 07.h),
                      SizedBox(
                        height: 56.h,
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () => _submitLoginForm(context),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              const Color(0xFFFF7643),
                            ),
                          ),
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Align(
                          alignment: Alignment.center,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Don’t have an account? ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Register',
                                  style: TextStyle(
                                    color: const Color(0xFFFF7643),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.sp,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const SignUpPage(),
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
