import { Schema, model, Document, Model } from "mongoose";
import { ObjectId } from "mongodb";
import { UserInterface } from "./user";

export interface PostInterface extends Document {
  authorId: String | UserInterface;
  images: String[];
  note: Number;
  description: String;
  comments: String[];
}

export const postSchema = new Schema({
  // authorId: { type: ObjectId, required: true },
  author: {
    type: Schema.Types.ObjectId,
    default: new ObjectId(),
    ref: "user",
  }, // provisional default for the seed
  images: { type: [String], required: true },
  note: { type: Number, default: null }, // maybe an "Note" documents array
  description: { type: String, required: true },
  comments: { type: [Schema.Types.ObjectId], default: [] },
});

const postModel: Model<PostInterface> = model("post", postSchema);
export default postModel;
