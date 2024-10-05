import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/internet_connectivity_check_provider.dart';

class InternetConnectivityCheck extends StatefulWidget {
  final Widget child;

  const InternetConnectivityCheck({super.key, required this.child});

  @override
  State<InternetConnectivityCheck> createState() => _InternetConnectivityCheckState();
}

class _InternetConnectivityCheckState extends State<InternetConnectivityCheck> {
  Future<void> internetCheck() async {
    final provider=context.read<InternetConnectivityCheckProvider>();
    provider.setLoading(loading: true);
   await provider.setInternetConnection();
   provider.setLoading(loading: false);

  }
  @override
  initState()  {
    WidgetsBinding.instance.addPostFrameCallback((_)  {
      internetCheck();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<InternetConnectivityCheckProvider>(context);
    final theme=Theme.of(context);
    final connectivityProvider=Provider.of<InternetConnectivityCheckProvider>(context);
    return Scaffold(
      body:connectivityProvider.isLoading?const SizedBox(): Center(
        child:connectivityProvider.internetConnection ?? false?
            widget.child:
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/image/connectivity_check1.png"),
              const Text("No Internet Connection")
            ],
          ),
        ),
      ),
    );
  }
}
