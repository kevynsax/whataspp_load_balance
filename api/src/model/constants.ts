export const urlWhats = (text: string, number: string): string =>
    `https://api.whatsapp.com/send?phone=${number}&text=${text}`;

export const connectionString: string = process.env.DATABASE_URL || "mongodb://127.0.0.1:27017/whatsapp_load_balance";

export const messageCollection: string = "message";
