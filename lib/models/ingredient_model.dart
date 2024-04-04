class Ingredient {
  String? name;

  Ingredient({
    this.name
  });

  factory Ingredient.fromJson(Map<String, dynamic> json)  => Ingredient(
    name: json['strIngredient1']
  );
}