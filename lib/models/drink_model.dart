class Drink {
  final String name;
  final String image;
  final String id;

  Drink({required this.name, required this.image, required this.id});

  factory Drink.fromJson(Map<String, dynamic> json) => Drink(
      name: json['strDrink'],
      image: json['strDrinkThumb'],
      id: json['idDrink']
    );
}