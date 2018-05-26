import "phoenix_html";

import { Game } from "elm/Game";

document.addEventListener("DOMContentLoaded", () => {
  const node = document.getElementById("gameapp");
  if (!node) return;

  const websocket = `wss://${window.location.host}/socket/websocket`;
  const gameid = node.dataset.gameid;
  if (!gameid) return;

  Game.embed(node, {
    gameid,
    websocket
  });
});
