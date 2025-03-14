# REST API

The DANDI Archive provides a RESTful API that allows programmatic access to the archive. The API is documented using both Swagger and ReDoc, which provide interactive interfaces for exploring and testing the API.

## Accessing the API

The DANDI API is available at:

- Production: [https://api.dandiarchive.org/](https://api.dandiarchive.org/)
- Staging: [https://api-staging.dandiarchive.org/](https://api-staging.dandiarchive.org/)

## API Documentation

The API documentation is available in three formats:

### Swagger UI

- Production: [https://api.dandiarchive.org/swagger/](https://api.dandiarchive.org/swagger/)
- Staging: [https://api-staging.dandiarchive.org/swagger/](https://api-staging.dandiarchive.org/swagger/)

The Swagger UI allows you to:

- Browse the available API endpoints
- See the required parameters for each endpoint
- Test the endpoints directly from the browser
- View the response formats

### ReDoc

- Production: [https://api.dandiarchive.org/redoc/](https://api.dandiarchive.org/redoc/)
- Staging: [https://api-staging.dandiarchive.org/redoc/](https://api-staging.dandiarchive.org/redoc/)

The ReDoc interface provides:

- A clean, responsive interface for exploring the API
- Detailed information about each endpoint
- Request and response examples
- Schema definitions

### ReadMe.io

- Production: https://dandi.readme.io

## Authentication

Some API endpoints require authentication. You can authenticate using an API key, which you can obtain from your DANDI account. To use the API key:

1. Log in to the DANDI Archive
2. Click on your user initials in the top-right corner
3. Copy your API key
4. Use the API key in the `Authorization` header of your requests:

```
Authorization: token YOUR_API_KEY
```

## Using the API

The API provides endpoints for:

- Listing and searching Dandisets
- Getting Dandiset metadata
- Listing and searching assets
- Getting asset metadata
- Downloading assets
- Managing Dandisets (requires authentication)
- Managing assets (requires authentication)

For more information on using the API, see the Swagger documentation.
