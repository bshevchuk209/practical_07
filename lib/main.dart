import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
    home: const RgbPage(),
  );
}

class RgbPage extends StatefulWidget {
  const RgbPage({super.key});
  @override
  State<RgbPage> createState() => _RgbPageState();
}

class _RgbPageState extends State<RgbPage> {
  final channels = [96, 128, 192];
  @override
  Widget build(BuildContext context) {
    final color = Color.fromARGB(255, channels[0], channels[1], channels[2]);
    final hex = channels
        .map((v) => v.toRadixString(16).padLeft(2, '0'))
        .join()
        .toUpperCase();
    return Scaffold(
      appBar: AppBar(title: const Text('Практична №7 • RGB')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Підбір кольору',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('Номер 24 → завдання 3. Змініть складові RGB.'),
              const SizedBox(height: 24),
              ColorPreview(color: color, hex: hex),
              const SizedBox(height: 24),
              for (var i = 0; i < 3; i++) ...[
                Text(
                  '${['Red', 'Green', 'Blue'][i]}: ${channels[i]}',
                  style: const TextStyle(fontSize: 18),
                ),
                Slider(
                  key: ValueKey('channel_$i'),
                  min: 0,
                  max: 255,
                  divisions: 255,
                  value: channels[i].toDouble(),
                  label: '${channels[i]}',
                  activeColor: [
                    Colors.red.shade700,
                    Colors.green.shade700,
                    Colors.blue.shade700,
                  ][i],
                  onChanged: (value) =>
                      setState(() => channels[i] = value.round()),
                ),
              ],
              Text(
                'RGB(${channels.join(', ')})',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: () =>
                    setState(() => channels.setAll(0, [96, 128, 192])),
                child: const Text('Початковий колір'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ColorPreview extends StatelessWidget {
  const ColorPreview({super.key, required this.color, required this.hex});
  final Color color;
  final String hex;
  @override
  Widget build(BuildContext context) => Semantics(
    label: 'Попередній перегляд кольору #$hex',
    child: Container(
      key: const ValueKey('preview'),
      height: 180,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '#$hex',
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: ThemeData.estimateBrightnessForColor(color) == Brightness.dark
              ? Colors.white
              : Colors.black,
        ),
      ),
    ),
  );
}
