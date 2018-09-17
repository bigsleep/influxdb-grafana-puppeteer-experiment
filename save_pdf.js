const puppeteer = require('puppeteer');
const url = process.argv[2];
const output_path = process.argv[3];
const width = 1920;
const heiht = 1080;

(async() => {
    const browser = await puppeteer.launch({
        headless: true,
        executablePath: 'chromium-browser',
        args: ['--no-sandbox', '--disable-setuid-sandbox']
    });

    const page = await browser.newPage();
    await page.setExtraHTTPHeaders({
        Authorization: 'Basic ' + new Buffer('admin:admin').toString('base64')
    });

    await page.setViewport({
        width: width,
        height: height,
        isMobile: false
    });

    await page.goto(url, {waitUntil: 'networkidle0'});

    await page.pdf({
        path: output_path,
        width: width + 'px',
        height: height + 'px',
    });

    await browser.close();
})();
