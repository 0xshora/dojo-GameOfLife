#[system]
mod cul_map_system {
    use dojo::world::Context;

    use dojo_gameoflife::components::Position;
    use dojo_gameoflife::components::Moves;
    // use dojo_gameoflife::components::MapConfig;
    use dojo_gameoflife::components::{Cell, Newcell};

    use dojo_gameoflife::constants::{HEIGHT, WIDTH};

    use debug::PrintTrait;

    #[event]
    use dojo_gameoflife::events::{Event, Moved};

    // #[derive(Serde, Drop)]
    // enum Direction {
    //     Left: (),
    //     Right: (),
    //     Up: (),
    //     Down: (),
    // }

    // impl DirectionIntoFelt252 of Into<Direction, felt252> {
    //     fn into(self: Direction) -> felt252 {
    //         match self {
    //             Direction::Left(()) => 0,
    //             Direction::Right(()) => 1,
    //             Direction::Up(()) => 2,
    //             Direction::Down(()) => 3,
    //         }
    //     }
    // }

    fn execute(ctx: Context) {
        // let mut mapconfing = get!(ctx.world, ctx.origin, (MapConfig));
        // let (mut position, mut moves) = get!(ctx.world, ctx.origin, (Position, Moves));
        // let next_map = next_map(ctx, mapconfig.width, mapconfig.height, mapconfig.cell);

        // moves.remaining -= 1;
        // let next = next_position(position, direction);
        
        // for debug
        // set!(
        //     ctx.world,
        //     (Cell {x: 1, y: 1, cell: 1},
        //     Cell {x: 2, y: 1, cell: 1},
        //     Cell {x: 3, y: 1, cell: 1},
        //     Cell {x: 1, y: 2, cell: 1},
        //     Cell {x: 1, y: 3, cell: 1},)
        // );

        // cul_newCellMap
        cul_cellMap(ctx);
        
        // copy new_cell to cell
        copy_newCell_to_cell(ctx);
        
        // reset new_cell
        reset_newCell(ctx);
        
        
        // set!(ctx.world, 
        //     MapConfig{
        //         player: ctx.origin,
        //         cell: next_map,
        //     }
        // );

        // set!(ctx.world, (moves, next));
        // emit!(ctx.world, Moved { player: ctx.origin, x: next.x, y: next.y, });
        return ();
    }

    // fn next_map(ctx: Context) {
    //     // let mut new_cell = 0;

    //     // cul_newCellMap
    //     cul_cellMap(ctx);
    //     // copy new_cell to cell
    //     copy_newCell_to_cell(ctx);
    //     // reset new_cell
    //     reset_newCell(ctx);
    // }

    fn cul_cellMap(ctx: Context) {
        let mut y: u32 = 0;
        let mut x: u32 = 0;
        let mut i: u32 = 0; // used for -1
        let mut j: u32 = 0; // used for -1
        let mut i: u32 = 0; // used for -1

        loop {
            if y >= HEIGHT {
                break;
            }
            // 'print y'.print();
            // y.print();
            loop {
                if x >= WIDTH {
                    break;
                }
                // 'print x'.print();
                // x.print();

                let mut liveNeighbors: u32 = 0;
                // let mut neighborIDs = [0, 0, 0];

                loop {
                    if j > 2 {
                        break;
                    }
                    // 'print j'.print();
                    // j.print();
                    loop {
                        if i > 2 {
                            break;
                        }
                        // 'idx'.print();
                        // i.print();
                        // j.print();
                        
                        if (i == 1 && j == 1) {
                            i = i + 1;
                            continue;
                        }
                        if (x == 0 && i == 0) {
                            i = i + 1;
                            continue;
                        }
                        if (y == 0 && j == 0) {
                            i = i + 1;
                            continue;
                        }
                        // 'HERE'.print();
                        let xx = x + i - 1;
                        let yy = y + j - 1;
                        if (xx >= WIDTH) {
                            i = i + 1;
                            continue;
                        }
                        if (yy >= HEIGHT) {
                            i = i + 1;
                            continue;
                        }

                        // neighborIDs = ??
                        let cell = get!(
                            ctx.world,
                            (xx, yy),
                            (Cell)
                        );
                        if (cell.cell == 0) {
                            i = i + 1;
                            continue;
                        } else {
                            // 'cell.cell == 1'.print();
                            // liveNeighbors.print();
                            liveNeighbors = liveNeighbors + 1;
                            i = i + 1;
                        };
                        // if (liveNeighbors < 3) {
                        //     // set!(
                        //     //     ctx.world,
                        //     //     Cell{x: x, y: y, cell: 1} // cell value should be ID of player...
                        //     // );
                        //     // 'liveNeighbors < 3'.print();
                        //     // pass
                        //     i = i + 1;
                        //     liveNeighbors += 1;
                        //     continue;
                        // }
                        // liveNeighbors += 1;
                        // i = i + 1;
                    };
                    i = 0;
                    j = j + 1;
                };

                let cell = get!(
                    ctx.world,
                    (x, y),
                    (Cell)
                );

                let cellValue = cell.cell;

                if (cellValue == 0) {
                    if (liveNeighbors == 3) {
                        // let dominantId = 1;
                        // new_cell[y * width + x] = 1; // ID
                        set!(
                            ctx.world,
                            Newcell{x: x, y: y, newcell: 1}
                        );
                    }
                    // else {
                    //     'cv is 0 and ln not 3'.print();
                    //     x.print();
                    //     y.print();
                    //     liveNeighbors.print();
                    // }
                } else {
                    if (liveNeighbors < 2 || liveNeighbors > 3) {
                        // // new_cell[y * width + x] = 0;
                        // 'liveNeighbors not 2 or 3'.print();
                        // x.print();
                        // y.print();
                        set!(
                            ctx.world,
                            Newcell{x: x, y: y, newcell: 0}
                        );
                    } else {
                        // 'liveNeighbors is 2 or 3'.print();
                        // x.print();
                        // y.print();
                        set!(
                            ctx.world,
                            Newcell{x: x, y: y, newcell: 1}
                        );
                        // new_cell[y * width + x] = 1;
                    }
                }
                j = 0;
                x = x + 1;
                // break;
            };
            x = 0;
            y = y + 1;
            // break;
        };
    }

    fn copy_newCell_to_cell(ctx: Context) {
        let mut x = 0;
        let mut y = 0;

        loop {
            if y >= HEIGHT {
                break;
            }
            loop {
                if x >= WIDTH {
                    break;
                }

                let newCell = get!(
                    ctx.world,
                    (x, y),
                    (Newcell)
                );
                let newCellValue = newCell.newcell;

                set!(
                    ctx.world,
                    Cell{x: x, y: y, cell: newCellValue}
                );

                x += 1;
            };
            x = 0;
            y += 1;
        };
    }

    fn reset_newCell(ctx: Context) {
        let mut x = 0;
        let mut y = 0;

        loop {
            if y >= HEIGHT {
                break;
            }
            // 'print y'.print();
            // y.print();
            loop {
                if x >= WIDTH {
                    break;
                }
                // 'print x'.print();
                // x.print();

                set!(
                    ctx.world,
                    Newcell{x: x, y: y, newcell: 0}
                );
                x += 1;
            };
            x = 0;
            y += 1;
        };
    }

    // fn next_position(mut position: Position, direction: Direction) -> Position {
    //     match direction {
    //         Direction::Left(()) => {
    //             position.x -= 1;
    //         },
    //         Direction::Right(()) => {
    //             position.x += 1;
    //         },
    //         Direction::Up(()) => {
    //             position.y -= 1;
    //         },
    //         Direction::Down(()) => {
    //             position.y += 1;
    //         },
    //     };

    //     position
    // }
}

