import 'package:dice_test/test2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/*
問題文

さとみさんは、一人ですごろくの練習をすることにしました。練習に使うすごろくは、左右に一直線に伸びる全長 A マスの形状です。すごろくの左端のマスがスタートで、右端のマスがゴールです。すごろくを始めるとき、スタートに駒が置かれた状態でスタートします。

駒を動かすために、1 ～ 6 が出るサイコロをふって、出た目の数のマスだけ右に進んでいきます。ゴールに到着した時点でゲームは終了します。

さとみさんはとてもストイックなので、練習中にはゴールにたどりつく可能性がある最小の回数だけしか、サイコロをふらないことにしました。さとみさんの代わりに、彼女がサイコロをふるべき回数を求めるプログラムを作成してください。
 */

class Test1Page extends StatefulWidget {
  const Test1Page({super.key});



  @override
  State<Test1Page> createState() => _Test1PageState();
}

final TextEditingController _controller = TextEditingController();



class _Test1PageState extends State<Test1Page> {

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
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => Test2Page()
            ));

          }, child: Text("次の課題へ",style: TextStyle(
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
          ElevatedButton(onPressed: () => conversion(_controller.text), child: Text("出力")),
        ],
      ),
    );
  }

  void conversion(String A) {
    try {
      var number = int.parse(A);

      // 制約💡2 ≤ A ≤100000, 整数
      if (number < 2 || number > 100000) {
        throw ArgumentError('Aは2以上100000以下の整数である必要があります');
      }

      number -= 1; // スタート位置を除く

      // サイコロを振る回数の計算（小数点切り捨て）
      int minRolls = number ~/ 6;

      // 余りがある場合、サイコロを1回追加で振る必要がある
      if (number % 6 > 0) {
        minRolls += 1;
      }
      print("Minimum rolls needed: $minRolls");
    } catch (e) {
      //　整数以外が入力された場合
    print('予期せぬエラーが発生しました');
    }
  }

}
