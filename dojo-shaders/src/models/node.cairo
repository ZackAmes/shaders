use cubit::types::fixed::{Fixed, FixedTrait, ONE_u128};
use cubit::types::vec3::{Vec3, Vec3Trait};
use cubit::types::vec2::{Vec2, Vec2Trait};

#[derive(Model, Drop, Serde)]
struct Node {
    #[key]
    id: u32,
   // value: NodeValue
   value: u8
}


#[derive(Drop, Introspect, Serde)]
enum NodeValue {
    add: (u32, u32),
    sub: (u32, u32),
    length: u32,
    vec3: Vec3,
    vec2: Vec2,
    float: Fixed

}