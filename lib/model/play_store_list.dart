/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 play_store_list.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_core_main/apis/apis.dart';
import 'package:eliud_core_main/tools/route_builders/route_builders.dart';
import 'package:eliud_core_main/apis/style/style_registry.dart';
import 'package:eliud_core_helpers/tools/has_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_core_main/model/background_model.dart';
import 'package:eliud_core_helpers/tools/delete_snackbar.dart';
import 'package:eliud_core_main/tools/etc/etc.dart';
import 'package:eliud_core_helpers/etc/enums.dart';
import 'package:eliud_core_main/apis/style/frontend/has_text.dart';

import 'package:eliud_pkg_create_model/model/play_store_list_event.dart';
import 'package:eliud_pkg_create_model/model/play_store_list_state.dart';
import 'package:eliud_pkg_create_model/model/play_store_list_bloc.dart';
import 'package:eliud_pkg_create_model/model/play_store_model.dart';

import 'package:eliud_core_main/model/app_model.dart';

import 'play_store_form.dart';

typedef PlayStoreWidgetProvider = Function(PlayStoreModel? value);

class PlayStoreListWidget extends StatefulWidget with HasFab {
  final AppModel app;
  final BackgroundModel? listBackground;
  final PlayStoreWidgetProvider? widgetProvider;
  final bool? readOnly;
  final String? form;
  //final PlayStoreListWidgetState? state;
  final bool? isEmbedded;

  PlayStoreListWidget(
      {super.key,
      required this.app,
      this.readOnly,
      this.form,
      this.widgetProvider,
      this.isEmbedded,
      this.listBackground});

  @override
  PlayStoreListWidgetState createState() {
    return PlayStoreListWidgetState();
  }

  @override
  Widget? fab(BuildContext context) {
    if ((readOnly != null) && readOnly!) return null;
    var state = PlayStoreListWidgetState();
    return state.fab(
      context,
    );
  }
}

class PlayStoreListWidgetState extends State<PlayStoreListWidget> {
  Widget? fab(BuildContext aContext) {
    return !Apis.apis()
            .getCoreApi()
            .memberIsOwner(context, widget.app.documentID)
        ? null
        : StyleRegistry.registry()
            .styleWithApp(widget.app)
            .adminListStyle()
            .floatingActionButton(
            widget.app,
            context,
            'PageFloatBtnTag',
            Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                pageRouteBuilder(widget.app,
                    page: BlocProvider.value(
                        value: BlocProvider.of<PlayStoreListBloc>(context),
                        child: PlayStoreForm(
                            app: widget.app,
                            value: null,
                            formAction: FormAction.addAction))),
              );
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    return Apis.apis().getCoreApi().buildWhenAccessDetermined(widget.app,
        (context) {
      return BlocBuilder<PlayStoreListBloc, PlayStoreListState>(
          builder: (context, state) {
        if (state is PlayStoreListLoading) {
          return StyleRegistry.registry()
              .styleWithApp(widget.app)
              .adminListStyle()
              .progressIndicator(widget.app, context);
        } else if (state is PlayStoreListLoaded) {
          final values = state.values;
          if ((widget.isEmbedded != null) && widget.isEmbedded!) {
            var children = <Widget>[];
            children.add(theList(
              context,
              values,
            ));
            children.add(StyleRegistry.registry()
                .styleWithApp(widget.app)
                .adminFormStyle()
                .button(
              widget.app,
              context,
              label: 'Add',
              onPressed: () {
                Navigator.of(context).push(
                  pageRouteBuilder(widget.app,
                      page: BlocProvider.value(
                          value: BlocProvider.of<PlayStoreListBloc>(context),
                          child: PlayStoreForm(
                              app: widget.app,
                              value: null,
                              formAction: FormAction.addAction))),
                );
              },
            ));
            return ListView(
                padding: const EdgeInsets.all(8),
                physics: ScrollPhysics(),
                shrinkWrap: true,
                children: children);
          } else {
            return theList(
              context,
              values,
            );
          }
        } else {
          return StyleRegistry.registry()
              .styleWithApp(widget.app)
              .adminListStyle()
              .progressIndicator(widget.app, context);
        }
      });
    });
  }

  Widget theList(
    BuildContext context,
    values,
  ) {
    var member = Apis.apis().getCoreApi().getMember(context);
    return Container(
        decoration: widget.listBackground == null
            ? StyleRegistry.registry()
                .styleWithApp(widget.app)
                .adminListStyle()
                .boxDecorator(widget.app, context, member)
            : BoxDecorationHelper.boxDecoration(
                widget.app, member, widget.listBackground),
        child: ListView.separated(
            separatorBuilder: (context, index) => StyleRegistry.registry()
                .styleWithApp(widget.app)
                .adminListStyle()
                .divider(widget.app, context),
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: values.length,
            itemBuilder: (context, index) {
              final value = values[index];

              if (widget.widgetProvider != null) {
                return widget.widgetProvider!(value);
              }

              return PlayStoreListItem(
                app: widget.app,
                value: value,
//            app: accessState.app,
                onDismissed: (direction) {
                  BlocProvider.of<PlayStoreListBloc>(context)
                      .add(DeletePlayStoreList(value: value));
                  ScaffoldMessenger.of(context).showSnackBar(DeleteSnackBar(
                    message: "PlayStore $value.documentID",
                    onUndo: () => BlocProvider.of<PlayStoreListBloc>(context)
                        .add(AddPlayStoreList(value: value)),
                  ));
                },
                onTap: () async {
                  final removedItem = await Navigator.of(context).push(
                      pageRouteBuilder(widget.app,
                          page: BlocProvider.value(
                              value:
                                  BlocProvider.of<PlayStoreListBloc>(context),
                              child: getForm(value, FormAction.updateAction))));
                  if (removedItem != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      DeleteSnackBar(
                        message: "PlayStore $value.documentID",
                        onUndo: () =>
                            BlocProvider.of<PlayStoreListBloc>(context)
                                .add(AddPlayStoreList(value: value)),
                      ),
                    );
                  }
                },
              );
            }));
  }

  Widget? getForm(value, action) {
    if (widget.form == null) {
      return PlayStoreForm(app: widget.app, value: value, formAction: action);
    } else {
      return null;
    }
  }
}

class PlayStoreListItem extends StatelessWidget {
  final AppModel app;
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final PlayStoreModel value;

  PlayStoreListItem({
    super.key,
    required this.app,
    required this.onDismissed,
    required this.onTap,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('__PlayStore_item_${value.documentID}'),
      onDismissed: onDismissed,
      child: ListTile(
        onTap: onTap,
        title: value.description != null
            ? Center(child: text(app, context, value.description!))
            : Center(child: text(app, context, value.documentID)),
      ),
    );
  }
}
