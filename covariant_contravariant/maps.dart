Map<String, String> takesChildReturnsChild(Map<String, String> someChildClass) {
  return {};
}

Map<String, String> takesBaseReturnsChild(Map<Object, Object> someBaseClass) {
  return {};
}

Map<Object, Object> takesChildReturnsBase(Map<String, String> someChildClass) {
  return {};
}

Map<Object, Object> takesBaseReturnsBase(Map<Object, Object> someBaseClass) {
  return {};
}

void funcThatTakesBaseReturnsBase(
  Map<Object, Object> Function(Map<Object, Object>) thing,
) {}
void funcThatTakesBaseReturnsChild(
  Map<String, String> Function(Map<Object, Object>) thing,
) {}
void funcThatTakesChildReturnsBase(
  Map<Object, Object> Function(Map<String, String>) thing,
) {}
void funcThatTakesChildReturnsChild(
  Map<String, String> Function(Map<String, String>) thing,
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
