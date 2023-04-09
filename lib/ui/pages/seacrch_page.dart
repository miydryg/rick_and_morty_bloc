import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rick_and_morty_bloc/bloc/character_bloc.dart';
import 'package:rick_and_morty_bloc/data/models/character.dart';

import '../widgets/custom_listview.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key,}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Character _currentCharacter;
  List<Results> _currentResults = [];
  int _currentPage = 1;
  String _currentSearchStr = '';

  final RefreshController refreshController = RefreshController();
  bool _isPagination = false;

  final _storage = HydratedBloc.storage;



  @override
  void initState() {
    if(_storage.runtimeType.toString().isEmpty){
      if (_currentResults.isEmpty) {
        context
            .read<CharacterBloc>()
            .add(const CharacterEvent.fetch(name: '', page: 1));
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CharacterBloc>().state;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 15, bottom: 15, left: 16, right: 16),
          child: TextField(
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromRGBO(86, 86, 86, 0.8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Search Name'),
            onChanged: (value) {
              _currentPage = 1;
              _currentResults = [];
              _currentSearchStr = value;
              context
                  .read<CharacterBloc>()
                  .add(CharacterEvent.fetch(name: value, page: _currentPage));
            },
          ),
        ),
        Expanded(
          child: state.when(
            loading: () {
              if(!_isPagination){
                return const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Loading...')
                    ],
                  ),
                );
              }else{
                return CustomListView(currentResultsList: _currentResults, currentPageListView: _currentPage,  isPaginationListView: _isPagination);
              }

            },
            loaded: (characterLoaded) {
              _currentCharacter = characterLoaded;
              if(_isPagination){
                _currentResults.addAll(_currentCharacter.results);
                refreshController.loadComplete();
                _isPagination = false;
              }else{
                _currentResults = _currentCharacter.results;
              }

              return _currentResults.isNotEmpty
                  ? CustomListView(currentResultsList: _currentResults, currentPageListView: _currentPage, currentCharacterListView: _currentCharacter, currentSearchStrListView: _currentSearchStr, isPaginationListView: _isPagination, refreshControllerListView:refreshController)
                  : const SizedBox();
            },
            error: () => const Text('Nothing found...'),
          ),
        ),
      ],
    );
  }
}



