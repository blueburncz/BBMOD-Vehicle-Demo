/// @func CBulletRayResult()
///
/// @desc A result of ray test.
function CBulletRayResult() constructor
{
	/// @var {Bool} If `true` then a hit was found.
	HasHit = false;

	/// @var {Real} A value in range 0..1, telling where the hit was found
	/// between the ray's starting point (0) and end point (1).
	HitFraction = 1;

	/// @var {Struct.BBMOD_Vec3} The position of the hit in world-space.
	Point = new BBMOD_Vec3();

	/// @var {Struct.BBMOD_Vec3} The normal of the hit in world-space.
	Normal = new BBMOD_Vec3();

	/// @var {Struct.CBulletCollisionObject, Undefined} The collision object
	/// that was hit or `undefined`.
	Object = undefined;
}
