import 'package:flutter/material.dart';

class IngredientDrink extends StatelessWidget {
  const IngredientDrink({
    super.key,
    this.titulo,
    this.subTitulo,
  });

  final String? titulo;
  final String? subTitulo;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12)
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(titulo ?? '', style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}