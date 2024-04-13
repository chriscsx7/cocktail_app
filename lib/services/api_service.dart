import 'dart:convert';
import 'package:cocktail_app/models/drink_detail_model.dart';
import 'package:cocktail_app/models/drink_model.dart';
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

  Future<List<Drink>> getDrinkBy(String type, String option) async {
    var response = await http.get(Uri.parse('$baseUri/filter.php?$type=$option'));

    final List<Drink> listaBebidas = [];
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      final bebidas = jsonResponse['drinks'];
      try {
        for (var element in bebidas) {
          listaBebidas.add(Drink.fromJson(element));
        }
      } catch (e) {
        print(e);
      }
    }
    return listaBebidas;
  }

  Future<Ingredient?> getIngredientBy(String ingredient) async {
    var response = await http.get(Uri.parse('$baseUri/search.php?i=$ingredient'));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      final ingredient = jsonResponse['ingredients'] as List?;
      if(ingredient == null || ingredient.isEmpty) return null;
      try {
        return Ingredient.fromJson(ingredient.first);
      } catch (e) {
        print(e);
      }
    }
    return null;
  }

  Future<DrinkDetails?> getDrinkDetails(String id) async {
    var response = await http.get(Uri.parse('$baseUri/lookup.php?i=$id'));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      final detalles = jsonResponse['drinks'] as List?;
      if(detalles == null || detalles.isEmpty) return null;
      try {
        return DrinkDetails.fromJson(detalles.first);
      } catch (e) {
        print(e);
      }
    }
    return null;
  }

  Future<List<String>?> getDrinkIngredients(String id) async {
    var response = await http.get(Uri.parse('$baseUri/lookup.php?i=$id'));

    final List<String> listaIngredientes = [];
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      final detalles = jsonResponse['drinks'] as List?;
      if(detalles == null || detalles.isEmpty) return null;
      try {
        for (int i = 1; i <= 15; i++) {
          if (detalles.first['strIngredient$i'] != null) listaIngredientes.add(detalles.first['strIngredient$i']);
        }
        return listaIngredientes;
      } catch (e) {
        print(e);
      }
    }
    return null;
  }

  Future<List<String>?> getDrinkIngredientsMeasure(String id) async {
    var response = await http.get(Uri.parse('$baseUri/lookup.php?i=$id'));

    final List<String> listaMedidas = [];
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      final detalles = jsonResponse['drinks'] as List?;
      if(detalles == null || detalles.isEmpty) return null;
      try {
        for (int i = 1; i <= 15; i++) {
          if (detalles.first['strMeasure$i'] != null) {
            listaMedidas.add(detalles.first['strMeasure$i']);
          } else {
            listaMedidas.add('');
          }
        }
        return listaMedidas;
      } catch (e) {
        print(e);
      }
    }
    return null;
  }

}