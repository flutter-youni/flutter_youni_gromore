import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_youni_gromore/event/gromore_error_event.dart';
import 'package:flutter_youni_gromore/event/gromore_reward_event.dart';
import 'ads_config.dart';
import 'banner_view.dart';
import 'package:flutter_youni_gromore/flutter_youni_gromore.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// @Author liuxiong
/// @Date 2024/1/10 21:21
/// @Description TODO
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _result = '';
  String _adEvent = '';
  bool isInitSuccess = false;
  bool isRequestPermission = false;

  @override
  void initState() {
    super.initState();
    setGromoreEvent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter GroMore Ads'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text('Result: $_result'),
            const SizedBox(height: 10),
            Text('onAdEvent: $_adEvent'),
            const SizedBox(height: 20),
            SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                child: const Text('初始化'),
                onPressed: () {
                  init();
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: ElevatedButton(
                    child: const Text('应用跟踪授权(IOS)'),
                    onPressed: () {
                      requestIDFA();
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Flexible(
                  child: ElevatedButton(
                    child: const Text('动态相关权限(Android)'),
                    onPressed: () {
                      requestPermissionIfNecessary();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text('激励视频'),
                  onPressed: () {
                    showReward();
                  },
                )),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text('开屏广告(全屏)'),
                onPressed: () {
                  showSplash();
                },
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text('插竖屏'),
                onPressed: () {
                  showInterstitial(AdsConfig.interstitialId);
                },
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text('banner广告'),
                onPressed: () {
                  jumpBannerPage();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool jumpCondition() {
    if (!isInitSuccess) {
      Fluttertoast.showToast(msg: "未初始化");
      return false;
    }
    if (!isRequestPermission) {
      Fluttertoast.showToast(msg: "未申请权限");
      return false;
    }
    return true;
  }

  void jumpBannerPage() {
    if (!jumpCondition()) {
      return;
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const BannerView();
    }));
  }

  /// 设置广告监听
  Future<void> setGromoreEvent() async {
    setState(() {
      _adEvent = '设置成功';
    });
    FlutterYouniGromore.onEventListener((event) {
      _adEvent = 'adId:${event.adId} action:${event.action}';
      if (event is GromoreErrorEvent) {
        // 错误事件
        _adEvent += ' errCode:${event.errCode} errMsg:${event.errMsg}';
      } else if (event is GromoreRewardEvent) {
        // 激励事件
        _adEvent +=
            ' rewardVerify:${event.rewardVerify} rewardAmount:${event.rewardAmount} rewardName:${event.rewardName} errCode:${event.errCode} errMsg:${event.errMsg} customData:${event.customData} userId:${event.userId}';
      }
      debugPrint('onEventListener:$_adEvent');
      setState(() {});
    });
  }

  /// 请求应用跟踪透明度授权
  Future<void> requestIDFA() async {
    bool result = await FlutterYouniGromore.requestIDFA;
    _adEvent = '请求广告标识符:$result';
    setState(() {});
  }

  /// 请求应用跟踪透明度授权
  Future<void> requestPermissionIfNecessary() async {
    bool result = await FlutterYouniGromore.requestPermissionIfNecessary;
    _adEvent = '请求相关权限:$result';
    isRequestPermission = result;
    setState(() {});
  }

  /// 展示开屏广告
  Future<void> showSplash() async {
    if (!jumpCondition()) {
      return;
    }
    try {
      bool result = await FlutterYouniGromore.showSplash(AdsConfig.splashId);
      _result = "展示开屏广告${result ? '成功' : '失败'}";
    } on PlatformException catch (e) {
      _result = "展示开屏广告失败 code:${e.code} msg:${e.message} details:${e.details}";
    }
  }

  /// 展示激励视频广告
  Future<void> showReward() async {
    if (!jumpCondition()) {
      return;
    }
    try {
      bool result = await FlutterYouniGromore.showReward(
        AdsConfig.rewardVideoId,
      );
      _result = "展示开屏广告${result ? '成功' : '失败'}";
    } on PlatformException catch (e) {
      _result = "展示开屏广告失败 code:${e.code} msg:${e.message} details:${e.details}";
    }
  }

  /// 展示插屏广告
  Future<void> showInterstitial(String codeId) async {
    if (!jumpCondition()) {
      return;
    }
    try {
      bool result = await FlutterYouniGromore.showInterstitial(codeId);
      _result = "展示插屏广告${result ? '成功' : '失败'}";
    } on PlatformException catch (e) {
      _result = "展示插屏广告失败 code:${e.code} msg:${e.message} details:${e.details}";
    }
    setState(() {});
  }

  /// 初始化广告 SDK
  Future<bool> init() async {
    try {
      bool result = await FlutterYouniGromore.init(
        AdsConfig.appId,
      );
      _result = "广告SDK 初始化${result ? '成功' : '失败'}";
      isInitSuccess = true;
      setState(() {});
      return result;
    } on PlatformException catch (e) {
      _result =
          "广告SDK 初始化失败 code:${e.code} msg:${e.message} details:${e.details}";
      isInitSuccess = false;
    }
    setState(() {});
    return false;
  }
}
