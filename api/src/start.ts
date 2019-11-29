import Server from "./server";

const server = new Server();
const port = parseInt(process.env.PORT || "3000", 10);

server.start(port);
