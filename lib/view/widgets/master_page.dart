import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:settings/view/pages/menu_items.dart';
import 'package:settings/view/widgets/detail_page.dart';
import 'package:settings/view/widgets/detail_route.dart';
import 'package:settings/view/widgets/menu_item.dart';
import 'package:yaru_icons/widgets/yaru_icons.dart';

class MasterPage extends StatefulWidget {
  const MasterPage({Key? key}) : super(key: key);

  @override
  MasterPageState createState() => MasterPageState();
}

class MasterPageState extends State<MasterPage> {
  late MenuItem selectedMenuItem;

  @override
  void initState() {
    selectedMenuItem = menuItems.first;
    super.initState();
    // goToDetail(menuItems.indexOf(selectedMenuItem));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: AppBar(
            leading: const Icon(YaruIcons.search),
            title: const Text('Settings',
                style: TextStyle(fontWeight: FontWeight.normal)),
          ),
        ),
        body: Center(
          child: ListView.builder(
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                      // gradient: menuItems[index] == selectedMenuItem
                      //     ? LinearGradient(stops: const [
                      //         0,
                      //         4
                      //       ], colors: [
                      //         Theme.of(context).primaryColor,
                      //         Theme.of(context)
                      //             .colorScheme
                      //             .onSurface
                      //             .withOpacity(0.1)
                      //       ])
                      //     : null,
                      border: menuItems[index] == selectedMenuItem
                          ? Border(
                              left: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 4),
                            )
                          : null,
                      // borderRadius: const BorderRadius.only(
                      //     topRight: Radius.circular(4.0),
                      //     bottomRight: Radius.circular(4.0)),
                      color: menuItems[index] == selectedMenuItem
                          ? Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.07)
                          : null),
                  child: ListTile(
                      // dense: true,
                      leading: Icon(
                        menuItems[index].iconData,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.8),
                      ),
                      selected: menuItems[index] == selectedMenuItem,
                      title: Text(menuItems[index].name,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.8))),
                      onTap: () {
                        setState(() => goToDetail(index));
                      }),
                );
              }),
        ));
  }

  void goToDetail(int index) {
    selectedMenuItem = menuItems[index];
    while (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
    Navigator.of(context).push(DetailRoute(
        builder: (context) => DetailPage(
              item: selectedMenuItem,
            )));
  }
}
