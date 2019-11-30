import {Controller, Get, Post, Put} from "@overnightjs/core";
import {Request, Response} from 'express';
import {Logger} from "@overnightjs/logger";
import {App} from "../model/app";

type apiEndpoint = (res: Response) => void;

@Controller('api/message')
export class MessageController {
    private readonly app = new App();

    @Get(':id')
    private redirect(req: Request, res: Response){
        Logger.Info(`Request - Redirect for id: ${req.params.id}`);

        this.responseFactory(() => this.app.getMessage(req.params.id))(res);
    }

    @Get('')
    private listAllMessages(req: Request, res: Response){
        Logger.Info('Request - List all Messages');

        this.responseFactory(this.app.getMessages)(res);
    }

    @Post('')
    private saveNewMessage(req: Request, res: Response){
        Logger.Info('Inserting new Message');

        this.responseFactory(() => this.app.saveMessage(req.body))(res);
    }

    @Put(':id')
    private updateMessage(req: Request, res: Response){
        Logger.Info(`Updating message: ${req.params.id}`);

        this.responseFactory(() => this.app.updateMessage(req.params.id, req.body))(res);
    }

    private responseFactory = <T>(callback: () => Promise<T>): apiEndpoint =>
        (res) =>
            callback()
                .then(x => res.send(x))
                .catch(err => res.status(501).send(err));
}
