import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/view/news_details_view/news_details_view.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeHeadlineCardItem extends StatefulWidget {
  final String? imgUrl;
  final String? headlineText;
  final String? description;
  final String? newsContent;
  final String? newsWebLink;

  const HomeHeadlineCardItem({
    super.key,
    this.imgUrl,
    this.headlineText,
    this.description,
    this.newsWebLink,
    this.newsContent,
  });

  @override
  State<HomeHeadlineCardItem> createState() => _HomeHeadlineCardItemState();
}

class _HomeHeadlineCardItemState extends State<HomeHeadlineCardItem> {
  Future<void> launchUrlSite({required String url}) async {
    final Uri urlParsed = Uri.parse(url);

    print("Attempting to launch URL: $urlParsed");

    if (await canLaunchUrl(urlParsed)) {
      await launchUrl(urlParsed);
    } else {
      print('Could not launch $urlParsed');
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Headline image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            child: CachedNetworkImage(
              height: 200,
              width: double.infinity,
              fit: BoxFit.fill,
              imageUrl: widget.imgUrl ?? "",
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                    colorFilter: const ColorFilter.mode(
                      Colors.red,
                      BlendMode.colorBurn,
                    ),
                  ),
                ),
              ),
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Image.network(
                "https://static.thenounproject.com/png/504708-200.png",
                height: 200,
                width: 200,
                fit: BoxFit.fill,
              ),
            ),
          ),

          // Headline text
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              widget.headlineText ?? "",
              style: theme.textTheme.headlineMedium,
            ),
          ),

          // Headline content
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 5,
            ),
            child: Text(
              widget.newsContent ?? "",
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w400,
                color: theme.colorScheme.onSurface.withOpacity(.5),
              ),
            ),
          ),

          // Headline description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              (widget.description?.length ?? 0) > 10
                  ? widget.description
                          ?.substring(0, widget.description!.length - 10) ??
                      ""
                  : widget.description ?? "",
              style: theme.textTheme.bodyMedium,
            ),
          ),

          // See more button
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0, top: 8),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewsDetailsView(
                        newsWebLink: widget.newsWebLink,
                        title: widget.headlineText,
                      ),
                    ),
                  );

                  // await launchUrlSite(
                  //   url: widget.newsWebLink ?? "https://www.prothomalo.com/",
                  // );
                },
                child: const Text("Read More"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
