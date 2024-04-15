import 'dart:io';

/// 广告配置信息
class AdsConfig {

  /// 获取 App id
  static String get appId {
    return '5522675';
  }
  
  /// 获取开屏广告位id
  static String get splashId {
    return '102788881';
  }

  /// 获取插屏广告位id 竖屏
  static String get interstitialId => '102790910';

  /// 获取插屏广告位id 横屏
  static String get interstitialIdHorizontal => '102790295';

  /// 获取插屏广告位id 半屏
  static String get interstitialIdHalf => '102790475';

  /// 获取激励视频广告位id
  static String get rewardVideoId => '102790133';

  /// 获取 Banner 广告位id
  static String get bannerId => '102790294';

}
