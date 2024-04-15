import 'gromore_event.dart';

/// @Author liuxiong
/// @Date 2024/1/10 21:59
/// @Description 广告激励事件
class GromoreRewardEvent extends GromoreEvent{
  ///奖励是否有效
  final bool rewardVerify;
  ///奖励数量
  final int rewardAmount;
  ///奖励名称
  final String rewardName;
  ///错误码
  final int? errCode;
  ///错误信息
  final String? errMsg;
  ///服务端验证的自定义信息
  final String? customData;
  ///服务端验证的用户信息
  final String? userId;
  GromoreRewardEvent(
      {required this.rewardVerify,
        required this.rewardAmount,
        required this.rewardName,
        this.errCode,
        this.errMsg,
        this.customData,
        this.userId,
        required String adId,
        required String action})
      : super(adId: adId, action: action);
  factory GromoreRewardEvent.fromJson(Map<dynamic,dynamic> json){
    return GromoreRewardEvent(
      adId: json['adId'],
      action: json['action'],
      rewardVerify: json['rewardVerify'],
      rewardAmount: json['rewardAmount'],
      rewardName: json['rewardName'],
      errCode: json['errCode'],
      errMsg: json['errMsg'],
      customData: json['customData'],
      userId: json['userId'],
    );
  }
}