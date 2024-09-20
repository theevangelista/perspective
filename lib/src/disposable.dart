// ignore_for_file: one_member_abstracts

/// Interface for objects that are considered disposable and must be dealt with
/// during the lifecycle of a view model.
abstract interface class Disposable {
  /// Dispose of this object and release it's resources.
  /// Call it whithin the appropriate lifecycle callback.
  void dispose();
}
