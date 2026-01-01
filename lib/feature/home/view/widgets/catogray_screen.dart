import 'package:flutter/material.dart';

import '../../../../core/models/news_model.dart';
import '../../../../core/theme/app_color.dart';
import 'news_widget.dart';

class CatograyScreen extends StatelessWidget {
  Function(NewsModel) onTap;

  CatograyScreen({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            'Good Morning\n Here is Some News For You',
            style: TextStyle(
              color: AppColor.white,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => NewsWidget(
                model: NewsModel.newsList[index],
                isLeft: index % 2 == 0,
                onTap: () {
                  onTap(NewsModel.newsList[index]);
                },
              ),
              separatorBuilder: (context, index) => SizedBox(height: 16),
              itemCount: NewsModel.newsList.length,
            ),
          ),
        ],
      ),
    );
  }
}
