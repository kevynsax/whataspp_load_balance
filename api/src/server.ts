import {Server as BaseServer} from '@overnightjs/core';
import * as bodyParser from "body-parser";
import {controllers} from "./controllers";
import {Logger} from "@overnightjs/logger";

export default class Server extends BaseServer{
    constructor() {
        super(true);

        this.app.use(bodyParser.json());
        this.app.use(bodyParser.urlencoded({extended: true}));
        this.setupControllers();
    }

    private setupControllers(): void{
        const ctrlInstances = controllers.map(x => new x());
        super.addControllers(ctrlInstances);
    }

    public start(port: number): void{
        const message = `Server is online on port: ${port}`;

        this.app.get('*', (req, res) => res.send(message));
        this.app.listen(port, () => Logger.Info(message));
    }
}
