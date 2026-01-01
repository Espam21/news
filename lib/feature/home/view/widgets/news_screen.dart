
import 'package:flutter/material.dart';
import 'package:news/core/models/news_model.dart';
import 'package:news/feature/home/view%20model/news_view_model.dart';
import 'package:news/feature/home/view/web_view_home_screen.dart';
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
                          return InkWell(
                            onTap: (){
                              if(article.url!=null&&article.url!.isNotEmpty){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewHomeScreen(url:article.url! ),));
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              margin: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: AppColor.white),
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      article.urlToImage ?? '',
                                      height: 220,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return SizedBox(
                                          height: 220,
                                          child: Center(
                                            child: Icon(
                                              Icons.image_not_supported_outlined,
                                              color: AppColor.white,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    article.title ?? '',
                                    style: TextStyle(
                                      color: AppColor.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'by ${article.author ?? ''}',
                                          style: TextStyle(color: AppColor.white),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        timeAgoSinceDate(
                                          article.publishedAt ?? '',
                                        ),
                                        style: TextStyle(color: AppColor.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  String timeAgoSinceDate(String time, {bool numericDates = true}) {
    DateTime date = DateTime.parse(time).toLocal();
    final date2 = DateTime.now().toLocal();
    final difference = date2.difference(date);

    if (difference.inSeconds < 5) {
      return 'Just now';
    } else if (difference.inSeconds <= 60) {
      return '${difference.inSeconds} seconds ago';
    } else if (difference.inMinutes <= 1) {
      return (numericDates) ? '1 minute ago' : 'A minute ago';
    } else if (difference.inMinutes <= 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours <= 1) {
      return (numericDates) ? '1 hour ago' : 'An hour ago';
    } else if (difference.inHours <= 60) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays <= 1) {
      return (numericDates) ? '1 day ago' : 'Yesterday';
    } else if (difference.inDays <= 6) {
      return '${difference.inDays} days ago';
    } else if ((difference.inDays / 7).ceil() <= 1) {
      return (numericDates) ? '1 week ago' : 'Last week';
    } else if ((difference.inDays / 7).ceil() <= 4) {
      return '${(difference.inDays / 7).ceil()} weeks ago';
    } else if ((difference.inDays / 30).ceil() <= 1) {
      return (numericDates) ? '1 month ago' : 'Last month';
    } else if ((difference.inDays / 30).ceil() <= 30) {
      return '${(difference.inDays / 30).ceil()} months ago';
    } else if ((difference.inDays / 365).ceil() <= 1) {
      return (numericDates) ? '1 year ago' : 'Last year';
    }
    return '${(difference.inDays / 365).floor()} years ago';
  }
}
