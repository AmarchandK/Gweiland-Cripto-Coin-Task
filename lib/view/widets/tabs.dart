import 'package:flutter/material.dart';

class TabWidget extends StatelessWidget {
  const TabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabBar(
      unselectedLabelColor: Colors.grey,
      labelColor: Colors.black,
      indicatorColor: Colors.black,
      
      tabs: [
        Padding(
            padding: EdgeInsets.only(top: 12),
            child: Text('Cryptocurrency', style: TextStyle(fontSize: 22))),
        Padding(
            padding: EdgeInsets.only(top: 12),
            child: Text('NFT', style: TextStyle(fontSize: 22))),
      ],
    );
  }
}
