#[system]
mod add_system {
    use dojo::world::Context;

    use dojo_gameoflife::components::Position;
    use dojo_gameoflife::components::Moves;
    // use dojo_gameoflife::components::MapConfig;
    use dojo_gameoflife::components::{Cell, Newcell};

    use dojo_gameoflife::constants::{HEIGHT, WIDTH};

    use debug::PrintTrait;

    #[event]
    use dojo_gameoflife::events::{Event, Moved};

    fn execute(ctx: Context, x: u32, y: u32) {
        let mut cell = get!(
            ctx.world,
            (x, y),
            (Cell)
        );
        if (cell.cell != 0) {
            'cell is occupied'.print();
            return;
        }
        set!(
            ctx.world,
            (Cell{x: x, y: y, cell: 1})
        );

        return();
    }
}
