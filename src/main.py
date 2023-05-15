from fastapi import FastAPI, HTTPException
from typing import List
from models import Product, Variant
from db import open_pool, close_pool, exec_query

app = FastAPI()

@app.on_event("startup")
async def startup():
    await open_pool()

@app.on_event("shutdown")
async def shutdown():
    await close_pool()

@app.get("/")
def root():
    return {"Hello": "World"}


@app.get("/products/{product_id}")
async def get_product_by_id(product_id: int) -> Product:
    query = """
        SELECT
            p.product_id,
            p.sku_number,
            p.product_name,
            p.description,
            p.price,
            p.quantity,
            v.variant_name
        FROM
            products p
        LEFT JOIN
            products_variants pv ON p.product_id = pv.product_id
        LEFT JOIN
            variants v ON pv.variant_id = v.variant_id
        WHERE
            p.product_id = %(product_id)s
        """
    params = {"product_id": product_id}
    result = await exec_query(query, params)
    
    if not result:
        raise HTTPException(status_code=404, detail="Product not found")

    product_data = result[0]
    product = Product(
        product_id=product_data[0],
        sku_number=product_data[1],
        product_name=product_data[2],
        description=product_data[3],
        price=product_data[4],
        quantity=product_data[5],
        variants=[Variant(variant_name=row[6]) for row in result]
    )
    return product


@app.get("/products/category/{category_name}")
async def get_products_by_category(category_name: str) -> List[Product]:
    query = """
        SELECT
            p.product_id,
            p.sku_number,
            p.product_name,
            p.description,
            p.price,
            p.quantity,
            v.variant_name
        FROM
            products p
        LEFT JOIN
            products_variants pv ON p.product_id = pv.product_id
        LEFT JOIN
            variants v ON pv.variant_id = v.variant_id
        INNER JOIN
            products_categories pc ON p.product_id = pc.product_id
        INNER JOIN
            categories c ON pc.category_id = c.category_id
        WHERE
            c.category_name = %(category_name)s
        """
    params = {"category_name": category_name}
    result = await exec_query(query, params)

    if not result:
        raise HTTPException(status_code=404, detail="No products found for the given category")

    products = []
    current_product_id = None
    current_product = None

    for row in result:
        if row[0] != current_product_id:
            if current_product:
                products.append(current_product)
            current_product_id = row
            current_product = Product(
                product_id=row[0],
                sku_number=row[1],
                product_name=row[2],
                description=row[3],
                price=row[4],
                quantity=row[5],
                variants=[Variant(variant_name=row[6])]
            )
        else:
            current_product.variants.append(Variant(variant_name=row[6]))

    if current_product:
        products.append(current_product)

    return products

@app.get("/products/sku/{sku_number}")
async def get_product_by_sku(sku_number: str) -> Product:
    query = """
        SELECT
            p.product_id,
            p.sku_number,
            p.product_name,
            p.description,
            p.price,
            p.quantity,
            v.variant_name
        FROM
            products p
        LEFT JOIN
            products_variants pv ON p.product_id = pv.product_id
        LEFT JOIN
            variants v ON pv.variant_id = v.variant_id
        WHERE
            p.sku_number = %(sku_number)s
        """
    params = {"sku_number": sku_number}
    result = await exec_query(query, params)

    if not result:
        raise HTTPException(status_code=404, detail="Product not found")

    product_data = result[0]
    product = Product(
        product_id=product_data[0],
        sku_number=product_data[1],
        product_name=product_data[2],
        description=product_data[3],
        price=product_data[4],
        quantity=product_data[5],
        variants=[Variant(variant_name=row[6]) for row in result]
    )
    return product

