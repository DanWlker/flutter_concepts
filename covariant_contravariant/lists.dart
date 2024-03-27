List<String> takesChildReturnsChild(List<String> someChildClass) {
  return [""];
}

List<String> takesBaseReturnsChild(List<Object> someBaseClass) {
  return [""];
}

List<Object> takesChildReturnsBase(List<String> someChildClass) {
  return [];
}

List<Object> takesBaseReturnsBase(List<Object> someBaseClass) {
  return [];
}

void funcThatTakesBaseReturnsBase(
  List<Object> Function(List<Object>) thing,
) {}
void funcThatTakesBaseReturnsChild(
  List<String> Function(List<Object>) thing,
) {}
void funcThatTakesChildReturnsBase(
  List<Object> Function(List<String>) thing,
) {}
void funcThatTakesChildReturnsChild(
  List<String> Function(List<String>) thing,
) {}

main() {
  funcThatTakesBaseReturnsBase(takesChildReturnsChild);
  funcThatTakesBaseReturnsBase(takesBaseReturnsChild);
  funcThatTakesBaseReturnsBase(takesChildReturnsBase);
  funcThatTakesBaseReturnsBase(takesBaseReturnsBase);

  funcThatTakesBaseReturnsChild(takesChildReturnsChild);
  funcThatTakesBaseReturnsChild(takesBaseReturnsChild);
  funcThatTakesBaseReturnsChild(takesChildReturnsBase);
  funcThatTakesBaseReturnsChild(takesBaseReturnsBase);

  funcThatTakesChildReturnsBase(takesChildReturnsChild);
  funcThatTakesChildReturnsBase(takesBaseReturnsChild);
  funcThatTakesChildReturnsBase(takesChildReturnsBase);
  funcThatTakesChildReturnsBase(takesBaseReturnsBase);

  funcThatTakesChildReturnsChild(takesChildReturnsChild);
  funcThatTakesChildReturnsChild(takesBaseReturnsChild);
  funcThatTakesChildReturnsChild(takesChildReturnsBase);
  funcThatTakesChildReturnsChild(takesBaseReturnsBase);
}
