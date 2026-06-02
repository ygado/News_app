import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/component/components.dart';
import '../login_views/cubit/login_cubit.dart';
import '../login_views/cubit/login_states.dart';
import '../login_views/login_views.dart';
import 'changePassword.dart';

class SettingProfile extends StatelessWidget {
  const SettingProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    await cubit.updateProfileImage();
                  },
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: cubit.userImage != null
                        ? FileImage(File(cubit.userImage!))
                        : AssetImage('assets/images/avatar.png'),
                    // child: cubit.userImage == null
                    //     ? const Icon(Icons.person, size: 40)
                    //     : null,
                  ),
                ),
                defaultSizeBox(height: 15.h),
                Text(
                  cubit.userName ?? '',
                  style: TextStyle(
                    fontSize: 22.sp,
                    color: cubit.isDark ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                defaultSizeBox(height: 15.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    width: double.infinity,
                    height: 35.h,
                    decoration: BoxDecoration(
                      color: cubit.isDark ? Colors.grey[800] : Colors.blue[100],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Text(
                              'ThemeMode',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: cubit.isDark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                          Spacer(),
                          Switch(
                            value: cubit.isDark,
                            onChanged: (value) {
                              cubit.changeMode(value);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                defaultSizeBox(height: 5.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: defaultMaterialButton(
                    text: 'ChangePassword',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ChangePassword();
                          },
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: defaultMaterialButton(
                    text: 'Logout',
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => LoginViews()),
                        (route) => false,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
