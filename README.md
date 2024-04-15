# 🔥🔥🔥穿山甲Gromore的Flutter插件（由你团队出品）

<p>
<a href="https://pub.flutter-io.cn/packages/flutter_youni_gromore"><img src=https://img.shields.io/pub/v/flutter_youni_gromore?color=orange></a>
<a href="https://pub.flutter-io.cn/packages/flutter_youni_gromore"><img src=https://img.shields.io/pub/likes/flutter_youni_gromore></a>
<a href="https://pub.flutter-io.cn/packages/flutter_youni_gromore"><img src=https://img.shields.io/pub/points/flutter_youni_gromore></a>
<a href="https://github.com/flutter-youni/flutter_youni_gromore/commits"><img src=https://img.shields.io/github/last-commit/flutter-youni/flutter_youni_gromore></a>
<a href="https://github.com/flutter-youni/flutter_youni_gromore"><img src=https://img.shields.io/github/stars/flutter-youni/flutter_youni_gromore></a>
</p>


## 简介

**Gromore最新版本**的Flutter插件，我们是一个致力于服务独立开发者的团队，这个插件我们会一直维护。

创业过程中我们解决了各种大大小小的问题，我希望我们的创业经验能让你少走弯路，遇到任何和创业相关的问题都可以咨询我们，万一我们遇到过呢。

* 如果你想做一个小项目需要资金联系我们
* 如果你有个想法，需要开发者和运营联系我们
* 如果你已经有开发好了一个应用，需要一个公司上架联系我们
* 如果你想找个公司接广告，我们只收10%，这个价格全网也难找

## 为什么选择新版本的Gromore？

1、老版本会面临被下架的风险，老版本的穿上甲版本有过度获取隐私位置隐私的问题。

<img src="https://github.com/flutter-youni/flutter_youni_gromore/blob/master/readme_image/162448.png" alt="WX20240415-162448@2x" style="zoom:50%;" />

2、会提高收入，如果是大的活动，比如双11，gromore都会针对这个版本进行更新，新版本的cpm都会有10%的提升

<img src="https://github.com/flutter-youni/flutter_youni_gromore/blob/master/readme_image/64346708.png" alt="image-20240415164346708" style="zoom: 33%;" />

## 支持平台

- ✅ **Android**
- ✅ **iOS**

## 支持广告

- ✅ **开屏广告**
- ✅ **插屏广告**
- ✅ **激励广告**
- ✅ **Banner广告**
- ❎**信息流广告**

## 接入方法

下面将分成Android和iOS一些配置，**Android和iOS接入Flutter的步骤都是相同的**；

### Android接入方法

Android的接入分成2个步骤

1、配置AndroidManifest，包括添加权限和provider；

2、Gradle需要的配置；

#### 步骤1：配置AndroidManifest

1、需要再AndroidManifest文件中添加以下权限；

```xml
<uses-permission android:name="android.permission.INTERNET" /> 
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" /> 
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />   
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.REQUEST_INSTALL_PACKAGES" /> 
<uses-permission android:name="android.permission.READ_PHONE_STATE" />  
```

2、资源文件配置，下面只包括了穿山甲和优量汇的配置，如果单独需要穿山甲或者优量汇，可以分别单独添加配置，如果需要配置快手、百度等平台请参考[如何接入快手、百度等平台的广告](https://www.csjplatform.com/union/media/union/download/detail?id=142&docId=27562&osType=android)

* 穿山甲和优量汇的provider配置，具体可以参考flutter_youni_gromore的Android demo

```xml
<!-- 穿山甲 start================== -->
        <provider
            android:name="com.bytedance.sdk.openadsdk.TTFileProvider"
            android:authorities="${applicationId}.TTFileProvider"
            android:exported="false"
            android:grantUriPermissions="true">
            <meta-data
                android:name="android.support.FILE_PROVIDER_PATHS"
                android:resource="@xml/pangle_file_paths" />
        </provider>

        <provider
            android:name="com.bytedance.sdk.openadsdk.multipro.TTMultiProvider"
            android:authorities="${applicationId}.TTMultiProvider"
            android:exported="false" />
        <!-- 穿山甲 end================== -->

<!-- GDT start================== -->
<!-- targetSDKVersion >= 24时才需要添加这个provider。provider的authorities属性的值为${applicationId}.fileprovider，请开发者根据自己的${applicationId}来设置这个值，例如本例中applicationId为"com.qq.e.union.demo"。 -->
        <provider
            android:name="com.qq.e.comm.GDTFileProvider"
            android:authorities="${applicationId}.gdt.fileprovider"
            android:exported="false"
            android:grantUriPermissions="true">
            <meta-data
                android:name="android.support.FILE_PROVIDER_PATHS"
                android:resource="@xml/gdt_file_path" />
        </provider>    
<activity
        android:name="com.qq.e.ads.PortraitADActivity"
        android:configChanges="keyboard|keyboardHidden|orientation|screenSize"
        android:screenOrientation="portrait" />
    <activity
        android:name="com.qq.e.ads.LandscapeADActivity"
        android:configChanges="keyboard|keyboardHidden|orientation|screenSize"
        android:screenOrientation="landscape"
        tools:replace="android:screenOrientation" />

    <!-- 声明SDK所需要的组件 -->
    <service
        android:name="com.qq.e.comm.DownloadService"
        android:exported="false" />
    <!-- 请开发者注意字母的大小写，ADActivity，而不是AdActivity -->

    <activity
        android:name="com.qq.e.ads.ADActivity"
        android:configChanges="keyboard|keyboardHidden|orientation|screenSize" />
    <!-- GDT end================== -->
```

* 这个步骤是配置`android.support.FILE_PROVIDER_PATHS`需要额xml文件，res/xml目录下添加两个个文件，文件名称是`pangle_file_paths.xml`和`gdt_file_path.xml`

  下面是`pangle_file_paths.xml`文件内容

  ```xml
   <?xml version="1.0" encoding="utf-8"?>
   <paths>
       <external-path name="tt_external_root" path="." />
       <external-path name="tt_external_download" path="Download" />
       <external-files-path name="tt_external_files_download" path="Download" />
       <files-path name="tt_internal_file_download" path="Download" />
       <cache-path name="tt_internal_cache_download" path="Download" />
   </paths>
  ```
  
  下面是`gdt_file_path.xml`文件内容
  
  ```xml
  <paths>
      <!-- 这个下载路径也不可以修改，必须为com_qq_e_download -->
      <external-cache-path
          name="gdt_sdk_download_path1"
          path="com_qq_e_download" />
      <cache-path
          name="gdt_sdk_download_path2"
          path="com_qq_e_download" />
  </paths>
  ```
  
  #### 步骤2：配置Gradle
  
  1、在rallprojects和buildscript下面添穿上甲的maven
  
  ```groovy
  buildscript {
      repositories {
          maven {
              url "https://artifact.bytedance.com/repository/pangle"
          }
      }
  }
  
  rootProject.allprojects {
      repositories {
          maven {
              url "https://artifact.bytedance.com/repository/pangle"
          }
      }
  }
  ```
  
  2、添加依赖库
  
  ```groovy
  dependencies {
      implementation "com.pangle.cn:mediation-sdk:5.9.2.8"//融合基础包，必须引入
    
      implementation "com.qq.e.union:union:4.540.1410"// 添加优量汇的广告SDK
    	implementation "com.pangle.cn:mediation-gdt-adapter:4.540.1410.3"//添加优量汇的adapter
  } 
  ```
  
  ### iOS接入方法
  
  Android的接入分成2个步骤
  
  1、添加pod依赖；
  
  2、在`Info.plist`文件中添加权限；
  
  #### 步骤1：添加pod依赖
  
  在`Podfile`文件中添加穿山甲和优量汇的pod依赖，可以参考flutter_youni_gromore下的iOSdemo
  
  ```pascal
  target 'Runner' do
    pod 'CSJMGdtAdapter', '4.14.63.0'
    pod 'GDTMobSDK','4.14.63'
  end
  ```
  
  #### 步骤2：添加权限
  
  在iOS14.5以后想要依旧能使用IDFA，建议开发者在初始化聚合SDK之前获取ATT授权，以便允许用户授权跟踪权限。
  
  首先，需要在App层级的info.plist里添加ATT权限描述：
  
  ```xml
  <key>NSUserTrackingUsageDescription</key>
  	<string>ATT权限使用说明，需要开发者自行设置描述</string>
  ```
  
  ### Flutter集成步骤
  
  #### pubspec.yaml
  ```Dart
  flutter_youni_gromore: ^1.0.0
  ```
  #### 引入
  ```Dart
  import 'package:flutter_youni_gromore/flutter_youni_gromore.dart';
  ```
  
  ## 使用
  
  ### SDK初始化
  ```Dart
  WidgetsFlutterBinding.ensureInitialized();
  setGromoreEvent();//设置广告监听事情，这个事件包括一些错误事件、激励视频事件
  init().then((value) {
      if (value) {
         //广告初始化成功了执行的一些动作和方法
      }
  });
  
   Future<bool> init() async {
      try {
        //这个是广告的初始化事件
        bool result = await FlutterYouniGromore.init(
          "广告id"
        );
        return result;
      } on PlatformException catch (e) {
      }
      return false;
    }
  ```
  
  ### 广告监听
  
  ```dart
  Future<void> setGromoreEvent() async {
      FlutterYouniGromore.onEventListener((event) {
        //event中最重要的两个属性是adId和action，adId就是广告位的id，action对应是广告位的行为
        //行为包括：广告错误、广告加载成功、广告填充、广告曝光、广告关闭（计时结束或者用户点击关闭）、广告点击、广告跳过、广告播放或计时完毕、获得广告激励 9个行为
        if (event is GromoreErrorEvent) {
        
        } else if (event is GromoreRewardEvent) {
   
        }
      });
    }
  ```
  
  下面是广告行为对应的名称：
  
  ```dart
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
  ```
  
  下面是利用广告监听，展示完闪屏跳转到首页的示例代码
  
  ```dart
  Future<void> setAdEvent() async {
      FlutterYouniGromore.onEventListener((event) {
        if (event.adId == "开屏广告位id") {//先判断是开屏的广告广告位
          if (event.action == GromoreEventActions.onAdClosed ||
              event.action == GromoreEventActions.onAdSkip ||
              event.action == GromoreEventActions.onAdComplete ||
              event.action == GromoreEventActions.onAdError) {//判断各种的事件类型，符合这些条件的情况跳转到首页
            gotoMain();//跳转到首页
          }
        }
      });
    }
  ```
  
  ### 开屏广告
  
  ```dart
  Future<void> showSplash() async {
      try {
        bool result = await FlutterYouniGromore.showSplash("广告位id");
      } on PlatformException catch (e) {
      }
    }
  ```
  
  ### 插屏广告
  
  ```dart
   Future<void> showInterstitial() async {
      try {
        bool result = await FlutterYouniGromore.showInterstitial("广告位id");
      } on PlatformException catch (e) {
      }
    }
  ```
  
  ### 激励视频广告
  
  ```dart
    Future<void> showReward() async {
      if (!jumpCondition()) {
        return;
      }
      try {
        bool result = await FlutterYouniGromore.showReward(
           "广告位id",
        );
      } on PlatformException catch (e) {
      }
    }
  ```
  ### Banner(横幅)广告
  ```dart
   GromoreBannerWidget(
                  codeId: "广告位id",
                  width: 300,//广告的宽度
                  height: 150,//广告的高度
                ),
  ```
  
  
  
  
  
  





