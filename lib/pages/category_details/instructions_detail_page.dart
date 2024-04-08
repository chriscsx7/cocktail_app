import 'package:cocktail_app/models/drink_detail_model.dart';
import 'package:cocktail_app/models/drink_model.dart';
import 'package:cocktail_app/services/api_service.dart';
import 'package:flutter/material.dart';

class InstructionsDetail extends StatefulWidget {
  final Drink drink;
  const InstructionsDetail({super.key, required this.drink});

  @override
  State<InstructionsDetail> createState() => _InstructionsDetailState();
}

class _InstructionsDetailState extends State<InstructionsDetail> {
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
        title: Text(detail?.strDrink ?? ''),
        foregroundColor: Theme.of(context).textTheme.titleLarge?.color,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Image(
                image: NetworkImage(
                  detail?.strDrinkThumb ?? 'https://media.tenor.com/On7kvXhzml4AAAAi/loading-gif.gif',
                ),
                width: 300,
                height: 300,
              ),
              const SizedBox(height: 16,),
              const Text('Instrucciones: ', style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600
              ),),
              const SizedBox(height: 16,),
              Text(detail?.strInstructions ?? 'Cargando..', style: const TextStyle(
                fontSize: 18
              ),)
            ],
          ),
        ),
      ),
    );
  }
}