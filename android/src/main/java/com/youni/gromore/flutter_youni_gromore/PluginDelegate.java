package com.youni.gromore.flutter_youni_gromore;

import android.app.Activity;
import android.content.Intent;
import android.util.Log;

import androidx.annotation.NonNull;

import com.bytedance.sdk.openadsdk.TTAdConfig;
import com.bytedance.sdk.openadsdk.TTAdSdk;
import com.bytedance.sdk.openadsdk.TTCustomController;
import com.bytedance.sdk.openadsdk.mediation.init.MediationPrivacyConfig;
import com.youni.gromore.flutter_youni_gromore.page.GromoreSplashActivity;
import com.youni.gromore.flutter_youni_gromore.page.InterstitialPage;
import com.youni.gromore.flutter_youni_gromore.page.MediationRewardActivity;
import com.youni.gromore.flutter_youni_gromore.page.NativeViewFactory;

import io.flutter.BuildConfig;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/// 插件代理
public class PluginDelegate implements MethodChannel.MethodCallHandler, EventChannel.StreamHandler {
    private final String TAG = PluginDelegate.class.getSimpleName();
    // Flutter 插件绑定对象
    public FlutterPlugin.FlutterPluginBinding bind;
    // 当前 Activity
    public Activity activity;
    // 返回通道
    private MethodChannel.Result result;
    // 事件通道
    private EventChannel.EventSink eventSink;
    // 插件代理对象
    private static PluginDelegate _instance;

    public static PluginDelegate getInstance() {
        return _instance;
    }

    // Banner View
    public static final String KEY_BANNER_VIEW = "flutter_gromore_banner";
    // 广告参数
    public static final String KEY_CODEID = "codeId";

    /**
     * 插件代理构造函数构造函数
     *
     * @param activity      Activity
     * @param pluginBinding FlutterPluginBinding
     */
    public PluginDelegate(Activity activity, FlutterPlugin.FlutterPluginBinding pluginBinding) {
        this.activity = activity;
        this.bind = pluginBinding;
        _instance = this;
    }

    /**
     * 方法通道调用
     *
     * @param call   方法调用对象
     * @param result 回调结果对象
     */
    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        String method = call.method;
        Log.d(TAG, "MethodChannel onMethodCall method:" + method + " arguments:" + call.arguments);
        if ("requestPermissionIfNecessary".equals(method)) {
            requestPermissionIfNecessary(call, result);
        } else if ("init".equals(method)) {
            init(call, result);
        } else if ("showSplash".equals(method)) {
            showSplash(call, result);
        } else if ("showInterstitial".equals(method)) {
            showInterstitial(call, result);
        } else if("showReward".equals(method)){
            showReward(call,result);
        }else {
            result.notImplemented();
        }
    }

    /**
     * 建立事件通道监听
     *
     * @param arguments 参数
     * @param events    事件回调对象
     */
    @Override
    public void onListen(Object arguments, EventChannel.EventSink events) {
        Log.d(TAG, "EventChannel onListen arguments:" + arguments);
        eventSink = events;
    }

    /**
     * 取消事件通道监听
     *
     * @param arguments 参数
     */
    @Override
    public void onCancel(Object arguments) {
        Log.d(TAG, "EventChannel onCancel");
        eventSink = null;
    }

    /**
     * 添加事件
     *
     * @param event 事件
     */
    public void addEvent(Object event) {
        if (eventSink != null) {
            Log.d(TAG, "EventChannel addEvent event:" + event.toString());
            eventSink.success(event);
        }
    }

    /**
     * 展示 Banner 广告
     */
    public void registerBannerView() {
        bind.getPlatformViewRegistry()
                .registerViewFactory(KEY_BANNER_VIEW, new NativeViewFactory(KEY_BANNER_VIEW, this));
    }

    /**
     * 请求权限
     *
     * @param call   MethodCall
     * @param result Result
     */
    public void requestPermissionIfNecessary(MethodCall call, MethodChannel.Result result) {
        TTAdSdk.getMediationManager().requestPermissionIfNecessary(activity);
        result.success(true);
    }

    /**
     * 初始化广告
     *
     * @param call   MethodCall
     * @param result Result
     */
    public void init(MethodCall call, final MethodChannel.Result result) {
        String appId = call.argument("appId");
        // 构建基础配置
        TTAdConfig.Builder configBuilder = new TTAdConfig.Builder()
                .appId(appId)
                .useMediation(true)
                .debug(BuildConfig.DEBUG)
                .supportMultiProcess(false);
        // 构建配置
        TTAdConfig  gmPangleOption = configBuilder
                    .customController(getTTCustomController(false))
                    .build();
        // 初始化 SDK
        TTAdSdk.init(activity.getApplicationContext(),gmPangleOption);
        TTAdSdk.start(new TTAdSdk.Callback() {
            @Override
            public void success() {
                result.success(TTAdSdk.isInitSuccess());
            }

            @Override
            public void fail(int i, String s) {
                result.success(false);
                Log.e(TAG, "TTAdSdk init start Error code:"+i+" msg:"+s);
            }
        });
    }


    private TTCustomController getTTCustomController(boolean limitPersonalAds) {
        return new TTCustomController() {

            @Override
            public boolean isCanUseWifiState() {
                return super.isCanUseWifiState();
            }

            @Override
            public String getMacAddress() {
                return super.getMacAddress();
            }

            @Override
            public boolean isCanUseWriteExternal() {
                return super.isCanUseWriteExternal();
            }

            @Override
            public String getDevOaid() {
                return super.getDevOaid();
            }

            @Override
            public boolean isCanUseAndroidId() {
                return super.isCanUseAndroidId();
            }

            @Override
            public String getAndroidId() {
                return super.getAndroidId();
            }

            @Override
            public MediationPrivacyConfig getMediationPrivacyConfig() {
                return new MediationPrivacyConfig() {

                    @Override
                    public boolean isLimitPersonalAds() {
                        return limitPersonalAds;
                    }

                    @Override
                    public boolean isProgrammaticRecommend() {
                        return limitPersonalAds;
                    }
                };
            }

            @Override
            public boolean isCanUsePermissionRecordAudio() {
                return super.isCanUsePermissionRecordAudio();
            }
        };
    }

    /**
     * 显示开屏广告
     *
     * @param call   MethodCall
     * @param result Result
     */
    public void showSplash(MethodCall call, MethodChannel.Result result) {
        String codeId = call.argument(KEY_CODEID);
        Intent intent = new Intent(activity, GromoreSplashActivity.class);
        intent.putExtra(KEY_CODEID, codeId);
        activity.startActivity(intent);
        // 设置进入动画
        activity.overridePendingTransition(android.R.anim.fade_in, android.R.anim.fade_out);
        result.success(true);
    }
    /**
     * 显示激励视频
     *
     * @param call   MethodCall
     * @param result Result
     */
    public void showReward(MethodCall call, MethodChannel.Result result) {
        String codeId = call.argument(KEY_CODEID);
        MediationRewardActivity.open(activity,codeId);
        // 设置进入动画
        activity.overridePendingTransition(android.R.anim.fade_in, android.R.anim.fade_out);
        result.success(true);
    }


    /**
     * 显示插屏广告
     *
     * @param call   MethodCall
     * @param result Result
     */
    public void showInterstitial(MethodCall call, MethodChannel.Result result) {
        InterstitialPage adPage = new InterstitialPage();
        adPage.showAd(activity, call);
        result.success(true);
    }

}
