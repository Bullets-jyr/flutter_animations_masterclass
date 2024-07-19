import 'package:flutter/material.dart';

// Implicit(암시적)
// 간적적으로 표현한다
// 명확하거나 직접적으로 제시되지 않음
// 직접적으로 표현하지 않고 제시함
// Implicit의 반대말은 Explicit(명시적)
// 이해되지만 직접적으로 언급되지 않음

// Explicit(명시적)
// 매우 명확하고 의심할 여지가 없다
// 공공연히 보여짐
// Explicit의 반대말은 Implicit(암시적)

// Implicitly Animated Widget
// trigger될 때 애니메이션이 있다는 건 알고 있지만, 여러분에 코드에는 보이지 않는거야.
// 여러분이 애니메이션을 만들지 않았으니까
// 그렇다면 언제 Implicit Animation이 있는지 어떻게 알 수 있을까?
// 위젯 이름이 animated로 시작한다면 그게 implicit animations의 종류라고 볼 수 있어
// 여러개를 한꺼번에 사용할 수 있다는거야
class ImplicitAnimationsScreen extends StatefulWidget {
  const ImplicitAnimationsScreen({super.key});

  @override
  State<ImplicitAnimationsScreen> createState() =>
      _ImplicitAnimationsScreenState();
}

class _ImplicitAnimationsScreenState extends State<ImplicitAnimationsScreen> {
  bool _visible = true;

  void _trigger() {
    setState(() {
      _visible = !_visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Implicit Animations'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              curve: Curves.elasticInOut,
              duration: const Duration(seconds: 2),
              // width: _visible ? size.width : size.width * 0.8,
              width: size.width * 0.8,
              // height: _visible ? size.width : size.width * 0.8,
              height: size.width * 0.8,
              transform: Matrix4.rotationZ(_visible ? 1 : 0),
              transformAlignment: Alignment.center,
              decoration: BoxDecoration(
                color: _visible ? Colors.red : Colors.amber,
                borderRadius: BorderRadius.circular(_visible ? 100 : 0),
              ),
            ),
            // AnimatedAlign(
            //   alignment: _visible ? Alignment.topLeft : Alignment.topRight,
            //   duration: Duration(seconds: 2),
            //   // Opacity, AnimatedOpacity 위젯
            //   child: AnimatedOpacity(
            //     opacity: _visible ? 1 : 0.2,
            //     duration: const Duration(seconds: 2),
            //     child: Container(
            //       width: size.width * 0.8,
            //       height: size.width * 0.8,
            //       color: Colors.amber,
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: _trigger,
              child: const Text(
                'Go!',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
