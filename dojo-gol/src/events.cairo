use starknet::ContractAddress;

#[derive(Drop, Clone, Serde, PartialEq, starknet::Event)]
struct Moved {
    player: ContractAddress,
    x: u32,
    y: u32
}

#[derive(Drop, Clone, Serde, PartialEq, starknet::Event)]
enum Event {
    Moved: Moved
}

// #[derive(Drop, Clone, Serde, PartialEq, starknet::Event)]
// struct Updated {
//     player: ContractAddress,
//     x: u32,
//     y: u32,
//     cell: u32
// }

// #[derive(Drop, Clone, Serde, PartialEq, starknet::Event)]
// struct MapConfig {
//     player: ContractAddress,
//     x: u32,
//     y: u32,
//     cell: u256
// }