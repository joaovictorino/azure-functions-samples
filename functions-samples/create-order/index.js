module.exports = async function (context, req) {
    context.log('API POST order created');

    const name = req.body.name;

    if(name){
        context.bindings.outputDocument = JSON.stringify({
            id: new Date().toISOString() + Math.random().toString().substring(2,10),
            name: name
        });
    }

    context.res = {
        status: 200
    };
}
