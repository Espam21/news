import 'package:flutter/material.dart';
import 'package:news/feature/home/view/search_screen.dart';
import 'package:provider/provider.dart';

import '../../../../core/models/news_model.dart';
import '../../../../core/theme/app_color.dart';
import '../../view model/news_view_model.dart';

class AppBarHome {
  static AppBar buildAppBar(
      BuildContext context,
      NewsModel? selectedModel,
      ) {
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
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChangeNotifierProvider(
              create: (_) => NewsViewModel(),
              child: SearchScreen(),
              ),
            ));
          },
          icon: Icon(Icons.search, color: AppColor.white),
        )
      ],
    );
  }
}

