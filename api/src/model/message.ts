import {Document, Schema, model} from 'mongoose';
import {messageCollection} from "./constants";

export interface IMessage extends Document{
    text: string;
    phones: string[];
    active: boolean;
}

export interface TORedirectMessage {
    text: string;
    phone: string;
}

export const MessageSchema = new Schema({
    text: {type: String, required: true},
    phones: {type: [String], required: true},
    active: {type: Boolean, required: true}
});

const Message = model<IMessage>(messageCollection, MessageSchema, messageCollection);
export default Message;
