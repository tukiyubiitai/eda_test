import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Test3Page extends StatefulWidget {
  const Test3Page({super.key});

  @override
  State<Test3Page> createState() => _Test2PageState();
}
final TextEditingController _controller = TextEditingController();

class _Test2PageState extends State<Test3Page> {

  @override
  void dispose() {
    _controller;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: () {}, child: Text("最初のページへ", style: TextStyle(
            fontWeight: FontWeight.bold,
          ),))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              keyboardType: TextInputType.number, // キーボードタイプを数値専用に設定
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly // 整数のみを許可
              ],
              decoration: InputDecoration(
                labelText: '整数を入力', // ユーザーに入力する内容を示すラベル
                hintText: 'ここに整数を入力してください', // 入力フィールドのヒント
              ),
            ),
          ),
          ElevatedButton(onPressed: () => conversion(_controller.text),
              child: Text("出力")),
        ],
      ),
    );
  }

  void conversion(String x) {

    RegExp regExp = RegExp(r'^[1-9]\d*$');

    // 制約💡　 x は 10 進数で n 桁の整数 xの先頭の文字は0ではない。
    if (!regExp.hasMatch(x)) {
      print('入力は10進数の整数で、先頭の文字は0ではない必要があります。');
      return;
    }

    // 制約💡　1≤n≤100, 整数
    if (x.length < 1 || x.length > 100) {
      print('入力は1から100桁の整数である必要があります。');
      return;
    }

    // 制約💡 n≤8, 整数
    if (x.length > 8) {
      print('このテストケースは簡単なテストケースの制約（n≤8）を満たしていません。');
      // 処理は継続
    }


    try {
      // 入力された数字の各桁をリストに変換
      List<int> digits = x.split('').map(int.parse).toList();

      // 先頭に来ることができない0を除外して最小の数字を探す
      int minNonZeroDigit = digits.where((d) => d > 0).reduce(min);

      // 最小の数字を先頭に置き、残りの数字を昇順に並べ替える
      digits.remove(minNonZeroDigit);
      digits.sort();

      // 最終的な数字を構築
      String result = '$minNonZeroDigit' + digits.join('');

      // 結果を出力
      print(result);
    } on ArgumentError catch (e) {
      print(e.message);
    } catch (e) {
      print('予期せぬエラーが発生しました');
    }
  }

  int min(int a, int b) => a < b ? a : b;

}


