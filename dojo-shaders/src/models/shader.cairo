#[derive(Model, Drop, Serde)]
struct Shader {
    #[key]
    owner: felt252,
    color_length: u8,
    position_length: u8
}

#[derive(Model, Drop, Serde)]
struct Manager {
    #[key]
    manager_type: u8,
    #[key]
    index: u8,
    value: felt252
}

#[generate_trait]
impl ManagerImpl of ManagerTrait {
    fn color(index: u8, value: felt252) -> Manager{
        Manager { manager_type: 0, index, value}
    }

    fn position(index: u8, value: felt252) -> Manager {
        Manager {manager_type:1, index, value}
    }
}

