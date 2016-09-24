import "dart:async";
import "package:string_editor/chars.dart" as Chars;
import "package:string_editor/string_editor.dart";
import "token.dart";
import "token_type.dart" as TokenType;

final StringEditor _AS = new StringEditor("as");
final StringEditor _ASSUME = new StringEditor("assume");
final StringEditor _DEF = new StringEditor("def");
final StringEditor _ELSE = new StringEditor("else");
final StringEditor _FOR = new StringEditor("for");
final StringEditor _IMPORT = new StringEditor("import");
final StringEditor _IN = new StringEditor("in");
final StringEditor _ONLY = new StringEditor("only");
final StringEditor _WHILE = new StringEditor("while");

class Lexer {
  StreamController<Token> _tokenStream = new StreamController<Token>();

  Stream<Token> get tokenStream => _tokenStream.stream;

  void scan(String source) {
    var editor = new StringEditor(source);
    var chars = editor.toList();
    var line = 1,
        index = -1;

    for (int i = 0; i < chars.length; i++) {
      var ch = chars[i];
      index++;

      // Whitespace
      if (ch == "\n") {
        _tokenStream.add(new Token(TokenType.NEWLINE, "\n", line, index));
        line++;
        index = -1;
      } else if (ch == " " || ch == "\t") {
        _tokenStream
            .add(new Token(TokenType.WHITESPACE, ch.toString(), line, index));
      } else if (ch == Chars.COMMA) {
        _tokenStream.add(new Token(TokenType.COMMA, ",", line, index));
      } else if (ch == Chars.PERIOD) {
        _tokenStream.add(new Token(TokenType.DOT, ".", line, index));
      } else if (ch == Chars.EXCLAMATION_POINT) {
        _tokenStream.add(new Token(TokenType.EXCLAMATION, "!", line, index));
      } else if (ch == Chars.GREATER_THAN) {
        _tokenStream.add(new Token(TokenType.GT, ">", line, index));
      } else if (ch == Chars.LESS_THAN) {
        _tokenStream.add(new Token(TokenType.LT, "<", line, index));
      } else if (ch == Chars.PAREN_L) {
        _tokenStream.add(new Token(TokenType.PAREN_L, "(", line, index));
      } else if (ch == Chars.PAREN_R) {
        _tokenStream.add(new Token(TokenType.PAREN_R, ")", line, index));
      } else if (ch == Chars.SQUARE_L) {
        _tokenStream.add(new Token(TokenType.SQUARE_R, "[", line, index));
      } else if (ch == Chars.SQUARE_R) {
        _tokenStream.add(new Token(TokenType.SQUARE_R, "]", line, index));
      } else if (ch == ":=") {
        _tokenStream.add(new Token(TokenType.ASSIGN, ":=", line, index));
      } else if (ch == ":") {
        _tokenStream.add(new Token(TokenType.COLON, ":", line, index));
      } else if (ch == ":=") {
        _tokenStream.add(new Token(TokenType.ASSIGN, ":=", line, index));
      } else if (ch == Chars.QUESTION_MARK)
        _tokenStream.add(new Token(TokenType.QUESTION, "?", line, index));
      else if (editor.compareN(_AS, start: i) == null) {
        _tokenStream.add(new Token(TokenType.AS, "as", line, index));
        index++;
      } else if (editor.compareN(_ASSUME, start: i) == null) {
        _tokenStream.add(new Token(TokenType.ASSUME, "assume", line, index));
        index += 5;
      } else if (editor.compareN(_DEF, start: i) == null) {
        _tokenStream.add(new Token(TokenType.DEF, "def", line, index));
        index += 2;
      } else if (editor.compareN(_ELSE, start: i) == null) {
        _tokenStream.add(new Token(TokenType.ELSE, "else", line, index));
        index += 3;
      } else if (editor.compareN(_FOR, start: i) == null) {
        _tokenStream.add(new Token(TokenType.FOR, "for", line, index));
        index += 2;
      } else if (editor.compareN(_IMPORT, start: i) == null) {
        _tokenStream.add(new Token(TokenType.IMPORT, "import", line, index));
        index += 5;
      } else if (editor.compareN(_IN, start: i) == null) {
        _tokenStream.add(new Token(TokenType.IN, "in", line, index));
        index++;
      } else if (editor.compareN(_ONLY, start: i) == null) {
        _tokenStream.add(new Token(TokenType.ONLY, "only", line, index));
        index += 3;
      } else if (editor.compareN(_WHILE, start: i) == null) {
        _tokenStream.add(new Token(TokenType.WHILE, "while", line, index));
        index += 4;
      } else if (ch == Chars.HYPHEN || ch.isNumeric()) {
        var buf = new StringBuffer(ch.toString());

        while (i < chars.length - 1 && chars[i + 1].isNumeric())
          buf.write(chars[++i]);

        if (i < chars.length - 1 && chars[i + 1] == Chars.PERIOD)
          buf.write(chars[++i]);

        while (i < chars.length - 1 && chars[i + 1].isNumeric())
          buf.write(chars[++i]);

        var text = buf.toString();
        _tokenStream.add(new Token(TokenType.NUMBER, text, line, index));
        index += text.length - 1;
      } else if (ch == Chars.DOUBLE_QUOTE) {
        var buf = new StringBuffer(ch.toString());
        var start = i + 0;

        while (i < chars.length - 1 && chars[i + 1] != Chars.NEWLINE &&
            chars[i + 1] != Chars.DOUBLE_QUOTE)
          buf.write(chars[++i]);

        while (i < chars.length - 1) {
          if (chars[i + 1] == Chars.DOUBLE_QUOTE) {
            buf.write(chars[++i]);
            break;
          } else i++;
        }

        var text = buf.toString();
        _tokenStream.add(new Token(TokenType.STRING, text, line, i - start - 1));
        index += text.length - 1;
      } else {
        while (i < chars.length -1 && chars[i + 1] != Chars.NEWLINE && chars[i + 1] != " " && chars[i + 1] != Chars.PAREN_L) {

        }
      }
    }

    _tokenStream.close();
  }
}
