#[system]
mod spawn {
    use dojo::world::Context;

    use dojo_gameoflife::components::Position;
    use dojo_gameoflife::components::Moves;
    use dojo_gameoflife::constants::OFFSET;

    #[event]
    use dojo_gameoflife::events::{Event, Moved};


    // so we don't go negative

    fn execute(ctx: Context) {
        // cast the offset to a u32
        let offset: u32 = OFFSET.try_into().unwrap();

        set!(
            ctx.world,
            (
                Moves { player: ctx.origin, remaining: 100 },
                Position { player: ctx.origin, x: offset, y: offset },
            )
        );

        emit!(ctx.world, Moved { player: ctx.origin, x: offset, y: offset, });

        return ();
    }
}