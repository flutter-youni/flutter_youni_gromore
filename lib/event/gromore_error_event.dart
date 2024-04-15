import 'gromore_event.dart';

/// @Author liuxiong
/// @Date 2024/1/10 21:52
/// @Description 广告错误事件
class GromoreErrorEvent extends GromoreEvent{
  ///错误码
  final int errCode;
  ///错误信息
  final String? errMsg;
  GromoreErrorEvent({required String adId,required String action,required this.errCode,this.errMsg}):
      super(adId: adId,action: action);
  ///解析 json 为错误事件对象
  factory GromoreErrorEvent.fromJson(Map<dynamic,dynamic> json){
    return GromoreErrorEvent(adId: json['adId'], action:  json['action'], errCode: json['errCode'],errMsg: json['errMsg']);
  }
}