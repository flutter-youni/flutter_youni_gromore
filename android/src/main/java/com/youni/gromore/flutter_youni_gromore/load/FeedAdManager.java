package com.youni.gromore.flutter_youni_gromore.load;//package com.zero.flutter_gromore_ads.load;
//
//import com.bytedance.msdk.api.v2.ad.nativeAd.GMNativeAd;
//
//import java.util.HashMap;
//import java.util.Map;
//
///**
// * 信息流广告管理
// */
//public class FeedAdManager {
//    private final String TAG = FeedAdManager.class.getSimpleName();
//    // 信息流广告管理类对象
//    private static FeedAdManager _instance;
//
//    public static synchronized FeedAdManager getInstance() {
//        if (_instance == null) {
//            synchronized (FeedAdManager.class) {
//                _instance = new FeedAdManager();
//            }
//        }
//        return _instance;
//    }
//
//    // 信息流广告列表
//    private final Map<Integer, GMNativeAd> feedAdList = new HashMap<Integer, GMNativeAd>();
//
//    /**
//     * 添加广告渲染对象
//     *
//     * @param key 广告缓存id
//     * @param ad  广告渲染对象
//     */
//    public void putAd(int key, GMNativeAd ad) {
//        feedAdList.put(key, ad);
//    }
//
//    /**
//     * 获取广告渲染对象
//     *
//     * @param key 广告缓存id
//     * @return 广告渲染对象
//     */
//    public GMNativeAd getAd(int key) {
//        return feedAdList.get(key);
//    }
//
//    /**
//     * 删除广告渲染对象
//     *
//     * @param key 广告缓存id
//     * @return 广告渲染对象
//     */
//    public GMNativeAd removeAd(int key) {
//        return feedAdList.remove(key);
//    }
//}
