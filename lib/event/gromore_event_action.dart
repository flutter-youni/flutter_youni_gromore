/// @Author liuxiong
/// @Date 2024/1/10 21:42
/// @Description TODO
///广告事件操作
class GromoreEventActions{
  ///广告错误
  static const String onAdError = 'onAdError';
  ///广告加载成功
  static const String onAdLoaded = 'onAdLoaded';
  ///广告填充
  static const String onAdPresent = 'onAdPresent';
  ///广告曝光
  static const String onAdExposure = 'onAdExposure';
  ///广告关闭（计时结束或者用户点击关闭）
  static const String onAdClosed= 'onAdClosed';
  ///广告点击
  static const String onAdClicked = 'onAdClicked';
  ///广告跳过
  static const String onAdSkip = 'onAdSkip';
  ///广告播放或计时完毕
  static const String onAdComplete = 'onAdComplete';
  ///获得广告激励
  static const String onAdReward = 'onAdReward';
}