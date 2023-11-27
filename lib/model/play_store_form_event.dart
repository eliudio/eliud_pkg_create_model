/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 play_store_form_event.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:eliud_core_main/model/model_export.dart';
import 'package:eliud_pkg_create_model/model/model_export.dart';

@immutable
abstract class PlayStoreFormEvent extends Equatable {
  const PlayStoreFormEvent();

  @override
  List<Object?> get props => [];
}

class InitialiseNewPlayStoreFormEvent extends PlayStoreFormEvent {}

class InitialisePlayStoreFormEvent extends PlayStoreFormEvent {
  final PlayStoreModel? value;

  @override
  List<Object?> get props => [value];

  InitialisePlayStoreFormEvent({this.value});
}

class InitialisePlayStoreFormNoLoadEvent extends PlayStoreFormEvent {
  final PlayStoreModel? value;

  @override
  List<Object?> get props => [value];

  InitialisePlayStoreFormNoLoadEvent({this.value});
}

class ChangedPlayStoreDocumentID extends PlayStoreFormEvent {
  final String? value;

  ChangedPlayStoreDocumentID({this.value});

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'ChangedPlayStoreDocumentID{ value: $value }';
}

class ChangedPlayStoreAppId extends PlayStoreFormEvent {
  final String? value;

  ChangedPlayStoreAppId({this.value});

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'ChangedPlayStoreAppId{ value: $value }';
}

class ChangedPlayStoreDescription extends PlayStoreFormEvent {
  final String? value;

  ChangedPlayStoreDescription({this.value});

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'ChangedPlayStoreDescription{ value: $value }';
}

class ChangedPlayStoreBackgroundIcon extends PlayStoreFormEvent {
  final BackgroundModel? value;

  ChangedPlayStoreBackgroundIcon({this.value});

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'ChangedPlayStoreBackgroundIcon{ value: $value }';
}

class ChangedPlayStoreConditions extends PlayStoreFormEvent {
  final StorageConditionsModel? value;

  ChangedPlayStoreConditions({this.value});

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'ChangedPlayStoreConditions{ value: $value }';
}