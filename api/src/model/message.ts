import {connect, Document, Schema, model} from 'mongoose';
import {connectionString, messageCollection} from "./constants";
import {Logger} from "@overnightjs/logger";

connect(connectionString, (err: any) => {
    if(err){
        Logger.Err('Error connecting to Mongo Db');
        return;
    }

    Logger.Info('Successfully Connected to Mongo Db');
});

export interface IMessage extends Document{
    text: string;
    phones: string[];
    active: boolean;
}

export const MessageSchema = new Schema({
    text: {type: String, required: true},
    phones: {type: [String], required: true},
    active: {type: Boolean, required: true}
});

const Message = model<IMessage>(messageCollection, MessageSchema, messageCollection);
export default Message;
