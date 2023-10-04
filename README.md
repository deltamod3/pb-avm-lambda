# house-price-prediction-api
## Installation  
1) Install python 3.8 or higher
2) Create new virtual environment `python -m venv venv`
3) Activate created environment `source venv/bin/activate`
4) Install dependencies `pip install -r requirements.txt`
5) Download .joblib files from Google Drive [LINK](https://drive.google.com/drive/folders/1p35QKAUrN5EChakDWsr9mlwkGCP_WsNf?usp=share_link)
6) Place .joblib files to `models` directory
7) Change directory to app with `cd ./app`
8) Run Flask app from app directory `flask run`
9) Send get or post queries with JSON body to `localhost:5000/`

### Request body example
```
{
    "type": "sale",
    "features.propertyType": "detachedHouse",
    "features.beds": 2,
    "features.baths": 0,
    "lat": 57.107,
    "lon": -2.239
}
```

### Response body example
Response will send back predicted price as well as received data
```
{
    "data": {
        "features.baths": 0,
        "features.beds": 2,
        "features.propertyType": "detachedHouse",
        "lat": 57.107,
        "lon": -2.239,
        "type": "sale"
    },
    "price": 256666.671875
}
```