import 'dart:convert';

import 'package:flutter/material.dart';

const String _networkImagesPath = 'https://image.tmdb.org/t/p';

const String _assetsPath = 'assets/images';

const String _92Size = '$_networkImagesPath/w92';
const String _200Size = '$_networkImagesPath/w200';
const String _780Size = '$_networkImagesPath/w780';
const String _originalSize = '$_networkImagesPath/original';

enum EImageSize { w92, w200, w780, original }

const Map<EImageSize, String> _sizeToNetworkPath = {
  EImageSize.w92: _92Size,
  EImageSize.w200: _200Size,
  EImageSize.w780: _780Size,
  EImageSize.original: _originalSize,
};

const Map<EImageSize, String> _sizeToHorizontalAssetPath = {
  EImageSize.w92: '$_assetsPath/w92horizontal.jpg',
  EImageSize.w200: '$_assetsPath/w200horizontal.jpg',
  EImageSize.w780: '$_assetsPath/w780horizontal.jpg',
};

const Map<EImageSize, String> _sizeToVerticalAssetPath = {
  EImageSize.w92: '$_assetsPath/w92vertical.jpg',
  EImageSize.w200: '$_assetsPath/w200vertical.jpg',
  EImageSize.w780: '$_assetsPath/w780vertical.jpg',
};

class AppUtils {
  static String formatRuntime(int runtime) {
    if (runtime != null && runtime > 0) {
      final num hours = runtime ~/ 60;
      final num minutes = runtime - hours * 60;

      return '$hoursч $minutesмин';
    }
    return '';
  }

  static String buildImagePath(String imageName,
      {EImageSize size = EImageSize.w92}) {
    assert(imageName != null);

    if (imageName.isEmpty) return '';

    return '${_sizeToNetworkPath[size]}$imageName';
  }

  static String buildAssetPath(
      {@required EImageSize size, Axis axis = Axis.vertical}) {
    assert(size != null);

    if (axis == Axis.horizontal) {
      return _sizeToHorizontalAssetPath[size];
    } else {
      return _sizeToVerticalAssetPath[size];
    }
  }
}
