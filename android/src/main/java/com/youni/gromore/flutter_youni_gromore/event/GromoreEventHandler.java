package com.youni.gromore.flutter_youni_gromore.event;

import com.youni.gromore.flutter_youni_gromore.PluginDelegate;

/**
 * 广告事件处理类
 */
public class GromoreEventHandler {
    // 广告事件处理对象
    private static volatile GromoreEventHandler _instance;

    /**
     * 获取广告事件处理类
     *
     * @return 广告事件处理对象
     */
    public static GromoreEventHandler getInstance() {
        if (_instance == null) {
            synchronized (GromoreEventHandler.class) {
                _instance = new GromoreEventHandler();
            }
        }
        return _instance;
    }

    /**
     * 添加广告事件
     *
     * @param event 广告事件
     */
    public void sendEvent(GoreEvent event) {
        if (event != null) {
            PluginDelegate.getInstance().addEvent(event.toMap());
        }
    }

}
