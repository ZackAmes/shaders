use cubit::f64::types::{vec2::{Vec2, Vec2Trait}, fixed::{Fixed, FixedTrait}};

mod shapes {

    use dojo_shaders::models::node::{Node, Float};

    fn circle(p: Vec2, r: Fixed) -> Node{

        Node::Sub ( Node.Length(p), Node.Float(r));

    }
}
