import 'package:dartz/dartz.dart';
import 'package:image_app/src/feature/image_list/data/models/data_model.dart';
import 'package:image_app/src/feature/image_list/data/models/model.dart';

abstract class ImageRepo {
  Future<Either<EmptyResponseModel, DataModel?>> fetchImages(String keyWord,int page);
}
