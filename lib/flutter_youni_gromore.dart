import 'package:flutter/services.dart';
import 'dart:io';

import 'event/gromore_event_handler.dart';

/// @Author liuxiong
/// @Date 2024/1/10 21:26
/// @Description TOD
/// GroMore 广告插件
class FlutterYouniGromore {
  ///方法通道
  static const MethodChannel _methodChannel =
      MethodChannel('flutter_youni_gromore');

  ///事件通道
  static const EventChannel _eventChannel =
      EventChannel('flutter_youni_gromore_event');

  ///事件回调
  static Future<void> onEventListener(
      OnAdEventListener onAdEventListener) async {
    _eventChannel.receiveBroadcastStream().listen((event) {
      handleAdEvent(event, onAdEventListener);
    });
  }

  /// 请求应用跟踪透明度授权 (仅IOS)
  static Future<bool> get requestIDFA async {
    if (Platform.isIOS) {
      final bool result = await _methodChannel.invokeMethod('requestIDFA');
      return result;
    }
    return true;
  }

  /// 动态请求相关权限（仅 Android）
  static Future<bool> get requestPermissionIfNecessary async {
    if (Platform.isAndroid) {
      final bool result =
          await _methodChannel.invokeMethod('requestPermissionIfNecessary');
      return result;
    }
    return true;
  }

  /// 初始化广告
  /// [appId] 应用ID
  static Future<bool> init(String appId) async {
    final bool result = await _methodChannel.invokeMethod('init', {
      'appId': appId,
    });
    return result;
  }

  /// 展示开屏广告
  /// [codeId] 广告位 id
  static Future<bool> showSplash(String codeId) async {
    final bool result = await _methodChannel.invokeMethod(
      'showSplash',
      {
        'codeId': codeId,
      },
    );
    return result;
  }
  /// 展示激励视频广告
  /// [codeId] 广告位 id
  static Future<bool> showReward(String codeId) async {
    final bool result = await _methodChannel.invokeMethod(
      'showReward',
      {
        'codeId': codeId,
      },
    );
    return result;
  }

  /// 展示插屏广告
  /// [codeId] 广告位 id
  static Future<bool> showInterstitial(String codeId) async {
    final bool result = await _methodChannel.invokeMethod(
      'showInterstitial',
      {'codeId': codeId},
    );
    return result;
  }
}
