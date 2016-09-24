import "package:proto_5gl/proto_5gl.dart";
import "package:string_editor/string_editor.dart";
import "package:test/test.dart";

main() {
  test("correct types and text", () async {
    var source = '''
    import <std>

    ? main
      print:"Hello, world!"23''';
    var lexer = new Lexer()..scan(source);

    await for (var token in lexer.tokenStream) {
      print(token.toString().replaceAll("\n", "\\n"));
    }
  });

  test("correct position", () {
    print(["poop"].contains(new StringEditor("poop")));
  });
}

void validateToken(Token token, String type, String text) {
  expect(token.type, equals(type),
      reason: "Invalid type '${token.type}' when wanted '$type'");
  expect(token.text, equals(text),
      reason: "Invalid type '${token.text}' when wanted '$text'");
}
