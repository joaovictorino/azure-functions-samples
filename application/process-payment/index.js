var uuid = require('uuid');

module.exports = async function(context, mySbMsg) {
    
    createTables();

    context.log('Payment process started', mySbMsg);

    const orderId = uuid.v4();
    context.bindings.ordersTable = {
        "status": mySbMsg.status,
        "id": orderId 
    };

    context.bindings.orderItemTable = [];
   
    mySbMsg.items.forEach(item => {
        context.bindings.orderItemTable.push({
            "id": uuid.v4(),
            "orderId": orderId,
            "name": item.name,
            "price": item.price,
            "quantity": item.quantity
        });
    });

    context.log('Payment confirmed');
};

function createTables() {
    var Connection = require('tedious').Connection;
    
    var config = {
        server: process.env.SQLServer,
        authentication: {
            type: 'default',
            options: {
                userName: process.env.SQLUser,
                password: process.env.SQLPass
            }
        },
        options: {
            encrypt: true,
            database: 'ordersdb'
        }
    };

    var Request = require('tedious').Request;

    var connection = new Connection(config);

    connection.on('connect', function(err) {
        if(err) {
            console.log('connection error');
            console.log(err);
        } else {
            console.log('connection success');
            validateTableExists();
        }
    });

    connection.connect();

    function validateTableExists() {
        request = new Request('SELECT * FROM dbo.Orders;', function(err) {
            if(err) {
                console.log('query error');
                console.log(err);
                executeScript();
            }
        });

        connection.execSql(request);
    };

    function executeScript() {
        const fs = require('fs');
        const buffer = fs.readFileSync(__dirname + '//create-tables.sql');
        const command = buffer.toString();
        request = new Request(command, function(err) {
            if(err) {
                console.log('query error');
                console.log(err);
            }
        });

        connection.execSql(request);
    };
};
