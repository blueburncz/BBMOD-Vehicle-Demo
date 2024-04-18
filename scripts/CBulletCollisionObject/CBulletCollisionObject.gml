/// @func CBulletCollisionObject()
///
/// @desc A Bullet physics collision object.
function CBulletCollisionObject() constructor
{
	/// @var {Pointer}
	/// @private
	__ptr = pointer_null;

	/// @var {Struct.CBulletCollisionShape}
	/// @private
	__shape = undefined;

	/// @var {Struct.CBulletCollisionWorld}
	/// @private
	__world = undefined;

	/// @func create(_shape)
	///
	/// @desc Creates the collision object. Must be called first before using
	/// other methods!
	///
	/// @param {Struct.CBulletCollisionShape} _shape The shape of the
	/// collision object.
	///
	/// @return {Struct.CBulletCollisionObject} Returns `self`.
	static create = function (_shape)
	{
		gml_pragma("forceinline");
		bbmod_assert(__ptr == pointer_null, "Method create can be called only once!");
		__ptr = btCollisionObject_create();
		set_collision_shape(_shape);
		return self;
	};

	/// @func set_collision_shape(_shape)
	///
	/// @desc Sets the shape of the collision object.
	///
	/// @param {Struct.CBulletCollisionShape} _shape The new shape of the
	/// collision object.
	///
	/// @return {Struct.CBulletCollisionObject} Returns `self`.
	static set_collision_shape = function (_shape)
	{
		gml_pragma("forceinline");
		__shape = _shape;
		btCollisionObject_setCollisionShape(__ptr, _shape.__ptr);
		return self;
	};

	/// @func get_collision_shape()
	///
	/// @desc Retrieves the shape of the collision object.
	///
	/// @return {Struct.CBulletCollisionShape} The collision shape.
	static get_collision_shape = function ()
	{
		gml_pragma("forceinline");
		return __shape;
	};

	/// @func set_enable_collision(_collisionObject, _enable)
	///
	/// @desc Enables or disables collision with given object.
	///
	/// @param {Struct.CBulletCollisionObject} _collisionObject The other
	/// collision object.
	/// @param {Bool} _enable Use `true` to enable or `false` to disable
	/// collisions with the object.
	///
	/// @return {Struct.CBulletCollisionObject} Returns `self`.
	static set_enable_collision = function (_collisionObject, _enable)
	{
		gml_pragma("forceinline");
		btCollisionObject_setIgnoreCollisionCheck(__ptr, _collisionObject.__ptr, !_enable);
		return self;
	};

	/// @func get_enable_collision(_collisionObject)
	///
	/// @desc Checks whether collision with given object is enabled.
	///
	/// @param {Struct.CBulletCollisionObject} _collisionObject The other
	/// collision object.
	///
	/// @return {Bool} Returns `true` if collisions with given object are
	/// enabled or `false` otherwise.
	static get_enable_collision = function (_collisionObject, _enable)
	{
		gml_pragma("forceinline");
		return btCollisionObject_checkCollideWith(__ptr, _collisionObject.__ptr);
	};

	/// @func is_active()
	///
	/// @desc Checks whether the collision object is active.
	///
	/// @return {Bool} Returns `true` if the collision object is active or
	/// `false` otherwise.
	static is_active = function ()
	{
		gml_pragma("forceinline");
		return btCollisionObject_isActive(__ptr);
	};

	/// @func activate()
	///
	/// @desc Activates the collision object.
	///
	/// @return {Struct.CBulletCollisionObject} Returns `self`.
	static activate = function ()
	{
		gml_pragma("forceinline");
		btCollisionObject_activate(__ptr);
		return self;
	};

	/// @func set_restitution(_restitution)
	///
	/// @desc Sets the restitution of the collision object.
	///
	/// @param {Real} _restitution The new restitution value.
	///
	/// @return {Struct.CBulletCollisionObject} Returns `self`.
	static set_restitution = function (_restitution)
	{
		gml_pragma("forceinline");
		btCollisionObject_setRestitution(__ptr, _restitution);
		return self;
	};

	/// @func get_restitution()
	///
	/// @desc Retrieves the restitution of the collision object.
	///
	/// @param {Real} The restitution value.
	static get_restitution = function ()
	{
		gml_pragma("forceinline");
		return btCollisionObject_getRestitution(__ptr);
	};

	/// @func set_friction(_friction)
	///
	/// @desc Sets the friction of the collision object.
	///
	/// @param {Real} _friction The new friction value.
	///
	/// @return {Struct.CBulletCollisionObject} Returns `self`.
	static set_friction = function (_friction)
	{
		gml_pragma("forceinline");
		btCollisionObject_setFriction(__ptr, _friction);
		return self;
	};

	/// @func get_friction()
	///
	/// @desc Retrieves the friction of the collision object.
	///
	/// @param {Real} The friction value.
	static get_friction = function ()
	{
		gml_pragma("forceinline");
		return btCollisionObject_getFriction(__ptr);
	};

	/// @func set_rolling_friction(_friction)
	///
	/// @desc Sets the rolling friction of the collision object.
	///
	/// @param {Real} _rollingFriction The new rolling friction value.
	///
	/// @return {Struct.CBulletCollisionObject} Returns `self`.
	static set_rolling_friction = function (_rollingFriction)
	{
		gml_pragma("forceinline");
		btCollisionObject_setRollingFriction(__ptr, _rollingFriction);
		return self;
	};

	/// @func get_rolling_friction()
	///
	/// @desc Retrieves the rolling friction of the collision object.
	///
	/// @param {Real} The rolling friction value.
	static get_rolling_friction = function ()
	{
		gml_pragma("forceinline");
		return btCollisionObject_getRollingFriction(__ptr);
	};

	/// @func set_spinning_friction(_spinningFriction)
	///
	/// @desc Sets the spinning friction of the collision object.
	///
	/// @param {Real} _spinningFriction The new spinning friction value.
	///
	/// @return {Struct.CBulletCollisionObject} Returns `self`.
	static set_spinning_friction = function (_spinningFriction)
	{
		gml_pragma("forceinline");
		btCollisionObject_setSpinningFriction(__ptr, _spinningFriction);
		return self;
	};

	/// @func get_spinning_friction()
	///
	/// @desc Retrieves the spinning friction of the collision object.
	///
	/// @param {Real} The spinning friction value.
	static get_spinning_friction = function ()
	{
		gml_pragma("forceinline");
		return btCollisionObject_getSpinningFriction(__ptr);
	};

	/// @func set_contact_stiffness(_stiffness)
	///
	/// @desc Sets the contact stiffness of the collision object.
	///
	/// @param {Real} _stiffness The new contact stiffness value.
	///
	/// @return {Struct.CBulletCollisionObject} Returns `self`.
	static set_contact_stiffness = function (_stiffness)
	{
		gml_pragma("forceinline");
		var _damping = btCollisionObject_getContactDamping(__ptr);
		btCollisionObject_setContactStiffnessAndDamping(__ptr, _stiffness, _damping);
		return self;
	};

	/// @func get_contact_stiffness()
	///
	/// @desc Retrieves the contact stiffness of the collision object.
	///
	/// @param {Real} The contact stiffness value.
	static get_contact_stiffness = function ()
	{
		gml_pragma("forceinline");
		return btCollisionObject_getContactStiffness(__ptr);
	};

	/// @func set_contact_damping(_damping)
	///
	/// @desc Sets the contact damping of the collision object.
	///
	/// @param {Real} _damping The new contact damping value.
	///
	/// @return {Struct.CBulletCollisionObject} Returns `self`.
	static set_contact_damping = function (_damping)
	{
		gml_pragma("forceinline");
		var _stiffness = btCollisionObject_getContactStiffness(__ptr);
		btCollisionObject_setContactStiffnessAndDamping(__ptr, _stiffness, _damping);
		return self;
	};

	/// @func get_contact_damping()
	///
	/// @desc Retrieves the contact damping of the collision object.
	///
	/// @param {Real} The contact damping value.
	static get_contact_damping = function ()
	{
		gml_pragma("forceinline");
		return btCollisionObject_getContactDamping(__ptr);
	};

	/// @func set_transform(_matrix)
	///
	/// @desc Sets the transformation of the collision object.
	///
	/// @param {Array<Real>} _matrix The collision object's new transformation
	/// matrix.
	///
	/// @return {Struct.CBulletCollisionObject} Returns `self`.
	static set_transform = function (_matrix)
	{
		gml_pragma("forceinline");
		var _transform = btTransform_create();
		btTransform_setFromMatrix(_transform, _matrix);
		btCollisionObject_setWorldTransform(__ptr, _transform);
		btTransform_destroy(_transform);
		return self;
	};

	/// @func get_transform(_outMatrix)
	///
	/// @desc Retrieves the transformation matrix of the collision object.
	///
	/// @param {Array<Real>} _outMatrix The matrix to store the collision
	/// object's transformation to.
	///
	/// @return {Struct.CBulletCollisionObject} Returns `self`.
	static get_transform = function (_outMatrix)
	{
		gml_pragma("forceinline");
		btCollisionObject_getWorldTransformMatrix(__ptr, _outMatrix);
		return self;
	};

	/// @func is_in_world()
	///
	/// @desc Checks whether the collision object is added in a collision world.
	///
	/// @return {Bool} Returns `true` if the collision object is added into a
	/// collision world, otherwise `false`.
	static is_in_world = function ()
	{
		gml_pragma("forceinline");
		return (__world != undefined);
	};

	/// @func get_world()
	///
	/// @desc Retrieves a collision world that the collision object is added to.
	///
	/// @return {Struct.CBulletCollisionWorld, Undefined} Returns the world
	/// that the collision object is added to or `undefined`.
	static get_world = function ()
	{
		gml_pragma("forceinline");
		return __world;
	};

	static destroy = function ()
	{
		gml_pragma("forceinline");
		if (__world != undefined)
		{
			__world.remove_collision_object(self);
			__world = undefined;
		}
		btCollisionObject_destroy(__ptr);
		__ptr = pointer_null;
		__shape = undefined;
		return undefined;
	};
}
