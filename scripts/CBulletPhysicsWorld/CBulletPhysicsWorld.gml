/// @func CBulletPhysicsWorld()
///
/// @extends CBulletCollisionWorld
///
/// @desc A Bullet physics world.
function CBulletPhysicsWorld()
	: CBulletCollisionWorld() constructor
{
	static BulletCollisionWorld_destroy = destroy;

	/// @var {Pointer}
	/// @private
	__constraintSolver = pointer_null;

	/// @var {Id.DsList<Struct.CBulletRigidBody>}
	/// @private
	__rigidBodies = ds_list_create();

	/// @var {Id.DsList<Struct.CBulletVehicle>}
	/// @private
	__vehicles = ds_list_create();

	/// @func create()
	///
	/// @desc Creates the Bullet physics collision world. Must be called first
	/// before using other methods!
	///
	/// @return {Struct.CBulletCollisionWorld} Returns `self`.
	static create = function ()
	{
		gml_pragma("forceinline");
		bbmod_assert(__ptr == pointer_null, "Method create can be called only once!");
		__collisionConfiguration = btDefaultCollisionConfiguration_create();
		__dispatcher = btCollisionDispatcher_create(__collisionConfiguration);
		__pairCache = btDbvtBroadphase_create();
		__constraintSolver = btSequentialImpulseConstraintSolver_create();
		__ptr = btDiscreteDynamicsWorld_create(
			__dispatcher, __pairCache, __constraintSolver, __collisionConfiguration);
		__create_debug_draw();
		set_gravity(new BBMOD_Vec3(0, 0, -9.8));
		return self;
	};

	/// @func update(_deltaTime)
	///
	/// @desc Updates the physics world.
	///
	/// @param {Real} _deltaTime How much time has passed since the last frame
	/// (in microseconds).
	///
	/// @return {Struct.CBulletPhysicsWorld} Returns `self`.
	static update = function (_deltaTime)
	{
		gml_pragma("forceinline");
		btDiscreteDynamicsWorld_stepSimulation(__ptr, _deltaTime / 1_000_000);
		return self;
	};

	/// @func set_gravity(_gravity)
	///
	/// @desc Sets gravity of the physics world.
	///
	/// @param {Struct.BBMOD_Vec3} _gravity The new gravity.
	///
	/// @return {Struct.CBulletCollisionWorld} Returns `self`.
	static set_gravity = function (_gravity)
	{
		gml_pragma("forceinline");
		btDiscreteDynamicsWorld_setGravityXYZ(__ptr, _gravity.X, _gravity.Y, _gravity.Z);
		return self;
	};

	/// @func get_gravity()
	///
	/// @desc Retrieves the gravity of the physics world.
	///
	/// @return {Struct.BBMOD_Vec3} The gravity of the physics world.
	static get_gravity = function ()
	{
		gml_pragma("forceinline");
		var _temp = btVector3_create();
		btDiscreteDynamicsWorld_getGravity(__ptr, _temp);
		var _gravity = new BBMOD_Vec3(
			btVector3_getX(_temp),
			btVector3_getY(_temp),
			btVector3_getZ(_temp));
		btVector3_destroy(_temp);
		return _gravity;
	};

	/// @func create_rigid_body()
	///
	/// @desc Creates a new rigid body.
	///
	/// @param {Struct.CBulletCollisionShape} _shape The collision shape of
	/// of the rigid body.
	/// @param {Real} _mass The mass of the rigid body. If 0 then the rigid body
	/// is static.
	/// @param {Struct.BBMOD_Vec3} [_localInertia] The local inertia of the
	/// rigid body. If not specified and mass isn't equal to 0, then it is
	/// computed using {@link CBulletCollisionShape.get_local_inertia}.
	///
	/// @return {Struct.CBulletRigidBody} The created rigid body.
	static create_rigid_body = function (_shape, _mass, _localInertia=undefined)
	{
		gml_pragma("forceinline");
		return (new CBulletRigidBody()).create(_shape, _mass, _localInertia);
	};

	/// @func add_rigid_body(_rigidBody[, _group[, _mask]])
	///
	/// @desc Adds a rigid body to this physics world.
	///
	/// @param {Struct.CBulletRigidBody} _rigidBody The rigid body to be
	/// added to this physics world.
	/// @param {Real} [_group] The collision filter group. Defaults to 1.
	/// @param {Real} [_mask] The collision filter mask. Defaults to -1.
	///
	/// @return {Struct.CBulletPhysicsWorld} Returns `self`.
	static add_rigid_body = function (_rigidBody, _group=1, _mask=-1)
	{
		gml_pragma("forceinline");
		bbmod_assert(_rigidBody.__world == undefined, "The rigid body is already added to a physics world!");
		btDiscreteDynamicsWorld_addRigidBody(__ptr, _rigidBody.__ptr, _group, _mask);
		ds_list_add(__rigidBodies, _rigidBody);
		__objectMap[? _rigidBody.__ptr] = _rigidBody;
		_rigidBody.__world = self;
		return self;
	};

	/// @func get_rigid_bodies()
	///
	/// @desc Retrieves a read-only list of rigid bodies added to this physics
	/// world.
	///
	/// @return {Id.DsList<Struct.CBulletRigidBody>} The list of rigid
	/// bodies added to this physics world.
	static get_rigid_bodies = function ()
	{
		gml_pragma("forceinline");
		return __rigidBodies;
	};

	/// @func has_rigid_body(_rigidBody)
	///
	/// @desc Checks whether given rigid body is added to this physics world.
	///
	/// @param {Struct.CBulletRigidBody} _rigidBody The rigid body to
	/// check.
	///
	/// @return {Bool} Returns `true` if the rigid body is added to this
	/// physics world.
	static has_rigid_body = function (_rigidBody)
	{
		gml_pragma("forceinline");
		return (_rigidBody.__world == self);
	};

	/// @func remove_rigid_body(_rigidBody)
	///
	/// @desc Removes a rigid body from the physics world.
	///
	/// @param {Struct.CBulletRigidBody} _rigidBody The rigid body to be
	/// removed from the physics world.
	///
	/// @return {Struct.CBulletPhysicsWorld} Returns `self`.
	static remove_rigid_body = function (_rigidBody)
	{
		gml_pragma("forceinline");
		bbmod_assert(_rigidBody.__world == self, "The rigid body is not added to this physics world!");
		btDiscreteDynamicsWorld_removeRigidBody(__ptr, _rigidBody.__ptr);
		ds_list_delete(__rigidBodies, ds_list_find_index(__rigidBodies, _rigidBody));
		ds_map_delete(__objectMap, _rigidBody.__ptr);
		return self;
	};

	/// @func create_vehicle_tuning()
	///
	/// @desc Creates a vehicle tuning.
	///
	/// @return {Struct.CBulletVehicleTuning} The created vehicle tuning.
	static create_vehicle_tuning = function (_shape, _tuning)
	{
		gml_pragma("forceinline");
		return (new CBulletVehicleTuning()).create();
	};

	/// @func create_vehicle(_rigidBody, _tuning)
	///
	/// @desc Creates a vehicle.
	///
	/// @param {Struct.CBulletRigidBody} _rigidBody The vehicle's rigid
	/// body.
	/// @param {Struct.CBulletVehicleTuning} _tuning The vehicle's
	/// tuning.
	///
	/// @return {Struct.CBulletVehicle} The created vehicle.
	static create_vehicle = function (_rigidBody, _tuning)
	{
		gml_pragma("forceinline");
		return (new CBulletVehicle()).create(_rigidBody, _tuning, self);
	};

	/// @func add_vehicle(_vehicle)
	///
	/// @desc Adds a vehicle to the physics world.
	///
	/// @param {Struct.CBulletVehicle} _vehicle The vehicle to add to the
	/// physics world.
	///
	/// @return {Struct.CBulletPhysicsWorld} Returns `self`.
	static add_vehicle = function (_vehicle)
	{
		gml_pragma("forceinline");
		bbmod_assert(_vehicle.__world == undefined, "The vehicle is already added to a physics world!");
		btDiscreteDynamicsWorld_addAction(__ptr, _vehicle.__ptr);
		ds_list_add(__vehicles, _vehicle);
		_vehicle.__world = self;
		return self;
	};

	/// @func get_vehicles()
	///
	/// @desc Retrieves a read-only list of vehicles added to this physics
	/// world.
	///
	/// @return {Id.DsList<Struct.CBulletVehicle>} The list of vehicles
	/// added to this physics world.
	static get_vehicles = function ()
	{
		gml_pragma("forceinline");
		return __vehicles;
	};

	/// @func has_vehicle(_vehicle)
	///
	/// @desc Checks whether given vehicle is added to this physics world.
	///
	/// @param {Struct.CBulletVehicle} _vehicle The vehicle to check.
	///
	/// @return {Bool} Returns `true` if the vehicle is added to this
	/// physics world.
	static has_vehicle = function (_vehicle)
	{
		gml_pragma("forceinline");
		return (_vehicle.__world == self);
	};

	/// @func remove_vehicle(_vehicle)
	///
	/// @desc Removes a vehicle from the physics world.
	///
	/// @param {Struct.CBulletVehicle} _vehicle The vehicle to be removed
	/// from the physics world.
	///
	/// @return {Struct.CBulletPhysicsWorld} Returns `self`.
	static remove_vehicle = function (_vehicle)
	{
		gml_pragma("forceinline");
		bbmod_assert(_vehicle.__world == self, "The vehicle is not added to this physics world!");
		btDiscreteDynamicsWorld_removeAction(__ptr, _vehicle.__ptr);
		ds_list_delete(__vehicles, ds_list_find_index(__vehicles, _vehicle));
		return self;
	};

	/// @func clear_forces()
	///
	/// @desc Clears all forces applied to all rigid bodies.
	///
	/// @return {Struct.CBulletPhysicsWorld} Returns `self`.
	static clear_forces = function ()
	{
		gml_pragma("forceinline");
		btDiscreteDynamicsWorld_clearForces(__ptr);
		return self;
	};

	/// @func apply_gravity()
	///
	/// @desc Applies gravity to all rigid bodies.
	///
	/// @return {Struct.CBulletPhysicsWorld} Returns `self`.
	static apply_gravity = function ()
	{
		gml_pragma("forceinline");
		btDiscreteDynamicsWorld_applyGravity(__ptr);
		return self;
	};

	static destroy = function ()
	{
		gml_pragma("forceinline");

		for (var i = ds_list_size(__rigidBodies) - 1; i >= 0; --i)
		{
			__rigidBodies[| i].destroy();
		}
		ds_list_destroy(__rigidBodies);

		for (var i = ds_list_size(__vehicles) - 1; i >= 0; --i)
		{
			__vehicles[| i].destroy();
		}
		ds_list_destroy(__vehicles);

		BulletCollisionWorld_destroy();
		btSequentialImpulseConstraintSolver_destroy(__constraintSolver);

		return undefined;
	};
}
