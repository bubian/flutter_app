import 'elements/index.dart' as elements;

class WidgetList {
  WidgetList();

  List getWidgetList() {
    List result = [];
    result.addAll(elements.getWidgets());
    return result;
  }
}
