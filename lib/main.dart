import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/modules/home_views/home_views.dart';
import 'package:news_app/modules/login_views/cubit/login_cubit.dart';
import 'package:news_app/modules/login_views/cubit/login_states.dart';
import 'package:news_app/shared/bloc_observer.dart';
import 'package:news_app/shared/network/local/shared_prefeence.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => LoginCubit()..createDataBase()..loadTheme(),
      child: BlocBuilder<LoginCubit, LoginStates>(
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  scaffoldBackgroundColor: Colors.white,
                  appBarTheme: AppBarTheme(
                    backgroundColor: Colors.white,
                    titleSpacing: 20.w,
                    titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 25.sp,
                    ),
                    iconTheme: IconThemeData(color: Colors.black, size: 25.sp),
                  ),
                  inputDecorationTheme: InputDecorationTheme(
                    labelStyle: TextStyle(color: Colors.black, fontSize: 15.sp),
                    hintStyle: TextStyle(color: Colors.black, fontSize: 15.sp),
                    prefixIconColor: Colors.black,
                    suffixIconColor: Colors.black,
                    errorStyle: TextStyle(color: Colors.black, fontSize: 15.sp),
                    border: OutlineInputBorder(),
                  ),
                  colorScheme: ColorScheme.light(onSurface: Colors.black),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.blue,
                    unselectedItemColor: Colors.grey[600],
                    backgroundColor: Colors.white,
                  ),
                ),
                darkTheme: ThemeData(
                  scaffoldBackgroundColor: Color(0xff333333),
                  appBarTheme: AppBarTheme(
                    backgroundColor: Color(0xff333333),
                    titleSpacing: 20.w,
                    titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 25.sp,
                    ),
                    iconTheme: IconThemeData(color: Colors.black, size: 25.sp),
                  ),
                  inputDecorationTheme: InputDecorationTheme(
                    labelStyle: TextStyle(color: Colors.white, fontSize: 15.sp),
                    hintStyle: TextStyle(color: Colors.white, fontSize: 15.sp),
                    prefixIconColor: Colors.white,
                    suffixIconColor: Colors.white,
                    errorStyle: TextStyle(color: Colors.white, fontSize: 15.sp),
                    border: OutlineInputBorder(),
                  ),
                  colorScheme: ColorScheme.dark(onSurface: Colors.white),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.blue,
                    unselectedItemColor: Colors.grey[600],
                    backgroundColor: Colors.black,
                  ),
                ),
                themeMode: LoginCubit.get(context).isDark
                    ? ThemeMode.dark
                    : ThemeMode.light,
                home: HomeViews(),
              );
            },
          );
        },
      ),
    );
  }
}
