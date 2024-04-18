/// @func CBulletSphereShape()
///
/// @extends CBulletCollisionShape
///
/// @desc A Bullet physics sphere collision shape.
function CBulletSphereShape()
	: CBulletCollisionShape() constructor
{
	/// @var {Real}
	/// @private
	__radius = 0;

	/// @func create(_radius)
	///
	/// @desc Creates the sphere shape. Must be called first before using other
	/// methods!
	///
	/// @param {Real} _radius The sphere's radius.
	///
	/// @return {Struct.CBulletSphereShape} Returns `self`.
	static create = function (_radius)
	{
		gml_pragma("forceinline");
		bbmod_assert(__ptr == pointer_null, "Method create can be called only once!");
		__ptr = btSphereShape_create(_radius);
		__radius = _radius;
		return self;
	};

	/// @func get_radius()
	///
	/// @desc Retreives the radius of the sphere.
	///
	/// @return {Real} The radius of the sphere.
	static get_radius = function ()
	{
		gml_pragma("forceinline");
		return __radius;
	};
}
