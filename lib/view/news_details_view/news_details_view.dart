import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailsView extends StatefulWidget {
  final String? newsWebLink;
  final String? title;
   const NewsDetailsView({super.key, this.newsWebLink, this.title});

  @override
  State<NewsDetailsView> createState() => _NewsDescriptionViewState();
}

class _NewsDescriptionViewState extends State<NewsDetailsView> {
  bool ?hasCallSupport;

   WebViewController controller=WebViewController();
  var loadingPercentage = 0;


  @override
  initState()  {
     WidgetsBinding.instance.addPostFrameCallback((_){

       controller = WebViewController()..enableZoom(true)..setJavaScriptMode(JavaScriptMode.unrestricted)
         ..setNavigationDelegate(NavigationDelegate(
           onPageStarted: (url) {
             setState(() {
               loadingPercentage = 0;
             });
           },
           onProgress: (progress) {
             setState(() {
               loadingPercentage = progress;
             });
           },
           onPageFinished: (url) {
             setState(() {
               loadingPercentage = 100;
             });
           },
         ))
         ..loadRequest(
           Uri.parse(widget.newsWebLink ??""),
         );
     });



    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return Scaffold(
    appBar: AppBar(
      title: Text(widget.title ?? "",maxLines: 2,),
    ),
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(
        
        
              controller: controller,
            ),
            loadingPercentage < 100
                ? LinearProgressIndicator(
              color: theme.colorScheme.primary,
              value: loadingPercentage / 100.0,
            )
                : Container(),
          ],
        ),
      ),
    );
  }
}
