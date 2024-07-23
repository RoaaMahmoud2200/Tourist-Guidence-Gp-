const router = require("express").Router();
const { body,validationResult } = require("express-validator");
const conn = require("../db/dbConnection");
const bcrypt = require("bcrypt");
const crypto = require("crypto");
const util = require("util");
const { log, Console } = require("console");


router.post(
    "/register",
    body("email")
    .isEmail()
    .withMessage("please enter a valid email!"),

    body("user_name")
    .isString()
    .withMessage("please enter a valid user_name")
    .isLength({ min: 3, max: 20 })
    .withMessage("name should be between (3-20) character"),

    body("password")
    .isLength({ min: 8, max: 12 })
    .withMessage("password should be between (8-12) character"),
 
    body("age")  
    .isLength({min:1})
    .withMessage("please enter a valid age"),

    body("mobile_num")
    .isMobilePhone()
    .withMessage(" mobile_num should be number")
    .isLength({ min: 11 , max: 12 })
    .withMessage("mobile_num should be 11 number "),

    body("language")
    .isString()
    .withMessage("language should be a string ")
    .isLength({ min: 2 , max: 10 })
    .withMessage(" please enter a valid language"),
   
    body("currency")
    .isString()
    .withMessage("please enter a valid currency should be a string")
    .isLength({ min: 2 , max: 10 })
    .withMessage("please enter a valid currency "),
    
            
   
    async (req, res) => {
      try {
        // 1- VALIDATION REQUEST [manual, express validation]
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
          return res.status(400).json({ errors: errors.array() });
        }
     
        
        // 2- CHECK IF EMAIL EXISTS
        const query = util.promisify(conn.query).bind(conn); // transform query mysql --> promise to use [await/async]
        const checkEmailExists = await query(
          "select * from  users where email = ?",
          [req.body.email]
        );
        
        if (checkEmailExists.length > 0) {
          return res.status(402).json({ ms: "this email already exists !"}) 
        }
       // 3- PREPARE OBJECT USER TO -> SAVE
        const RegisterData = {
            id:req.body.id,
            email: req.body.email,  
            user_name: req.body.user_name,
            password: await bcrypt.hash(req.body.password, 10),
            age:req.body.age, 
            mobile_num: req.body.mobile_num,
            language :req.body.language,
            currency:req.body.currency,
            token: crypto.randomBytes(16).toString("hex"), 
        };
  
        // 4- INSERT USER OBJECT INTO DB
        await query("insert into users set ? ", RegisterData);
        delete RegisterData.password;
        res.status(200).json({ ms: RegisterData});

      }  catch (error) {
        res.status(500).json({ err: error });
      }
    }
  );
  

  router.post(
    "/login",
    body("email").isEmail().withMessage("please enter a valid email!"),
    body("password")
      .isLength({ min: 8, max: 12 })
      .withMessage("password should be between (8-12) character"),
    async (req, res) => {
      try {
        // 1- VALIDATION REQUEST [manual, express validation]
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
          return res.status(400).json({ errors: errors.array() });
        }
  
        // 2- CHECK IF EMAIL EXISTS
        const query = util.promisify(conn.query).bind(conn); // transform query mysql --> promise to use [await/async]
        const user = await query("select * from users where email = ?", [
          req.body.email,
        ]);
        if (user.length == 0) {
          return res.status(402).json({ms: "this email is not exists !" });
        }

        // 3- COMPARE HASHED PASSWORD
        const checkPassword = await bcrypt.compare( req.body.password, user[0].password );
        if (checkPassword) {
          delete user[0].password;
          res.status(200).json(user[0]);
        } else {
         return  res.status(405).json({ms: "password is wrong "});
        }
        
      } catch (error) {
        res.status(500).json({ err: error });
      }
    }
  );

 


module.exports = router;