part of 'add_button_bloc.dart';
@immutable
abstract class AddButtonEvent {
AddButtonEvent();
}
class AddButtonChangeEvent extends AddButtonEvent {
  final IconData addButtoniconData;
  AddButtonChangeEvent({
    required this.addButtoniconData,
  });

}
class AddButtonChangedEvent extends AddButtonEvent{
  AddButtonChangedEvent();
}