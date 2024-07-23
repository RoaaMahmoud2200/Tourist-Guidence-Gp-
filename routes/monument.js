const router = require("express").Router();
const conn = require("../db/dbConnection");
const { body, validationResult } = require("express-validator");
const admin = require("../middleware/admin");
const fs = require("fs"); // file system
const upload = require("../middleware/uploadImages");
const authorized = require("../middleware/authorize");
const util = require("util"); // helper 
// CREATE monument [ADMIN]
router.post(
    "", admin,
    upload.single("image_url"),
     body("name")
      .isString()
      .withMessage("please enter a valid monument name"),
  
    body("description")
      .isString()
      .withMessage(" description should be string  ")
      .isLength({ min: 10 })
      .withMessage("description should be at lease 20 characters"),

      body("location")
      .isString()
      .withMessage("location should be string  ")
      .isLength({ min: 5 })
      .withMessage("location  should be at lease 5 characters"),

      body("weather")
      .isString()
      .withMessage("please enter a valid weather "),

      body("historical_period")
      .isString()
      .withMessage("please enter a valid historical_period "),
      
      body("instructions")
      .isString()
      .withMessage("please enter a valid instructions "),

      body("availability")
      .isString()
      .withMessage("please enter a valid availability	 ")
      .isLength({ min: 2})
      .withMessage("availability  should be at lease 2 characters"),


    async (req, res) => {
      try {
        // 1- VALIDATION REQUEST [manual, express validation]
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
          return res.status(400).json({ errors: errors.array() });
        }
     
      // 2- VALIDATE THE IMAGE
      if (!req.file) {
        return res.status(409).json({ms: "Image is Required",});
      }
        // 3- PREPARE monument object
        const monumentObject = {
          name: req.body.name,
          description: req.body.description,
          location: req.body.location,
          weather :req.body.weather,
          historical_period :req.body.historical_period,
          instructions :req.body.instructions,
          availability :req.body.availability,
          image_url: req.file.filename,

        };
   
        // 4 - INSERT monument INTO DB
        const query = util.promisify(conn.query).bind(conn);
        await query("insert into monument set ? ",  monumentObject);
        res.status(200).json({
          ms: " monument created successfully !",
        });
      } catch (err) {
        res.status(500).json(err);
      }
    }
  );
  
  //-------------------------------------------------------
  // UPDATE monument [ADMIN]
router.put(
    "/:id", // params
    admin,upload.single("image_url"),
    body("name")
      .isString()
      .withMessage("please enter a valid monument name"),
  
    body("description")
      .isString()
      .withMessage(" description should be string  ")
      .isLength({ min: 10 })
      .withMessage("description should be at lease 20 characters"),

      body("location")
      .isString()
      .withMessage("location should be string  ")
      .isLength({ min: 5 })
      .withMessage("location  should be at lease 5 characters"),

      body("weather")
      .isString()
      .withMessage("please enter a valid weather "),

      body("historical_period")
      .isString()
      .withMessage("please enter a valid historical_period "),
      
      body("instructions")
      .isString()
      .withMessage("please enter a valid instructions "),

      body("availability")
      .isString()
      .withMessage("please enter a valid availability	 ")
      .isLength({ min: 2})
      .withMessage("availability  should be at lease 2 characters"),
    

    async (req, res) => {
      try {
        // 1- VALIDATION REQUEST [manual, express validation]
        const query = util.promisify(conn.query).bind(conn);
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
          return res.status(400).json({ errors: errors.array() });
        }
   
        // 3- CHECK IF monument EXISTS OR NOT
        
        const monument = await query("select * from monument where id = ?", [
          req.params.id,
        ]);
        if (!monument[0]) {
          return res.status(404).json({ ms: "monument not found !" });
        }
  
        // 4- PREPARE monument OBJECT
        const monumentObject = {
          name: req.body.name,
          description: req.body.description,
          location: req.body.location,
          weather :req.body.weather,
          historical_period :req.body.historical_period,
          instructions :req.body.instructions,
          availability :req.body.availability,

        };
        if (req.file) {
          monumentObject.image_url = req.file.filename;
          fs.unlinkSync("./upload/" + monument[0].image_url); // delete old image
        }
  
        // 4- UPDATE monument
        await query("update monument set ? where id = ?", [monumentObject, monument[0].id]);
  
        res.status(200).json({
          ms: "monument  updated successfully",
        });
      } catch (err) {
        res.status(500).json(err);
      }
    }
  );
//-------------------------------------------------------
  // DELETE monument [ADMIN]
router.delete(
    "/:id", // params
    admin,
    async (req, res) => {
      try {
        // 1- CHECK IF monument EXISTS OR NOT
        const query = util.promisify(conn.query).bind(conn);
        const monument = await query("select * from monument where id = ?", [
          req.params.id,
        ]);
        if (!monument[0]) {
        return  res.status(404).json({ ms: "monument not found !" });
        }
        // 2- REMOVE monument image
        fs.unlinkSync("./upload/" + monument[0].image_url); // delete old image
         // 3- REMOVE monument 
        await query("delete from monument where id = ?", [monument[0].id]);
        res.status(200).json({
          ms: "monument delete successfully",
        });
      } catch (err) {
        res.status(500).json(err);
      }
    }
  );
//-------------------------------------------------------
  // show all captured mounment [ADMIN, USER]
  
router.get("/scanedMonument", authorized,async (req, res) => {
    const query = util.promisify(conn.query).bind(conn);
    const scanedMonument = await query(`select * from scaned_monument where user_id=?`,res.locals.user.id);
    
    scanedMonument.map((scanedMonument) => {
      scanedMonument.image_url = "http://" + req.hostname + ":3000/" + scanedMonument.image_url;
    }
    );
    //show if favourite or not 
      let monumentFavourites = [];
            for (let index = 0; index < scanedMonument.length; index++) {
              let isfav=0 ;
             const isFavQuery = await query(`select * from favourite where monument_id =?`,scanedMonument[index].id);
             if(isFavQuery[0]){
               isfav=1;}
               monumentFavourites.push(isfav);
             }
             const mixedMonument=[]
             let x={ }
             for (let  index = 0; index < scanedMonument.length; index++) {
              delete scanedMonument[index].user_id;
              x={scanedMonument:scanedMonument[index],isFav:monumentFavourites[index]}
              mixedMonument.push(x) ;
             
            }
    res.status(200).json(mixedMonument);
  });
//-------------------------------------------------------
  // LIST  [ADMIN, USER]
  
  router.get("",authorized, async (req, res) => {
    const query = util.promisify(conn.query).bind(conn);
    const monument = await query(`select * from monument`);
    monument.map((monument) => {
      monument.image_url = "http://" + req.hostname + ":3000/" + monument.image_url;
    }
    );
    //show if favourite or not 
      let monumentFavourites = [];
            for (let index = 0; index < monument.length; index++) {
              let isfav=0 ;
             const isFavQuery = await query(`select * from favourite where monument_id =? and user_id=?`,[monument[index].id,res.locals.user.id]);
             if(isFavQuery[0]){
               isfav=1;}
               monumentFavourites.push(isfav);
             }
             const mixedMonument=[]
             let x={ }
             for (let  index = 0; index < monument.length; index++) {
              x={monument:monument[index],isFav:monumentFavourites[index]}
              mixedMonument.push(x) ;
             
            }
    res.status(200).json(mixedMonument);
  });

  //-------------------------------------------------------

  // SHOW monument [ADMIN, USER]
router.get("/:id",authorized, async (req, res) => {
  const query = util.promisify(conn.query).bind(conn);
  const monument = await query("select * from monument where id = ?", [
    req.params.id,
  ]);

  if (!monument[0]) {
    res.status(404).json({ ms: "monument not found !" });
  }
  monument[0].image_url = "http://" + req.hostname + ":3000/" + monument[0].image_url;
  monument[0].reviews = await query(
    "select * from user_monument_review where monument_id = ?",
    monument[0].id
  );
  let isfav=0 ;
  const isFavQuery = await query(`select * from favourite where monument_id =? and user_id=? `,[monument[0].id,res.locals.user.id]);
  if(isFavQuery[0]){
    isfav=1;
  }
  for (let index = 0; index <  monument[0].reviews.length; index++) {
    delete  monument[0].reviews[index].monument_id,
    delete  monument[0].reviews[index].user_id
  }

  res.status(200).json({ ms:monument[0],isfav });
});


 //-------------------------------------------------------

  // SHOW monument [ADMIN, USER]
router.get("/:id", async (req, res) => {
  const query = util.promisify(conn.query).bind(conn);
  const monument = await query("select * from monument where id = ?", [
    req.params.id,
  ]);

  if (!monument[0]) {
    res.status(404).json({ ms: "monument not found !" });
  }
  monument[0].image_url = "http://" + req.hostname + ":3000/" + monument[0].image_url;
  monument[0].reviews = await query(
    "select * from user_monument_review where monument_id = ?",
    monument[0].id
  );
  let isfav=0 ;
  const isFavQuery = await query(`select * from favourite where monument_id =?`,monument[0].id);
  if(isFavQuery[0]){
    isfav=1;
  }
  for (let index = 0; index <  monument[0].reviews.length; index++) {
    delete  monument[0].reviews[index].monument_id,
    delete  monument[0].reviews[index].user_id
  }

  res.status(200).json({ ms:monument[0],isfav });
});
//--------------------------------------------------------
// MAKE REVIEW [ADMIN, USER]
router.post(
  "/review",
  authorized,
  body("monument_id").isNumeric().withMessage("please enter a valid monument ID"),
  body("review").isString().withMessage("please enter a valid Review"),
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
      const x=  await query( "select * from user_monument_review where user_id = ? AND monument_id= ?",[res.locals.user.id,req.body.monument_id]  );
       if (x[0]){
        return res.status(410).json({ ms: "you already do a review for this item" });
       }
      // 3 - PREPARE MOVIE REVIEW OBJECT
      const reviewObj = {
        user_id: res.locals.user.id,
        user_name: res.locals.user.user_name,
        monument_id: monument[0].id,
        review: req.body.review,
      };
      // 4- INSERT monument OBJECT INTO DATABASE
      await query("insert into user_monument_review set ?", reviewObj);
      delete reviewObj.user_id;
      res.status(200).json({ms: "review added successfully !" });
    } catch (err) {
      console.log(err);
      res.status(500).json(err);
    }
  }
);



module.exports = router ;