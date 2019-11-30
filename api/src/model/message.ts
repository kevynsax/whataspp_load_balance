import {Document, Schema, model, connect} from 'mongoose';
import {connectionString, messageCollection} from "./constants";
import {Logger} from "@overnightjs/logger";

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
