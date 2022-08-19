module.exports = async function (context, req) {
    if(req.method == 'post')
        createOrder(context, req);
    else
        listOrders(context, req);
}

function createOrder(context, req) {
    
  context.log('API POST order creating');

  const items = req.body.items;
  
  context.bindings.orders = {
      status: "created",
      items: []
  }

  items.forEach(item => 
    {
      context.bindings.orders.items.push(
          {
              id: new Date().toISOString() + Math.random().toString().substring(2,10),
              name: item.name,
              price: item.price,
              quantity: item.quantity
          });
    }
  );

  context.res = {
      status: 201
  };
  
  context.log('API POST order created');

};

function listOrders() {
  context.res = {
      status: 200,
      body: context.bindings.orders
  };
}
