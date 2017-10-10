# Paradistatic

Render Paradisec-generated XML data into a static HTML documents

## Usage

### OS X

#### Single file

On OS X, you can use the `xsltproc` tool to transform XML documents according to transformations given in a XSL file. The usage is: `xsltproc -o output.html transforms.xsl input.xml`

Thus, for some given XML file from Paradisec, e.g. `NT5-200518-CAT-PDSC_ADMIN.xml`, you can transform it using the `CAT-PDSC_ADMIN.xsl` from this repository accordingly:

```bash
xsltproc -o output.html CAT-PDSC_ADMIN.xsl NT5-200518-CAT-PDSC_ADMIN.xml
```

#### Batch processing

Using the `find ... -exec ...` to find and list files according to some pattern, then execute a command on the list of files. Adapting the `xsltproc` call above, the following command searches the `~/Users/person/PARADISECTEST` for files ending with `-CAT-PDSC_ADMIN.xml`, and then applies the `xsltproc ...` command to them (where `{}` is the name of the file found, e.g. `NT5-200518-CAT-PDSC_ADMIN.xml`)

```bash
find ~/Users/person/PARADISECTEST -name "*-CAT-PDSC_ADMIN.xml" -exec xsltproc -o {}.html CAT-PDSC_ADMIN.xsl {} \;
```

***Note***. The command above requires you to execute it from the directory where `CAT-PDSC_ADMIN.xsl` is located (i.e. do `cd ...`, before `find ... exec`).

## Deployment

### Paths

While the generated `.html` files can be served from anywhere under the LibraryBox domain. However, the `coedl-assets` folder containing the Javascript and CSS dependencies must be located under `Shared/coedl-assets`.

If you want the dependencies to be served from elsewhere, change the CSS `<link href ...` and Javascript `<script src ...` paths within `CAT-PDSC_ADMIN.xsl`:

```html
<!-- Line 21: -->
<link rel="stylesheet" type="text/css" href="/Shared/coedl-assets/dist/bootstrap-3.3.7-dist/css/bootstrap.min.css"/>

...

<!-- Line 45: -->
<script type="text/javascript" src="/Shared/coedl-assets/dist/jquery-3.2.1.min.js"></script>
```

