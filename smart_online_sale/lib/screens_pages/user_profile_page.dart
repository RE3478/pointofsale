import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smart_online_sale/providers/image_gallery_provider.dart';
import 'package:smart_online_sale/providers/user_profile_provider.dart';

// ignore: must_be_immutable
class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);
  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _postalAddressController = TextEditingController();

  void _saveAndPushOnFireBase(BuildContext contex) async {
    bool isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (!isValid) {
      return;
    }

    _formKey.currentState!.save();
    Provider.of<SaveUserProfileProvider>(context, listen: false).saveUserProfie(
      context,
      _nameController.text.trim(),
      _phoneNumberController.text,
      _postalAddressController.text.trim(),
      Provider.of<GalleryImageProvider>(context, listen: false).profile!,
    );
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<GalleryImageProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15.h,
                    ),
                    Center(
                      child: Text(
                        'User Profile ',
                        style: TextStyle(
                            color: const Color(0xFFFF7643),
                            fontWeight: FontWeight.bold,
                            fontSize: 34.h),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Center(
                      child: Consumer<GalleryImageProvider>(
                        builder: (context, gIP, child) => GestureDetector(
                          onTap: () async {
                            await gIP.uploadImage();
                          },
                          child: Container(
                            child: gIP.profile == null
                                ? CircleAvatar(
                                    radius: 65.h,
                                    child: Image.asset(
                                        'assets/images/profile1.png'),
                                  )
                                : CircleAvatar(
                                    radius: 65.h,
                                    backgroundImage: MemoryImage(gIP.profile!),
                                  ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'Enter full name',
                        label: const Text(
                          'Name',
                          style: TextStyle(color: Color(0xFFFF7643)),
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
                          return 'Please enter your name';
                        } else if (!RegExp(r"^[a-zA-Z]+(?:\s[a-zA-Z]+)+$")
                            .hasMatch(value)) {
                          return 'Please enter valid name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    TextFormField(
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: '0321-1234567',
                        label: const Text('Phone number',
                            style: TextStyle(color: Color(0xFFFF7643))),
                        prefixIcon: const Icon(
                          Icons.phone,
                          color: Color.fromARGB(255, 153, 90, 67),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter mobile no';
                        } else if (!RegExp(r'^[03][0-9]{10,}$')
                            .hasMatch(value)) {
                          return 'Please enter valid mobile no';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    TextFormField(
                      controller: _postalAddressController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.location_on,
                          color: Color.fromARGB(255, 153, 90, 67),
                        ),
                        hintText: 'Enter postal address',
                        label: const Text('Postal Address',
                            style: TextStyle(color: Color(0xFFFF7643))),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      validator: ((value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter postal address';
                        } else if (!RegExp(r'^[#.0-9a-zA-Z\s,-]+$')
                            .hasMatch(value)) {
                          return 'please enter valid postal address';
                        }
                        return null;
                      }),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    SizedBox(
                      height: 50.h,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          _saveAndPushOnFireBase(context);
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            const Color(0xFFFF7643),
                          ),
                        ),
                        child: Text(
                          'save',
                          style: Theme.of(context).textTheme.button,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
