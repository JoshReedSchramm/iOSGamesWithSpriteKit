typedef NS_OPTIONS(uint32_t, CollisionCategory) {
    CategoryBall   = 1 << 0,
    CategoryBumper = 1 << 1,
    CategoryTarget = 1 << 2,
};