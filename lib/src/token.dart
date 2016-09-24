import "pos.dart";

class Token {
  String type, text;
  Pos pos;

  Token.empty();

  Token(this.type, this.text, int line, int index) : pos = new Pos(line, index);

  @override
  String toString() => "$pos \"$text\" -> $type";
}
