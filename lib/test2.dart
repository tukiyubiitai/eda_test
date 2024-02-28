import 'package:dice_test/test3.dart';
import 'package:flutter/material.dart';
import 'dart:math';


/*
問題文
横方向に並んだマス目と、リバーシの石を使って「 1 次元リバーシ」をしました。具体的なルールは以下の通りです。


初期配置では、二つの石が隣り合って並んでいる。左側が黒で、右側が白である。
黒石から初めて、黒石と白石を交互に打つ。パスはできない。
他の石と隣り合う場所にしか石は打てない。従って、石を置けるのは、すでに置かれている石の、右隣か、左隣の二箇所のみである。
石を打ったら、打った石と、それに最も近い同じ色の石の、間にある石を全てひっくり返す。打った石の隣の石が同じ色だった場合や、同じ色の石がなかった場合は、どの石もひっくり返さない。
石をひっくり返せなくても打つことはできる。

この「1次元リバーシ」の棋譜は、LとRからなる文字列で表されます。棋譜の i 文字目が Lの時は、 i 手目で石 ( i が奇数の時は黒石、偶数の時は白石)が、すでに置かれている石の左隣に置かれたことを、Rの時は右隣に置かれたことを表します。

棋譜が与えられるので、最終的な黒石と白石の数を求めてください。

1 次元リバーシの棋譜 S が与えられます。最終的な黒石と白石の個数をスペース区切りで出力してください。
 */

class Test2Page extends StatefulWidget {
  const Test2Page({super.key});

  @override
  State<Test2Page> createState() => _Test2PageState();
}
final TextEditingController _controller = TextEditingController();

class _Test2PageState extends State<Test2Page> {
  @override
  Widget build(BuildContext context) {

    @override
    void dispose() {
      _controller;
      super.dispose();
    }
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => Test3Page()
            ));
          }, child: Text("次の課題へ", style: TextStyle(
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
              decoration: InputDecoration(
                labelText: 'RまたはLを入力', // ユーザーに入力する内容を示すラベル
              ),
            ),
          ),
          ElevatedButton(onPressed: () => conversion(_controller.text),
              child: Text("出力")),
        ],
      ),
    );
  }

   // 1次元リバーシゲームのシミュレーションを行う関数
  void conversion(String S) {
    // 制約💡　S の長さは 1 以上 10（6乗） 以下
    if (S.length < 1 || S.length > 10e6) {
      throw ArgumentError('棋譜の文字列の長さが1以上かつ10^6以下である必要があります。');
    }

      // 初期配置: 黒石(B)が左、白石(W)が右
      List<String> board = ['B', 'W'];

      // 棋譜の文字列を1文字ずつ処理する
      for (int i = 0; i < S.length; i++) {
        String move = S[i]; // 現在の手順(LまたはR)

        // 制約💡　S の各文字はLまたはRである
        if (move != 'R' && move != 'L') {
          throw ArgumentError('棋譜の文字列にRまたはL以外の文字が含まれています。');
        }

        String stone = i % 2 == 0 ? 'B' : 'W'; // 奇数手目は黒石(B)、偶数手目は白石(W)

        if (move == 'L') {
          board.insert(0, stone); // 左隣に石を置く
        } else { // 'R'
          board.add(stone); // 右隣に石を置く
        }

        // 石をひっくり返す処理を実行
        flipStones(board, stone);
      }

      // 黒石(B)と白石(W)の数をカウント
      int blackStones = board
          .where((stone) => stone == 'B')
          .length;
      int whiteStones = board
          .where((stone) => stone == 'W')
          .length;

      // 最終結果を出力
      print('$blackStones $whiteStones');
    }

  // ボード上の石をひっくり返す関数
  void flipStones(List<String> board, String stone) {
    int firstIndex = board.indexOf(stone); // 置かれた石の最初のインデックス
    int lastIndex = board.lastIndexOf(stone); // 置かれた石の最後のインデックス

    if (firstIndex != lastIndex) { // 同色の石が2つ以上ある場合のみ実行
      // 最初と最後の石の間にあるすべての石をひっくり返す
      for (int i = firstIndex + 1; i < lastIndex; i++) {
        board[i] = stone; // 間の石を置かれた石と同じ色に変更
      }
    }
  }
  }



