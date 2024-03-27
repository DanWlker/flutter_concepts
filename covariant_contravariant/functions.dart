class SomeBaseClass {
  String value;

  SomeBaseClass({
    required this.value,
  });
}

class SomeChildClass extends SomeBaseClass {
  SomeChildClass({required super.value});
}

class SomeBaseReturnClass {
  int value;

  SomeBaseReturnClass({
    required this.value,
  });
}

class SomeChildReturnClass extends SomeBaseReturnClass {
  SomeChildReturnClass({required super.value});
}

SomeChildReturnClass takesChildReturnsChild(SomeChildClass someChildClass) {
  return SomeChildReturnClass(value: 2);
}

SomeChildReturnClass takesBaseReturnsChild(SomeBaseClass someBaseClass) {
  return SomeChildReturnClass(value: 2);
}

SomeBaseReturnClass takesChildReturnsBase(SomeChildClass someChildClass) {
  return SomeChildReturnClass(value: 2);
}

SomeBaseReturnClass takesBaseReturnsBase(SomeBaseClass someBaseClass) {
  return SomeChildReturnClass(value: 2);
}

void funcThatTakesBaseReturnsBase(
  SomeBaseReturnClass Function(SomeBaseClass) thing,
) {}
void funcThatTakesBaseReturnsChild(
  SomeChildReturnClass Function(SomeBaseClass) thing,
) {}
void funcThatTakesChildReturnsBase(
  SomeBaseReturnClass Function(SomeChildClass) thing,
) {}
void funcThatTakesChildReturnsChild(
  SomeChildReturnClass Function(SomeChildClass) thing,
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
