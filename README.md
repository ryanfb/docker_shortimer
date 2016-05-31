# docker_shortimer

This is a Dockerized environment for running a development instance of [code4lib/shortimer](https://github.com/code4lib/shortimer), the Django web app that runs <http://jobs.code4lib.org/>.

Requirements:

 * [`docker`](https://www.docker.com/) 1.10.0+
 * [`docker-compose`](https://docs.docker.com/compose/) 1.6.0+

Usage:

 * Find your `docker` IP address with e.g. `docker-machine ip dev`
 * Run `docker-compose build && docker-compose up`
 * Open `docker.machine.ip.from-earlier:8000` in a browser

If you want to use this with a `git checkout` of `shortimer` (so you can experiment with local modifications before they're committed/pushed), you can copy the files from this repository into your `shortimer` directory, then edit the `Dockerfile` to use `ADD` instead of `RUN git clone` (see [this blog post](http://ryanfb.github.io/etc/2015/07/29/git_strategies_for_docker.html) for more info).
