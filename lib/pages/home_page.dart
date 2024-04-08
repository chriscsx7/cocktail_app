import 'package:cocktail_app/pages/category_details/category_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../services/api_service.dart';
import 'widgets/category_drink.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String lista = 'c';

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final service = ApiService();

    const url = 'https://scontent.fcyw4-1.fna.fbcdn.net/v/t39.30808-6/432787881_308814988878514_2230215282488264154_n.jpg?_nc_cat=1&ccb=1-7&_nc_sid=5f2048&_nc_eui2=AeFl7sIkz4oL9sWzjaEi_9UMfrRSBiS0SX9-tFIGJLRJf6jiD6s2fico82RQU6m3spzVPnO2GwtQo9W_JHHY2IaN&_nc_ohc=mtBoFB86bzcAb6dVdqJ&_nc_ht=scontent.fcyw4-1.fna&oh=00_AfDBAt8NdJnDxmAq12sEhErEdql7nqFu83mtmmsrVp7jtQ&oe=661426A0';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cocteleria', style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold
        ),),
        centerTitle: false,
        leading: const CircleAvatar(
          radius: 50.0,
          backgroundImage: NetworkImage(url
          )
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Wrap(
              spacing: 16,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: [
                ListItem(nombre: 'Categorias', icono: Icons.category, selected: lista == 'c', onTap: () => onTap('c'),),
                ListItem(nombre: 'Vasos', icono: Icons.wine_bar, selected: lista == 'g', onTap: () => onTap('g')),
                ListItem(nombre: 'Ingredientes', icono: Icons.food_bank, selected: lista == 'i', onTap: () => onTap('i'),),
                ListItem(nombre: 'Tipos', icono: Icons.liquor, selected: lista == 'a', onTap: () => onTap('a'),),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(
              child: FutureBuilder(
                future: service.getList(lista),
                builder: (context, AsyncSnapshot<List<String>?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
                  final data = snapshot.data ?? [];
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: data.map((e) => CategoryDrink(
                          titulo: e,
                          color: Colors.lightBlueAccent.shade100,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => CategoryPage(
                                type: lista, 
                                option: e
                              ))
                            );
                          },
                        ),
                      ).toList()
                    ),
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onTap(String opcion) {
    setState(() {
      lista = opcion;
    });
  }
}

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.nombre,
    required this.icono,
    required this.selected,
    this.onTap
  });

   final String nombre;
   final IconData icono;
   final bool selected;
   final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        decoration: BoxDecoration(
          color: !selected ? Colors.blue.shade200 : Colors.blue,
          borderRadius: BorderRadius.circular(12)
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icono, color: Colors.white,),
            SizedBox(
              width: 8,
            ),
            Text(nombre, style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white
            ),)
          ],
        ),
      ),
    );
  }
}