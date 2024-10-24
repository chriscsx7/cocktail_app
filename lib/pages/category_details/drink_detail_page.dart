import 'package:cocktail_app/models/drink_detail_model.dart';
import 'package:cocktail_app/models/drink_model.dart';
import 'package:cocktail_app/pages/widgets/ingredient_widget.dart';
import 'package:cocktail_app/services/api_service.dart';
import 'package:flutter/material.dart';

class DrinkDetail extends StatefulWidget {
  final Drink drink;
  const DrinkDetail({super.key, required this.drink});

  @override
  State<DrinkDetail> createState() => _DrinkDetailState();
}

class _DrinkDetailState extends State<DrinkDetail> {
  DrinkDetails? detail;
  List<String>? ingredients;
  List<String>? measures;
  bool showIngredients = false;
  bool showInstructions = false;
  bool showGlass = false;
  ApiService service = ApiService();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final drinkDetails = await service.getDrinkDetails(widget.drink.id);
    final ingredientsData = await service.getDrinkIngredients(widget.drink.id);
    final measuresData = await service.getDrinkIngredientsMeasure(widget.drink.id);
    setState(() {
      detail = drinkDetails;
      ingredients = ingredientsData;
      measures = measuresData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff173540),
        title: const Text('Bebida', style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold),),
        elevation: 4,
        foregroundColor: Theme.of(context).textTheme.titleLarge?.color,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image(
              image: NetworkImage(
                detail?.strDrinkThumb ?? 'https://media.tenor.com/On7kvXhzml4AAAAi/loading-gif.gif',
              ),
              width: 430,
              height: 430,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    detail?.strDrink ?? 'Cargando datos..',
                    style: const TextStyle(
                      color: Color(0xff217373),
                      fontSize: 38,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 8,),
                  const Divider(
                    color: Color(0xff173540),
                    thickness: 2,
                  ),
                  description('Ingredientes', Icons.food_bank, showIngredients, () {setState(() {showIngredients = !showIngredients;});}),
                  if (showIngredients && ingredients != null && measures != null)
                    SizedBox(
                      height: 160,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.all(16),
                        itemCount: ingredients!.length,
                        itemBuilder: (context, index) {
                          final String ingredient = ingredients![index];
                          final String measure = measures![index];
                          return IngredientWidget(
                            image: 'https://www.thecocktaildb.com/images/ingredients/$ingredient-Small.png',
                            ingredient: ingredient,
                            measure: measure
                          );
                        }
                      ),
                    ),
                  const Divider(
                    color: Color(0xff173540),
                    thickness: 2,
                  ),
                  description('Instrucciones', Icons.list_alt, showInstructions, () {setState(() {showInstructions = !showInstructions;});}),
                  if (showInstructions)
                    const SizedBox(height: 16,),
                  if (showInstructions)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 12, 0),
                      child: Text(detail?.strInstructions ?? 'Cargando..', style: const TextStyle(
                        fontSize: 16
                      ),),
                    ),
                  if (showInstructions)
                    const SizedBox(height: 16,),
                  const Divider(
                    color: Color(0xff173540),
                    thickness: 2,
                  ),
                  description('Servir en', Icons.liquor, showGlass, () {setState(() {showGlass = !showGlass;});}),
                  const SizedBox(height: 16,),
                  if (showGlass)
                    Text(detail?.strGlass ?? 'Cargando..', style: const TextStyle(
                      fontSize: 16
                    ),),
                  if (showGlass)
                    const SizedBox(height: 32,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  InkWell description(String description, IconData icono, bool isExpanded, onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Icon(icono, color: const Color(0xff161F30)),
            const SizedBox(width: 20),
            Text(
              description,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff217373),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(width: 20),
            Icon(isExpanded ? Icons.expand_more : Icons.chevron_right, color: const Color(0xff161F30)),
          ],
        ),
      ),
    );
  }
}
