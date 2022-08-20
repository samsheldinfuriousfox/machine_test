import 'package:dartz/dartz.dart';
import 'package:image_app/src/feature/data/models/model.dart';
import 'package:image_app/src/feature/image_list/data/models/data_model.dart';

abstract class ImageRepo {
  Future<Either<EmptyResponseModel, DataModel?>> fetchImages(String keyWord);
}
