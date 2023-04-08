import 'package:flutter/material.dart';

import '../../data/models/character.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({Key? key, required this.currentResultsList}) : super(key: key);
  final List<Results> currentResultsList;
  @override
  Widget build(BuildContext context) {

    return ListView.separated(
        itemBuilder: (context, index) {
          final result = currentResultsList[index];
          return Padding(
            padding: const EdgeInsets.only(right: 16,left: 16,top: 3,bottom: 3),
            child: ListTile(
              title: Text(
                result.name,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        },
        shrinkWrap: true,
        separatorBuilder: (_, index) => const SizedBox(
          height: 5,
        ),
        itemCount: currentResultsList.length);
  }
}