import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/layout/news_layout.dart';
import 'package:news_app/modules/login_views/cubit/login_cubit.dart';
import 'package:news_app/modules/login_views/cubit/login_states.dart';
import 'package:news_app/modules/register_views/register_views.dart';

import '../../shared/component/components.dart';

class LoginViews extends StatefulWidget {
  const LoginViews({super.key});

  @override
  State<LoginViews> createState() => _LoginViewsState();
}

class _LoginViewsState extends State<LoginViews> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
                            text: 'Login',
                            color: cubit.isDark ? Colors.white : Colors.black,
                            fontSize: 50.sp,
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
                            obscureText: cubit.isPassword,
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
                            suffixIcon: cubit.isPassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            onPressed: () {
                              cubit.changeIconEye();
                            },
                          ),
                          defaultSizeBox(height: 10.h),
                          defaultMaterialButton(
                            text: 'Login',
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              if (formKey.currentState!.validate()) {
                                bool isSuccess = await cubit.loginUser(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                                if (isSuccess) {
                                  await cubit.getUserData();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: cubit.isDark
                                          ? Color(0xff333333)
                                          : Colors.white,
                                      content: defaultText(
                                        text: 'Login Successfully',
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
                                      builder: (_) => NewsLayout(),
                                    ),
                                    (route) => false,
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: cubit.isDark
                                          ? Color(0xff333333)
                                          : Colors.white,
                                      content: defaultText(
                                        text: 'Wrong Email Or Password',
                                        fontSize: 17.sp,
                                        color: cubit.isDark
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              defaultText(
                                text: 'Don\'t Have An Account?',
                                color: cubit.isDark
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 17.sp,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return RegisterViews();
                                      },
                                    ),
                                    (route) => false,
                                  );
                                },
                                child: defaultText(
                                  text: 'Register',
                                  color: cubit.isDark
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 17.sp,
                                ),
                              ),
                            ],
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
