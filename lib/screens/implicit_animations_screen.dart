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
            // 그리고 여기 TweenAnimationBuilder는 여러분이 설정한 curve를 사용해서 이 두 값 사이에 애니메이션을 적용할거야
            // 이 위젯은 여러분이 정한 임의 값 사이를 설정한 duration 동안에 애니메이션을 적용할 수 있고,
            //
            TweenAnimationBuilder(
              // tween이란 애니메이션의 타겟값을 말하는거야
              // 어디서 어디까지 애니메이션 효과를 추가하고 싶은지 설정할 수 있어
              // ex) 0부터 1까지 일 수도 있고, 1부터 20, 5에서 15까지... 등 그게 바로 tween이야.
              // tween은 시작갑과 목표값이 있는 object이고,
              // TweenAnimationBuilder는 그 값 사이에서 애니메이션을 적용할거야
              // tween 자체가 between (사이에)라는 단어에서 유래된거야
              // 그니깐 두 값 사이에 애니메이션을 적용하려면 tween을 만들면 돼
              // Tween은 explicit animation에서도 사용돼서 나중에도 보게 될거야
              // Tween에선 애니메이션의 대상, 다시 말해 애니메이션의 시작 값, 끝 값을 정의하면 돼.
              // 이건 애니메이션 대상이고
              // tween: Tween(begin: 10.0, end: 20.0),
              // tween: Tween(begin: 10.0, end: 20.0),
              tween: ColorTween(
                begin: Colors.yellow,
                end: Colors.red,
              ),
              curve: Curves.bounceInOut,
              duration: const Duration(seconds: 5),
              // builder는 현재 애니메이션이 적용되는 값으로 호출될 함수야
              builder: (context, value, child) {
                // return Text('$value');
                return Image.network(
                  'https://storage.googleapis.com/cms-storage-bucket/780e0e64d323aad2cdd5.png',
                  color: value,
                  // colorBlendMode를 통해서 색상이 이미지와 어떻게 혼합될지를 설정해줄 수 있어,
                  colorBlendMode: BlendMode.colorBurn,
                );
              },
            ),
            // AnimatedContainer(
            //   curve: Curves.elasticInOut,
            //   duration: const Duration(seconds: 2),
            //   // width: _visible ? size.width : size.width * 0.8,
            //   width: size.width * 0.8,
            //   // height: _visible ? size.width : size.width * 0.8,
            //   height: size.width * 0.8,
            //   transform: Matrix4.rotationZ(_visible ? 1 : 0),
            //   transformAlignment: Alignment.center,
            //   decoration: BoxDecoration(
            //     color: _visible ? Colors.red : Colors.amber,
            //     borderRadius: BorderRadius.circular(_visible ? 100 : 0),
            //   ),
            // ),
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
