package com.youni.gromore.flutter_youni_gromore.page;

import android.os.Bundle;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.widget.FrameLayout;

import androidx.appcompat.app.AppCompatActivity;

import com.bytedance.sdk.openadsdk.AdSlot;
import com.bytedance.sdk.openadsdk.CSJAdError;
import com.bytedance.sdk.openadsdk.CSJSplashAd;
import com.bytedance.sdk.openadsdk.TTAdNative;
import com.bytedance.sdk.openadsdk.TTAdSdk;
import com.youni.gromore.flutter_youni_gromore.PluginDelegate;
import com.youni.gromore.flutter_youni_gromore.R;
import com.youni.gromore.flutter_youni_gromore.event.GoreErrorEvent;
import com.youni.gromore.flutter_youni_gromore.event.GoreEvent;
import com.youni.gromore.flutter_youni_gromore.event.GromoreEventAction;
import com.youni.gromore.flutter_youni_gromore.event.GromoreEventHandler;
import com.youni.gromore.flutter_youni_gromore.utils.StatusBarUtils;
import com.youni.gromore.flutter_youni_gromore.utils.UIUtils;

/**
 * 开屏广告
 */
public class GromoreSplashActivity extends AppCompatActivity implements TTAdNative.CSJSplashAdListener,CSJSplashAd.SplashAdListener {
    private final String TAG = GromoreSplashActivity.class.getSimpleName();
    // 广告容器
    private FrameLayout gromore_container;
    // 广告位 id
    private String codeId;
    // 开屏广告
    private CSJSplashAd gmSplashAd;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        UIUtils.hideBottomUIMenu(this);
        StatusBarUtils.setTranslucent(this);
        setContentView(R.layout.activity_ad_splash);
        initView();
        initData();
    }

    /**
     * 初始化View
     */
    private void initView() {
        gromore_container = findViewById(R.id.splash_gromore_container);
    }

    /**
     * 初始化数据
     */
    private void initData() {

        // 获取参数
        codeId = getIntent().getStringExtra(PluginDelegate.KEY_CODEID);
        int width = (int) UIUtils.getScreenWidthInPx(this);
        int height = UIUtils.getRealHeight(this);
        // 创建开屏广告
        AdSlot adSlot = new AdSlot.Builder()
                .setCodeId(codeId)
                .setImageAcceptedSize(width, height) // 单位是px
                .build();
        // 加载广告
        TTAdSdk.getAdManager().createAdNative(this).loadSplashAd(adSlot,this,3500);
    }

    /**
     * 完成广告，退出开屏页面
     */
    private void finishPage() {
        finish();
        // 设置退出动画
        overridePendingTransition(android.R.anim.fade_in, android.R.anim.fade_out);
        // 销毁
        if (gmSplashAd != null&&gmSplashAd.getMediationManager()!=null) {
            gmSplashAd.setSplashAdListener(null);
            gmSplashAd.getMediationManager().destroy();
            gmSplashAd = null;
        }
    }

    /**
     * 开屏页一定要禁止用户对返回按钮的控制，否则将可能导致用户手动退出了App而广告无法正常曝光和计费
     */
    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_BACK || keyCode == KeyEvent.KEYCODE_HOME) {
            return true;
        }
        return super.onKeyDown(keyCode, event);
    }

    @Override
    public void onSplashLoadSuccess(CSJSplashAd csjSplashAd) {
        Log.d(TAG, "onSplashLoadSuccess");
        GromoreEventHandler.getInstance().sendEvent(new GoreEvent(this.codeId, GromoreEventAction.onAdLoaded));
    }

    @Override
    public void onSplashLoadFail(CSJAdError adError) {
        Log.e(TAG, "onSplashLoadFail code:" + adError.getCode() + " msg:" + adError.getMsg());
        GromoreEventHandler.getInstance().sendEvent(new GoreErrorEvent(this.codeId, adError.getCode(), adError.getMsg()));
        finishPage();
    }

    @Override
    public void onSplashRenderSuccess(CSJSplashAd csjSplashAd) {
        Log.d(TAG, "onSplashRenderSuccess");
        //获取SplashView
        if (this.isFinishing()) {
            finishPage();
            return;
        }
        gmSplashAd=csjSplashAd;
        csjSplashAd.setSplashAdListener(this);
        View splashView = csjSplashAd.getSplashView();
        if (splashView == null) {
            finishPage();
            return;
        }
        UIUtils.removeFromParent(splashView);
        gromore_container.removeAllViews();
        gromore_container.addView(splashView);
        // 加载事件
        GromoreEventHandler.getInstance().sendEvent(new GoreEvent(this.codeId, GromoreEventAction.onAdPresent));
    }

    @Override
    public void onSplashRenderFail(CSJSplashAd csjSplashAd, CSJAdError adError) {
        Log.e(TAG, "onSplashRenderFail code:" + adError.getCode() + " msg:" + adError.getMsg());
        GromoreEventHandler.getInstance().sendEvent(new GoreErrorEvent(this.codeId, adError.getCode(), adError.getMsg()));
    }

    @Override
    public void onSplashAdShow(CSJSplashAd csjSplashAd) {
        Log.d(TAG, "onAdShow");
        GromoreEventHandler.getInstance().sendEvent(new GoreEvent(this.codeId, GromoreEventAction.onAdExposure));
    }

    @Override
    public void onSplashAdClick(CSJSplashAd csjSplashAd) {
        Log.d(TAG, "onAdClicked");
        GromoreEventHandler.getInstance().sendEvent(new GoreEvent(this.codeId, GromoreEventAction.onAdClicked));
        finishPage();
    }

    @Override
    public void onSplashAdClose(CSJSplashAd csjSplashAd, int i) {
        Log.d(TAG, "onSplashAdClose");
        GromoreEventHandler.getInstance().sendEvent(new GoreEvent(this.codeId, GromoreEventAction.onAdClosed));
        finishPage();
    }
}