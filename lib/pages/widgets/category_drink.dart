import 'package:flutter/material.dart';

class CategoryDrink extends StatelessWidget {
  const CategoryDrink({
    super.key,
    this.titulo,
    required this.color,
    this.onTap
  });

  final String? titulo;
  final Color color;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12)
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Text(titulo ?? '', style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),),
              ),
              Icon(Icons.chevron_right, size: 48),
            ],
          ),
        ),
      )
    );
  }
}