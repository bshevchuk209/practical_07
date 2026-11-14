import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:practical_07/main.dart';

void main() {
  testWidgets('RGB channels update preview and reset', (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('#6080C0'), findsOneWidget);
    for (var i = 0; i < 3; i++) {
      final slider = tester.widget<Slider>(find.byKey(ValueKey('channel_$i')));
      slider.onChanged!(i == 0 ? 255 : 0);
      await tester.pump();
    }
    expect(find.text('#FF0000'), findsOneWidget);
    expect(
      tester
          .widget<Container>(find.byKey(const ValueKey('preview')))
          .decoration,
      isA<BoxDecoration>().having(
        (d) => d.color,
        'color',
        const Color(0xffff0000),
      ),
    );
    await tester.ensureVisible(find.text('Початковий колір'));
    await tester.tap(find.text('Початковий колір'));
    await tester.pump();
    expect(find.text('#6080C0'), findsOneWidget);
  });
}
