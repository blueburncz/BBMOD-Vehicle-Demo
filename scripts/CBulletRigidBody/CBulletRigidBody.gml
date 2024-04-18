/// @func CBulletRigidBody()
///
/// @extends CBulletCollisionObject
///
/// @desc A Bullet physics rigid body.
function CBulletRigidBody()
	: CBulletCollisionObject() constructor
{
	static BulletCollisionObject_destroy = destroy;

	/// @var {Pointer}
	/// @private
	__motionState = pointer_null;

	/// @func create(_shape, _mass[, _localInertia])
	///
	/// @desc Creates the rigid body. Must be called first before using other
	/// methods!
	///
	/// @param {Struct.CBulletCollisionShape} _shape The collision shape of
	/// of the rigid body.
	/// @param {Real} _mass The mass of the rigid body. If 0 then the rigid body
	/// is static.
	/// @param {Struct.BBMOD_Vec3} [_localInertia] The local inertia of the
	/// rigid body. If not specified and mass isn't equal to 0, then it is
	/// computed using {@link CBulletCollisionShape.get_local_inertia}.
	///
	/// @return {Struct.CBulletRigidBody} Returns `self`.
	static create = function (_shape, _mass, _localInertia=undefined)
	{
		gml_pragma("forceinline");
		bbmod_assert(__ptr == pointer_null, "Method create can be called only once!");
		__motionState = btDefaultMotionState_create();
		var _temp = btVector3_create(0, 0, 0);
		if (_localInertia != undefined)
		{
			btVector3_setValue(_temp, _localInertia.X, _localInertia.Y, _localInertia.Z);
		}
		else if (_mass != 0)
		{
			_localInertia = _shape.get_local_inertia(_mass);
			btVector3_setValue(_temp, _localInertia.X, _localInertia.Y, _localInertia.Z);
		}
		__ptr = btRigidBody_create(_mass, __motionState, _shape.__ptr, _temp);
		btVector3_destroy(_temp);
		__shape = _shape;
		return self;
	};

	/// @func set_gravity(_gravity)
	///
	/// @desc Sets gravity for the rigid body.
	///
	/// @param {Struct.BBMOD_Vec3} _gravity The new gravity for the rigid body.
	///
	/// @return {Struct.CBulletRigidBody} Returns `self`.
	static set_gravity = function (_gravity)
	{
		gml_pragma("forceinline");
		btRigidBody_setGravityXYZ(__ptr, _gravity.X, _gravity.Y, _gravity.Z);
		return self;
	};

	/// @func get_gravity()
	///
	/// @desc Retrieves gravity applied to the rigid body.
	///
	/// @return {Struct.BBMOD_Vec3} The gravity applied to the rigid body.
	static get_gravity = function ()
	{
		gml_pragma("forceinline");
		var _temp = btVector3_create();
		btRigidBody_getGravity(__ptr, _temp);
		var _gravity = new BBMOD_Vec3(
			btVector3_getX(_temp),
			btVector3_getY(_temp),
			btVector3_getZ(_temp));
		btVector3_destroy(_temp);
		return _gravity;
	};

	/// @func apply_gravity()
	///
	/// @desc Applies gravity to the rigid body.
	///
	/// @return {Struct.CBulletRigidBody} Returns `self`.
	static apply_gravity = function ()
	{
		gml_pragma("forceinline");
		btRigidBody_applyGravity(__ptr);
		return self;
	};

	/// @func clear_gravity()
	///
	/// @desc Clears gravity force applied to the rigid body.
	///
	/// @return {Struct.CBulletRigidBody} Returns `self`.
	static clear_gravity = function ()
	{
		gml_pragma("forceinline");
		btRigidBody_clearGravity(__ptr);
		return self;
	};

	/// @func set_linear_damping(_damping)
	///
	/// @desc Sets linear damping for the rigid body.
	///
	/// @param {Real} _damping The new linear damping factor.
	///
	/// @return {Struct.CBulletRigidBody} Returns `self`.
	static set_linear_damping = function (_damping)
	{
		gml_pragma("forceinline");
		btRigidBody_setDamping(__ptr, _damping, btRigidBody_getAngularDamping(__ptr));
		return self;
	};

	/// @func get_linear_damping()
	///
	/// @desc Retrieves the rigid body's linear damping factor.
	///
	/// @return {Real} The rigid body's linear damping factor.
	static get_linear_damping = function ()
	{
		gml_pragma("forceinline");
		return btRigidBody_getLinearDamping(__ptr);
	};

	/// @func set_angular_damping(_damping)
	///
	/// @desc Sets angular damping for the rigid body.
	///
	/// @param {Real} _damping The new angular damping factor.
	///
	/// @return {Struct.CBulletRigidBody} Returns `self`.
	static set_angular_damping = function (_damping)
	{
		gml_pragma("forceinline");
		btRigidBody_setDamping(__ptr, btRigidBody_getLinearDamping(__ptr), _damping);
		return self;
	};

	/// @func get_angular_damping()
	///
	/// @desc Retrieves the rigid body's angular damping factor.
	///
	/// @return {Real} The rigid body's angular damping factor.
	static get_angular_damping = function ()
	{
		gml_pragma("forceinline");
		return btRigidBody_getAngularDamping(__ptr);
	};

	/// @func apply_damping(_deltaTime)
	///
	/// @desc Applies damping to the rigid body for given delta time.
	///
	/// @param {Real} _deltaTime How much time has passed since the last frame
	/// (in microseconds).
	///
	/// @return {Struct.CBulletRigidBody} Returns `self`.
	static apply_damping = function (_deltaTime)
	{
		gml_pragma("forceinline");
		btRigidBody_applyDamping(__ptr, _deltaTime / 1_000_000);
		return self;
	};

	/// @func set_mass(_mass)
	///
	/// @desc Sets the mass of the rigid body.
	///
	/// @param {Real} _mass The new mass of the rigid body.
	///
	/// @return {Struct.CBulletRigidBody} Returns `self`.
	static set_mass = function (_mass)
	{
		gml_pragma("forceinline");
		var _temp = btVector3_create();
		btRigidBody_getLocalInertia(__ptr, _temp);
		btRigidBody_setMassProps(__ptr, _mass, _temp);
		btVector3_destroy(_temp);
		return self;
	};

	/// @func get_mass()
	///
	/// @desc Retrieves the mass of the rigid body.
	///
	/// @return {Real} The mass of the rigid body.
	static get_mass = function ()
	{
		gml_pragma("forceinline");
		return btRigidBody_getMass(__ptr);
	};

	/// @func set_local_inertia(_localInertia}
	///
	/// @desc Sets the local inertia of the rigid body.
	///
	/// @param {Struct.BBMOD_Vec3} _localInertia The new local inertia.
	///
	/// @return {Struct.CBulletRigidBody} Returns `self`.
	static set_local_inertia = function (_localInertia)
	{
		gml_pragma("forceinline");
		btRigidBody_setMassPropsXYZ(__ptr, btRigidBody_getMass(__ptr), _localInertia.X, _localInertia.Y, _localInertia.Z);
		return self;
	};

	/// @func get_local_inertia()
	///
	/// @desc Retrieves the local inertia of the rigid body.
	///
	/// @return {Struct.BBMOD_Vec3} The local inertia of the rigid body.
	static get_local_inertia = function ()
	{
		gml_pragma("forceinline");
		var _temp = btVector3_create();
		btRigidBody_getLocalInertia(__ptr, _temp);
		var _localInertia = new BBMOD_Vec3(
			btVector3_getX(_temp),
			btVector3_getY(_temp),
			btVector3_getZ(_temp));
		btVector3_destroy(_temp);
		return _localInertia;
	};

	/// @func set_linear_factor(_linearFactor)
	///
	/// @desc Sets the linear factor of the rigid body.
	///
	/// @param {Struct.BBMOD_Vec3} _linearFactor The new linear factor.
	///
	/// @return {Struct.CBulletRigidBody} Returns `self`.
	static set_linear_factor = function (_linearFactor)
	{
		gml_pragma("forceinline");
		var _temp = btVector3_create(_linearFactor.X, _linearFactor.Y, _linearFactor.Z);
		btRigidBody_setLinearFactor(__ptr, _temp);
		btVector3_destroy(_temp);
		return self;
	};

	/// @func get_linear_factor()
	///
	/// @desc Retrieves the linear factor of the rigid body.
	///
	/// @return {Struct.BBMOD_Vec3} The linear factor of the rigid body.
	static get_linear_factor = function ()
	{
		gml_pragma("forceinline");
		var _temp = btVector3_create();
		btRigidBody_getLinearFactor(__ptr, _temp);
		var _linearFactor = new BBMOD_Vec3(
			btVector3_getX(_temp),
			btVector3_getY(_temp),
			btVector3_getZ(_temp));
		btVector3_destroy(_temp);
		return _linearFactor;
	};

	/// @func set_angular_factor(_angularFactor)
	///
	/// @desc Sets the angular factor of the rigid body
	///
	/// @param {Struct.BBMOD_Vec3} _angularFactor The new angular factor.
	///
	/// @return {Struct.CBulletRigidBody} Returns `self`.
	static set_angular_factor = function (_angularFactor)
	{
		gml_pragma("forceinline");
		var _temp = btVector3_create(_angularFactor.X, _angularFactor.Y, _angularFactor.Z);
		btRigidBody_setAngularFactor(__ptr, _temp);
		btVector3_destroy(_temp);
		return self;
	};

	/// @func get_angular_factor()
	///
	/// @desc Retrieves the angular factor of the rigid body.
	///
	/// @return {Real} The angular factor of the rigid body.
	static get_angular_factor = function ()
	{
		gml_pragma("forceinline");
		var _temp = btVector3_create();
		btRigidBody_getAngularFactor(__ptr, _temp);
		var _angularFactor = new BBMOD_Vec3(
			btVector3_getX(_temp),
			btVector3_getY(_temp),
			btVector3_getZ(_temp));
		btVector3_destroy(_temp);
		return _angularFactor;
	};

	/// @func get_position()
	///
	/// @desc Retrieves the position of the rigid body.
	///
	/// @return {Struct.BBMOD_Vec3} The position of the rigid body.
	static get_position = function ()
	{
		gml_pragma("forceinline");
		var _temp = btVector3_create();
		btRigidBody_getCenterOfMassPosition(__ptr, _temp);
		var _centerOfMass = new BBMOD_Vec3(
			btVector3_getX(_temp),
			btVector3_getY(_temp),
			btVector3_getZ(_temp));
		btVector3_destroy(_temp);
		return _centerOfMass;
	};

	/// @func get_rotation()
	///
	/// @desc Retrieves the rotation of the rigid body.
	///
	/// @return {Struct.BBMOD_Quaternion} The rotation of the rigid body.
	static get_rotation = function ()
	{
		gml_pragma("forceinline");
		var _temp = btQuaternion_create();
		btRigidBody_getOrientation(__ptr, _temp);
		var _orientation = new BBMOD_Quaternion(
			btQuaternion_getX(_temp),
			btQuaternion_getY(_temp),
			btQuaternion_getZ(_temp),
			btQuaternion_getW(_temp));
		btQuaternion_destroy(_temp);
		return _orientation;
	};

	/// @func apply_central_force()
	///
	/// @desc Applies a force to the rigid body at its center.
	///
	/// @param {Struct.BBMOD_Vec3} _force The force to apply.
	///
	/// @return {Struct.CBulletRigidBody} Returns `self`.
	static apply_central_force = function (_force)
	{
		gml_pragma("forceinline");
		btRigidBody_applyCentralForceXYZ(__ptr, _force.X, _force.Y, _force.Z);
		return self;
	};

	/// @func get_total_force()
	///
	/// @desc Retrieves the total force applied to the rigid body.
	///
	/// @return {Struct.BBMOD_Vec3} The total force applied to the rigid body.
	static get_total_force = function ()
	{
		gml_pragma("forceinline");
		var _temp = btVector3_create();
		btRigidBody_getTotalForce(__ptr, _temp);
		var _totalForce = new BBMOD_Vec3(
			btVector3_getX(_temp),
			btVector3_getY(_temp),
			btVector3_getZ(_temp));
		btVector3_destroy(_temp);
		return _totalForce;
	};

	/// @func get_total_torque()
	///
	/// @desc Retrieves the total torque applied to the rigid body.
	///
	/// @return {Struct.BBMOD_Vec3} The total torque applied to the rigid body.
	static get_total_torque = function ()
	{
		gml_pragma("forceinline");
		var _temp = btVector3_create();
		btRigidBody_getTotalTorque(__ptr, _temp);
		var _totalTorque = new BBMOD_Vec3(
			btVector3_getX(_temp),
			btVector3_getY(_temp),
			btVector3_getZ(_temp));
		btVector3_destroy(_temp);
		return _totalTorque;
	};

	/// @func apply_torque(_torque)
	///
	/// @desc Applies a torque to the rigid body.
	///
	/// @param {Struct.BBMOD_Vec3} _torque The torque to apply.
	///
	/// @return {Struct.CBulletRigidBody} Returns `self`.
	static apply_torque = function (_torque)
	{
		gml_pragma("forceinline");
		var _temp = btVector3_create(_torque.X, _torque.Y, _torque.Z);
		btRigidBody_applyTorque(__ptr, _temp);
		btVector3_destroy(_temp);
		return self;
	};

	/// @func apply_force(_force, _relPos)
	///
	/// @desc Applies a force to the rigid body at a relative position.
	///
	/// @param {Struct.BBMOD_Vec3} _force The force to apply.
	/// @param {Struct.BBMOD_Vec3} _relPos A position relative to the rigid body.
	///
	/// @return {Struct.CBulletRigidBody} Returns `self`.
	static apply_force = function (_force, _relPos)
	{
		gml_pragma("forceinline");
		btRigidBody_applyForceXYZ(__ptr, _force.X, _force.Y, _force.Z, _relPos.X, _relPos.Y, _relPos.Z);
		return self;
	};

	/// @func apply_central_impulse(_impulse)
	///
	/// @desc Applies an impulse to the rigid body at its center.
	///
	/// @param {Struct.BBMOD_Vec3} _impulse The impulse to apply.
	///
	/// @return {Struct.CBulletRigidBody} Returns `self`.
	static apply_central_impulse = function (_impulse)
	{
		gml_pragma("forceinline");
		btRigidBody_applyCentralImpulseXYZ(__ptr, _impulse.X, _impulse.Y, _impulse.Z);
		return self;
	};

	/// @func apply_torque_impulse(_torque)
	///
	/// @desc Applies a torque impulse to the rigid body.
	///
	/// @param {Struct.BBMOD_Vec3} _torque The torque impulse to apply.
	///
	/// @return {Struct.CBulletRigidBody} Returns `self`.
	static apply_torque_impulse = function (_torque)
	{
		gml_pragma("forceinline");
		btRigidBody_applyTorqueImpulseXYZ(__ptr, _torque.X, _torque.Y, _torque.Z);
		return self;
	};

	/// @func apply_impulse(_impulse, _relPos)
	///
	/// @desc Applies an impulse to the rigid body at a relative position.
	///
	/// @param {Struct.BBMOD_Vec3} _impulse The impulse to apply.
	/// @param {Struct.BBMOD_Vec3} _relPos A position relative to the rigid body.
	///
	/// @return {Struct.CBulletRigidBody} Returns `self`.
	static apply_impulse = function (_impulse, _relPos)
	{
		gml_pragma("forceinline");
		btRigidBody_applyImpulseXYZ(__ptr, _impulse.X, _impulse.Y, _impulse.Z, _relPos.X, _relPos.Y, _relPos.Z);
		return self;
	};

	/// @func apply_push_impulse(_impulse, _relPos)
	///
	/// @desc Applies a push impulse to the rigid body at a relative position.
	///
	/// @param {Struct.BBMOD_Vec3} _impulse The impulse to apply.
	/// @param {Struct.BBMOD_Vec3} _relPos A position relative to the rigid body.
	///
	/// @return {Struct.CBulletRigidBody} Returns `self`.
	static apply_push_impulse = function (_impulse, _relPos)
	{
		gml_pragma("forceinline");
		btRigidBody_applyPushImpulseXYZ(__ptr, _impulse.X, _impulse.Y, _impulse.Z, _relPos.X, _relPos.Y, _relPos.Z);
		return self;
	};

	/// @func set_push_velocity(_velocity)
	///
	/// @desc Sets the push velocity of the rigid body.
	///
	/// @param {Struct.BBMOD_Vec3} _velocity The new push velocity.
	///
	/// @return {Struct.CBulletRigidBody} Returns `self`.
	static set_push_velocity = function (_velocity)
	{
		gml_pragma("forceinline");
		btRigidBody_setPushVelocityXYZ(__ptr, _velocity.X, _velocity.Y, _velocity.Z);
		return self;
	};

	/// @func get_push_velocity()
	///
	/// @desc Retrieves the push velocity of the rigid body.
	///
	/// @return {Struct.BBMOD_Vec3} The push velocity of the rigid body.
	static get_push_velocity = function ()
	{
		gml_pragma("forceinline");
		var _temp = btVector3_create();
		btRigidBody_getPushVelocity(__ptr, _temp);
		var _pushVelocity = new BBMOD_Vec3(
			btVector3_getX(_temp),
			btVector3_getY(_temp),
			btVector3_getZ(_temp));
		btVector3_destroy(_temp);
		return _pushVelocity;
	};

	/// @func set_turn_velocity(_velocity)
	///
	/// @desc Sets the turn velocity of the rigid body.
	///
	/// @param {Struct.BBMOD_Vec3} _velocity The new turn velocity.
	///
	/// @return {Struct.CBulletRigidBody} Returns `self`.
	static set_turn_velocity = function (_velocity)
	{
		gml_pragma("forceinline");
		btRigidBody_setTurnVelocityXYZ(__ptr, _velocity.X, _velocity.Y, _velocity.Z);
		return self;
	};

	/// @func get_turn_velocity()
	///
	/// @desc Retrieves the turn velocity of the rigid body.
	///
	/// @return {Struct.BBMOD_Vec3} The turn velocity of the rigid body.
	static get_turn_velocity = function ()
	{
		gml_pragma("forceinline");
		var _temp = btVector3_create();
		btRigidBody_getTurnVelocity(__ptr, _temp);
		var _turnVelocity = new BBMOD_Vec3(
			btVector3_getX(_temp),
			btVector3_getY(_temp),
			btVector3_getZ(_temp));
		btVector3_destroy(_temp);
		return _turnVelocity;
	};

	/// @func apply_central_push_impulse(_impulse)
	///
	/// @desc Applies an impulse to the rigid body at its center.
	///
	/// @param {Struct.BBMOD_Vec3} _impulse The impulse to apply.
	///
	/// @return {Struct.CBulletRigidBody} Returns `self`.
	static apply_central_push_impulse = function (_impulse)
	{
		gml_pragma("forceinline");
		btRigidBody_applyCentralPushImpulseXYZ(__ptr, _impulse.X, _impulse.Y, _impulse.Z);
		return self;
	};

	/// @func apply_torque_turn_impulse(_torque)
	///
	/// @desc Applies a torque turn impulse to the rigid body.
	///
	/// @param {Struct.BBMOD_Vec3} _torque The torque turn impulse to apply.
	///
	/// @return {Struct.CBulletRigidBody} Returns `self`.
	static apply_torque_turn_impulse = function (_torque)
	{
		gml_pragma("forceinline");
		btRigidBody_applyTorqueTurnImpulseXYZ(__ptr, _torque.X, _torque.Y, _torque.Z);
		return self;
	};

	/// @func clear_forces()
	///
	/// @desc Clears all forces applied to the rigid body.
	///
	/// @return {Struct.CBulletRigidBody} Returns `self`.
	static clear_forces = function ()
	{
		gml_pragma("forceinline");
		btRigidBody_clearForces(__ptr);
		return self;
	};

	/// @func set_linear_velocity(_velocity)
	///
	/// @desc Sets the linear velocity of the rigid body.
	///
	/// @param {Struct.BBMOD_Vec3} _velocity The new linear velocity.
	///
	/// @return {Struct.CBulletRigidBody} Returns `self`.
	static set_linear_velocity = function (_velocity)
	{
		gml_pragma("forceinline");
		btRigidBody_setLinearVelocityXYZ(__ptr, _velocity.X, _velocity.Y, _velocity.Z);
		return self;
	};

	/// @func get_linear_velocity()
	///
	/// @desc Retrieves the linear velocity of the rigid body.
	///
	/// @return {Struct.BBMOD_Vec3} The linear velocity of the rigid body.
	static get_linear_velocity = function ()
	{
		gml_pragma("forceinline");
		var _temp = btVector3_create();
		btRigidBody_getLinearVelocity(__ptr, _temp);
		var _linearVelocity = new BBMOD_Vec3(
			btVector3_getX(_temp),
			btVector3_getY(_temp),
			btVector3_getZ(_temp));
		btVector3_destroy(_temp);
		return _linearVelocity;
	};

	/// @func set_angular_velocity(_velocity)
	///
	/// @desc Sets the angular velocity of the rigid body.
	///
	/// @param {Struct.BBMOD_Vec3} _velocity The new angular velocity.
	///
	/// @return {Struct.CBulletRigidBody} Returns `self`.
	static set_angular_velocity = function (_velocity)
	{
		gml_pragma("forceinline");
		btRigidBody_setAngularVelocityXYZ(__ptr, _velocity.X, _velocity.Y, _velocity.Z);
		return self;
	};

	/// @func get_angular_velocity()
	///
	/// @desc Retrieves the angular velocity of the rigid body.
	///
	/// @return {Struct.BBMOD_Vec3} The angular velocity of the rigid body.
	static get_angular_velocity = function ()
	{
		gml_pragma("forceinline");
		var _temp = btVector3_create();
		btRigidBody_getAngularVelocity(__ptr, _temp);
		var _angularVelocity = new BBMOD_Vec3(
			btVector3_getX(_temp),
			btVector3_getY(_temp),
			btVector3_getZ(_temp));
		btVector3_destroy(_temp);
		return _angularVelocity;
	};

	/// @func translate(_vector)
	///
	/// @desc Translates the rigid body by the vector.
	///
	/// @param {Struct.BBMOD_Vec3} _vector The vector to translate the rigid
	/// body by.
	///
	/// @return {Struct.CBulletRigidBody} Returns `self`.
	static translate = function (_vector)
	{
		gml_pragma("forceinline");
		btRigidBody_translateXYZ(__ptr, _vector.X, _vector.Y, _vector.Z);
		return self;
	};

	/// @func get_aabb(_transform, _outMin, _outMax)
	///
	/// @desc Retrieves an axis-aligned bounding box (AABB) of the rigid body.
	///
	/// @param {Struct.BBMOD_Vec3} _outMin A vector to store the AABB's minimum
	/// coordinate to.
	/// @param {Struct.BBMOD_Vec3} _outMax A vector to store the AABB's maximum
	/// coordinate to.
	///
	/// @return {Struct.CBulletRigidBody} Returns `self`.
	static get_aabb = function (_outMin, _outMax)
	{
		gml_pragma("forceinline");
		var _tempMin = btVector3_create();
		var _tempMax = btVector3_create();
		btRigidBody_getAabb(__ptr, _tempMin, _tempMax);
		_outMin.Set(
			btVector3_getX(_tempMin),
			btVector3_getY(_tempMin),
			btVector3_getZ(_tempMin));
		_outMax.Set(
			btVector3_getX(_tempMax),
			btVector3_getY(_tempMax),
			btVector3_getZ(_tempMax));
		btVector3_destroy(_tempMin);
		btVector3_destroy(_tempMax);
		return self;
	};

	static destroy = function ()
	{
		gml_pragma("forceinline");
		if (__world != undefined)
		{
			__world.remove_rigid_body(self);
			__world = undefined;
		}
		BulletCollisionObject_destroy();
		btDefaultMotionState_destroy(__motionState);
		return undefined;
	};
}
