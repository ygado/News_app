import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/news_states.dart';
import 'package:news_app/modules/news_views/news_views.dart';
import 'package:news_app/modules/search/search_views.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

import '../../modules/settings/setting_profile.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsHomeInitialStates());
  static NewsCubit get(BuildContext context) => BlocProvider.of(context);

  int currentIndex = 0;
  int categoryCardIndex = 0;
  void changeCategoryCardIndex(int index) {
    categoryCardIndex = index;
    emit(NewsChangeCategoryCardIndexStates());
  }

  List<BottomNavigationBarItem> bottomItem = [
    BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
    BottomNavigationBarItem(
      icon: Icon(Icons.search_off_outlined),
      label: 'Search',
    ),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];
  List<String> titleAppBar = ['Home', 'Search', 'Setting'];
  List<String> categoryCardItem = [
    'Business',
    'Entertainment',
    'General',
    'Health',
    'Science',
    'Sports',
    'Technology',
  ];
  List<Widget> screens = [NewsViews(), SearchViews(), SettingProfile()];
  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(NewsChangeBottomNavBarStates());
  }

  List<dynamic> articles = [];
  void getData({required String category}) {
    emit(NewsGetDataLoadingStates());
    debugPrint('Category = $category');
    DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'category': category,
            'country': 'us',
            'apiKey': '15c359358e34441689d02797f26a8261',
          },
        )
        .then((value) {
          articles = value.data['articles'];
          emit(NewsGetDataSuccessfullyStates());
        })
        .catchError((error) {
          debugPrint('Error When Get Data From Api ${error.toString()}');
          emit(NewsGetDataFailureStates());
        });
  }

  List<dynamic> searchArticles = [];
  void searchData(String value) {
    emit(NewsSearchDataLoadingStates());
    searchArticles = [];
    DioHelper.getData(
          url: 'v2/everything',
          query: {'q': value, 'apiKey': '15c359358e34441689d02797f26a8261'},
        )
        .then((value) {
          searchArticles = value.data['articles'];
          emit(NewsSearchDataSuccessfullyStates());
        })
        .catchError((error) {
          debugPrint('Error When Get Data From Api ${error.toString()}');
          emit(NewsSearchDataFailureStates());
        });
  }
}
