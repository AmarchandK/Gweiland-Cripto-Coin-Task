import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:gweiland_flutter_task/controller/home_controller.dart';
import 'package:gweiland_flutter_task/view/widets/appbar.dart';
import 'package:gweiland_flutter_task/view/widets/currency_items.dart';
import 'package:gweiland_flutter_task/view/widets/search.dart';
import 'package:gweiland_flutter_task/view/widets/tabs.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  static HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Scaffold(
          appBar: const PreferredSize(
              preferredSize: Size.fromHeight(200),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    AppBarWidget(),
                    SearchWidget(),
                    Spacer(),
                    TabWidget(),
                  ],
                ),
              )),
          body: Obx(
            () => controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : controller.coinItems.isEmpty
                    ? Center(
                        child: TextButton(
                            onPressed: () => controller.getCoins(),
                            child: const Text("Something went wrong \n Refresh",
                                textAlign: TextAlign.center)),
                      )
                    : const TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                            SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CurrencyCardWidget(),
                                    TopCryptosTittle(),
                                    CryptoItemsWidget()
                                  ],
                                ),
                              ),
                            ),
                            SizedBox()
                          ]),
          ),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
