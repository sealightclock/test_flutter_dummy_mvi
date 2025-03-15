abstract class MyStringIntent {}
class UpdateFromUserIntent extends MyStringIntent {
  final String newValue;
  UpdateFromUserIntent(this.newValue);
}
class UpdateFromServerIntent extends MyStringIntent {}
