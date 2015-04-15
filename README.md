use-express4
--------

To quickly start using express 4.x, for lazy people.

## To install for your project, in project dir run:

    npm install use-express4 --save
    
## Then write code

    var use_ex = require("use-express4");
    use_ex.initAppFunc = function(app, express) {
      // do your init here...
      app.use(express.static(path.join(__dirname, 'www')));
    }
    // then launch server
    use_ex.launch(8000);
    // or launch a local server using an available port, and open a browser to view it
    use_ex.launchLocalDev();
    
## Or simple start a static www server from command line

    # install globally
    npm install -g use-express4

    # then launch www server to serve static files in './', and browse to it
    servedir -d ./ -b
        
    # or if you want to launch on a specific port
    servedir -p 80 -d ./ -b
    
    