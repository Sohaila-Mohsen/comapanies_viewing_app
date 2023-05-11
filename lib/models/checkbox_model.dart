class CheckBoxModel {
  List<String> choices;
  List<int> selected = [];
  CheckBoxModel(this.choices, {selected}) {
    if (selected != null) this.selected = selected;
  }
}

CheckBoxModel industries =
    CheckBoxModel(["Health", "Marketing", "Agriculture", "Trade", "Software"]);
CheckBoxModel comapnySizes = CheckBoxModel(["Micro", "Small", "Mini", "Large"]);
