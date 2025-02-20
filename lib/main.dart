import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';
import 'package:marketing_app/constant/colors.dart';
import 'package:marketing_app/model/marketing_response_model.dart';
import 'package:marketing_app/pages/market_list_view.dart';
import 'package:marketing_app/pages/single_view.dart';
import 'package:marketing_app/service/market_services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MarketplaceScreen(),
    );
  }
}
