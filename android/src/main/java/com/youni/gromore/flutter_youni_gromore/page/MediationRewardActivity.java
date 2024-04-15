package com.youni.gromore.flutter_youni_gromore.page;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;

import androidx.annotation.Nullable;

import com.bytedance.sdk.openadsdk.AdSlot;
import com.bytedance.sdk.openadsdk.TTAdConstant;
import com.bytedance.sdk.openadsdk.TTAdNative;
import com.bytedance.sdk.openadsdk.TTAdSdk;
import com.bytedance.sdk.openadsdk.TTRewardVideoAd;
import com.youni.gromore.flutter_youni_gromore.R;
import com.youni.gromore.flutter_youni_gromore.event.GoreErrorEvent;
import com.youni.gromore.flutter_youni_gromore.event.GoreEvent;
import com.youni.gromore.flutter_youni_gromore.event.GromoreEventAction;
import com.youni.gromore.flutter_youni_gromore.event.GromoreEventHandler;

/**
 * 融合demo，激励视频广告使用示例。更多功能参考接入文档。
 *
 * 注意：每次加载的广告，只能展示一次
 *
 * 接入步骤：
 * 1、创建AdSlot对象
 * 2、创建TTAdNative对象
 * 3、创建加载、展示监听器
 * 4、加载广告
 * 5、加载成功后，展示广告
 * 6、在onDestroy中销毁广告
 */
public class MediationRewardActivity extends Activity {

    public static final String TAG=MediationRewardActivity.class.getSimpleName();
    public static void open(Context context,String mediaId){
        Intent intent = new Intent(context, MediationRewardActivity.class);
        intent.putExtra("reward_media_id",mediaId);
        context.startActivity(intent);
    }
    public String mMediaId; // 融合广告位

    private TTRewardVideoAd mTTRewardVideoAd; // 插全屏广告对象

    private TTAdNative.RewardVideoAdListener mRewardVideoListener; // 广告加载监听器

    private TTRewardVideoAd.RewardAdInteractionListener mRewardVideoAdInteractionListener; // 广告展示监听器

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.mediation_activity_reward);
        mMediaId=getIntent().getStringExtra("reward_media_id");
        loadRewardVideoAd();
    }

    private void loadRewardVideoAd() {
        /** 1、创建AdSlot对象 */

        AdSlot adslot = new AdSlot.Builder()
                .setCodeId(mMediaId)

                .setOrientation(TTAdConstant.ORIENTATION_VERTICAL)
                .build();

        /** 2、创建TTAdNative对象 */

        TTAdNative adNativeLoader = TTAdSdk.getAdManager().createAdNative(this);

        /** 3、创建加载、展示监听器 */
        initListeners();

        /** 4、加载广告 */

        adNativeLoader.loadRewardVideoAd(adslot, mRewardVideoListener);
    }

    // 广告加载成功后，开始展示广告
    private void showRewardVideoAd() {
        if (this.isFinishing()) {
            finishPage();
            return;
        }
        if (mTTRewardVideoAd == null) {
            Log.i(TAG, "请先加载广告或等待广告加载完毕后再调用show方法");
            return;
        }
        /** 5、设置展示监听器，展示广告 */

        mTTRewardVideoAd.setRewardAdInteractionListener(mRewardVideoAdInteractionListener);

        mTTRewardVideoAd.showRewardVideoAd(this);
    }

    private void initListeners() {
        // 广告加载监听器

        this.mRewardVideoListener = new TTAdNative.RewardVideoAdListener() {
            @Override
            public void onError(int i, String s) {
                GromoreEventHandler.getInstance().sendEvent(new GoreErrorEvent(mMediaId, i, s));
                Log.i(TAG, "reward load fail: errCode: " + i + ", errMsg: " + s);
            }

            @Override

            public void onRewardVideoAdLoad(TTRewardVideoAd ttRewardVideoAd) {
                Log.i(TAG, "reward load success");
                mTTRewardVideoAd = ttRewardVideoAd;
                GromoreEventHandler.getInstance().sendEvent(new GoreEvent(mMediaId, GromoreEventAction.onAdPresent));
                showRewardVideoAd();
            }

            @Override

            public void onRewardVideoCached() {
                Log.i(TAG, "reward cached success");
            }

            @Override

            public void onRewardVideoCached(TTRewardVideoAd ttRewardVideoAd) {
                Log.i(TAG, "reward cached success 2");
                mTTRewardVideoAd = ttRewardVideoAd;
            }
        };
        // 广告展示监听器

        this.mRewardVideoAdInteractionListener = new TTRewardVideoAd.RewardAdInteractionListener() {
            @Override

            public void onAdShow() {
                GromoreEventHandler.getInstance().sendEvent(new GoreEvent(mMediaId, GromoreEventAction.onAdExposure));
                Log.i(TAG, "reward show");
            }

            @Override

            public void onAdVideoBarClick() {
                GromoreEventHandler.getInstance().sendEvent(new GoreEvent(mMediaId, GromoreEventAction.onAdClicked));
                finishPage();
                Log.i(TAG, "reward click");
            }

            @Override

            public void onAdClose() {
                GromoreEventHandler.getInstance().sendEvent(new GoreEvent(mMediaId, GromoreEventAction.onAdClosed));
                finishPage();
                Log.i(TAG, "reward close");
            }

            @Override
            public void onVideoComplete() {
                Log.i(TAG, "reward onVideoComplete");
                GromoreEventHandler.getInstance().sendEvent(new GoreEvent(mMediaId, GromoreEventAction.onAdClosed));
                finishPage();
            }

            @Override
            public void onVideoError() {
                Log.i(TAG, "reward onVideoError");
            }

            @Override

            public void onRewardVerify(boolean b, int i, String s, int i1, String s1) {
                Log.i(TAG, "reward onRewardVerify");
            }

            @Override
            public void onRewardArrived(boolean isRewardValid, int rewardType, Bundle extraInfo) {
                Log.i(TAG, "reward onRewardArrived");
            }

            @Override
            public void onSkippedVideo() {
                GromoreEventHandler.getInstance().sendEvent(new GoreEvent(mMediaId, GromoreEventAction.onAdClosed));
                finishPage();
                Log.i(TAG, "reward onSkippedVideo");
            }
        };
    }

    /**
     * 完成广告，退出开屏页面
     */
    private void finishPage() {
        finish();
        // 设置退出动画
        overridePendingTransition(android.R.anim.fade_in, android.R.anim.fade_out);
        /** 6、在onDestroy中销毁广告 */
        if (mTTRewardVideoAd != null && mTTRewardVideoAd.getMediationManager() != null) {
            mTTRewardVideoAd.getMediationManager().destroy();
        }
    }
    @Override
    protected void onDestroy() {
        super.onDestroy();
        /** 6、在onDestroy中销毁广告 */
        if (mTTRewardVideoAd != null && mTTRewardVideoAd.getMediationManager() != null) {
            mTTRewardVideoAd.getMediationManager().destroy();
        }
    }
}
