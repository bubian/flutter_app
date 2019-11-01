package pds.com.native_bridge

import android.os.Build
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import org.json.JSONObject

class NativeBridgePlugin: MethodCallHandler {
  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "native_bridge")
      channel.setMethodCallHandler(NativeBridgePlugin())
    }
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when(call.method){
      "getBuildType" ->{
        result.success(BuildConfig.BUILD_TYPE)
      }

      "getPlatformVersion" -> {
        result.success("Android ${android.os.Build.VERSION.RELEASE}")
      }
      else -> {
        result.notImplemented()
      }
    }
  }
}
