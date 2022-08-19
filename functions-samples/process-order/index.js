module.exports = async function (context, inputDocument) {

    if (!!inputDocument && inputDocument.length > 0) {

        if(inputDocument[0].status != 'confirmed') {
            context.log('Processing order');

            inputDocument[0].status = 'confirmed';
            
            context.bindings.outputDocument = inputDocument[0];
            
            context.bindings.ordersProcessed = JSON.stringify(inputDocument[0]);

            context.log('Order confirmed');
        }
    }
}
