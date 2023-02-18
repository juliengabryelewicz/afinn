import 'package:afinn/afinn.dart';

void main() {
  var afinn = Afinn(AfinnCode.french);
  print('${afinn.analyze("c'est une excellente nouvelle pour les investisseurs malgré la crise")}');
}
