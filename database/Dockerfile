# Use the official PostgreSQL image from Docker Hub
FROM postgres:latest

# Set environment variables
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=ChatGPT
ENV POSTGRES_DB=CommerceDB

# Copy the SQL scripts to the Docker container
COPY create-tables.sql /docker-entrypoint-initdb.d/
COPY insert-main-data.sql /docker-entrypoint-initdb.d/

# Expose the default PostgreSQL port
EXPOSE 5432

# Start PostgreSQL and execute the SQL scripts
CMD ["postgres"]
