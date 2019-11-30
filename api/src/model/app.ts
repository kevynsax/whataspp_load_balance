import Message, {IMessage} from "./message";

export class App {
    public getMessages = (): Promise<IMessage[]> =>
        this.repoToPromise(c => Message.find(c));

    public getMessage = (id: string): Promise<IMessage> =>
        this.repoToPromise(callback => Message.findById(id, callback));

    public saveMessage = (msg: IMessage): Promise<IMessage> =>
        this.repoToPromise(callback => Message.insertMany([msg], (err, res) => callback(err, res[0])));

    public updateMessage = (id: string, msg: IMessage) =>
        this.repoToPromise(callback => Message.updateOne({"_id": id}, msg, (err, _) => callback(err, msg)));

    private repoToPromise = <T>(call: (callback: (err: any, res: T) => void) => void): Promise<T> =>
        new Promise<T>((resolve, reject) => call((err, res) => {
            if(err){
                reject(err);
                return;
            }

            resolve(res);
        }));
}
