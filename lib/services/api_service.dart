import 'dart:convert';
import 'package:cocktail_app/models/category_model.dart';
import 'package:cocktail_app/models/ingredient_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUri = 'https://www.thecocktaildb.com/api/json/v1/1';


  Future<List<String>> getList(String lista) async {
    var response = await http.get(Uri.parse('$baseUri/list.php?$lista=list'));

    final List<String> listaCategorias = [];
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      final categorias = jsonResponse['drinks'];
      String clave = '';
      switch (lista) {
        case 'c': clave = 'strCategory';
        case 'g': clave = 'strGlass';
        case 'i': clave = 'strIngredient1';
        case 'a': clave = 'strAlcoholic';
        default: clave = 'strCategory';
      }
      for (var element in categorias) {
        listaCategorias.add(element[clave]);
      }
    }
    return listaCategorias;
  }

  

}