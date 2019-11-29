import {Controller, Get} from "@overnightjs/core";
import {Request, Response} from 'express';
import {Logger} from "@overnightjs/logger";


@Controller('api/message')
export class MessageController {

    @Get(':id')
    private redirect(req: Request, res: Response){
        Logger.Info(`Redirect for id: ${req.params.id}`);
        res.redirect("https://www.google.com",301)
    }
}
