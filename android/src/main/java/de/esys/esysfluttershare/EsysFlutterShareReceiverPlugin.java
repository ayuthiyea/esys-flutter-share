package de.esys.esysfluttershare;

import android.content.Context;
import android.content.Intent;
import android.util.Log;
import android.content.BroadcastReceiver;
import android.content.ComponentName;

import io.flutter.plugin.common.EventChannel.EventSink;
import io.flutter.plugin.common.EventChannel.StreamHandler;

/**
 * EsysFlutterShareReceiverPlugin
 */
public class EsysFlutterShareReceiverPlugin extends BroadcastReceiver implements StreamHandler {
    public static EventSink eventSink;

    @Override
    public void onListen(Object arguments, EventSink events) {
        EsysFlutterShareReceiverPlugin.eventSink = events;
    }

    @Override
    public void onCancel(Object arguments) {

        EsysFlutterShareReceiverPlugin.eventSink = null;
    }

    @Override
    public void onReceive(Context context, Intent intent) {
        if (EsysFlutterShareReceiverPlugin.eventSink != null) {
            EsysFlutterShareReceiverPlugin.eventSink.success(true);
        }
    }
}
