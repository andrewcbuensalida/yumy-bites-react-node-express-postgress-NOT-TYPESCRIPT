const { Pool } = require("pg");
require("dotenv").config();

//for postgres on heroku
const pool = new Pool({
	connectionString: process.env.DATABASE_URL,
	ssl: {
		rejectUnauthorized: false,
	},
});


//for local postgres
// const pool = new Pool();
// module.exports = {
// 	query: (text, params) => pool.query(text, params),
// };

module.exports = pool;
