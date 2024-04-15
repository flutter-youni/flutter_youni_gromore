package com.youni.gromore.flutter_youni_gromore.event;

import java.util.HashMap;

/**
 * 广告错误事件
 */
public class GoreErrorEvent extends GoreEvent {
    // 错误码
    private final int errCode;
    // 错误信息
    private final String errMsg;

    // 错误事件实体
    public GoreErrorEvent(String adId, int errCode, String errMsg) {
        super(adId, GromoreEventAction.onAdError);
        this.errCode = errCode;
        this.errMsg = errMsg;
    }

    /**
     * 重写 toMap 方法
     *
     * @return 返回错误事件的map
     */
    @Override
    public HashMap<String, Object> toMap() {
        HashMap<String, Object> newMap = super.toMap();
        newMap.put("errCode", errCode);
        newMap.put("errMsg", errMsg);
        return newMap;
    }
}
