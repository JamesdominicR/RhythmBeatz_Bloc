import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
part 'add_button_event.dart';
part 'add_button_state.dart';

class AddButtonBloc extends Bloc<AddButtonEvent, AddButtonState> {
  AddButtonBloc() : super(AddButtonInitial()) {
    on<AddButtonChangeEvent>((event, emit) {
      emit(AddButtonChange(addIconData: event.addButtoniconData));
      emit (AddButtonChanged());  
    });
    on<AddButtonChangedEvent>((event, emit) {
      emit((AddButtonChanged()));
      emit((AddButtonChanged()));
    });
  }
}
