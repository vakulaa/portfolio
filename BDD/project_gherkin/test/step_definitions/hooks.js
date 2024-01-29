const { After } = require('cucumber');
const { browser } = require('protractor');

After({ tags: '@medium' }, async function () {
    const screenshot = await browser.takeScreenshot();
    const decodedImage = new Buffer.from(screenshot, 'base64');
    return this.attach(decodedImage, 'image/png');
});






















