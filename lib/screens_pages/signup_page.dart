import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smart_online_sale/providers/password_provider.dart';
import 'package:smart_online_sale/providers/signup_provider.dart';
import 'package:smart_online_sale/utils/routes_redirection.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _userTypeController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _submitSignUpForm(BuildContext context) {
    bool isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    Provider.of<SignUpProvider>(context, listen: false).onSubmittedSignUpForm(
      context,
      _nameController.text.trim(),
      _userTypeController.text.trim(),
      _emailController.text,
      _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    var passwordProvider =
        Provider.of<PasswordProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: const Color.fromARGB(243, 241, 242, 242),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, bottom: 20),
              child: ListView(
                children: [
                  SizedBox(height: 150.h),
                  Center(
                    child: Text(
                      'WelCome to Account Creation',
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  Center(
                    child: Text(
                      'SignUp with Email',
                      style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  TextFormField(
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Enter full name ',
                      label: Text('Your name',
                          style: TextStyle(
                              fontSize: 16.sp, color: const Color(0xFFFF7643))),
                      prefixIcon: const Icon(Icons.person,
                          color: Color.fromARGB(255, 153, 90, 67)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter full name';
                      } else if (!RegExp(r"^[a-zA-Z]+(?:\s[a-zA-Z]+)+$")
                          .hasMatch(value)) {
                        return 'Please enter valid name';
                      }
                      return null;
                    }),
                  ),
                  SizedBox(height: 20.h),
                  TextFormField(
                    controller: _userTypeController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Enter user type name here',
                      label: Text(
                        'admin/manager/staff/customer',
                        style: TextStyle(
                            fontSize: 16.sp, color: const Color(0xFFFF7643)),
                      ),
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Color.fromARGB(255, 153, 90, 67),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your type name admin/manager/staff/customer';
                      } else if (!RegExp(r"^[a-zA-Z]+$").hasMatch(value)) {
                        return 'Please enter valid user type name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.h),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Enter email here',
                      label: Text('Email',
                          style: TextStyle(
                              fontSize: 16.sp, color: const Color(0xFFFF7643))),
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Color.fromARGB(255, 153, 90, 67),
                      ),
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
                  SizedBox(height: 20.h),
                  Consumer<PasswordProvider>(
                    builder: ((context, pp, child) => TextFormField(
                          obscureText: pp.isObscure,
                          controller: _passwordController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              hintText: 'Enter password here',
                              label: Text('Password',
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      color: const Color(0xFFFF7643))),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              prefixIcon: const Icon(
                                Icons.vpn_key,
                                color: Color.fromARGB(255, 153, 90, 67),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () =>
                                    passwordProvider.isToggleObscure(),
                                icon: Icon(pp.isObscure
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                color: pp.isObscure
                                    ? const Color.fromARGB(255, 199, 98, 61)
                                    : const Color.fromARGB(255, 106, 100, 98),
                              )),
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
                  SizedBox(height: 10.h),
                  SizedBox(
                    height: 50.h,
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        _submitSignUpForm(context);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color(0xFFFF7643),
                        ),
                      ),
                      child: Text(
                        'Sign Up',
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
                              text: 'Already have an account? ',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                            TextSpan(
                              text: 'Login',
                              style: TextStyle(
                                color: const Color(0xFFFF7643),
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.pushReplacementNamed(
                                    context, RouteGenerator.login),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
