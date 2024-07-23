const router = require("express").Router();
const conn = require("../db/dbConnection");
const { body, validationResult } = require("express-validator");
const admin = require("../middleware/admin");
const fs = require("fs"); // file system
const upload = require("../middleware/uploadImages");
const authorized = require("../middleware/authorize");
const util = require("util"); // helper 

// add to favourite [ADMIN, USER]
router.post( "",authorized, body("monument_id").isNumeric().withMessage("please enter a valid monument ID"),
  
    async (req, res) => {
      try {
        const query = util.promisify(conn.query).bind(conn);
        // 1- VALIDATION REQUEST [manual, express validation]
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
          return res.status(400).json({ errors: errors.array() });
        }
        // 2- CHECK IF monument EXISTS OR NOT
        const monument = await query("select * from monument where id = ?", [
          req.body.monument_id,
        ]);
        if (!monument[0]) {
          return  res.status(404).json({ ms: "monument not found !" });
        }
        // 3 - PREPARE OBJECT
        const favObj = {
          user_id: res.locals.user.id,
          monument_id: monument[0].id,
          isFavourite:1,
        };
        // 4- INSERT  OBJECT INTO DATABASE
        await query("insert into  favourite set ?", favObj);
        delete favObj.user_id;
        res.status(200).json({ms: "moument added to favourite" });
      } catch (err) {
        console.log(err);
        res.status(500).json(err);
      }} );
  

  
 // show all favourite monument for specific user

  router.get(
    "",authorized,
      async (req, res) => {
   
          // CHECK IF keyword  EXISTS in table job
          const USERID=res.locals.user.id;
          const query = util.promisify(conn.query).bind(conn); // transform query mysql --> promise to use [await/async]
          const favourites = await query(
            "select * from  favourite where user_id = ?",USERID );

            if (!favourites[0]) {
                return res.status(420).json({ ms: "no favourites" });
              }
              const x = [];
            let monumentFavourites = [{}];
            for (let index = 0; index < favourites.length; index++) {
              monumentFavourites=await query(
               "select * from  monument where id = ?", favourites[index].monument_id);
               monumentFavourites.map((monumentFavourites) => {
                monumentFavourites.image_url = "http://" + req.hostname + ":3000/" + monumentFavourites.image_url;
              }
              );
               monumentFavourites.forEach((object)=>{
                x.push(object);
              });
             }

             res.status(200).json(x);
      }
    );
    



    // DELETE favourite 
router.delete(
  "/:id", // params
  authorized,
  async (req, res) => {
    try {
      // 1- CHECK IF trip EXISTS OR NOT
      const query = util.promisify(conn.query).bind(conn);
      const fav = await query("select * from favourite where monument_id = ? and user_id=?", [
        req.params.id,res.locals.user.id
      ]);
      if (!fav[0]) {
      return  res.status(422).json({ ms: " this monument isnot in your favourite !" });
      }
    
      // 2- REMOVE fav 
      await query("delete from favourite where id = ?",fav[0].id);
      res.status(200).json({ ms: " monument removed successfully"});
    } catch (err) {
      res.status(500).json(err);
    }
  }
);

  
  module.exports = router ;