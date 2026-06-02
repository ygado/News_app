import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/modules/login_views/cubit/login_states.dart';
import 'package:news_app/modules/login_views/login_views.dart';

import '../../shared/component/components.dart';
import '../login_views/cubit/login_cubit.dart';

class RegisterViews extends StatefulWidget {
  const RegisterViews({super.key});

  @override
  State<RegisterViews> createState() => _RegisterViewsState();
}

class _RegisterViewsState extends State<RegisterViews> {
  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    userController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginStates>(
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Scaffold(
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(20.r),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          defaultText(
                            text: 'Register',
                            color: cubit.isDark ? Colors.white : Colors.black,
                            fontSize: 50.sp,
                          ),
                          defaultSizeBox(height: 15.h),
                          defaultTextFormField(
                            controller: userController,
                            keyboardType: TextInputType.text,
                            onFieldSubmitted: (value) {
                              debugPrint(value);
                            },
                            onChanged: (value) {
                              debugPrint(value);
                            },
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'You Must Enter Name';
                              }
                              final regExp = RegExp(
                                r'^[a-zA-Z0-9][a-zA-Z0-9._]{2,18}[a-zA-Z0-9]$',
                              );
                              if (!regExp.hasMatch(value)) {
                                return 'Must be 4-20 characters. No spaces or special characters allowed.';
                              }
                              return null;
                            },
                            hintText: 'Enter Your Name',
                            labelText: 'Enter Your Name',
                            prefixIcon: Icons.text_increase,
                          ),
                          defaultSizeBox(height: 15.h),
                          defaultTextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            onFieldSubmitted: (value) {
                              debugPrint(value);
                            },
                            onChanged: (value) {
                              debugPrint(value);
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'You Must Enter Email';
                              }
                              final regExp = RegExp(
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                              );
                              if (!regExp.hasMatch(value)) {
                                return 'Enter Valid Email example@domain.com';
                              }
                              return null;
                            },
                            hintText: 'Enter Your Email',
                            labelText: 'Enter Your Email',
                            prefixIcon: Icons.email_outlined,
                          ),
                          defaultSizeBox(height: 15.h),
                          defaultTextFormField(
                            obscureText: cubit.enterPassword,
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            onFieldSubmitted: (value) {
                              debugPrint(value);
                            },
                            onChanged: (value) {
                              debugPrint(value);
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'You Must Enter Password';
                              }
                              if (value.length < 6) {
                                return 'You Must Enter Valid Password';
                              }
                              return null;
                            },
                            hintText: 'Enter Your Password',
                            labelText: 'Enter Your Password',
                            prefixIcon: Icons.lock_outline,
                            suffixIcon: cubit.enterPassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            onPressed: () {
                              cubit.changeEnterPassword();
                            },
                          ),
                          defaultSizeBox(height: 15.h),
                          defaultTextFormField(
                            obscureText: cubit.confirmPassword,
                            controller: confirmPasswordController,
                            keyboardType: TextInputType.visiblePassword,
                            onFieldSubmitted: (value) {
                              debugPrint(value);
                            },
                            onChanged: (value) {
                              debugPrint(value);
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'You Must Confirm Password';
                              }
                              if (value.length < 6) {
                                return 'You Must Enter Valid Password';
                              }
                              return null;
                            },
                            hintText: 'Confirm Your Password',
                            labelText: 'Confirm Your Password',
                            prefixIcon: Icons.lock_outline,
                            suffixIcon: cubit.confirmPassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            onPressed: () async {
                              cubit.changeConfirmPassword();
                            },
                          ),
                          defaultSizeBox(height: 10.h),
                          defaultMaterialButton(
                            text: 'Register',
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              if (formKey.currentState!.validate()) {
                                if (passwordController.text !=
                                    confirmPasswordController.text) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: cubit.isDark
                                          ? Color(0xff333333)
                                          : Colors.white,
                                      content: defaultText(
                                        text: 'Password does not match',
                                        fontSize: 17.sp,
                                        color: cubit.isDark
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  );
                                  return;
                                }
                                bool checkEmail = await cubit.checkEmail(
                                  email: emailController.text,
                                );
                                if (checkEmail) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: cubit.isDark
                                          ? Color(0xff333333)
                                          : Colors.white,
                                      content: defaultText(
                                        text: 'Email Already Exist',
                                        fontSize: 17.sp,
                                        color: cubit.isDark
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  );
                                } else {
                                  cubit.insertDataBase(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    userName: userController.text,
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: cubit.isDark
                                          ? Color(0xff333333)
                                          : Colors.white,
                                      content: defaultText(
                                        text: 'Register Successfully',
                                        fontSize: 17.sp,
                                        color: cubit.isDark
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  );
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return LoginViews();
                                      },
                                    ),
                                    (route) => false,
                                  );
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
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
