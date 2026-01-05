
import 'package:flutter/material.dart';
import 'package:news/core/models/news_model.dart';
import 'package:news/feature/home/view%20model/news_view_model.dart';
import 'package:news/feature/home/view/web_view_home_screen.dart';
import 'package:news/feature/home/view/widgets/aritcle_widget.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_color.dart';
import '../../data/api_manger.dart';
import '../../data/models/news_response.dart';

class NewsScreen extends StatefulWidget {
  final NewsModel category;

  const NewsScreen({super.key, required this.category});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  NewsViewModel viewModel = NewsViewModel();
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      lazy: false,
      create: (context) => viewModel..getSource(widget.category.id),
      builder: (context, child) {
        return Consumer<NewsViewModel>(
          builder: (context, value, child) => Column(
            children: [
              DefaultTabController(
                length: viewModel.sources.length,
                child: TabBar(
                  onTap: viewModel.onTapChange,
                  overlayColor: WidgetStatePropertyAll(
                    Colors.white.withOpacity(0.2),
                  ),
                  tabAlignment: TabAlignment.start,
                  isScrollable: true,
                  dividerColor: Colors.transparent,
                  indicatorColor: AppColor.white,
                  labelColor: AppColor.white,
                  unselectedLabelColor: AppColor.white,
                  tabs: viewModel.sources.map((e) {
                    return Tab(text: e.name ?? "");
                  }).toList(),
                ),
              ),
              Expanded(
                child: viewModel.isLoading
                    ? Center(child: CircularProgressIndicator(color: AppColor.white,))
                    : ListView.builder(
                        itemBuilder: (context, index) {
                          var article = viewModel.article[index];
                          return AritcleWidget(article: article);
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }


}
