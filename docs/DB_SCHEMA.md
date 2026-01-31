# Firestore Database Schema

## Collection: articles
Stores articles created by authenticated users.

## Document Structure
Stores articles created within the app.


### Fields
| Field | Type | Description |
|-------|------|-------------|
| id | string | Yes | Unique article identifier (auto-generated) |
| title | string | Yes | Article title |
| content | string | Yes | Full article content |
| thumbnailURL | string | Yes | Reference to image in Firebase Cloud Storage: `media/articles/{filename}` |
| createdAt | timestamp | Yes | Creation timestamp |

> The Firestore document ID is used as the article identifier.

### Example Document
```json
{
  "id": "article123",
  "title": "My First Article",
  "content": "This is the full content of my first article.",
  "thumbnailURL": "media/articles/article_123.jpg",
  "createdAt": "Timestamp(2024, 1, 5)"
}
```

### Storage Structure
```

Firebase Cloud Storage
|__ media/
    |__ articles/
        |__ article_123.jpg
        |__ article_456.png
        |__ ...
```