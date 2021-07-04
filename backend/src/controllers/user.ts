import { NextFunction, Request, Response } from "express";
import User from "../../models/user";

module.exports = {
  getUserById: async ({ params: { userId } }: Request, res: Response) => {
    try {
      const user = await User.findById(userId);
      res.json(user);
      console.log(user);
    } catch (error) {
      console.log(error);
    }
  },
  getUsersByName: async ({ params: { filter } }: Request, res: Response) => {
    try {
      console.log(filter);
      const filteredUsers = await User.find({
        name: { $regex: filter, $options: "i" },
      });
      console.log(filteredUsers);
    } catch (error) {
      console.log(error);
    }
  },
};
