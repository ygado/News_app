import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/news_cubit.dart';
import 'package:news_app/layout/cubit/news_states.dart';
import 'package:news_app/models/title_models.dart';
import 'package:news_app/shared/component/components.dart';

class NewsViews extends StatelessWidget {
  const NewsViews({super.key});
  final List<ItemModel> itemModel = const [
    ItemModel(image: 'assets/images/business.avif', text: 'Business'),
    ItemModel(image: 'assets/images/entertaiment.avif', text: 'Entertainment'),
    ItemModel(image: 'assets/images/general.avif', text: 'General'),
    ItemModel(image: 'assets/images/health.avif', text: 'Health'),
    ItemModel(image: 'assets/images/science.jpeg', text: 'Science'),
    ItemModel(image: 'assets/images/sports.jpeg', text: 'Sports'),
    ItemModel(image: 'assets/images/technology.jpeg', text: 'Technology'),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsCubit, NewsStates>(
      builder: (context, state) {
        var list = NewsCubit.get(context).articles;
        return ConditionalBuilder(
          condition: state is! NewsGetDataLoadingStates,
          builder: (context) => CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 95,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: itemModel.length,
                    itemBuilder: (context, index) {
                      return defaultItem(
                        itemModel: itemModel[index],
                        context,
                        index,
                      );
                    },
                  ),
                ),
              ),
              SliverList.separated(
                // shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return defaultArticleModel(context, list[index]);
                },
                separatorBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey,
                    ),
                  );
                },
                itemCount: list.length,
              ),
            ],
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
