from typing import List
from pydantic import BaseModel

class Variant(BaseModel):
    variant_name: str

class Product(BaseModel):
    product_id: int
    sku_number: str
    product_name: str
    description: str
    price: float
    quantity: int
    variants: List[Variant]

class Category(BaseModel):
    category_id: int
    category_name: str
    products: List[Product]
