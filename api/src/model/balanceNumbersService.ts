import {IMessage} from "./message";
import {Logger} from "@overnightjs/logger";

interface RedirectData {
    idMessage: string;
    phone: string;
}

export class BalanceNumbersService {
    private static redirects: RedirectData[] = [];

    public static getNextPhone(msg: IMessage): string{
        const allRedirects: RedirectData[] = this.redirects.filter(x => x.idMessage.toString() == msg._id.toString());

         if(msg.phones.every(x => allRedirects.some(z => z.phone === x)))
             this.clearRedirects(msg);

        const phone = msg.phones.find(x => !allRedirects.some(z => z.phone === x)) || msg.phones[0];

        this.insertRedirect(msg, phone);

        return phone;
    }

    private static clearRedirects(msg: IMessage): void{
        this.redirects = this.redirects.filter(x => x.idMessage.toString() !== msg._id.toString());
    }

    private static insertRedirect(msg: IMessage, phone: string): void{
        this.redirects = [...this.redirects, {idMessage: msg._id, phone}];
    }
}
