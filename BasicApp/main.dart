import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<StatefulWidget> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final controller = TextEditingController();

  final List<bool> _selection = [true, false, false, false];
  String tip = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            if(tip.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text( 
                tip,
                style: const TextStyle(fontSize: 30),
              ),
              ),
            const Text('Total Amount'),
            SizedBox(
              width: 70,
              child: TextField(
                controller: controller,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(hintText: '\$100.00'),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: ToggleButtons(isSelected: _selection,
               onPressed: updateSelection,
                children: const [
                Text('5%'),
                Text('10%'),
                Text('15%'),
                Text('20%')
              ]),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 20,
                backgroundColor: Colors.green,
              ),
              onPressed: calculateTip,
              child: const Text(
                'Calculate Tip',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  void updateSelection(int selectedIndex) {
    setState(() {
      for (int i = 0; i < _selection.length; i++) {
        _selection[i] = selectedIndex == i;
      }
    });
  }

  void calculateTip() {
    final totalAmount = double.parse(controller.text);
    if (totalAmount == 0) {
      setState(() {
        tip = 'Invalid amount';
      });
      return;
    }
    final selectedIndex = _selection.indexWhere((element) => element);
    final tipPercentage = [0.05, 0.1, 0.15, 0.2][selectedIndex];
    final tipTotal = (totalAmount * tipPercentage).toStringAsFixed(2);

    setState(() {
      tip = '\$$tipTotal';
    });
  }
}
