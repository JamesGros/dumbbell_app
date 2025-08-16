// ignore_for_file: constant_identifier_names, curly_braces_in_flow_control_structures, unreachable_switch_default

enum BarbellType {
  BARBELL_TITAN_SSB,
  BARBELL_45LB,
  BARBELL_35LB,
  BARBELL_25LB,
  BARBELL_15LB,
  BARBELL_IRONMASTER_5lb // IRON MASTER - Dumbbell handle (5lb) + locking screws (2.5lb x 2) = 10lb
}

//
// This is used by the LoadBarbellView's checkbox widgets
// and the Widget that displays the "loaded barbell" details.
//
class LoadBarbellStruct {
  BarbellType barbellInUse;
  // WorkoutType workoutType; // 0 = Wendler, 1 = Hatch

  // Global LoadBarbellView header information
  //   Title, Working Set information (Percent x Reps of 1RM)
  // late String title;
  // late double percent;
  // late int reps;
  // late int setNumber;
  // late int oneRepMax;
  // late int oneRepMaxHatchBackSquat;
  // late int oneRepMaxHatchFrontSquat;

  // Keep the states of the button menus across the
  // WendlerView()/HatchView(0) and the LoadBarbellView() classes.
  // Given these states, the WendlerView and HatchView will
  // sort the "WidgetFlipper::cards" widgets list to the previous
  // order before passing the widgets list to the WidgetFlipper
  // construtor.
  late int wendlerMovement;
  late int wendlerSetType;
  late int hatchMovement;

  //**********************************************/
  // Constructor
  //**********************************************/
  LoadBarbellStruct({required this.barbellInUse});
}

double getCurrentBarbellTypeDouble(BarbellType barbellType) {
  switch (barbellType) {
    case BarbellType.BARBELL_TITAN_SSB:
      return 61.0;
    case BarbellType.BARBELL_45LB:
      return 45.0;
    case BarbellType.BARBELL_35LB:
      return 35.0;
    case BarbellType.BARBELL_25LB:
      return 25.0;
    case BarbellType.BARBELL_15LB:
      return 15.0;
    case BarbellType.BARBELL_IRONMASTER_5lb:
      return 5.0;
  }
}

String getCurrentBarbellTypeString(BarbellType barbellType) {
  switch (barbellType) {
    case BarbellType.BARBELL_TITAN_SSB:
      return "SSB Barbell "; // Added extra space char for Neon(), must have same length as other texts.
    case BarbellType.BARBELL_45LB:
      return "45lb Barbell";
    case BarbellType.BARBELL_35LB:
      return "35lb Barbell";
    case BarbellType.BARBELL_25LB:
      return "25lb Barbell";
    case BarbellType.BARBELL_15LB:
      return "15lb Barbell";
    case BarbellType.BARBELL_IRONMASTER_5lb:
      return "5lb Handle ";
  }
}

BarbellType getCurrentBarbellTypeEnumFromPickerList(String pickerValue) {
  if (pickerValue.contains("SSB")) {
    return BarbellType.BARBELL_TITAN_SSB;
  } else if (pickerValue.contains("45lb"))
    return BarbellType.BARBELL_45LB;
  else if (pickerValue.contains("35lb"))
    return BarbellType.BARBELL_35LB;
  else if (pickerValue.contains("25lb"))
    return BarbellType.BARBELL_25LB;
  else if (pickerValue.contains("15lb")) return BarbellType.BARBELL_15LB;
  return BarbellType.BARBELL_45LB;
}

int getCurrentBarbellTypeInt(BarbellType barbellType) {
  switch (barbellType) {
    case BarbellType.BARBELL_TITAN_SSB:
      return 0;
    case BarbellType.BARBELL_45LB:
      return 1;
    case BarbellType.BARBELL_35LB:
      return 2;
    case BarbellType.BARBELL_25LB:
      return 3;
    case BarbellType.BARBELL_15LB:
      return 4;
    case BarbellType.BARBELL_IRONMASTER_5lb:
      return 5;
    default:
      return 0;
  }
}

BarbellType getCurrentBarbellTypeEnum(int barbellType) {
  switch (barbellType) {
    case 0:
      return BarbellType.BARBELL_TITAN_SSB;

    case 1:
      return BarbellType.BARBELL_45LB;

    case 2:
      return BarbellType.BARBELL_35LB;

    case 3:
      return BarbellType.BARBELL_25LB;

    case 4:
      return BarbellType.BARBELL_15LB;

    case 5:
      return BarbellType.BARBELL_IRONMASTER_5lb;

    default:
      return BarbellType.BARBELL_TITAN_SSB;
  }
}

// String getCurrentMovementTypeString(WorkoutType workoutType, int movement) {
//   if (workoutType == WorkoutType.Wendler) {
//     switch (movement) {
//       case 0:
//         return "Deadlift";
//       case 1:
//         return "Squat";
//       case 2:
//         return "Bench Press";
//       case 3:
//         return "Overhead Press";
//       default:
//         return "";
//     }
//   } else if (workoutType == WorkoutType.Hatch) {
//     switch (movement) {
//       case 0:
//         return "Back Squat";
//       case 1:
//         return "Front Squat";
//       default:
//         return "";
//     }
//   }
// }
