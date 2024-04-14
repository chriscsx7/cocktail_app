import 'package:cocktail_app/pages/category_details/category_detail_page.dart';
import 'package:flutter/material.dart';
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

    const url = 'https://images.immediate.co.uk/production/volatile/sites/30/2020/01/retro-cocktails-b12b00d.jpg?quality=90&webp=true&resize=600,545';
    // const url2 = 'https://scontent.fcyw4-1.fna.fbcdn.net/v/t39.30808-6/432787881_308814988878514_2230215282488264154_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=5f2048&_nc_eui2=AeFl7sIkz4oL9sWzjaEi_9UMfrRSBiS0SX9-tFIGJLRJf6jiD6s2fico82RQU6m3spzVPnO2GwtQo9W_JHHY2IaN&_nc_ohc=ISGNIyXvayMAb6FPfIk&_nc_ht=scontent.fcyw4-1.fna&oh=00_AfDufyeqb9_Bj_2IZpsywidk8LxWMwMB8QbSEYaDYWv3OA&oe=661EB2A0';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff173540),
        elevation: 4,
        title: const Text('Cocteleria', style: TextStyle(
          color: Colors.greenAccent,
          fontSize: 32,
          fontWeight: FontWeight.bold
        ),),
        centerTitle: false,
        actions: const [
          CircleAvatar(
            radius: 40.0,
            backgroundImage: NetworkImage(url)
          ),
        ],
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
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: FutureBuilder(
                future: service.getList(lista),
                builder: (context, AsyncSnapshot<List<String>?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
                  final data = snapshot.data ?? [];
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: data.map((e) => CategoryDrink(
                          titulo: e,
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
      child: Card(
        color: !selected ? const Color(0xff217373) : const Color(0xff173540),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          width: 160,
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icono, color: Colors.greenAccent,),
                const SizedBox(
                  width: 8,
                ),
                Text(nombre, style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}