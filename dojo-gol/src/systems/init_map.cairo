#[system]
mod init_map_system {
    use dojo::world::Context;

    use dojo_gameoflife::components::Position;
    use dojo_gameoflife::components::Moves;
    use dojo_gameoflife::constants::{OFFSET, WIDTH, HEIGHT};
    use dojo_gameoflife::components::Cell;

    #[event]
    use dojo_gameoflife::events::{Event, Moved};


    // so we don't go negative

    fn execute(ctx: Context) {
        // cast the offset to a u32
        // let offset: u32 = OFFSET.try_into().unwrap();
        set!(
            ctx.world,
            (
                Cell { x: 0, y: 0, cell: 0 },
                // no need for now
                // MapConfig { player: ctx.origin, width: WIDTH, height: HEIGHT, cell: 0},
            )
        );

        // emit!(ctx.world, Moved { player: ctx.origin, x: offset, y: offset, });
        return ();
    }
}