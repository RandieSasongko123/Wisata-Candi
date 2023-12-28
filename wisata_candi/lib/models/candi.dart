import 'package:flutter/material.dart';

class Candi {
  final String name;
  final String location;
  final String description;
  final String built;
  final String type;
  final String imageAsset;
  final List<String> imageUrls;
  bool isFavorite;

  VoidCallback? onFavoriteChange;

  Candi({
    required this.name,
    required this.location,
    required this.description,
    required this.built,
    required this.type,
    required this.imageAsset,
    required this.imageUrls,
    this.isFavorite = false,
    this.onFavoriteChange,
  });
}
