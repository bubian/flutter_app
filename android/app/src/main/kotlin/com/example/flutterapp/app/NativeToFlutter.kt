package com.example.flutterapp.app

import android.app.Activity
import android.os.Bundle

/**
 * @author: pengdaosong
 * CreateTime:  2019-10-31 22:12
 * Email：pengdaosong@medlinker.com
 * Description:
 */

class NativeToFlutter : Activity() {
//    private lateinit var mMethodChannel: MethodChannel   //flutter连接
    private val METHOD_CHANNER = "com.yang.test001"      //与flutter连接的标识
    private var mIsSendFlutter = false

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
//        setContentView(R.layout.activity_main)

//        initView()
//        initListener()
    }

//    private fun initView() {
//        //绑定flutterView 第一种方法
//        val flutterView = Flutter.createView(this, lifecycle, "route1")
//        llMainBottom.addView(flutterView)
//
////        //第二种方法
////        val tx = supportFragmentManager.beginTransaction()
////        tx.replace(R.id.llMainBottom, Flutter.createFragment("route1"))
////        tx.commit()
//
//        //初始化MethodChannel
//        mMethodChannel = MethodChannel(flutterView, METHOD_CHANNER)
//    }
//
//    private fun initListener() {
//        //接受flutter消息监听
//        mMethodChannel.setMethodCallHandler(object : MethodChannel.MethodCallHandler {
//            override fun onMethodCall(p0: MethodCall, p1: MethodChannel.Result) {
//                //根据收到的消息key进行接收
//                when (p0.method) {
//                    "flutter" -> {
//                        val msg = p0.arguments
//                        tvMain.text = msg.toString()
//                    }
//                    else -> {
//
//                    }
//                }
//            }
//        })
//
//        btnMain.setOnClickListener {
//            //发送msg给flutter
//            mMethodChannel.invokeMethod("android", if (mIsSendFlutter) {
//                "你好 世界！"
//            } else {
//                "Hello World!"
//            })
//            mIsSendFlutter = !mIsSendFlutter
//        }
//    }
}