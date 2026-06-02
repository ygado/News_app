import 'dart:async';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/shared/component/components.dart';

import '../../layout/cubit/news_cubit.dart';
import '../../layout/cubit/news_states.dart';

class SearchViews extends StatefulWidget {
  const SearchViews({super.key});

  @override
  State<SearchViews> createState() => _SearchViewsState();
}

class _SearchViewsState extends State<SearchViews> {
  var formKey = GlobalKey<FormState>();
  Timer? _debounce;
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    _debounce?.cancel();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: defaultTextFormField(
                controller: searchController,
                onChanged: (value) {
                  if (_debounce?.isActive ?? false) _debounce!.cancel();
                  _debounce = Timer(Duration(milliseconds: 500), () {
                    NewsCubit.get(context).searchData(value);
                  });
                },
                hintText: 'Search',
                labelText: 'Search',
                prefixIcon: Icons.search_outlined,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'You Must Enter Your Search';
                  }
                  return null;
                },
              ),
            ),
          ),
          defaultSizeBox(height: 15.h),
          Expanded(
            child: BlocBuilder<NewsCubit, NewsStates>(
              builder: (context, state) {
                var cubit = NewsCubit.get(context);
                var list = cubit.searchArticles;

                return ConditionalBuilder(
                  condition: state is! NewsSearchDataLoadingStates,
                  fallback: (context) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.blue,
                        ),
                        SizedBox(height: 20.h),
                        defaultText(
                          text: 'Searching...',
                          fontSize: 16.sp,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  builder: (context) {
                    if (list.isEmpty && searchController.text.isNotEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 80.sp,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 20.h),
                            defaultText(
                              text: 'No Results Found',
                              fontSize: 18.sp,
                              color: Colors.grey,
                            ),
                            defaultText(
                              text: 'Try a different search term',
                              fontSize: 14.sp,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      );
                    }
                    if (list.isEmpty && searchController.text.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.search, size: 80.sp, color: Colors.grey),
                            SizedBox(height: 20.h),
                            defaultText(
                              text: 'Search for News',
                              fontSize: 18.sp,
                              color: Colors.grey,
                            ),
                            defaultText(
                              text: 'Type something in the search box above',
                              fontSize: 14.sp,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      );
                    }
                    return ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return defaultArticleModel(context, list[index]);
                      },
                      separatorBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            height: 1,
                            width: double.infinity,
                            color: Colors.grey.withOpacity(0.3),
                          ),
                        );
                      },
                      itemCount: list.length,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
