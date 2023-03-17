import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../../globals/colors.dart';
import '../../globals/enums.dart';
import '../../globals/styles.dart';
import '../../models/manthan_models/manthan_event_model.dart';
import '../../stores/common_store.dart';
import 'card_date_widget.dart';
import 'manthan_popup_menu.dart';
import 'menu_item.dart';

class ManthanResultCard extends StatefulWidget {
  final eventModel;
  const ManthanResultCard({super.key, required this.eventModel});

  @override
  State<ManthanResultCard> createState() => _ManthanResultCardState();
}

class _ManthanResultCardState extends State<ManthanResultCard> {
  bool isExpanded = false;
  List<PopupMenuEntry> popupOptions = [
    optionsMenuItem('Edit', 'edit result', Themes.kWhite),
    const PopupMenuDivider(
      height: 2,
    ),
    optionsMenuItem('Delete', 'delete', Themes.errorRed),
  ];

  @override
  Widget build(BuildContext context) {
    var commonStore = context.read<CommonStore>();
    bool isManthan = (widget.eventModel.runtimeType == ManthanEventModel);
    return Observer(builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ManthanPopupMenu(
          eventModel: widget.eventModel,
          items: commonStore.viewType == ViewType.admin ? popupOptions : [],
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Themes.cardColor2,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: [
                    SizedBox(
                      height: isManthan ? 98 : 78,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 4),
                                child: SizedBox(
                                  height: 28,
                                  child: Text(widget.eventModel.event,
                                      style: cardEventStyle),
                                ),
                              ),
                              isManthan
                                  ? SizedBox(
                                  height: 20,
                                  child: Text(widget.eventModel.module,
                                      style: cardStageStyle1))
                                  : Container(),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                          Container(
                              alignment: Alignment.topCenter,
                              width: 82,
                              child: DateWidget(
                                date: widget.eventModel.date,
                              ))
                        ],
                      ),
                    ),
                  ]),

                  SizedBox(
                    // height: 24,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              const Icon(
                                Icons.emoji_events_outlined,
                                color: Themes.warning,
                                size: 12,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Expanded(
                                child: Text(
                                  widget.eventModel.victoryStatement!,
                                  overflow: TextOverflow.visible,
                                  style: cardStageStyle1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                          },
                          child: Container(
                            height: 24,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Themes.kGrey),
                            width: 64,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              child: Row(
                                children: [
                                  Text(
                                    isExpanded ? 'Less' : 'More',
                                    style: cardResultStyle1,
                                  ),
                                  Icon(
                                    isExpanded
                                        ? Icons.keyboard_arrow_up_outlined
                                        : Icons.keyboard_arrow_down_outlined,
                                    size: 14,
                                    color: Themes.cardFontColor2,
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  isExpanded
                      ? Column(
                    children: [
                      const Divider(
                        height: 32,
                        color: Themes.bottomNavHighlightColor,
                        thickness: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: SizedBox(
                          height: 12,
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 26,
                                  ),
                                  Text(
                                    'Hostel',
                                    style: cardResultStyle2,
                                  ),
                                ],
                              ),
                              Text(
                                'Points',
                                style: cardResultStyle2,
                              ),
                            ],
                          ),
                        ),
                      ),
                      HostelsPointsSection(eventModel: widget.eventModel)
                    ],
                  )
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

// class HostelsPointsSection extends StatelessWidget {
//   final eventModel;
//
//   HostelsPointsSection({Key? key, required this.eventModel})
//       : super(key: key);
//
//   var length = 0;
//
//   void count() {
//     for(var x in eventModel.results)
//       {
//         length++;
//       }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     count();
//     return ConstrainedBox(
//         constraints: BoxConstraints(
//           maxHeight: length * 30,
//         ),
//         child: ListView.builder(
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: eventModel.results.length,
//             itemBuilder: (context, index) {
//               return ConstrainedBox(
//                 constraints: BoxConstraints(
//                     maxHeight: 1 * 30),
//                 child: ListView.builder(
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: eventModel.results[index],
//                     itemBuilder: (context, subIndex) {
//                       return scoreCardItem(
//                           index + 1,
//                           eventModel.results[index][subIndex].hostelName!,
//                           eventModel.results[index][subIndex].primaryScore!,
//                           eventModel.results[index][subIndex].secondaryScore);
//                     }),
//               );
//             }));
//   }
//
//
//   Widget scoreCardItem(int position, String hostelName, String finalScore,
//       String? secondaryScore) {
//     final split = secondaryScore?.split(',');
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           SizedBox(
//             height: 18,
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Container(
//                   alignment: Alignment.center,
//                   width: 16,
//                   height: 18,
//                   child: Text(
//                     '$position',
//                     style: cardVenueStyle1,
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 SizedBox(
//                   width: 105,
//                   child: Text(
//                     overflow: TextOverflow.visible,
//                     hostelName,
//                     style: cardVenueStyle1,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             alignment: Alignment.center,
//             height: 18,
//             child: Row(
//               children: [
//                 Text(
//                   finalScore,
//                   style: cardPostponedStyle,
//                 ),
//                 secondaryScore == null
//                     ? Container()
//                     : Row(
//                   children: [
//                     const SizedBox(
//                       width: 8,
//                     ),
//                     SizedBox(
//                       width: (split?.length.toDouble())! * 18,
//                       child: ListView.builder(
//                           itemCount: split?.length,
//                           scrollDirection: Axis.horizontal,
//                           physics: const NeverScrollableScrollPhysics(),
//                           itemBuilder: (context, index) {
//                             return Container(
//                               alignment: Alignment.centerRight,
//                               width: 18,
//                               child: Text(
//                                 split![index],
//                                 style: cardSecondaryScoreStyle,
//                               ),
//                             );
//                           }),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }


class HostelsPointsSection extends StatelessWidget {
  final eventModel;

  const HostelsPointsSection({Key? key, required this.eventModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: eventModel.results.length,
            itemBuilder: (context, position) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 18,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 16,
                          height: 18,
                          child: Text(
                            (position + 1).toString(),
                            style: cardVenueStyle1,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 150,
                          child: Text(
                            eventModel.results[position].hostelName!,
                            overflow: TextOverflow.visible,
                            style: cardVenueStyle1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 18,
                    child: Text(
                      eventModel.results[position].primaryScore!.toString(),
                      style: cardPostponedStyle,
                    ),
                  )
                ],
              );
            }),
      ],
    );
  }
}
