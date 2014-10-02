Purrrl
=============

Purrrl is a simple way to share files publicly using your command line. 

Create your free account over at http://purrrl.link

## Installation

```shell
gem install purrrl
````

## Example Usage

###### Firstly, you need to authorise your machine to use the service:

```shell
purrrl login
````

###### To upload a file from your local machine to the service, type the following:

```shell
purrrl upload filepath
````
After receiving your file, the server generates an MD5 hash of the uploaded file and outputs it in the headers of the download page. You can use this for security verification purposes.

###### Show a list of all your uploaded files using: 

```shell
purrrl files
````

###### Delete an uploaded file resource:

```shell
purrrl rm full_url
````

###### Searching files using grep:

```shell
purrrl files | grep 'query'
````

Instead of using the full `purrrl` command, you also have a shorthand version called `prl`

## Legal

If you wish to use Purrrl, we ask that you please agree to the following terms of use.

1. You will not upload or share any copyrighted material.
2. You will not upload or share any child pornography.
3. You will not upload or share any other illegal material.
4. We do not own or take responsibility for any files you upload.
5. We reserve the right to remove your files or even account if you violate our terms.
6. You will not abuse the service, resources or IP.

## License

Purrrl is available under the GPL license. See the LICENSE file for more info.
