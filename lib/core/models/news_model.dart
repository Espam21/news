class NewsModel{
  final String id;
  final String title;
  final String image;

  NewsModel({required this.id, required this.title, required this.image});

  static List<NewsModel> newsList = [
    NewsModel(id: 'general', title: 'general', image: 'assets/images/Rectangle 1.png'),
    NewsModel(id: 'business', title: 'business', image: 'assets/images/business.png'),
    NewsModel(id: 'sports', title: 'sports', image: 'assets/images/sports.png'),
    NewsModel(id: 'entertainment', title: 'entertainment', image: 'assets/images/entertainment.png'),
    NewsModel(id: 'health', title: 'medical', image: 'assets/images/medical.png'),
    NewsModel(id: 'technology', title: 'tech', image: 'assets/images/tech.png'),
    NewsModel(id: 'science', title: 'science', image: 'assets/images/science.png'),
  ];
}