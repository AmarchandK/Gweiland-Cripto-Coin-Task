import 'package:get/state_manager.dart';
import 'package:gweiland_flutter_task/model/coin_model.dart';
import 'package:gweiland_flutter_task/service/get_cryptos_service.dart';

class HomeController extends GetxController {
  RxList coinItems = [].obs;
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    getCoins();
    super.onInit();
  }

  void getCoins() async {
    isLoading.value = true;
    final response = await CoinRepository.getCoinDetail();
    if (response != null) {
      final List list = response["data"];
      for (var element in list) {
        final CoinModel coin = CoinModel.fromJson(element);
        coinItems.add(coin);
      }
    }
    isLoading.value = false;
  }

  Future<String> getLogo(String coinId) async {
    final response = await CoinRepository.getCoinLogo(coinId);
    final String logo = response.data["data"][coinId]["logo"];
    return logo;
  }
}
