import 'package:cocktail_app/models/drink_model.dart';
import 'package:cocktail_app/services/api_service.dart';
import 'package:flutter/material.dart';

class IngredientsDetail extends StatefulWidget {
  final Drink drink;
  const IngredientsDetail({super.key, required this.drink});

  @override
  State<IngredientsDetail> createState() => _IngredientsDetailState();
}

class _IngredientsDetailState extends State<IngredientsDetail> {
  ApiService service = ApiService();

  Future<List<String>?> fetchData1() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return service.getDrinkIngredients(widget.drink.id);
  }

  Future<List<String>?> fetchData2() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return service.getDrinkIngredientsMeasure(widget.drink.id);
  }

  Future<List> combinedFuture() async {
    List<Future> futures = [fetchData1(), fetchData2()];
    return Future.wait(futures);
  }

  @override
  Widget build(BuildContext context) {
    service.getDrinkIngredientsMeasure(widget.drink.id);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0,
        title: Text(widget.drink.name),
        foregroundColor: Theme.of(context).textTheme.titleLarge?.color,
      ),
      body: FutureBuilder(
        future: combinedFuture(),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator()
           );
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          List<String> data1 = snapshot.data![0];
          List<String> data2 = snapshot.data![1];

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: data1.length,
            itemBuilder: (context, index) {
              final String ingredient = data1[index];
              final String medida = data2[index];
              return IngredientCard(
                image: 'https://www.thecocktaildb.com/images/ingredients/$ingredient-Small.png',
                ingredient: ingredient,
                measure: medida
              );
            }
          );
        }
      )
    );
  }
}

class IngredientCard extends StatelessWidget {
  const IngredientCard({
    super.key,
    required this.image,
    required this.ingredient,
    required this.measure
  });

  final String image;
  final String ingredient;
  final String measure;

  @override
  Widget build(BuildContext context) {
    return Card(
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12)
    ),
    child: InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric( vertical: 12, horizontal: 8 ),
        child: Row(
          children: [
            Image.network(
              image,
              height: 90,
              errorBuilder: (context, error, stackTrace) => const CircularProgressIndicator()
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: Text(ingredient, style: const TextStyle(fontSize: 24))),
                    ],
                  ),
                  Text(measure, style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 24),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}