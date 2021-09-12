part of 'models.dart';

enum FoodType { new_food, popular, recommended }

class Food extends Equatable {
  final int id;
  final String picturePath;
  final String name;
  final String description;
  final String ingredients;
  final int price;
  final double rate;
  final List<FoodType> types;

  Food({
    this.id,
    this.picturePath,
    this.name,
    this.description,
    this.ingredients,
    this.price,
    this.rate,
    this.types,
  });

  factory Food.fromJson(Map<String, dynamic> data) => Food(
        id: data['id'],
        picturePath: baseURL + '/storage/' + data['picture_path'],
        name: data['name'],
        description: data['description'],
        ingredients: data['ingredients'],
        price: int.parse(data['price']),
        rate: double.parse(data['rate']),
        types: data['types'].toString().split(',').map((type) {
          switch (type) {
            case 'recommended':
              return FoodType.recommended;
              break;
            case 'popular':
              return FoodType.popular;
              break;
            default:
              return FoodType.new_food;
          }
        }).toList(),
      );

  @override
  List<Object> get props =>
      [id, picturePath, name, description, ingredients, price, rate];
}
