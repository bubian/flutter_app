import 'package:logging/logging.dart';

class FLog{
  static Logger _logger = new Logger("flog");

  static void i(String msg){
    _logger.info(msg);
  }

  static void w(String msg){
    _logger.warning(msg);
  }

  static void s(String msg){
    _logger.severe(msg);
  }

  static void sh(String msg){
    _logger.shout(msg);
  }
}