#[cfg(test)]
mod tests {
    use dojo::world::{IWorldDispatcherTrait, IWorldDispatcher};
    use dojo::test_utils::spawn_test_world;

    use debug::PrintTrait;

    use dojo_gameoflife::components::{cell, Cell};
    use dojo_gameoflife::components::{newcell, Newcell};

    use dojo_gameoflife::systems::init_map_system;
    use dojo_gameoflife::systems::cul_map_system;
    use dojo_gameoflife::systems::add_system;

    use dojo_gameoflife::constants::{HEIGHT, WIDTH};

    fn setup_world() -> IWorldDispatcher {
        // let mut componetns = array![];
        let mut components = array::ArrayTrait::new();
        components.append(cell::TEST_CLASS_HASH);
        components.append(newcell::TEST_CLASS_HASH);

        // let mut systems = array![];
        let mut systems = array::ArrayTrait::new();
        systems.append(init_map_system::TEST_CLASS_HASH);
        systems.append(cul_map_system::TEST_CLASS_HASH);
        systems.append(add_system::TEST_CLASS_HASH);

        let world = spawn_test_world(components, systems);

        // init??
        let mut init_call_data = array::ArrayTrait::new();
        world.execute('init_map_system'.into(), init_call_data);
        world
    }

    #[test]
    #[available_gas(3000000000000000)]
    fn test_add() {
        let world = setup_world();
        'add test'.print();

        let mut map_call_data = array::ArrayTrait::new();
        map_call_data.append(0); // x
        map_call_data.append(0); // y
        world.execute('add_system'.into(), map_call_data);

        let cell_0_0 = get!(
            world,
            (0, 0),
            (Cell)
        );
        if cell_0_0.cell == 1 {
            'add test success'.print();
        } else {
            'add test failed'.print();
        }
    }
}