import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/news_cubit.dart';
import 'package:news_app/layout/cubit/news_states.dart';
import 'package:news_app/modules/login_views/cubit/login_cubit.dart';
import 'package:news_app/shared/component/components.dart';

class NewsLayout extends StatefulWidget {
  const NewsLayout({super.key});

  @override
  State<NewsLayout> createState() => _NewsLayoutState();
}

class _NewsLayoutState extends State<NewsLayout> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewsCubit>(
      create: (context) => NewsCubit()..getData(category: 'Business'),
      child: BlocBuilder<NewsCubit, NewsStates>(
        builder: (context, state) {
          var cubit = NewsCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              surfaceTintColor: Colors.white,
              title: defaultText(
                text: cubit.currentIndex == 0
                    ? cubit.categoryCardItem[cubit.categoryCardIndex]
                    : cubit.titleAppBar[cubit.currentIndex],
                color: LoginCubit.get(context).isDark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNavBar(index);
              },
              items: cubit.bottomItem,
            ),
            body: cubit.screens[cubit.currentIndex],
          );
        },
      ),
    );
  }
}
