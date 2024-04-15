package com.youni.gromore.flutter_youni_gromore.page;

import android.util.Log;

import androidx.annotation.NonNull;

import com.bytedance.sdk.openadsdk.AdSlot;
import com.bytedance.sdk.openadsdk.TTAdNative;
import com.bytedance.sdk.openadsdk.TTFullScreenVideoAd;
import com.youni.gromore.flutter_youni_gromore.event.GromoreEventAction;

import io.flutter.plugin.common.MethodCall;

/**
 * 插屏广告
 */
public class InterstitialPage extends BaseAdPage implements TTAdNative.FullScreenVideoAdListener, TTFullScreenVideoAd.FullScreenVideoAdInteractionListener {
    private final String TAG = InterstitialPage.class.getSimpleName();
    private TTFullScreenVideoAd ad;

    @Override
    public void loadAd(@NonNull MethodCall call) {
        adslot = new AdSlot.Builder()
                .setCodeId(this.codeId)
                .build();
        adNativeLoader.loadFullScreenVideoAd(adslot, this);
    }

    @Override
    public void onError(int i, String s) {
        Log.e(TAG, "onInterstitialLoadFail code:" + i + " msg:" + s);
        sendErrorEvent(i, s);
    }

    @Override
    public void onFullScreenVideoAdLoad(TTFullScreenVideoAd ttFullScreenVideoAd) {
        Log.i(TAG, "onFullScreenVideoAdLoad");
        ad=ttFullScreenVideoAd;
        ad.setFullScreenVideoAdInteractionListener(this);
        ad.showFullScreenVideoAd(activity);
        // 添加广告事件
        sendEvent(GromoreEventAction.onAdLoaded);
    }

    @Override
    public void onFullScreenVideoCached() {

    }

    @Override
    public void onFullScreenVideoCached(TTFullScreenVideoAd ttFullScreenVideoAd) {

    }

    @Override
    public void onAdShow() {
        Log.i(TAG, "onAdShow");
        // 添加广告事件
        sendEvent(GromoreEventAction.onAdExposure);
    }

    @Override
    public void onAdVideoBarClick() {
        Log.i(TAG, "onAdVideoBarClick");
        // 添加广告事件
        sendEvent(GromoreEventAction.onAdClicked);
    }

    @Override
    public void onAdClose() {
        Log.i(TAG, "onAdClose");
        if (ad != null && ad.getMediationManager() != null) {
            ad.setFullScreenVideoAdInteractionListener(null);
            ad.getMediationManager().destroy();
        }
        // 添加广告事件
        sendEvent(GromoreEventAction.onAdClosed);
    }

    @Override
    public void onVideoComplete() {
        Log.i(TAG, "onVideoComplete");
        // 添加广告事件
        sendEvent(GromoreEventAction.onAdComplete);
    }

    @Override
    public void onSkippedVideo() {
        Log.i(TAG, "onSkippedVideo");
        // 添加广告事件
        sendEvent(GromoreEventAction.onAdSkip);
    }
}