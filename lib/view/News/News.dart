import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:r_creative/Controller/Services/News_service.dart';
import 'package:r_creative/contants/color.dart';
import 'package:r_creative/model/Get_news_Model.dart';
import 'package:r_creative/view/widgets/Coustom_AppBar.dart';

class News extends StatelessWidget {
  const News({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "News", onLeadingPressed: () {}, actions: [
        IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
      ]),
      body: SafeArea(
        child: FutureBuilder<GetNews?>(
          future: NewsService().fetchNews(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: MyColors.mycolor3));
            } else if (snapshot.hasError || snapshot.data == null) {
              return _errorWidget(context);
            }
            final newsList = snapshot.data!.news.news;
            return newsList.isEmpty
                ? const Center(child: Text("No news available"))
                : RefreshIndicator(
                    color: MyColors.mycolor3,
                    onRefresh: () async => (context as Element).markNeedsBuild(),
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: newsList.length,
                      itemBuilder: (context, index) => NewsCard(newsItem: newsList[index]),
                    ),
                  );
          },
        ),
      ),
    );
  }
}

Widget _errorWidget(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error_outline, size: 48, color: Colors.grey[400]),
        const SizedBox(height: 16),
        const Text("Failed to load news", style: TextStyle(fontSize: 16, color: Colors.grey)),
        const SizedBox(height: 8),
        ElevatedButton(onPressed: () => (context as Element).markNeedsBuild(), child: const Text("Retry")),
      ],
    ),
  );
}

class NewsCard extends StatelessWidget {
  final NewsElement newsItem;
  const NewsCard({super.key, required this.newsItem});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('MMM dd, yyyy • h:mm a').format(newsItem.createdAt.toLocal());
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.grey.shade200)),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _showNewsDetail(context, newsItem),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 4, height: 40, color: MyColors.mycolor3),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(newsItem.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), maxLines: 2, overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 8),
                        Text(newsItem.description, style: TextStyle(fontSize: 14, color: Colors.grey.shade800, height: 1.3), maxLines: 3, overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(formattedDate, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey.shade400),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  void _showNewsDetail(BuildContext context, NewsElement newsItem) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) => NewsDetailBottomSheet(newsItem: newsItem),
    );
  }
}

class NewsDetailBottomSheet extends StatelessWidget {
  final NewsElement newsItem;
  const NewsDetailBottomSheet({super.key, required this.newsItem});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('MMM dd, yyyy • h:mm a').format(newsItem.createdAt.toLocal());
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      maxChildSize: 0.9,
      minChildSize: 0.4,
      expand: false,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(width: 40, height: 5, color: Colors.grey.shade300, margin: const EdgeInsets.only(bottom: 24)),
                ),
                Text(newsItem.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Text(formattedDate, style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
                const SizedBox(height: 24),
                Text(newsItem.description, style: const TextStyle(fontSize: 16, height: 1.5)),
              ],
            ),
          ),
        );
      },
    );
  }
}
