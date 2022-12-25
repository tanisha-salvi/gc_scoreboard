import 'package:flutter/material.dart';
import '../models/event_model.dart';
import '../widgets/cards/schedule_card.dart';
import '../widgets/schedule_page/filter_bar.dart';
import '../widgets/common/top_bar.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/src/stores/common_store.dart';


class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {

  final TextEditingController sport = TextEditingController(text: "Overall");
  final TextEditingController hostel = TextEditingController(text: "Overall");
  final List<String> _itemsSports = [
    'Overall',
    'Athletics',
    'Swimming',
    'Basketball',
    'Football',
    'Badminton',
    'Aquatics'
  ];

  final List<String> _itemsHostels =[
    'Overall',
    'Brahma',
    'Manas',
    'Kameng',
  ];

  EventModel eventModel = EventModel(
      name: 'Badminton Doubles',
      group: 'Athletics',
      category: 'Men',
      stage: 'Quarter-Final',
      date: DateTime.now(),
      venue: 'Table Tennis Court, Old SAC',
      results: [],
      hostels: [
        'Married Scholars',
        'Brahmaputra',
        'Married Scholars',
        // 'Brahmaputra',
        // 'Married Scholars',
        // 'Brahmaputra',
        // 'Married Scholars',
        // 'Brahmaputra',
        // 'Married Scholars',
        // 'Brahmaputra',
        // 'Married Scholars',
        // 'Brahmaputra',
        // 'Married Scholars',
        // 'Brahmaputra',
      ]);

  @override
  Widget build(BuildContext context) {
    var commonStore = context.read<CommonStore>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TopBar(),
            FilterBar(sport: sport, hostel: hostel, itemsHostels: _itemsHostels, itemsSports: _itemsSports),
            ScheduleCard(
              eventModel: eventModel,
              status: '',
            ),
            ScheduleCard(
              eventModel: eventModel,
              status: 'postponed',
            ),
            ScheduleCard(
              eventModel: eventModel,
              status: 'cancelled',
            ),
          ],
        ),
      ),
    );
  }
}
