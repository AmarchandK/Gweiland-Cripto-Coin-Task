import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:gweiland_flutter_task/utils/constants.dart';

class CoinRepository {
  static final Dio dio =
      Dio(BaseOptions(baseUrl: Constants.baseUrl, headers: Constants.header));

  static Future<dynamic> getCoinDetail() async {
    try {
      Response response =
          await dio.get("${Constants.latestListing}?start=1&limit=20");
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! <= 299) {
        Constants.showDialogue("Fetched Successfully",
            color: Constants.baseColor.withOpacity(0.2));
        return response.data;
      }
    } catch (e) {
      log("Fail $e");
      Constants.errorHandler(e);
      return null;
    }
    return null;
  }

  static Future getCoinLogo(String coinId) async {
    try {
      Response response = await dio.get(Constants.coinLogo + coinId);
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! <= 299) {
        return response;
      }
    } catch (e) {
      log("Fail $e");
      return null;
    }
    return null;
  }
}
