import Message, {IMessage, TORedirectMessage} from "./message";
import {BalanceNumbersService} from "./balanceNumbersService";
import {urlWhats} from "./constants";

export class App {
    public getMessages = (): Promise<IMessage[]> =>
        this.repoToPromise(c => Message.find(c));

    public getUrlWhatsApp = (id: string): Promise<string> =>
        this.repoToPromise<IMessage>(callback => Message.findById(id, callback))
            .then(this.balanceBetweenPhoneNumbers)
            .then(x => urlWhats(x.text, x.phone));

    public saveMessage = (msg: IMessage): Promise<IMessage> =>
        this.repoToPromise(callback => Message.insertMany([msg], (err, res) => callback(err, res[0])));

    public updateMessage = (id: string, msg: IMessage) =>
        this.repoToPromise(callback => Message.updateOne({"_id": id}, msg, (err, _) => callback(err, msg)));

    private balanceBetweenPhoneNumbers = (msg: IMessage): TORedirectMessage => ({
        text: msg.text,
        phone: BalanceNumbersService.getNextPhone(msg)
    });

    private repoToPromise = <T>(call: (callback: (err: any, res: T) => void) => void): Promise<T> =>
        new Promise<T>((resolve, reject) => call((err, res) => {
            if(err){
                reject(err);
                return;
            }

            resolve(res);
        }));
}
