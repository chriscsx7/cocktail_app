import 'package:flutter/material.dart';

class CategoryDrink extends StatelessWidget {
  const CategoryDrink({
    super.key,
    this.titulo,
    this.onTap
  });

  final String? titulo;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
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
                child: Text(titulo ?? '', style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),),
              ),
              const Icon(Icons.chevron_right, size: 48),
            ],
          ),
        ),
      )
    );
  }
}