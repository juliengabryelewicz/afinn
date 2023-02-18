import 'afinn_code.dart';
import 'lang/english.dart';
import 'lang/french.dart';

class Afinn {
  AfinnCode? code;
  Map<String, int> sentiments = {};

  Afinn([AfinnCode? code]) {
    this.code = code ?? AfinnCode.english;
    setWordsSentiment();
  }

  void setWordsSentiment() {
    sentiments.clear();
    switch (code) {
      case AfinnCode.english:
        sentiments.addAll(english);
        break;
      case AfinnCode.french:
        sentiments.addAll(french);
        break;
      default:
        throw ('Wrong AFINN code. Please choose french');
    }
  }

  void changeLanguage(AfinnCode code) {
    this.code = code;
    setWordsSentiment();
  }

  void addWord(String word, int value) {
    sentiments[word] = value;
  }

  void addWords(Map<String, int> words) {
    sentiments.addAll(words);
  }

  void removeWord(String word) {
    sentiments.remove(word);
  }

  void removeWords(List<String> words) {
    for (var i = 0; i < words.length; i++) {
      sentiments.remove(words[i]);
    }
  }

  Map<String, dynamic> analyze(String text) {
    try {
      if (text.trim().isEmpty) throw ('Empty text. Please add one');
      int score = 0;
      var wordsPositive = [];
      var wordsNegative = [];

      List<String> listWords = text.toLowerCase().trim().split(' ');
      for (var i = 0; i < listWords.length; i++) {
        if(sentiments.containsKey(listWords[i])){
          int value = sentiments[listWords[i]] ?? 0;
          score += value;
          if (value < 0) {
            wordsNegative.add([listWords[i], value]);
          } else {
            wordsPositive.add([listWords[i], value]);
          }
        }
      }

      return {
        'score': score,
        'mean': listWords.isNotEmpty ? score / listWords.length : 0,
        'tokens': listWords,
        'positive': wordsPositive,
        'negative': wordsNegative
      };
    } catch (e) {
      throw Exception(e);
    }
  }

}

