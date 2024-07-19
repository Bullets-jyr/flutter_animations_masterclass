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
  late final AnimationController _animationController =
      AnimationController(vsync: this);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Calls its callback once per animation frame.
    // 애니메이션 컨트롤러가 ticker에 연결되기 때문이야.
    // Ticker(
    //   (elapsed) => print(elapsed),
    // ).start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explicit Animations'),
      ),
    );
  }
}
