import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_app/views/welcome_page/pages.dart';
import 'package:flutter_app/views/welcome_page/page_reveal.dart';
import 'package:flutter_app/views/welcome_page/pager_indicator.dart';
import 'package:flutter_app/views/welcome_page/page_dragger.dart';
class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new SplashPageState();
}

class SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  StreamController<SlideUpdate> slideUpdateStream;
  AnimatedPageDragger animatedPageDragger;

  int activeIndex = 0;
  SlideDirection slideDirection = SlideDirection.none;
  int nextPageIndex = 0;
  int waitingNextPageIndex = -1;

  double slidePercent = 0.0;

  SplashPageState() {
    slideUpdateStream = new StreamController<SlideUpdate>();

    slideUpdateStream.stream.listen((SlideUpdate event) {
      if(mounted) {
        setState(() {
          if (event.updateType == UpdateType.dragging) {
            slideDirection = event.direction;
            slidePercent = event.slidePercent;

            if (slideDirection == SlideDirection.leftToRight) {
              nextPageIndex = activeIndex - 1;
            } else if (slideDirection == SlideDirection.rightToLeft) {
              nextPageIndex = activeIndex + 1;
            } else {
              nextPageIndex = activeIndex;
            }
          } else if (event.updateType == UpdateType.doneDragging) {
            if (slidePercent > 0.5) {
              animatedPageDragger = new AnimatedPageDragger(
                slideDirection: slideDirection,
                transitionGoal: TransitionGoal.open,
                slidePercent: slidePercent,
                slideUpdateStream: slideUpdateStream,
                vsync: this,
              );
            } else {
              animatedPageDragger = new AnimatedPageDragger(
                slideDirection: slideDirection,
                transitionGoal: TransitionGoal.close,
                slidePercent: slidePercent,
                slideUpdateStream: slideUpdateStream,
                vsync: this,
              );

              waitingNextPageIndex = activeIndex;
            }

            animatedPageDragger.run();
          } else if (event.updateType == UpdateType.animating) {
            slideDirection = event.direction;
            slidePercent = event.slidePercent;
          } else if (event.updateType == UpdateType.doneAnimating) {
            if(waitingNextPageIndex != -1) {
              nextPageIndex = waitingNextPageIndex;
              waitingNextPageIndex = -1;
            }else{
              activeIndex = nextPageIndex;
            }

            slideDirection = SlideDirection.none;
            slidePercent = 0.0;

            animatedPageDragger.dispose();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    slideUpdateStream.close();
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children:[
        new Page(
          viewModel: pages[activeIndex],
          percentVisible: 1.0,
        ),
        new PageReveal(
          revealPercent: slidePercent,
          child: new Page(
            viewModel: pages[nextPageIndex],
            percentVisible: slidePercent,
          ),
        ),
        new PageIndicator(
          viewModel: new PagerIndicatorViewModel(
            pages,
            activeIndex,
            slideDirection,
            slidePercent
          ),
        ),
        new PageDragger(
          canDragLeftToRight: activeIndex > 0,
          canDragRightToLeft: activeIndex < pages.length -1,
          slideUpdateStream: this.slideUpdateStream,
        )
      ]
    );
  }
}
