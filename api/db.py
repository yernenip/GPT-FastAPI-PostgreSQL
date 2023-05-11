import psycopg_pool
import os
import dotenv

dotenv.load_dotenv()

conn = f'host={os.getenv("HOSTNAME")} port={os.getenv("PORT")} dbname={os.getenv("DATABASE")} user={os.getenv("USER")} password={os.getenv("PASSWORD")}'
pool = psycopg_pool.AsyncConnectionPool(conninfo=conn, open=False)

async def open_pool():
    await pool.open()
    await pool.wait()

async def close_pool():
    pool.close()

async def exec_query(query, params=None):
    async with pool.connection() as conn:
        async with conn.cursor() as cursor:
            await cursor.execute(query, params)
            results = await cursor.fetchall()
            return results
