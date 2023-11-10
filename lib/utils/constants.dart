import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/get_navigation/src/snackbar/snackbar_controller.dart';
import 'package:get/utils.dart';

class Constants {
  static const String baseUrl = "https://pro-api.coinmarketcap.com/";
  static const String latestListing = "v1/cryptocurrency/listings/latest";
  static const String coinLogo = "v2/cryptocurrency/info?id=";

  static const Color baseColor = Color(0xff00CE08);
  static const Color redColor = Colors.red;

  static const String appToken = "2fe5926f-f6e2-4f3c-b608-e6abe14c7493";

  static const Map<String, String> header = {
    "Accepts": "application/json",
    "X-CMC_PRO_API_KEY": Constants.appToken
  };
  static const List<FlSpot> greenChartData = [
    FlSpot(0, 1.5),
    FlSpot(2.6, 2.3),
    FlSpot(4.9, 5),
    FlSpot(6.8, 3.1),
    FlSpot(8, 4),
    FlSpot(9.5, 1.6),
    FlSpot(11, 6)
  ];
  static const List<FlSpot> redChartData = [
    FlSpot(0, 8),
    FlSpot(2.6, 6),
    FlSpot(4.9, 8),
    FlSpot(6.8, 3.1),
    FlSpot(8, 4),
    FlSpot(9.5, 1.6),
    FlSpot(11, 0)
  ];
  static void errorHandler(Object e) {
    if (e is DioException) {
      if (e.response?.data["status"] == false) {
        showDialogue(e.response!.data["message"]);
      } else if (e.response?.statusCode == 401) {
        showDialogue(e.response!.data["message"]);
      } else if (e.type == DioExceptionType.connectionTimeout) {
        showDialogue("Connection timed out");
      } else if (e.type == DioExceptionType.receiveTimeout) {
        showDialogue("Timeout ");
      } else if (e.type == DioExceptionType.cancel) {
        showDialogue("Cancelled");
      } else if (e.type == DioExceptionType.sendTimeout) {
        showDialogue("Slow Network");
      } else if (e.type == DioExceptionType.badResponse) {
        showDialogue("Bad response");
      } else if (e.type == DioExceptionType.unknown) {
        showDialogue('Something went Wrong');
      }
    } else if (e is SocketException) {
      showDialogue('No Internet Connection');
    }
  }

  static SnackbarController showDialogue(String tittle, {Color? color}) {
    return Get.showSnackbar(
      GetSnackBar(
          messageText: Text(tittle,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
          backgroundColor: color ?? redColor,
          icon: const Icon(CupertinoIcons.exclamationmark_shield),
          duration: const Duration(milliseconds: 1800),
          barBlur: 10,
          dismissDirection: DismissDirection.horizontal,
          overlayBlur: 1,
          margin: const EdgeInsets.all(20.0),
          animationDuration: const Duration(seconds: 2),
          snackStyle: SnackStyle.GROUNDED,
          borderColor: Colors.white,
          borderRadius: 10),
    );
  }

  static String getPersontage(double decimalValue) =>
      '${(decimalValue * 100).toStringAsFixed(2)} %';
  static bool getMovementStatus(double decimalValue) =>
      decimalValue < 0 ? false : true;
}
