declare module "elm/Test" {
  interface Ports {
    render: Elm.Port<(board: Board) => void>;
  }

  export const Test: Elm.App<Ports, { websocket: string }>;
}

declare module "elm/Game" {
  interface Ports {
    render: Elm.Port<(raw: { content: GameState }) => void>;
  }

  export const Game: Elm.App<Ports, { websocket: string; gameid: string }>;
}

declare namespace Elm {
  export interface Port<T> {
    subscribe(callback: T): void;
  }

  export interface Program<T> {
    ports: T;
  }

  export interface App<T, Options> {
    fullscreen(options?: Options): Program<T>;
    embed(node: Element, options?: Options): Program<T>;
  }
}

type Point = [number, number];

type Food = Point;

interface Snake {
  taunt?: any;
  name: string;
  id: string;
  healthPoints: number;
  headType: string;
  tailType: string;
  coords: Point[];
  color: string;
  death: string;
}

interface GameState {
  board: Board;
}

interface Board {
  deadSnakes: any[];
  food: Food[];
  gameId: string;
  height: number;
  id: string;
  snakes: Snake[];
  turn: number;
  width: number;
}
