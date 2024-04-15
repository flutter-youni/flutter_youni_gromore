import 'gromore_error_event.dart';
import 'gromore_event_action.dart';
import 'gromore_reward_event.dart';

/// @Author liuxiong
/// @Date 2024/1/10 21:38
/// @Description TODO
///广告事件
class GromoreEvent{
  ///广告id
  final String adId;
  ///操作
  final String action;
  GromoreEvent({required this.adId, required this.action});
  ///解析 AdEvent
  factory GromoreEvent.fromJson(Map<dynamic,dynamic> json){
    String action = json['action'];
    if(action == GromoreEventActions.onAdError){
     return GromoreErrorEvent.fromJson(json);
    }else if(action == GromoreEventActions.onAdReward){
      return GromoreRewardEvent.fromJson(json);
    }else{
      return GromoreEvent(
        adId: json['adId'],
        action: action,
      );
    }
  }
}

class AdRewardEvent {
}