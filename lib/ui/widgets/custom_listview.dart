import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rick_and_morty_bloc/bloc/character_bloc.dart';
import 'package:rick_and_morty_bloc/ui/widgets/custom_list_tile.dart';

import '../../data/models/character.dart';

class CustomListView extends StatelessWidget {
   CustomListView({Key? key, required this.currentResultsList,  required this.currentPageListView,  this.currentCharacterListView,  this.currentSearchStrListView, required this.isPaginationListView, this.refreshControllerListView}) : super(key: key);
  final List<Results> currentResultsList;
   int currentPageListView;
   final currentCharacterListView;
   final currentSearchStrListView;
    bool isPaginationListView;
   final refreshControllerListView;
  @override
  Widget build(BuildContext context) {

    return SmartRefresher(
      controller: refreshControllerListView,
      enablePullUp: true,
      enablePullDown: false,
      onLoading: (){
        isPaginationListView = true;
        currentPageListView++;
        if(currentPageListView <= currentCharacterListView.info.pages){
          context.read<CharacterBloc>().add(CharacterEvent.fetch(name: currentSearchStrListView, page: currentPageListView));
        }else{
          refreshControllerListView.loadNoData();
        }
      },
      child: ListView.separated(
          itemBuilder: (context, index) {
            final result = currentResultsList[index];
            return Padding(
              padding: const EdgeInsets.only(right: 16,left: 16,top: 3,bottom: 3),
              child: CustomListTile(result: result)
            );
          },
          shrinkWrap: true,
          separatorBuilder: (_, index) => const SizedBox(
            height: 5,
          ),
          itemCount: currentResultsList.length),
    );
  }
}