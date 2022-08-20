import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:image_app/src/feature/data/models/model.dart';
import 'package:dartz/dartz.dart';
import 'package:image_app/src/feature/image_list/data/models/data_model.dart';
import 'package:image_app/src/feature/image_list/domain/image_page_repo.dart';
import 'package:image_app/src/utils/network_client.dart';

class ImageRepoImpl extends ImageRepo {
  final ApiClient _apiClient;
  ImageRepoImpl(this._apiClient);
  String apiKey = "";
  @override
  Future<Either<EmptyResponseModel, DataModel?>> fetchImages(
      String keyWord) async {
    if (apiKey.isEmpty) {
      String languageJSONString =
          await rootBundle.loadString("assets/key/key.json");
      Map<String, dynamic> value = jsonDecode(languageJSONString);
      apiKey = value["apikey"] ?? "";
    }
    return await _apiClient.get("/api/", DataModel(),
        queryParameters: {"image_type": "photo", "key": apiKey, "q": keyWord});
  }
}
