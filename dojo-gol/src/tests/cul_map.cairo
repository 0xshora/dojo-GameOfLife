#[cfg(test)]
mod tests {
    use dojo::world::{IWorldDispatcherTrait, IWorldDispatcher};
    use dojo::test_utils::spawn_test_world;

    use debug::PrintTrait;

    use dojo_gameoflife::components::{cell, Cell};
    use dojo_gameoflife::components::{newcell, Newcell};

    use dojo_gameoflife::systems::init_map_system;
    use dojo_gameoflife::systems::cul_map_system;

    use dojo_gameoflife::constants::{HEIGHT, WIDTH};

    // #[event]
    // use dojo_gameoflife::events::{Updated};

    fn setup_world() -> IWorldDispatcher {
        // let mut componetns = array![];
        let mut components = array::ArrayTrait::new();
        components.append(cell::TEST_CLASS_HASH);
        components.append(newcell::TEST_CLASS_HASH);

        // let mut systems = array![];
        let mut systems = array::ArrayTrait::new();
        systems.append(init_map_system::TEST_CLASS_HASH);
        systems.append(cul_map_system::TEST_CLASS_HASH);

        let world = spawn_test_world(components, systems);

        // init??
        let mut init_call_data = array::ArrayTrait::new();
        world.execute('init_map_system'.into(), init_call_data);
        world
    }

    #[test]
    #[available_gas(3000000000000000)]
    fn test_cul_cellMap() {
        let world = setup_world();

        'done setup'.print();

        // set!(world,
        //     Cell{x: 1, y:1, cell: 1}
        // );

        // set!(world,
        //     Newcell{x:1, y:1, newcell: 0}
        // );

        'set is done!'.print();

        let mut map_call_data = array::ArrayTrait::new();
        world.execute('cul_map_system'.into(), map_call_data);

        // if we set...
        // set!(
        //     ctx.world,
        //     (Cell {x: 1, y: 1, cell: 1},
        //     Cell {x: 2, y: 1, cell: 1},
        //     Cell {x: 3, y: 1, cell: 1},
        //     Cell {x: 1, y: 2, cell: 1},
        //     Cell {x: 1, y: 3, cell: 1},)
        // );


        let cell_1_1 = get!(
            world,
            (1, 1),
            (Cell)
        );

        let cell_0_2 = get!(
            world,
            (0, 2),
            (Cell)
        );

        let cell_2_0 = get!(
            world,
            (0, 2),
            (Cell)
        );

        cell_1_1.cell.print();
        cell_0_2.cell.print();
        cell_2_0.cell.print();
        
        if cell_1_1.cell == 1 {
            'Correct for cell'.print();
        } else {
            'Wrong for cell'.print();
        }
        if cell_0_2.cell == 1 {
            'Correct for cell(0,2)'.print();
        } else {
            'Wrong for cell(0,2)'.print();
        }
        if cell_2_0.cell == 1 {
            'Correct for cell(2,0)'.print();
        } else {
            'Wrong for cell(2,0)'.print();
        }
        

        let newcell_1 = get!(
            world,
            (1, 1),
            (Newcell)
        );

        if newcell_1.newcell == 0 {
            'Correct'.print();
        } else {
            'Wrong'.print();
        }
    }

    #[test]
    #[available_gas(3000000000000000)]
    fn test_reset_newCell() {
        let world = setup_world();

        // set!(world,
        //     Newcell{x:1, y:1, newcell: 1}
        // );
        let mut map_call_data = array::ArrayTrait::new();
        world.execute('cul_map_system'.into(), map_call_data);
    }

}