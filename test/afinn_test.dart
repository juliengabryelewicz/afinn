import 'package:afinn/afinn.dart';
import 'package:test/test.dart';

void main() {

  group('Tests for French Language', () {
    final afinn = Afinn(AfinnCode.french);

    setUp(() {
    });

    tearDown(() {
      afinn.setWordsSentiment();
    });

    test('Neutral score', () {
      var result = afinn.analyze("Je m'appelle Julien");
      expect(result["score"], equals(0));
    });

    test('Remove word', () {
      afinn.removeWord("puéril");
      expect(afinn.sentiments["puéril"], equals(null));
    });

    test('Remove words', () {
      afinn.removeWords(["puéril", "glaçant"]);
      expect(afinn.sentiments["puéril"], equals(null));
      expect(afinn.sentiments["glaçant"], equals(null));
    });

    test('Remove word and new score', () {
      afinn.removeWord("puéril");
      var result = afinn.analyze("c'est puéril");
      expect(result["score"], equals(0));
    });

    test('Remove word and new score', () {
      afinn.removeWords(["puéril", "glaçant"]);
      var result = afinn.analyze("c'est puéril et glaçant");
      expect(result["score"], equals(0));
    });

    test('Add word', () {
      afinn.addWord("excellent", 3);
      expect(afinn.sentiments["excellent"], equals(3));
    });

    test('Add words', () {
      afinn.addWords({"excellent":3, "bon":2});
      expect(afinn.sentiments["excellent"], equals(3));
      expect(afinn.sentiments["bon"], equals(2));
    });

    test('Add word and new score', () {
      afinn.addWord("excellent", 3);
      expect(afinn.sentiments["excellent"], equals(3));
      var result = afinn.analyze("Le repas est bon et excellent");
      expect(result["score"], equals(3));
    });

    test('Add words and new score', () {
      afinn.addWords({"excellent":3, "bon":2});
      expect(afinn.sentiments["excellent"], equals(3));
      var result = afinn.analyze("Le repas est bon et excellent");
      expect(result["score"], equals(5));
    });
  });

  group('Tests for English Language', () {
    final afinn = Afinn();

    setUp(() {
    });

    tearDown(() {
      afinn.setWordsSentiment();
    });

    test('Neutral score', () {
      var result = afinn.analyze("My name is Julien");
      expect(result["score"], equals(0));
    });

    test('Remove word', () {
      afinn.removeWord("gloom");
      expect(afinn.sentiments["gloom"], equals(null));
    });

    test('Remove words', () {
      afinn.removeWords(["gloom", "glory"]);
      expect(afinn.sentiments["gloom"], equals(null));
      expect(afinn.sentiments["glory"], equals(null));
    });

    test('Remove word and new score', () {
      afinn.removeWord("gloom");
      var result = afinn.analyze("into the gloom");
      expect(result["score"], equals(0));
    });

    test('Remove word and new score', () {
      afinn.removeWords(["gloom", "glory"]);
      var result = afinn.analyze("gloom and glory");
      expect(result["score"], equals(0));
    });

    test('Add word', () {
      afinn.addWord("excellent", 3);
      expect(afinn.sentiments["excellent"], equals(3));
    });

    test('Add words', () {
      afinn.addWords({"excellent":3, "tasty":2});
      expect(afinn.sentiments["excellent"], equals(3));
      expect(afinn.sentiments["tasty"], equals(2));
    });

    test('Add word and new score', () {
      afinn.addWord("excellent", 3);
      expect(afinn.sentiments["excellent"], equals(3));
      var result = afinn.analyze("this meal is excellent and tasty");
      expect(result["score"], equals(3));
    });

    test('Add words and new score', () {
      afinn.addWords({"excellent":3, "tasty":2});
      expect(afinn.sentiments["excellent"], equals(3));
      var result = afinn.analyze("this meal is excellent and tasty");
      expect(result["score"], equals(5));
    });
  });
}
