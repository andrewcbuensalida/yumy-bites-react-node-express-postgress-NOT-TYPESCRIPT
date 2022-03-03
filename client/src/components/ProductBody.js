import React from "react";
import { IProduct } from "../interfaces/Interfaces";
import "./ProductBody.css";

function ProductBody({ oneContent }) {
	return (
		<div>
			<div className="ProductsContent_price">₱{oneContent.price}</div>
			<div className="ProductsContent_img">
				<img src={oneContent.imageUrl} alt="" />
			</div>
		</div>
	);
}

export default ProductBody;
