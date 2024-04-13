import 'package:cocktail_app/models/ingredient_model.dart';
import 'package:cocktail_app/services/api_service.dart';
import 'package:flutter/material.dart';

class IngredientDetail extends StatefulWidget {
  final String ingredient;
  const IngredientDetail({super.key, required this.ingredient});

  @override
  State<IngredientDetail> createState() => _IngredientDetailState();
}

class _IngredientDetailState extends State<IngredientDetail> {
  Ingredient? detail;
  ApiService service = ApiService();

  @override
  void initState() {
    super.initState();
    service.getIngredientBy(widget.ingredient).then((value){
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                'https://www.thecocktaildb.com/images/ingredients/${detail?.strIngredient}.png',
                errorBuilder: (context, error, stackTrace) =>
                Image.network(
                  'https://media.tenor.com/On7kvXhzml4AAAAi/loading-gif.gif'
                ),
                width: 430,
                height: 430,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      detail?.strIngredient ?? 'Cargando datos..',
                      style: const TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 8,),
                    const Divider(color: Colors.black,),
                    const Text('Descripción', style: TextStyle(fontSize: 18),),
                    const SizedBox(height: 16,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 12, 0),
                      child: Text(detail?.strDescription ?? 'Cargando..', style: const TextStyle(
                        fontSize: 16
                      ),),
                    ),
                    const Divider(color: Colors.black,),
                    const Text('Tipo', style: TextStyle(fontSize: 18),),
                    const SizedBox(height: 16,),
                    Text(detail?.strType ?? 'Cargando..', style: const TextStyle(
                      fontSize: 16
                    ),),
                    const Divider(color: Colors.black,),
                    const Text('Alcohol', style: TextStyle(fontSize: 18),),
                    const SizedBox(height: 16,),
                    Text(detail?.strAlcohol ?? 'Cargando..', style: const TextStyle(
                      fontSize: 16
                    ),),
                    const Divider(color: Colors.black,),
                    const Text('Porcentaje', style: TextStyle(fontSize: 18),),
                    const SizedBox(height: 16,),
                    Text('%${detail?.strAbv ?? 'Cargando..'}', style: const TextStyle(
                      fontSize: 16
                    ),),
                    const SizedBox(height: 32,),
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