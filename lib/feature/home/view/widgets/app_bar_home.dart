import 'package:flutter/material.dart';

import '../../../../core/models/news_model.dart';
import '../../../../core/theme/app_color.dart';

class AppBarHome{
  static AppBar buildAppBar(NewsModel? selectedModel) {
    return AppBar(
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: AppColor.white),
      centerTitle: true,
      title: Text(
        selectedModel == null ? 'Home' : selectedModel.title,
        style: TextStyle(
          fontSize: 20,
          color: AppColor.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.search, color: AppColor.white),
        )
      ],
    );
  }

}
