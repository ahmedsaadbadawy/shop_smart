import '../models/categories_model.dart';
import 'app_images.dart';

class AppConstants {
  static const String productImageUrl =
      'https://i.ibb.co/8r1Ny2n/20-Nike-Air-Force-1-07.png';
  static List<String> bannersImages = [
    AssetsManager.imagesBannersBanner1,
    AssetsManager.imagesBannersBanner2,
  ];
  static List<CategoryModel> categoriesList = [
    CategoryModel(
      id: "Phones",
      image: AssetsManager.imagesCategoriesMobiles,
      name: "Phones",
    ),
    CategoryModel(
      id: "Laptops",
      image: AssetsManager.imagesCategoriesPc,
      name: "Laptops",
    ),
    CategoryModel(
      id: "Electronics",
      image: AssetsManager.imagesCategoriesElectronics,
      name: "Electronics",
    ),
    CategoryModel(
      id: "Watches",
      image: AssetsManager.imagesCategoriesWatch,
      name: "Watches",
    ),
    CategoryModel(
      id: "Clothes",
      image: AssetsManager.imagesCategoriesFashion,
      name: "Clothes",
    ),
    CategoryModel(
      id: "Shoes",
      image: AssetsManager.imagesCategoriesShoes,
      name: "Shoes",
    ),
    CategoryModel(
      id: "Books",
      image: AssetsManager.imagesCategoriesBookImg,
      name: "Books",
    ),
    CategoryModel(
      id: "Cosmetics",
      image: AssetsManager.imagesCategoriesCosmetics,
      name: "Cosmetics",
    ),
  ];
}
