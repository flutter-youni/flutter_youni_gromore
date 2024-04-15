package com.youni.gromore.flutter_youni_gromore.load;//package com.zero.flutter_gromore_ads.load;
//
//import android.app.Activity;
//import android.util.Log;
//
//import androidx.annotation.NonNull;
//
//import com.bytedance.msdk.api.AdError;
//import com.bytedance.msdk.api.v2.GMAdConstant;
//import com.bytedance.msdk.api.v2.ad.nativeAd.GMNativeAd;
//import com.bytedance.msdk.api.v2.ad.nativeAd.GMNativeAdLoadCallback;
//import com.bytedance.msdk.api.v2.ad.nativeAd.GMUnifiedNativeAd;
//import com.bytedance.msdk.api.v2.slot.GMAdOptionUtil;
//import com.bytedance.msdk.api.v2.slot.GMAdSlotNative;
//import com.zero.flutter_gromore_ads.event.AdEventAction;
//import com.zero.flutter_gromore_ads.page.BaseAdPage;
//import com.zero.flutter_gromore_ads.utils.UIUtils;
//
//import java.util.ArrayList;
//import java.util.List;
//
//import io.flutter.plugin.common.MethodCall;
//import io.flutter.plugin.common.MethodChannel;
//
///**
// * 信息流加载对象
// */
//public class FeedAdLoad extends BaseAdPage implements GMNativeAdLoadCallback {
//    private final String TAG = FeedAdLoad.class.getSimpleName();
//    GMUnifiedNativeAd ad;
//    private MethodChannel.Result result;
//
//    /**
//     * 加载信息流广告列表
//     * @param call
//     * @param result
//     */
//    public void loadFeedAdList(Activity activity, @NonNull MethodCall call, @NonNull MethodChannel.Result result) {
//        this.result=result;
//        showAd(activity,call);
//    }
//
//    @Override
//    public void loadAd(@NonNull MethodCall call) {
//        // 获取请求模板广告素材的尺寸
//        int expressViewWidth = call.argument("width");
//        int expressViewHeight = call.argument("height");
//        int count = call.argument("count");
//        // 如果为空则创建
////        if (ad == null) {
////
////        }
//        // 原生广告
//        ad = new GMUnifiedNativeAd(activity, posId);
//        // 广告配置
//        GMAdSlotNative adSlot = new GMAdSlotNative.Builder()
//                .setAdStyleType(GMAdConstant.TYPE_EXPRESS_AD)//必传，表示请求的模板广告还是原生广告，AdSlot.TYPE_EXPRESS_AD：模板广告 ； AdSlot.TYPE_NATIVE_AD：原生广告
//                // 备注
//                // 1:如果是信息流自渲染广告，设置广告图片期望的图片宽高 ，不能为0
//                // 2:如果是信息流模板广告，宽度设置为希望的宽度，高度设置为0(0为高度选择自适应参数)
//                .setImageAdSize((int) UIUtils.getScreenWidthDp(activity), 0)// 必选参数 单位dp ，详情见上面备注解释
//                .setAdCount(count)//请求广告数量为1到3条
//                .build();
//        ad.loadAd(adSlot,this);
//    }
//
//    @Override
//    public void onAdLoaded(@NonNull List<GMNativeAd> list) {
//        List<Integer> adResultList=new ArrayList<>();
//        Log.i(TAG, "onNativeExpressAdLoad onAdLoaded");
//        if (list.isEmpty()) {
//            this.result.success(adResultList);
//            return;
//        }
//        Log.i(TAG, "onNativeExpressAdLoad onAdLoaded ："+list.size());
//        for (GMNativeAd adItem : list) {
//            int key=adItem.hashCode();
//            adResultList.add(key);
//            FeedAdManager.getInstance().putAd(key,adItem);
//        }
//        // 添加广告事件
//        sendEvent(AdEventAction.onAdLoaded);
//        this.result.success(adResultList);
//    }
//
//    @Override
//    public void onAdLoadedFail(@NonNull AdError adError) {
//        Log.e(TAG, "onError code:" + adError.code + " msg:" + adError.message);
//        sendErrorEvent(adError.code, adError.message);
//        this.result.error(""+adError.code, adError.message,adError.message);
//    }
//}
