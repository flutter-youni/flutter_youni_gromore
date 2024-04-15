
import 'gromore_event.dart';

/// @Author liuxiong
/// @Date 2024/1/10 21:34
/// @Description TODO
///广告事件回调监听
typedef OnAdEventListener = void Function(GromoreEvent event);

/// 处理广告事件
void handleAdEvent(dynamic data, OnAdEventListener  listener){
  if(data != null){
    GromoreEvent adEvent = GromoreEvent.fromJson(data);
    listener.call(adEvent);
  }
}