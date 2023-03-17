import 'package:scoreboard/src/models/manthan_models/manthan_event_model.dart';
import '../globals/enums.dart';

List<ManthanEventModel> manthanFilterSchedule({required List<ManthanEventModel> input, required String module})
{
  print(module);
  List<ManthanEventModel> output=[];
  output.addAll(input);
  output.retainWhere((element){
    if(module == Module.overall.moduleName)
      {
        print(module);
        return true;
      }
    else if(module == element.module)
      {
        return true;
      }
    else
      {
        return false;
      }
  });
  return output;
}
