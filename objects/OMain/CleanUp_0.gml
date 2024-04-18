renderer = renderer.destroy();
postProcessor = postProcessor.destroy();
physicsWorld = physicsWorld.destroy();
terrainShape = terrainShape.destroy();
dirtEmitter = dirtEmitter.destroy();
bbmod_light_punctual_remove(jeepLight1);
bbmod_light_punctual_remove(jeepLight2);
bbmod_lens_flare_clear();
bbmod_reflection_probe_clear();
