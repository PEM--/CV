## CV
Automate creation of resume with Jade & Less.

### Installation
Before you begin your journey into reformating your resume, you need the following tools:

#### Brew
[Brew](http://brew.sh/) is a package manager tool for OS X. Its installation is straightforward:

```
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
```

#### NodeJS
[NodeJS](http://nodejs.org/) is a JS virtual machine based on Chrome's JavaScript runtime. Basically, it provides the power of modern JS libraries while being in you terminal's session. Thanks to [Brew](http://brew.sh/), its installation is stupid simple:
```
brew install node
```

By doing so, [Brew](http://brew.sh/) has also installed [NodeJS](http://nodejs.org/)'s package manager: [NPM](https://npmjs.org/). This core piece of software is your gateway to the 52K (and counting) libraries that you can use with [NodeJS](http://nodejs.org/).

#### Grunt, Bower, PhantomJS
Though most tools and libraries are installed locally, aside of this project, some tools should be installed globally so that they are easily accessed in your terminal's session.

[Grunt](http://gruntjs.com/) is a task runner. Think of it as a simple batch file but programmed in JS. Hence, it speaks the language of the web avoiding you to change from one language to the other each time you want to perform evolution. It is a great citizen of the full stack JS development. Install it with the following command:
```
npm install -g grunt-cli
```

While [NPM](https://npmjs.org/) aims to bring the incredible and vivid ecosystem of JS to your terminal for server or tooling developments, [Bower](http://bower.io/) is its counterpart for the browser development. This package manager allows you to handle all the web libraries that you will embed in your HTML pages. It is a must have for every front UX developer. Install it with the following command:
```
npm install -g bower
```

The last tool that we need is [PhantomJS](http://phantomjs.org/), an headless internet browser. Though commonly used for testing, this tool is leverage in this project for producing PDF files 'on-th-fly' of your resume. The installation is just like the previous tools:
```
npm install -g phantomjs
```

### Building
#### Install the local dependencies
This project uses [Jade](http://jade-lang.com/), [LESS](http://lesscss.org/), [Twitter's Bootstrap](http://getbootstrap.com/), some Grunt plugins. Everything it imported in 2 commands:
```
bower install
npm install
```

#### Automated build while editing
Simply hit the following command to perform a LiveReload session while editing your resume:
```
grunt
```

#### Creating 
PENDING TASK. FOR THE MOMENT, SIMPLY PRINT YOUR RESUME HITTING CMD+P IN YOUR BROWSER.

### Customizing the project
#### The content of your resume
The content is placed into a single file. But you can partition it upon will thanks to [Jade](http://jade-lang.com/). The single file is located in `app/index.jade`.

#### The layout of your resume
As we are using [Twitter's Bootstrap](http://getbootstrap.com/) as the CSS framework which is written in [LESS](http://lesscss.org/), the single CSS file is written in the same language. The file is located in `app/css/cv.less`. This file import all the necessary file from [Twitter's Bootstrap](http://getbootstrap.com/) and apply the expected customization at its end.
