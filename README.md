# Custom Vision API Demo

## Development
### Installation
Run `npm install` to install the packages for this project.
If you haven't already done so, please install Rescript with `npm install -g bs-platform`.

### Start Dev Server
To start the Dev Server, you'll need to run two commands:

```sh
npm run start:re
npm run start
```

If you want to test with SSL, do this instead:
```sh
npm run start:re
npm run gen-cert
npm run start:secure
```

`npm run gen-cert` will generate `snowpack.crt` and `snowpack.key` which will be used by `npm run start:secure`.

### Build
Run `npm run build` to generate the bundled code in the `build/` folder.