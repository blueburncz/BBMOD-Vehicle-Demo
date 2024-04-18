/// @func CBulletBoxShape()
///
/// @extends CBulletCollisionShape
///
/// @desc A Bullet physics box collision shape.
function CBulletBoxShape()
	: CBulletCollisionShape() constructor
{
	/// @var {Struct.BBMOD_Vec3}
	/// @private
	__halfExtents = new BBMOD_Vec3();

	/// @func create(_halfExtents)
	///
	/// @desc Creates the box shape. Must be called first before using other
	/// methods!
	///
	/// @param {Struct.BBMOD_Vec3} _halfExtents The half extents of the box.
	///
	/// @return {Struct.CBulletBoxShape} Returns `self`.
	static create = function (_halfExtents)
	{
		gml_pragma("forceinline");
		bbmod_assert(__ptr == pointer_null, "Method create can be called only once!");
		__ptr = btBoxShape_createXYZ(_halfExtents.X, _halfExtents.Y, _halfExtents.Z);
		_halfExtents.Copy(__halfExtents);
		return self;
	};

	/// @func get_half_extents()
	///
	/// @desc Retrieves the half extents of the box.
	///
	/// @return {Struct.BBMOD_Vec3} The half extents of the box.
	static get_half_extents = function ()
	{
		gml_pragma("forceinline");
		return __halfExtents.Clone();
	};
}
