import 'package:flutter/material.dart';
import 'package:rick_and_morty_kobe/components/character_card.dart';
import 'package:rick_and_morty_kobe/models/paginated_characters.dart';
import 'package:rick_and_morty_kobe/repositories/character_repository.dart';
import 'package:rick_and_morty_kobe/themes/app_colors.dart';
import 'package:rick_and_morty_kobe/widgets/app_bar_widget.dart';


class HomePage extends StatefulWidget {
  static  const routeId = '/';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<PaginatedCharacters>? futureCharacters;

  @override
  void initState() {
    futureCharacters = CharacterRepository.getAllCharacters();
    super.initState();
  } 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context),
      backgroundColor: AppColors.backgroundColor,
      body: FutureBuilder<PaginatedCharacters>(future: futureCharacters, builder: (context, snapshot){
        if(snapshot.hasData){
          final data = snapshot.data;
          if(data == null){
            return Text('Nenhum personagem encontrado', style: TextStyle(color: Colors.white),);}
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 8),
            itemCount: data.results.length,
            itemBuilder: (context,index){
              return CharacterCard(
                character: data.results[index],
                 onTap: (){
                  print('Personagem ${data.results[index].name} clicado');
                 });
            }
          );
        }
        if(snapshot.hasError){
          return Text('Um erro aconteceu',style: TextStyle(color: Colors.white),);
        }
        
        return CircularProgressIndicator();
          

      } ,)
      
    );
  }
}