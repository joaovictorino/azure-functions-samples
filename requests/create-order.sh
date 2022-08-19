#!/bin/bash

curl -i -X POST http://localhost:7071/api/orders \
	-H 'Content-Type: application/json' \
	-d '
{
	"items" : [
		{
			"name": "tablet",
			"price": 100.0,
			"quantity": 1
		},
		{
			"name": "pen",
			"price": 20.0,
			"quantity": 1
		}
	]
}'
