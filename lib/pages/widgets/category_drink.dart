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
      color: const Color(0xff217373),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Text(titulo ?? '', style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600
                ),),
              ),
              const Icon(Icons.chevron_right, size: 38, color: Colors.greenAccent,),
            ],
          ),
        ),
      )
    );
  }
}