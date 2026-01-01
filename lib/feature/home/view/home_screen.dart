import 'package:flutter/material.dart';
import 'package:news/core/models/news_model.dart';
import 'package:news/core/theme/app_color.dart';
import 'package:news/feature/home/data/api_manger.dart';
import 'package:news/feature/home/view/widgets/app_bar_home.dart';
import 'package:news/feature/home/view/widgets/catogray_screen.dart';
import 'package:news/feature/home/view/widgets/news_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NewsModel? selectedModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      drawer: Drawer(
        backgroundColor: AppColor.black,
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: AppColor.white),
              child: Center(child: Text('news')),
            ),
            ListTile(
              title: Text('Home'),
              titleTextStyle: TextStyle(color: AppColor.white, fontSize: 18),
              leading: Icon(Icons.home, color: AppColor.white),
              onTap: () {
                selectedModel = null;
                setState(() {});
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBarHome.buildAppBar(selectedModel),
      body: selectedModel == null
          ? CatograyScreen(onTap: onSelect)
          : NewsScreen(category: selectedModel!),
    );
  }

  void onSelect(NewsModel model) {
    selectedModel = model;
    setState(() {});
  }
}

//FutureBuilder(
//               future: ApiManger.getNews(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError) {
//                   return Center(
//                     child: Text(
//                       snapshot.error.toString(),
//                       style: TextStyle(color: AppColor.white),
//                     ),
//                   );
//                 } else {
//                   var news = snapshot.data ?? [];
//                   return Column(
//                     children: [
//                       Expanded(
//                         child: ListView.separated(
//                           itemBuilder: (context, index) => Text(
//                             news[index].description??'no title found',
//                             style: TextStyle(color: AppColor.white, fontSize: 18),
//                           ),
//                           separatorBuilder: (context, index) =>
//                               SizedBox(height: 10),
//                           itemCount: news.length,
//                         ),
//                       ),
//                     ],
//                   );
//                 }
//               },
//             ),
