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
  ApiService service = ApiService();

  @override
  void initState() {
    super.initState();
    service.getDrinkDetails(widget.drink.id).then((value){
      setState(() {
        detail = value;
      });
    });
  }

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff173540),
        title: const Text('Bebida', style: TextStyle(color: Colors.greenAccent),),
        elevation: 4,
        foregroundColor: Theme.of(context).textTheme.titleLarge?.color,
      ),
      body: Center(
        child: SingleChildScrollView(
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
                    description('Ingredientes', Icons.food_bank),
                    FutureBuilder(
                      future: combinedFuture(),
                      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator()
                        );
                        }

                        List<String> data1 = snapshot.data![0];
                        List<String> data2 = snapshot.data![1];

                        return SizedBox(
                          height: 160,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.all(16),
                            itemCount: data1.length,
                            itemBuilder: (context, index) {
                              final String ingredient = data1[index];
                              final String medida = data2[index];
                              return IngredientWidget(
                                image: 'https://www.thecocktaildb.com/images/ingredients/$ingredient-Small.png',
                                ingredient: ingredient,
                                measure: medida
                              );
                            }
                          ),
                        );
                      }
                    ),
                    const Divider(
                      color: Color(0xff173540),
                      thickness: 2,
                    ),
                    description('Instrucciones', Icons.list_alt),
                    const SizedBox(height: 16,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 12, 0),
                      child: Text(detail?.strInstructions ?? 'Cargando..', style: const TextStyle(
                        fontSize: 16
                      ),),
                    ),
                    const SizedBox(height: 16,),
                    const Divider(
                      color: Color(0xff173540),
                      thickness: 2,
                    ),
                    description('Servir en', Icons.liquor),
                    const SizedBox(height: 16,),
                    Text(detail?.strGlass ?? 'Cargando..', style: const TextStyle(
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

  InkWell description(String description, IconData icono) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icono, color: const Color(0xff161F30),),
            const SizedBox(width: 20),
            Text(
                description,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff217373)
                ),
                textAlign: TextAlign.center,
              ),
            const SizedBox(width: 20)
          ],
        ),
      ),
    );
  }
}