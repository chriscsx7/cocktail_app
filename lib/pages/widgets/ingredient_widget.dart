import 'package:cocktail_app/pages/category_details/ingredient_detail_page.dart';
import 'package:flutter/material.dart';

class IngredientWidget extends StatelessWidget {
  const IngredientWidget({
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
    return InkWell(
      child: SizedBox(
        width: 190,
        height: 125,
        child: Card(
          margin: const EdgeInsets.all(8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.network(
                  image,
                  height: 50,
                  errorBuilder: (context, error, stackTrace) => const CircularProgressIndicator()
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: Text(ingredient, style: const TextStyle(fontSize: 18))),
                        ],
                      ),
                      Text(measure, style: const TextStyle(fontSize: 14)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => IngredientDetail(ingredient: ingredient))
        );
      },
    );
  }
}