import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../../functions/filters/spardha_schedule_filter.dart';
import '../../globals/styles.dart';
import '../../services/api.dart';
import '../../stores/common_store.dart';
import '../../stores/spardha_store.dart';
import '../../widgets/cards/results/spardha_results_card.dart';
import '../../models/spardha_models/spardha_event_model.dart';
import '../../widgets/ui/shimmer.dart';
import '../../widgets/common/top_bar.dart';
import '../../widgets/filters/spardha_filter_bar.dart';
import '../../widgets/ui/err_reload.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({Key? key}) : super(key: key);

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  @override
  Widget build(BuildContext context) {
    var commonStore = context.read<CommonStore>();
    var spardhaStore = context.read<SpardhaStore>();

    reloadCallback() {
      // reload page
      setState(() {});
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        children: [
          const TopBar(),
          const SpardhaFilterBar(),
          FutureBuilder<List<SpardhaEventModel>>(
              future:
                  APIService(context).getSpardhaResults(commonStore.viewType),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 200,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: ShowShimmer(
                              height: 300,
                              width: MediaQuery.of(context).size.width,
                            ),
                          );
                        }),
                  );
                } else if (snapshot.hasData) {
                  List<SpardhaEventModel> allSpardhaEventSchedules = snapshot.data!;
                  return Observer(builder: (context) {
                    List<SpardhaEventModel> filteredEventSchedules = filterSpardhaSchedule(
                        input: allSpardhaEventSchedules,
                        event: spardhaStore.selectedEvent,
                        date: spardhaStore.selectedDate,
                        hostel: spardhaStore.selectedHostel);
                    return Expanded(
                        child: filteredEventSchedules.isNotEmpty
                            ? ListView.builder(
                                itemCount: filteredEventSchedules.length,
                                itemBuilder: (context, index) {
                                  return SpardhaResultsCard(
                                      eventModel:
                                          filteredEventSchedules[index]);
                                })
                            : Center(
                                child:
                                    Text("No Result found", style: fontStyle1),
                              ));
                  });
                }
                return ErrorReloadPage(apiFunction: reloadCallback);
              })
        ],
      ),
    );
  }
}
