import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class TreeProgress extends StatefulWidget {
  final double valueSlider;

  const TreeProgress({super.key, required this.valueSlider});

  @override
  State<TreeProgress> createState() => _TreeProgressState();
}

class _TreeProgressState extends State<TreeProgress> {
  StateMachineController? controller;
  SMIInput<double>? inputValue;
  double valueSlider = 0;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color.fromARGB(255, 109, 162, 160),
      body: Stack(
        children: [
          RiveAnimation.asset('assets/treeb.riv',
          //fit:BoxFit.fitWidth,
          onInit: (artboard) {
            controller = StateMachineController.fromArtboard(
              artboard, 
              "State Machine 1",
              );
              if (controller != null) {
                artboard.addController(controller!);
                inputValue = controller?.findInput("input");
                inputValue?.change(widget.valueSlider);
              }

          },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                  child: Slider(
                    value: valueSlider, 
                    onChanged: (v) {
                      setState(() {
                        valueSlider = v;
                      });
                      inputValue?.change(v);
                
                    },
                    min: 0,
                    max: 100,
                    ),
                ),
            ],
          )
        ],
      ),
    
    );
  }
   @override 
      void didUpdateWidget(TreeProgress oldWidget) {
        super.didUpdateWidget(oldWidget);
        if (widget.valueSlider != oldWidget.valueSlider && inputValue != null) {
          inputValue?.change(widget.valueSlider);
        }
      }
}
 