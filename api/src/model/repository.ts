import Message, {IMessage} from "./message";

class Repository {
    public GetMessages = (): Promise<IMessage[]> =>
        this.ToPromise(c => Message.find(c));

    public GetMessage = (id: string): Promise<IMessage> =>
        this.ToPromise(callback => Message.findById(id, callback));

    public SaveMessage = (msg: IMessage): Promise<IMessage> =>
        this.ToPromise(callback => Message.insertMany([msg], (err, res) => callback(err, res[0])));

    public UpdateMessage = (id: string, msg: IMessage) =>
        this.ToPromise(callback => Message.updateOne({"_id": id}, msg, (err, _) => callback(err, msg)));

    private ToPromise = <T>(call: (callback: (err: any, res: T) => void) => void): Promise<T> =>
        new Promise<T>((resolve, reject) => call((err, res) => {
            if(err){
                reject(err);
                return;
            }

            resolve(res);
        }));
}

export default Repository;
