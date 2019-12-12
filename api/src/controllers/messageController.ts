import {Controller, Delete, Get, Post, Put} from "@overnightjs/core";
import {Request, Response} from 'express';
import {Logger} from "@overnightjs/logger";
import {App} from "../model/app";

@Controller('api/message')
export class MessageController {
    private readonly app = new App();

    @Get(':id')
    private redirect(req: Request, res: Response){
        Logger.Info(`Request - Redirect for id: ${req.params.id}`);

        this.app.getUrlWhatsApp(req.params.id)
            .then(url => res.redirect(url, 301));
    }

    @Get('')
    private listAllMessages(req: Request, res: Response){
        Logger.Info('Request - List all Messages');

        this.responseFactory(res, this.app.getMessages);
    }

    @Post('')
    private saveNewMessage(req: Request, res: Response){
        Logger.Info('Inserting new Message');

        this.responseFactory(res, () => this.app.saveMessage(req.body));
    }

    @Put(':id')
    private updateMessage(req: Request, res: Response){
        Logger.Info(`Updating message: ${req.params.id}`);

        this.responseFactory(res, () => this.app.updateMessage(req.params.id, req.body));
    }

    @Delete(':id')
    private deleteMessage(req: Request, res: Response){
        Logger.Info(`Request to delete message: ${req.params.id}`);

        this.responseFactory(res, () => this.app.deleteMessage(req.params.id));
    }

    private responseFactory = <T>(res: Response, callback: () => Promise<T>): void => {
        callback()
            .then(x => res.send(x))
            .catch(err => {
                Logger.Err(err);
                res.status(501).send(err);
            });
    }
}
