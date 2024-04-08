import 'package:cocktail_app/models/drink_detail_model.dart';
import 'package:cocktail_app/models/drink_model.dart';
import 'package:cocktail_app/pages/category_details/glass_detail_page.dart';
import 'package:cocktail_app/pages/category_details/ingredients_detail_page.dart';
import 'package:cocktail_app/pages/category_details/instructions_detail_page.dart';
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

  @override
  void initState() {
    super.initState();
    ApiService service = ApiService();
    service.getDrinkDetails(widget.drink.id).then((value){
      setState(() {
        detail = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0,
        foregroundColor: Theme.of(context).textTheme.titleLarge?.color,
      ),
      body: Center(
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
                      fontSize: 38,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 8,),
                  descriptionCard('Ingredientes', Icons.food_bank, () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => IngredientsDetail(drink: widget.drink))
                    );
                  }),
                  descriptionCard('Instrucciones', Icons.list_alt, () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => InstructionsDetail(drink: widget.drink))
                    );
                  }),
                  descriptionCard('Vaso', Icons.liquor, () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => GlassDetail(drink: widget.drink))
                    );
                  })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  InkWell descriptionCard(String description, IconData icono, Function() onTap) {
    return InkWell(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(icono),
              const SizedBox(width: 8,),
              Expanded(child: Text(description, textAlign: TextAlign.center,)),
              const SizedBox(width: 8,),
              const Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}