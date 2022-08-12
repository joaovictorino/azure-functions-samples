module.exports = async function (context, inputDocument) {
    if (!!inputDocument && inputDocument.length > 0) {
        context.log('Document Id: ', inputDocument[0].id);
    }
}
