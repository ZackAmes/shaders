use cubit::f64::types::{
    fixed::{Fixed, FixedTrait, ONE},
    vec2::{Vec2, Vec2Trait},
    vec3::{Vec3, Vec3Trait}
};

use dojo_shaders::tsl::types::{
    args::{Args, ArgsTrait, ArgsType},
    node_type::{NodeType},
    float::{Float, FloatTrait}
};

#[derive(Model, Drop,Copy, Serde)]
struct Node {
    #[key]
    id: u32,
    node_type: u8,
    args: Args
}

#[generate_trait]
impl NodeImpl of NodeTrait {
    fn fixed(id: u32, value: Fixed) -> Node {
        let node_type: u8 = NodeType::Fixed.into();
        let args = ArgsTrait::fixed(value);
        Node { id, node_type, args}
    }

    fn add(id: u32, args_type: ArgsType, a:u32, b:u32) -> Node{
        let node_type: u8 = NodeType::Add.into();
        let args = ArgsTrait::two_ids(args_type, a, b);
        Node {id, node_type, args}
    }

    fn get_type(self: Node) -> NodeType {
        let t = self.node_type;
        if(t == 1) {return NodeType::Fixed;};
        if(t == 2) {return NodeType::Vec2;};
        if(t == 3) {return NodeType::Vec3;};
        if(t == 4) {return NodeType::Position;};
        if(t == 5) {return NodeType::Add;};
        if(t == 6) {return NodeType::Sub;};
        if(t == 7) {return NodeType::Length;};
        NodeType::None    
    }

    
}
