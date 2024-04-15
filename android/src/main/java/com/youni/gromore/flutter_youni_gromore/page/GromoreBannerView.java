package com.youni.gromore.flutter_youni_gromore.page;

import android.content.Context;
import android.util.Log;
import android.view.View;
import android.widget.FrameLayout;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.bytedance.sdk.openadsdk.AdSlot;
import com.bytedance.sdk.openadsdk.TTAdDislike;
import com.bytedance.sdk.openadsdk.TTAdNative;
import com.bytedance.sdk.openadsdk.TTNativeExpressAd;
import com.youni.gromore.flutter_youni_gromore.PluginDelegate;
import com.youni.gromore.flutter_youni_gromore.event.GromoreEventAction;
import com.youni.gromore.flutter_youni_gromore.utils.UIUtils;

import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.platform.PlatformView;

/**
 * Banner 广告 View
 */
class GromoreBannerView extends BaseAdPage implements PlatformView, TTAdNative.NativeExpressAdListener, TTNativeExpressAd.ExpressAdInteractionListener, TTAdDislike.DislikeInteractionCallback {
    private final String TAG = GromoreBannerView.class.getSimpleName();
    @NonNull
    private final FrameLayout frameLayout;
    private final PluginDelegate pluginDelegate;
    private final int id;
    private TTNativeExpressAd bad;


    GromoreBannerView(@NonNull Context context, int id, @Nullable Map<String, Object> creationParams, PluginDelegate pluginDelegate) {
        this.id = id;
        this.pluginDelegate = pluginDelegate;
        frameLayout = new FrameLayout(context);
        MethodCall call = new MethodCall("AdBannerView", creationParams);
        showAd(this.pluginDelegate.activity, call);
    }

    @NonNull
    @Override
    public View getView() {
        return frameLayout;
    }

    @Override
    public void dispose() {
        disposeAd();
    }

    @Override
    public void loadAd(@NonNull MethodCall call) {
        // 获取请求模板广告素材的尺寸
        int expressViewWidth = call.argument("width");
        int expressViewHeight = call.argument("height");
        this.adslot = new AdSlot.Builder()
                .setCodeId(codeId)
                .setImageAcceptedSize(UIUtils.dp2px(activity,expressViewWidth), UIUtils.dp2px(activity,expressViewHeight))
                .build();
        // 加载广告
        adNativeLoader.loadBannerExpressAd(adslot, this);
    }

    /**
     * 销毁广告
     */
    private void disposeAd() {
        frameLayout.removeAllViews();
        if (bad != null) {
            bad.setExpressInteractionListener(null);
            bad.destroy();
        }
    }

    @Override
    public void onError(int i, String s) {
        Log.e(TAG, "onError code:" + i + " msg:" + s);
        sendErrorEvent(i, s);
        disposeAd();
    }

    @Override
    public void onNativeExpressAdLoad(List<TTNativeExpressAd> list) {
        if (list == null || list.size() == 0) {
            Log.e(TAG, "onNativeExpressAdLoad list is null or size is 0");
            return;
        }
        bad = list.get(0);
        bad.setExpressInteractionListener(this);
        bad.setDislikeCallback(activity, this);
        bad.render();
    }

    @Override
    public void onAdClicked(View view, int i) {
        Log.i(TAG, "onAdClicked");
        // 添加广告事件
        sendEvent(GromoreEventAction.onAdClicked);
    }

    @Override
    public void onAdShow(View view, int i) {
        Log.i(TAG, "onAdShow");
        // 添加广告事件
        sendEvent(GromoreEventAction.onAdExposure);
    }

    @Override
    public void onRenderFail(View view, String s, int i) {
        Log.e(TAG, "onRenderFail code:" + i + " msg:" + s);
        sendErrorEvent(i, s);
        disposeAd();
    }

    @Override
    public void onRenderSuccess(View view, float v, float v1) {
        Log.i(TAG, "onRenderSuccess");
        if (bad != null) {
            frameLayout.removeAllViews();
            frameLayout.addView(bad.getExpressAdView());
            // 添加广告事件
            sendEvent(GromoreEventAction.onAdPresent);
        }else{
            disposeAd();
        }
    }

    @Override
    public void onShow() {
        Log.i(TAG, "Dislike onShow");
    }

    @Override
    public void onSelected(int i, String s, boolean b) {
        Log.i(TAG, "Dislike onSelected");
        // 添加广告事件
        disposeAd();
        sendEvent(GromoreEventAction.onAdClosed);
    }

    @Override
    public void onCancel() {
        Log.i(TAG, "Dislike onCancel");
    }
}