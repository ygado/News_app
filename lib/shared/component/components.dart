import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/layout/cubit/news_cubit.dart';
import 'package:news_app/models/title_models.dart';
import 'package:news_app/modules/login_views/cubit/login_cubit.dart';

import '../../modules/web_view/web_view.dart';

Widget defaultText({
  required String text,
  double fontSize = 25,
  FontWeight fontWeight = FontWeight.bold,
  TextAlign? textAlign,
  TextOverflow? textOverflow,
  int? maxLines,
  required Color color,
}) => Text(
  maxLines: maxLines,
  overflow: textOverflow,
  text,
  style: TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color),
);

SizedBox defaultSizeBox({double? height, double? width}) =>
    SizedBox(height: height, width: width);

Widget defaultTextFormField({
  bool obscureText = false,
  bool readOnly = false,
  Function(String)? onFieldSubmitted,
  ValueChanged? onChanged,
  Function()? onTap,
  Function()? onPressed,
  FormFieldValidator? validator,
  TextInputType? keyboardType,
  TextEditingController? controller,
  IconData? prefixIcon,
  IconData? suffixIcon,
  required String hintText,
  required String labelText,
}) => TextFormField(
  autovalidateMode: AutovalidateMode.onUserInteraction,
  obscureText: obscureText,
  readOnly: readOnly,
  onFieldSubmitted: onFieldSubmitted,
  onChanged: onChanged,
  onTap: onTap,
  validator: validator,
  keyboardType: keyboardType,
  controller: controller,
  decoration: InputDecoration(
    prefixIcon: Icon(prefixIcon),
    suffixIcon: IconButton(onPressed: onPressed, icon: Icon(suffixIcon)),
    hintText: hintText,
    labelText: labelText,
    border: OutlineInputBorder(),
  ),
);

Widget defaultMaterialButton({required String text, Function()? onPressed}) =>
    Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: double.infinity,
        height: 35.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: Colors.cyan,
        ),
        child: MaterialButton(
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: defaultText(text: text, color: Colors.white, fontSize: 25.sp),
        ),
      ),
    );

Widget defaultItem(
  BuildContext context,
  int index, {
  required ItemModel itemModel,
}) {
  return GestureDetector(
    onTap: () {
      NewsCubit.get(context).changeCategoryCardIndex(index);
      NewsCubit.get(context).getData(
        category: NewsCubit.get(context).categoryCardItem[index].toLowerCase(),
      );
    },
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 95,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              image: DecorationImage(
                image: AssetImage(itemModel.image),
                fit: BoxFit.fill,
              ),
            ),
            child: Center(
              child: defaultText(
                text: itemModel.text,
                color: Colors.white,
                fontSize: 15.sp,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget defaultArticleModel(BuildContext context, article) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return WebScreen(url: article['url']);
          },
        ),
      );
    },
    child: Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Image.network(
                article['urlToImage'] ?? '',
                height: 140.h,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/science.jpeg',
                    height: 140.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
          defaultSizeBox(height: 5.h),
          defaultText(
            text: article['title'] ?? 'No Title',
            fontSize: 20.sp,
            color: LoginCubit.get(context).isDark ? Colors.white : Colors.grey,
            maxLines: 1,
            textOverflow: TextOverflow.ellipsis,
          ),
          defaultSizeBox(height: 5.h),
          defaultText(
            text: article['description'] ?? 'No Description',
            color: LoginCubit.get(context).isDark ? Colors.white : Colors.black,
            fontSize: 20.sp,
            maxLines: 4,
            textOverflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ),
  );
}
