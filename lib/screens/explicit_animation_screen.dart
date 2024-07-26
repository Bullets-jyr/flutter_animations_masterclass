import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ExplicitAnimationScreen extends StatefulWidget {
  const ExplicitAnimationScreen({super.key});

  @override
  State<ExplicitAnimationScreen> createState() =>
      _ExplicitAnimationScreenState();
}

class _ExplicitAnimationScreenState extends State<ExplicitAnimationScreen>
    with SingleTickerProviderStateMixin {
  // SingleTickerProviderStateMixin
  // SingleTickerProviderStateMixin은 Ticker를 제공해, 우린 이미 그게 뭔지 알지!

  /// TickerProviderStateMixin
  /// 차이점은 SingleTickerProviderStateMixin은 애니메이션 컨트롤러가 하나라
  /// ticker가 하나만 필요할 때 사용하는 거야
  /// 이게 SingleTickerProviderStateMixin를 사용하는 경우야,
  /// 애니메이션 컨트롤러를 여러 개 가지고 있으면 그것들은 모두 ticker가 필요해
  /// 그 때 TickerProviderStateMixin을 사용하는 거야

  // Ticker
  // ticker때문에 이 모든 작업들이 일어나는 거야
  // ticker때문에 우리는 이런 코드들을 쓴 거야
  // 애니메이션 컨트롤러는 인스턴스화된 후 초기화되면서 vsync의 createTicker를 실행해.
  // 우리의 애니메이션 컨트롤러는 ticker에 연결되어 있어, 알았지?
  // ..: Cascade notation 이야
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
    // 0.0에 시작해서 1.0에서 끝나는데, 원한다면 이 값을 수정할 수 있어
    // lowerBound: 50.0,
    // upperBound: 100.0,
    reverseDuration: const Duration(seconds: 1),
  )
    ..addListener(() {
      // 이건 매번 컨트롤러의 값이 바뀔 때마다 함수를 실행할 거야
      // setState(() {});
      // setState(() {
      //   _value = _animationController.value;
      // });
      _range.value = _animationController.value;
    });
    // ..addStatusListener((status) {
    //   print(status);
    //   if (status == AnimationStatus.completed) {
    //     _animationController.reverse();
    //   } else if (status == AnimationStatus.dismissed) {
    //     _animationController.forward();
    //   }
    // });

  // late final Animation<Color?> _color = ColorTween(
  //   begin: Colors.amber,
  //   end: Colors.red,
  // ).animate(_animationController);

  // BoxDecoration
  late final Animation<Decoration> _decoration = DecorationTween(
    begin: BoxDecoration(
      color: Colors.amber,
      borderRadius: BorderRadius.circular(20),
    ),
    end: BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.circular(120),
    ),
  ).animate(_curved);

  late final Animation<double> _rotation = Tween(
    begin: 0.0,
    end: 0.5,
  ).animate(_curved);

  late final Animation<double> _scale = Tween(
    begin: 1.0,
    end: 1.1,
  ).animate(_curved);

  late final Animation<Offset> _position = Tween(
    begin: Offset.zero,
    // -1: 100퍼센트
    // end: Offset(0, -1),
    // end: Offset(0, -0.5),
    end: Offset(0, -0.2),
  ).animate(_curved);

  // CurvedAnimation
  // 물론 여기에서 late를 쓰지 않고 애니메이션 컨트롤러를 쓸 수 없어
  // 속성을 초기화할 때 this를 쓸거면 late를 사용해야 하기 때문이야 (vsync: this,)
  // late인 애니메이션 컨트롤러를 사용하면 이를 사용하는 모든 것에서 late를 써야 해
  late final CurvedAnimation _curved = CurvedAnimation(
    parent: _animationController,
    curve: Curves.elasticOut,
    reverseCurve: Curves.bounceIn,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Calls its callback once per animation frame.
    // 애니메이션 컨트롤러가 ticker에 연결되기 때문이야.
    // 애니메이션 컨트롤러는 가능한 한 빨리 실행되어야 하거든
    // Ticker(
    //   (elapsed) => print(elapsed),
    // ).start();
    // Timer.periodic(const Duration(milliseconds: 500), (timer) {
    //   print(_animationController.value);
    // });
  }

  void _play() {
    _animationController.forward();
  }

  void _pause() {
    _animationController.stop();
  }

  void _rewind() {
    _animationController.reverse();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // double _value = 0;
  // ValueNotifier 값을 가지고 있는 역할을 해, 알겠지?
  // 우린 화면을 다시 build, rendering하지 않고 이 값을 수정할 수 있게 돼
  final ValueNotifier<double> _range = ValueNotifier(0.0);

  void _onChanged(double value) {
    // setState(() {
    //   _value = value;
    // });
    // _animationController.value = value;
    // _animationController.animateTo(value);
    _range.value = 0;
    _animationController.value = value;
  }

  bool _looping = false;

  void _toggleLooping() {
    if (_looping) {
      _animationController.stop();
    } else {
      _animationController.repeat(
        reverse: true,
      );
    }
    setState(() {
      _looping = !_looping;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      appBar: AppBar(
        title: Text('Explicit Animations'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // fractional은 자식 요소를 기준으로 위치가 바뀐다는걸 의미해
            SlideTransition(
              position: _position,
              child: ScaleTransition(
                scale: _scale,
                child: RotationTransition(
                  turns: _rotation,
                  child: DecoratedBoxTransition(
                    decoration: _decoration,
                    child: const SizedBox(
                      height: 300,
                      width: 300,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            // tween: 트윈을 사용하면 애니메이션 대상의 시작과 끝을 지정할 수 있어
            // AnimatedBuilder는 최후의 수단으로 사용해야해, explicit(명시적) 애니메이션을 사용한 경우에 말야
            // xxxTransition: Transition으로 끝나는건 explicit 애니메이션이야. 알겠지?
            // 모든 AnimatedBuilder를 쌓아 만드는건 좋은 생각이 아니야
            // AnimatedBuilder(
            //   // animation: _animationController,
            //   animation: _color,
            //   builder: (context, child) {
            //     return Container(
            //       color: _color.value,
            //       width: 400,
            //       height: 400,
            //     );
            //     // return Opacity(
            //     //   opacity: _animationController.value,
            //     //   child: Container(
            //     //     color: Colors.amber,
            //     //     width: 400,
            //     //     height: 400,
            //     //   ),
            //     // );
            //     // return Text(
            //     //   '${_animationController.value}',
            //     //   style: TextStyle(
            //     //     fontSize: 58,
            //     //   ),
            //     // );
            //   },
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _play,
                  child: Text(
                    'Play',
                  ),
                ),
                ElevatedButton(
                  onPressed: _pause,
                  child: Text(
                    'Pause',
                  ),
                ),
                ElevatedButton(
                  onPressed: _rewind,
                  child: Text(
                    'Rewind',
                  ),
                ),
                ElevatedButton(
                  onPressed: _toggleLooping,
                  child: Text(
                    _looping ? 'Stop looping' : 'Start looping',
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            // Slider(
            //   value: _value.value,
            //   onChanged: _onChanged,
            // ),
            ValueListenableBuilder(
              valueListenable: _range,
              builder: (context, value, child) {
                return Slider(
                  // value: _value,
                  value: _range.value,
                  onChanged: _onChanged,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
