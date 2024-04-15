package com.youni.gromore.flutter_youni_gromore.page;


import static com.youni.gromore.flutter_youni_gromore.PluginDelegate.KEY_CODEID;

import android.app.Activity;

import com.bytedance.sdk.openadsdk.AdSlot;
import com.bytedance.sdk.openadsdk.TTAdNative;
import com.bytedance.sdk.openadsdk.TTAdSdk;
import com.youni.gromore.flutter_youni_gromore.event.GoreErrorEvent;
import com.youni.gromore.flutter_youni_gromore.event.GoreEvent;
import com.youni.gromore.flutter_youni_gromore.event.GromoreEventHandler;

import io.flutter.plugin.common.MethodCall;

/**
 * 基础广告页面
 */
public abstract class BaseAdPage {
    // 上下文
    protected Activity activity;
    // 广告位 id
    protected String codeId;
    // 广告配置
    protected AdSlot adslot;
    // 广告加载器
    protected TTAdNative adNativeLoader;

    /**
     * 显示广告
     *
     * @param activity 上下文
     * @param call     方法调用
     */
    public void showAd(Activity activity, MethodCall call) {
        this.activity = activity;
        this.codeId = call.argument(KEY_CODEID);
        this.adNativeLoader= TTAdSdk.getAdManager().createAdNative(activity);
        loadAd(call);
    }

    /**
     * 加载广告
     *
     * @param call 方法调用
     */
    public abstract void loadAd(MethodCall call);

    /**
     * 发送广告事件
     *
     * @param event 广告事件
     */
    protected void sendEvent(GoreEvent event) {
        GromoreEventHandler.getInstance().sendEvent(event);
    }

    /**
     * 发送广告事件
     *
     * @param action 操作
     */
    protected void sendEvent(String action) {
        sendEvent(new GoreEvent(codeId, action));
    }

    /**
     * 发送错误事件
     *
     * @param errCode 错误码
     * @param errMsg  错误事件
     */
    protected void sendErrorEvent(int errCode, String errMsg) {
        sendEvent(new GoreErrorEvent(codeId, errCode, errMsg));
    }
}
