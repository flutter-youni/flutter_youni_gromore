package com.youni.gromore.flutter_youni_gromore.event;

import java.util.HashMap;

/**
 * 广告事件
 */
public class GoreEvent {
    // 广告 id
    private final String adId;
    // 操作
    private final String action;

    public GoreEvent(String adId, String action) {
        this.adId = adId;
        this.action = action;
    }

    /**
     * 转换为 Map 方面传输
     *
     * @return 转换后的 Map 对象
     */
    public HashMap<String, Object> toMap() {
        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("adId", adId);
        map.put("action", action);
        return map;
    }
}
