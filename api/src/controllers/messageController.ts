import {Controller, Get, Post, Put} from "@overnightjs/core";
import {Request, Response} from 'express';
import {Logger} from "@overnightjs/logger";
import Repository from "../model/repository";

type apiEndpoint = (res: Response) => void;

@Controller('api/message')
export class MessageController {
    private readonly repo = new Repository();

    @Get(':id')
    private redirect(req: Request, res: Response){
        Logger.Info(`Request - Redirect for id: ${req.params.id}`);

        this.responseFactory(() => this.repo.GetMessage(req.params.id))(res);
    }

    @Get('')
    private listAllMessages(req: Request, res: Response){
        Logger.Info('Request - List all Messages');

        this.responseFactory(this.repo.GetMessages)(res);
    }

    @Post('')
    private saveNewMessage(req: Request, res: Response){
        Logger.Info('Inserting new Message');

        this.responseFactory(() => this.repo.SaveMessage(req.body))(res);
    }

    @Put(':id')
    private updateMessage(req: Request, res: Response){
        Logger.Info(`Updating message: ${req.params.id}`);

        this.responseFactory(() => this.repo.UpdateMessage(req.params.id, req.body))(res);
    }

    private responseFactory = <T>(callback: () => Promise<T>): apiEndpoint =>
        (res) =>
            callback()
                .then(x => res.send(x))
                .catch(err => res.status(501).send(err));
}
