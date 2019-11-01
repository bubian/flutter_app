- flutter引用插件的两种方式:pub库引用/本地库引用
dependencies:
  flutter:
    sdk: flutter

  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^0.1.2
#pub插件引用
#  webview_flutter: ^0.3.0

#本地插件引用 注意缩进格式
  webview_flutter:
    path: plugins/webview_flutter
    
 然后同步工程