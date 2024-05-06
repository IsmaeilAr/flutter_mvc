import 'package:flutter/material.dart';
import 'menu_item_model.dart';

void onSelectedProgram(
  BuildContext context,
  MenuItemModel item,
  var program,
  VoidCallback goToDetails,
  VoidCallback recommend,
  VoidCallback goToEdit,
  VoidCallback delete,
) {
  switch (item.icon) {
    case Icons.details:
      goToDetails();
      break;

    case Icons.recommend:
      recommend();
      break;

    case Icons.edit:
      goToEdit();
      break;

    case Icons.delete:
      delete();
      break;
  }
}
