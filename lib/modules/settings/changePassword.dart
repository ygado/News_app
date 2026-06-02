import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/modules/login_views/login_views.dart';

import '../../shared/component/components.dart';
import '../login_views/cubit/login_cubit.dart';
import '../login_views/cubit/login_states.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    oldPassword.dispose();
    newPassword.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, index) {},
      builder: (context, index) {
        var cubit = LoginCubit.get(context);
        return Scaffold(
          body: Form(
            key: formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        'UpdatePassword',
                        style: TextStyle(
                          fontSize: 25.sp,
                          fontWeight: FontWeight.bold,
                          color: cubit.isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      defaultSizeBox(height: 15.h),
                      defaultTextFormField(
                        controller: oldPassword,
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (value) {
                          debugPrint(value);
                        },
                        onFieldSubmitted: (value) {
                          debugPrint(value);
                        },
                        obscureText: cubit.isOldPassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'You Must Enter Old Password';
                          }
                          if (value.length < 6) {
                            return 'Please Enter a valid Password';
                          }
                          return null;
                        },
                        labelText: 'Enter Your Old Password',
                        hintText: 'Enter Your Old Password',
                        prefixIcon: Icons.lock_outline,
                        suffixIcon: cubit.isOldPassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        onPressed: () {
                          cubit.changeIconEyeOld();
                        },
                      ),
                      defaultSizeBox(height: 15.h),
                      defaultTextFormField(
                        controller: newPassword,
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (value) {
                          debugPrint(value);
                        },
                        onFieldSubmitted: (value) {
                          debugPrint(value);
                        },
                        obscureText: cubit.isNewPassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'You Must Enter New Password';
                          }
                          if (value.length < 6) {
                            return 'Please Enter a valid Password';
                          }
                          return null;
                        },
                        labelText: 'Enter New Password',
                        hintText: 'Enter New Password',
                        prefixIcon: Icons.lock_outline,
                        suffixIcon: cubit.isNewPassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        onPressed: () {
                          cubit.changeIconEyeNew();
                        },
                      ),
                      defaultSizeBox(height: 15.h),
                      defaultTextFormField(
                        controller: confirmPassword,
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (value) {
                          debugPrint(value);
                        },
                        onFieldSubmitted: (value) {
                          debugPrint(value);
                        },
                        obscureText: cubit.isNewConfirmPassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'You Must Confirm Password';
                          }
                          if (value.length < 6) {
                            return 'Please Enter a valid Password';
                          }
                          return null;
                        },
                        labelText: 'Confirm Your Password',
                        hintText: 'Confirm Your Password',
                        prefixIcon: Icons.lock_outline,
                        suffixIcon: cubit.isNewConfirmPassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        onPressed: () {
                          cubit.changeIconEyeNewConfirm();
                        },
                      ),
                      defaultSizeBox(height: 15.h),
                      defaultMaterialButton(
                        text: 'Update',
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            if (newPassword.text != confirmPassword.text) {
                              return ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Password Does Not Match'),
                                ),
                              );
                            }
                            bool checkPassword = await cubit.checkPassword(
                              password: oldPassword.text,
                            );
                            if (checkPassword) {
                              cubit.updatePassword(
                                oldPassword: oldPassword.text,
                                newPassword: newPassword.text,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Password Updated Successfully',
                                  ),
                                ),
                              );
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (_) => LoginViews()),
                                    (route) => false,
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Password Is Wrong')),
                              );
                            }
                          }
                        }
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
