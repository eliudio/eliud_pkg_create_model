/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 play_store_form_bloc.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:eliud_core_helpers/etc/enums.dart';

import 'package:eliud_pkg_create_model/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_create_model/model/model_export.dart';

import 'package:eliud_pkg_create_model/model/play_store_form_event.dart';
import 'package:eliud_pkg_create_model/model/play_store_form_state.dart';

class PlayStoreFormBloc extends Bloc<PlayStoreFormEvent, PlayStoreFormState> {
  final FormAction? formAction;
  final String? appId;

  PlayStoreFormBloc(this.appId, {this.formAction})
      : super(PlayStoreFormUninitialized()) {
    on<InitialiseNewPlayStoreFormEvent>((event, emit) {
      PlayStoreFormLoaded loaded = PlayStoreFormLoaded(
          value: PlayStoreModel(
        documentID: "",
        appId: "",
        description: "",
      ));
      emit(loaded);
    });

    on<InitialisePlayStoreFormEvent>((event, emit) async {
      // Need to re-retrieve the document from the repository so that I get all associated types
      PlayStoreFormLoaded loaded = PlayStoreFormLoaded(
          value: await playStoreRepository(appId: appId)!
              .get(event.value!.documentID));
      emit(loaded);
    });
    on<InitialisePlayStoreFormNoLoadEvent>((event, emit) async {
      PlayStoreFormLoaded loaded = PlayStoreFormLoaded(value: event.value);
      emit(loaded);
    });
    PlayStoreModel? newValue;
    on<ChangedPlayStoreDocumentID>((event, emit) async {
      if (state is PlayStoreFormInitialized) {
        final currentState = state as PlayStoreFormInitialized;
        newValue = currentState.value!.copyWith(documentID: event.value);
        if (formAction == FormAction.addAction) {
          emit(await _isDocumentIDValid(event.value, newValue!));
        } else {
          emit(SubmittablePlayStoreForm(value: newValue));
        }
      }
    });
    on<ChangedPlayStoreDescription>((event, emit) async {
      if (state is PlayStoreFormInitialized) {
        final currentState = state as PlayStoreFormInitialized;
        newValue = currentState.value!.copyWith(description: event.value);
        emit(SubmittablePlayStoreForm(value: newValue));
      }
    });
    on<ChangedPlayStoreBackgroundIcon>((event, emit) async {
      if (state is PlayStoreFormInitialized) {
        final currentState = state as PlayStoreFormInitialized;
        newValue = currentState.value!.copyWith(backgroundIcon: event.value);
        emit(SubmittablePlayStoreForm(value: newValue));
      }
    });
    on<ChangedPlayStoreConditions>((event, emit) async {
      if (state is PlayStoreFormInitialized) {
        final currentState = state as PlayStoreFormInitialized;
        newValue = currentState.value!.copyWith(conditions: event.value);
        emit(SubmittablePlayStoreForm(value: newValue));
      }
    });
  }

  DocumentIDPlayStoreFormError error(String message, PlayStoreModel newValue) =>
      DocumentIDPlayStoreFormError(message: message, value: newValue);

  Future<PlayStoreFormState> _isDocumentIDValid(
      String? value, PlayStoreModel newValue) async {
    if (value == null) {
      return Future.value(error("Provide value for documentID", newValue));
    }
    if (value.isEmpty) {
      return Future.value(error("Provide value for documentID", newValue));
    }
    Future<PlayStoreModel?> findDocument =
        playStoreRepository(appId: appId)!.get(value);
    return await findDocument.then((documentFound) {
      if (documentFound == null) {
        return SubmittablePlayStoreForm(value: newValue);
      } else {
        return error("Invalid documentID: already exists", newValue);
      }
    });
  }
}
