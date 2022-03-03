const express = require("express");
const db = require("./db");
const cors = require("cors");
require("dotenv").config();
const path = require("path");
const app = express();
app.use(cors());
app.use(express.json());

if (process.env.NODE_ENV === "production") {
	app.use(express.static(path.join(__dirname, "../client/build")));
	app.use(express.static("public"));
}

app.get("/api/v1/", async (req, res) => {
	console.log(`get hit`);
	try {
		const customers = await db.query(
			`SELECT * FROM customer ORDER BY "lastName"`
		);
		const products = await db.query(
			`SELECT * FROM product ORDER BY "name"`
		);

		const orders = await db.query(
			`SELECT * FROM "order" ORDER BY "deliveryTime"`
		);

		res.status(200).json({
			ok: true,
			data: {
				customers: customers.rows,
				products: products.rows,
				orders: orders.rows,
			},
		});
	} catch (error) {
		console.log("this is error", error);
		res.status(400).json({
			ok: false,
			data: {},
		});
	}
});

app.post("/api/v1/customer", async (req, res) => {
	try {
		const result = await db.query(
			"INSERT INTO customer (firstName,lastName,homeAddress,cellPhone) VALUES ($1,$2,$3,$4) RETURNING *",
			[
				req.body.firstName,
				req.body.lastName,
				req.body.homeAddress,
				req.body.cellPhone,
			]
		);
		res.status(201).json({
			status: "success",
			data: result.rows[0],
		});
	} catch (error) {
		console.log(error);
	}
});

app.get("*", (req, res) => {
	res.sendFile(path.join(__dirname, "..client/build", "index.html"));
});

const PORT = process.env.PORT || 3500;
app.listen(PORT, () => console.log(`Connected to ${process.env.PORT}`));
