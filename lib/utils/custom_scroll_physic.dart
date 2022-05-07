import 'package:flutter/cupertino.dart';

/// This Override and use the FixrdExtentImplementation to increase the speed of the scroll
/// if scrolled at a slow speed
class CustomScrollPhysic extends FixedExtentScrollPhysics {
  /// Creates a scroll physics that always lands on items.
  const CustomScrollPhysic({ScrollPhysics? parent}) : super(parent: parent);

  @override
  FixedExtentScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomScrollPhysic(parent: buildParent(ancestor));
  }

  @override
  Simulation? createBallisticSimulation(ScrollMetrics position, double velocity) {
    /// The velocity will never go below the minimum velocity, To make it feell
    /// not boring to scroll it

    double minVelocity = 1300;
    double maxVelocity = 1500;
    if (velocity != 0.0) {
      if (velocity.isNegative && velocity > -minVelocity) {
        velocity = -minVelocity;
      }
      if (velocity.isNegative && velocity < maxVelocity) {
        velocity = -minVelocity;
      }

      if (!velocity.isNegative && velocity < minVelocity) {
        velocity = minVelocity;
      }
      if (!velocity.isNegative && velocity > minVelocity) {
        velocity = minVelocity;
      }
    }
    return super.createBallisticSimulation(position, velocity);
  }
}
