
#[derive(Drop, Copy, Serde, Introspect)]
enum NodeType {
    None,
    Fixed,
    Vec2,
    Vec3,
    Position,
    Add,
    Sub,
    Length
}

impl NodeTypeTrait of NodeTypeTrait{
    fn is_base(self: Node) -> bool {
            let node_type = self.get_type();

            match node_type {
                // base types
                NodeType::None => {
                    true
                },
                NodeType::Fixed => {
                    true
                },
                NodeType::Vec2 => {
                    true
                },
                NodeType::Vec3 => {
                    true
                },
                NodeType::Position => {
                    true
                },
                //operations
                NodeType::Add => {
                    false
                },
                NodeType::Sub => {
                    false
                },
                NodeType::Length => {
                    false
                }
            }

        }
}

impl NodeTypeIntoU8 of Into<NodeType, u8> {
    fn into(self: NodeType) -> u8 {
        match self {
            NodeType::None => 0,
            NodeType::Fixed => 1,
            NodeType::Vec2 => 2,
            NodeType::Vec3 => 3,
            NodeType::Position => 4,
            NodeType::Add => 5,
            NodeType::Sub => 6,
            NodeType::Length => 7
        }
    }
}

