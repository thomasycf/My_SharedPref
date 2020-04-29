package com.example.my_share_pref;

import android.content.Context;
import android.content.SharedPreferences;
import android.os.Bundle;

import androidx.annotation.NonNull;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import java.lang.reflect.Type;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.dart.DartExecutor;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  private MethodChannel methodChannel;
  private SharedPreferences sharedPref;
  private SharedPreferences.Editor myEditor;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    methodChannel.setMethodCallHandler(new MethodChannel.MethodCallHandler() {
      @Override
      public void onMethodCall(MethodCall call, MethodChannel.Result result) {
        switch (call.method){
          case "WRITE":
            Set<String> newMessageSets = sharedPref.getStringSet("flutter.messageLog", new HashSet<String>());
            HashMap<String, String> newMapData = new HashMap<>();
            newMapData.put("userName", "this is username");
            newMapData.put("password", "this is password");
            newMapData.put("createAt", "time:"+ new Date().getTime());
            Gson gson = new Gson();
            Type gsonType = new TypeToken<HashMap>(){}.getType();
            String gsonString = gson.toJson(newMapData,gsonType);
            newMessageSets.add(gsonString);
            myEditor.putStringSet("flutter.messageLog", newMessageSets);
            myEditor.commit();
            break;
          default:
            result.success(true);
            break;
        }
      }
    });

     sharedPref = getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE);
    Set<String> messageSets = sharedPref.getStringSet("flutter.messageLog", new HashSet<String>());

    HashMap<String, String> mapData = new HashMap<>();
    mapData.put("userName", "this is username");
    mapData.put("password", "this is password");
    mapData.put("createAt", "time:"+ new Date().getTime());

    Gson gson = new Gson();
    Type gsonType = new TypeToken<HashMap>(){}.getType();
    String gsonString = gson.toJson(mapData,gsonType);

    messageSets.add(gsonString);

    myEditor = sharedPref.edit();
    myEditor.putStringSet("flutter.messageLog", messageSets);
    myEditor.commit();
  }

  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    GeneratedPluginRegistrant.registerWith(flutterEngine);
    DartExecutor dartExecutor = flutterEngine.getDartExecutor();
    methodChannel = new MethodChannel(dartExecutor.getBinaryMessenger(), "MY_SP");
  }
}
