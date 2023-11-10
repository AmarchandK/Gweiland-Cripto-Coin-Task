import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:gweiland_flutter_task/controller/home_controller.dart';
import 'package:gweiland_flutter_task/model/coin_model.dart';
import 'package:gweiland_flutter_task/utils/constants.dart';
import 'package:gweiland_flutter_task/view/widets/chart.dart';

class TopCryptosTittle extends StatelessWidget {
  const TopCryptosTittle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Top Cryptocurrencies", style: TextStyle(fontSize: 20)),
          TextButton(
              onPressed: () {},
              child: const Text("View All",
                  style: TextStyle(fontSize: 16, color: Colors.grey))),
        ],
      ),
    );
  }
}

class CryptoItemsWidget extends StatefulWidget {
  const CryptoItemsWidget({super.key});

  @override
  State<CryptoItemsWidget> createState() => _CryptoItemsWidgetState();
}

class _CryptoItemsWidgetState extends State<CryptoItemsWidget>
    with SingleTickerProviderStateMixin {
  final HomeController controller = Get.find<HomeController>();
  late final AnimationController animationController;
  List<Animation<Offset>> listAnimations = [];
  int itemLength = 0;
  void playAnimation() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    itemLength = controller.coinItems.isEmpty ? 5 : controller.coinItems.length;
    listAnimations = List.generate(
      itemLength,
      (index) =>
          Tween(begin: const Offset(-1, 0), end: const Offset(0, 0)).animate(
        CurvedAnimation(
          parent: animationController,
          curve: Interval(index * (1 / itemLength), 1),
        ),
      ),
    );
    animationController.forward();
  }

  @override
  void initState() {
    playAnimation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => const SizedBox(height: 5),
        itemCount: 15,
        itemBuilder: (context, index) {
          CoinModel item = controller.coinItems[index];
          return SlideTransition(
              position: listAnimations[index],
              child: CryptoItemTile(item: item));
        });
  }
}

class CryptoItemTile extends StatelessWidget {
  const CryptoItemTile({super.key, required this.item});

  final CoinModel item;

  @override
  Widget build(BuildContext context) {
    bool isGreen = Constants.getMovementStatus(item.quote.usd.percentChange24h);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 30,
        child: LogoBuilder(item: item),
      ),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.symbol,
                  maxLines: 2,
                  overflow: TextOverflow.visible,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  item.name,
                  maxLines: 2,
                  overflow: TextOverflow.visible,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          const Spacer(),
          SizedBox(
              width: 90,
              child: CommonChartWidget(
                  showGradient: false,
                  spots: isGreen
                      ? Constants.greenChartData
                      : Constants.redChartData,
                  color: isGreen ? Constants.baseColor : Constants.redColor))
        ],
      ),
      trailing: SizedBox(
        width: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("\$ ${item.quote.usd.price.round()} USD",
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w700)),
            Text(Constants.getPersontage(item.quote.usd.percentChange24h),
                style: TextStyle(
                    color: Constants.getMovementStatus(
                            item.quote.usd.percentChange24h)
                        ? Constants.baseColor
                        : Constants.redColor,
                    fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }
}

class CurrencyCardWidget extends GetView<HomeController> {
  const CurrencyCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    CoinModel item = controller.coinItems.first;
    return Card(
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Constants.baseColor.withOpacity(0.1),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 1,
                        child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Constants.baseColor,
                            child: LogoBuilder(item: item))),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item.symbol,
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  '\$ ${item.quote.usd.price.round()} USD',
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(item.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500)),
                                Text(
                                  Constants.getPersontage(
                                      item.quote.usd.percentChange24h),
                                  style: const TextStyle(
                                      color: Constants.baseColor,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: const CommonChartWidget(
                spots: Constants.greenChartData,
                showGradient: true,
                color: Constants.baseColor),
          ),
        ],
      ),
    );
  }
}

class LogoBuilder extends GetView<HomeController> {
  const LogoBuilder({super.key, required this.item});

  final CoinModel item;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.getLogo(item.id.toString()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator.adaptive();
        } else if (snapshot.error != null) {
          return const Icon(Icons.error);
        } else if (snapshot.hasData) {
          return Image.network(snapshot.data ?? '');
        }
        return const Icon(Icons.error);
      },
    );
  }
}
