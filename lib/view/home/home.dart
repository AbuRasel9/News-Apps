import 'package:flutter/material.dart';
import 'package:news_app/provider/home_headline_provider.dart';
import 'package:news_app/provider/internet_connectivity_check_provider.dart';
import 'package:news_app/view/home/widget/home_news_headline_card_item.dart';
import 'package:provider/provider.dart';

import '../Internet_connectivity/internet_connectivity.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<void> homeHeadlineGet() async {
    final headlineProvider = context.read<HomeHeadlineProvider>();
    headlineProvider.setLoading(loading: true);
    await headlineProvider.getListHomeHeadlineArticle();
    headlineProvider.setLoading(loading: false);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeHeadlineGet();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final headlineProvider = Provider.of<HomeHeadlineProvider>(context);

    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: InternetConnectivityCheck(
        child: RefreshIndicator(
            color: theme.colorScheme.primary,
            onRefresh: () async {
              await homeHeadlineGet();
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: headlineProvider.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      // scrollDirection: Axis.vertical,
                      itemCount:
                          headlineProvider.homeHeadlineArticleList?.length ?? 0,
                      itemBuilder: (context, index) {
                        final item =
                            headlineProvider.homeHeadlineArticleList?[index];
                        return HomeHeadlineCardItem(
                          imgUrl: headlineProvider
                                  .homeHeadlineArticleList?[index].urlToImage ??
                              "https://about.fb.com/wp-content/uploads/2023/09/GettyImages-686732223.jpg",
                          headlineText: item?.title ?? "",
                          description: item?.description ?? "",
                          newsContent: item?.content ?? "",
                          newsWebLink:
                              item?.url ?? "https://www.prothomalo.com/",
                        );
                      },
                    ),
            )),
      ),
    );
  }
}
