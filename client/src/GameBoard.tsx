import { useEffect, useState } from "react";
import { useComponentValue } from "@latticexyz/react";
// import { useMUD } from "./MUDContext";
import { useDojo } from './DojoContext';

import { Direction, } from './dojo/createSystemCalls'
// import { hexToArray } from "@latticexyz/utils";
import { EntityIndex, setComponent } from '@latticexyz/recs';
import { getFirstComponentByType } from './utils';
// import { world } from "./mud/world";
import { Pause, Play, Power, PlayCircle } from "lucide-react";
import { HEIGHT, WIDTH } from "./constants";

function getCellColor(cell: number | undefined): string {
  const _cell = Number(cell);
  if (cell === undefined || _cell === 0) return "bg-white/10";

  const _quotient: number = _cell % 10;
  switch (_quotient) {
    case 0:
      return "bg-gray-600";
    case 1:
      return "bg-blue-600";
    case 2:
      return "bg-green-600";
    case 3:
      return "bg-yellow-600";
    case 4:
      return "bg-red-600";
    case 5:
      return "bg-purple-600";
    case 6:
      return "bg-pink-600";
    case 7:
      return "bg-sky-600";
    case 8:
      return "bg-amber-600";
    case 9:
      return "bg-teal-600";
    default:
      return "bg-gray-600";
  }
}

// 16進数の文字列をバイト配列に変換する
function hexToBytes(hex: any) {
  let bytes = [];
  for (let c = 0; c < hex.length; c += 2)
      bytes.push(parseInt(hex.substr(c, 2), 16));
  return bytes;
}

export const GameBoard = () => {
  const {
    setup: {
        systemCalls: { spawn, move },
        components: { Moves, Position, MapConfig },
        network: { graphSdk, call }
      },
      account: { create, list, select, account, isDeploying }
    } = useDojo();

    // entity id - this example uses the account address as the entity id
  const entityId = account.address;

  // get current component values
  const position = useComponentValue(Position, parseInt(entityId.toString()) as EntityIndex);
  const moves = useComponentValue(Moves, parseInt(entityId.toString()) as EntityIndex);
  // const mapconfig = useComponentValue(MapConfig, parseInt(entityId.toString()) as EntityIndex);

  useEffect(() => {

    if (!entityId) return;

    const fetchData = async () => {
      const { data } = await graphSdk.getEntities();

      if (data) {
        const remaining = getFirstComponentByType(data.entities?.edges, 'Moves') as Moves;
        const position = getFirstComponentByType(data.entities?.edges, 'Position') as Position;
        // const mapconfig = getFirstComponentByType(data.entities?.edges, 'MapConfig') as MapConfig;

        setComponent(Moves, parseInt(entityId.toString()) as EntityIndex, { remaining: remaining.remaining })
        setComponent(Position, parseInt(entityId.toString()) as EntityIndex, { x: position.x, y: position.y })
        // setComponent(MapConfig, parseInt(entityId.toString()) as EntityIndex, { width: mapconfig.width, height: mapconfig.height })
      }
    }
    fetchData();
  }, [account.address]);

  // const height = 45; // HEIGHT;
  // const width = 60; // WIDTH;

  // 一時的に0で初期化
  let cellData: number[] = new Array(WIDTH * HEIGHT).fill(0);

  const cellValues = Array.from(cellData).map((value, index) => {
    return {
      x: index % WIDTH,
      y: Math.floor(index / WIDTH),
      value,
    };
  });

  const rows = new Array(HEIGHT).fill(0).map((_, i) => i);
  const columns = new Array(WIDTH).fill(0).map((_, i) => i);


  return (
    <>
      <div className="flex justify-center pt-2 pb-4 font-dot text-xl">
        <div className="mr-8">
          Cycle: 0
          {/* Cycle: {BigInt(calculatedCount?.value ?? 0).toLocaleString()} */}
        </div>
        <div className="">
          {/* Cells: {BigInt(activeCells).toLocaleString()} */}
          Cells: 10
        </div>
      </div>

      {entityId ? (
        <>
          <div className="flex justify-center">
            <div className="grid gap-1">
              {rows.map((y) =>
                columns.map((x) => {
                  const cell = cellValues.find(
                    (t) => t.x === x && t.y === y
                  )?.value;
                  return (
                    <div
                      key={`${x},${y}`}
                      style={{
                        gridColumn: x + 1,
                        gridRow: y + 1,
                      }}
                      onClick={async (event) => {
                        console.log("click");
                      }}
                    >
                      <div 
                        className={`h-2.5 w-2.5 ${getCellColor(0) ?? ""}`}
                      />
                    </div>
                  );
                })
              )}
            </div>
          </div>
          {entityId && (
            <>
              <div className="flex justify-center py-4 font-dot items-center">
                <div
                  className={`mr-1.5 h-2.5 w-2.5 ${getCellColor(1
                    // Number(userId)
                  )}`}
                />
                {/* <div className="mr-8">Player Id: {entityId}</div> */}
                <div className="mr-8">Player Id: {1}</div>
                <div className="mr-12">Stamina: {moves ? `${moves['remaining']}` : 'Need to Spawn'}</div>
                <button
                  type="button"
                  className="text-white border-gray-200 hover:bg-gray-200/5 border-2 px-4 py-1.5 text-center mr-4 rounded-sm"
                  onClick={() => {console.log("pass")}}
                >
                  Stop / Pass
                </button>
                <button
                  type="button"
                  className="text-white border-gray-200 hover:bg-gray-200/5 border-2 px-4 py-1.5 text-center mr-4 rounded-sm"
                  onClick={() => {console.log("clear")}}
                >
                  <div className="flex items-center text-amber-600">
                    <Power size={18} className="mr-1" />
                    Reset
                  </div>
                </button>
              </div>
            </>
          )}
        </>
      ) : (
        <div className="flex justify-center">
          <button
            type="button"
            className="text-white border-gray-200 hover:bg-gray-200/5 border-4 px-8 py-3 text-center rounded-sm mt-32 text-2xl font-dot"
            onClick={()=>{console.log("join")}}
          >
            <div className="flex items-center">
              <PlayCircle size={26} className="mr-4" />
              Start Playing
            </div>
          </button>
        </div>
      )}
    </>
  );
};