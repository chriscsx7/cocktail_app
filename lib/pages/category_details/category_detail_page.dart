import 'package:cocktail_app/models/drink_model.dart';
import 'package:cocktail_app/pages/category_details/drink_detail_page.dart';
import 'package:cocktail_app/services/api_service.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  final String type;
  final String option;

  const CategoryPage({
    super.key,
    required this.type,
    required this.option
  });

  @override
  Widget build(BuildContext context) {
    final service = ApiService();

    return  Scaffold(
      appBar: AppBar(
        elevation: 4,
        backgroundColor: const Color(0xff173540),
        title: Text(option, style: const TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold),),
        foregroundColor: Theme.of(context).textTheme.titleLarge?.color,
      ),
      body: FutureBuilder(
        future: service.getDrinkBy(type, option),
        builder: (context, AsyncSnapshot<List<Drink>?> snapshot) {
          final List<Drink> data = snapshot.data ?? [];
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final Drink drink = data[index];
              return DrinkCard(drink: drink, option: option);
            },
          );
        }
      ),
    );
  }
}

class DrinkCard extends StatelessWidget {
  const DrinkCard({
    super.key,
    required this.drink,
    required this.option,
  });

  final Drink drink;
  final String option;

  @override
  Widget build(BuildContext context) {
    return Card(
    color: const Color(0xff217373),
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
              drink.image,
              height: 90,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child; // Display image once loaded
                return const Center(child: CircularProgressIndicator());
              },
              errorBuilder: (context, error, stackTrace)
                  => Icon(
                    Icons.image,
                    size: 64,
                    color: DefaultTextStyle.of(context).style.color?.withOpacity(0.6)
                  ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: Text(drink.name, style: const TextStyle(
                            fontSize: 24,
                            color: Colors.white
                          )
                        )
                      ),
                      IconButton(
                        alignment: Alignment.topCenter,
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                        // ignore: dead_code
                        icon: Icon(true ? Icons.star : Icons.star_border, color: Theme.of(context).secondaryHeaderColor),
                        onPressed: () {

                        },
                      )
                    ],
                  ),
                  Text(option, style: const TextStyle(fontSize: 16, color: Colors.greenAccent)),
                    const SizedBox(height: 24),
                  ],
                ),
              )
            ],
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => DrinkDetail(drink: drink))
          );
        },
      ),
    );
  }
}