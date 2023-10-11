import 'package:flutter/material.dart';
import 'package:local_eat/widget/event_list_tile.dart';

class EventList extends StatelessWidget {
  const EventList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (BuildContext context, int index) { 
        return EventListTile();

     }, itemCount: 3,);
  }
}