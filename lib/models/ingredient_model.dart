class Ingredient {
  String? idIngredient;
  String? strIngredient;
  String? strDescription;
  String? strType;
  String? strAlcohol;
  dynamic strAbv;

  Ingredient({
      required this.idIngredient,
      required this.strIngredient,
      required this.strDescription,
      required this.strType,
      required this.strAlcohol,
      required this.strAbv,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
      idIngredient: json["idIngredient"],
      strIngredient: json["strIngredient"],
      strDescription: json["strDescription"],
      strType: json["strType"],
      strAlcohol: json["strAlcohol"],
      strAbv: json["strABV"],
  );
}