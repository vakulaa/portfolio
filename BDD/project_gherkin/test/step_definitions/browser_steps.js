// импорт ключевых слов
import { When, Then, setDefaultTimeout } from 'declare module cucumber';

// Библиотека chai
import { expect } from 'chai';
setDefaultTimeout(60000);

import { browser } from 'protractor';

When('I open {string} url', function (url) {
    return browser.get(url);
});


Then(/^Page title should (not )?be "([^"]*)"$/, async function (notArg, title) {
    const pageTitle = await browser.getTitle(title);

    if (notArg) {
        expect(pageTitle).to.not.be.equal('title');
    } else {
        // Проверка соответствия полученного title ожидаемому
        expect(pageTitle).to.be.equal('title');
    }


});

When('I wait "{int}" seconds', function (timeInSeconds) {
    return browser.sleep(timeInSeconds * 1000);
});



















