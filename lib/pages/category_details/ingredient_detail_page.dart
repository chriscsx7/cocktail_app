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
  String noData = "No hay datos";
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
    return detail == null ?
    const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    ) :
    Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff173540),
        title: const Text('Ingrediente', style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold),),
        elevation: 4,
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
                      detail?.strIngredient ?? noData,
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
                    _label('Descripción'),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 12, 0),
                      child: Text(detail?.strDescription ?? noData, style: const TextStyle(
                      fontSize: 16
                      ),),
                    ),
                    const Divider(
                      color: Color(0xff173540),
                      thickness: 2,
                    ),
                    _label('Tipo'),
                    Text(detail?.strType ?? noData, style: const TextStyle(
                      fontSize: 16
                    ),),
                    const Divider(
                      color: Color(0xff173540),
                      thickness: 2,
                    ),
                    _label('Alcohol'),
                    Text(detail?.strAlcohol ?? noData, style: const TextStyle(
                      fontSize: 16
                    ),),
                    const Divider(
                      color: Color(0xff173540),
                      thickness: 2,
                    ),
                    if (detail?.strAlcohol != 'No') _label('Porcentaje'),
                    if(detail?.strAlcohol != 'No')
                      detail?.strAbv == noData || detail?.strAbv == null ?
                      Text(noData, style: const TextStyle(fontSize: 16),) :
                      Text('% ${detail?.strAbv}', style: const TextStyle(fontSize: 16),),
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

  Row _label(String label) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            label, style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xff217373)
            ),
          ),
        ),
      ],
    );
  }
}