/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 model/component_registry.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import '../model/internal_component.dart';
import 'package:eliud_core_main/apis/registryapi/component/component_spec.dart';
import 'abstract_repository_singleton.dart';
import 'package:eliud_core_main/apis/registryapi/component/component_constructor.dart';
import 'package:eliud_core_main/apis/apis.dart';

import 'play_store_component_selector.dart';

/* 
 * Component registry contains a list of components
 */
class ComponentRegistry {
  /* 
   * Initialise the component registry
   */
  init(
    ComponentConstructor playStoreComponentConstructorDefault,
    ComponentEditorConstructor playStoreComponentEditorConstructor,
  ) {
    Apis.apis()
        .getRegistryApi()
        .addInternalComponents('eliud_pkg_create_model', [
      "playStores",
    ]);

    Apis.apis()
        .getRegistryApi()
        .addDropDownSupporter("playStores", DropdownButtonComponentFactory());
    Apis.apis().getRegistryApi().register(
        componentName: "playStores",
        componentConstructor: playStoreComponentConstructorDefault);
    Apis.apis()
        .getRegistryApi()
        .addComponentSpec('eliud_pkg_create_model', 'create', [
      ComponentSpec(
          'playStores',
          playStoreComponentConstructorDefault,
          PlayStoreComponentSelector(),
          playStoreComponentEditorConstructor,
          ({String? appId}) => playStoreRepository(appId: appId)!),
    ]);
    Apis.apis().getRegistryApi().registerRetrieveRepository(
        'eliud_pkg_create_model',
        'playStores',
        ({String? appId}) => playStoreRepository(appId: appId)!);
  }
}
