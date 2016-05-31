FROM ubuntu:14.04
MAINTAINER Ryan Baumann <ryan.baumann@gmail.com>

# Install the Ubuntu packages.
RUN apt-get update \
  && apt-get install -y python-dev python-virtualenv mysql-server libmysqlclient-dev git build-essential

# Clone
RUN git clone git://github.com/code4lib/shortimer.git && cd shortimer && git checkout 5e7850051e177fdbc27bad407ad19a4a636422be
# OR
# ADD . /shortimer

# Replace sh with bash so we can source for virtualenv
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN cd /shortimer \
  && virtualenv --no-site-packages ENV \
  && source ENV/bin/activate \ 
  && pip install -r requirements.txt
COPY settings.py.template /shortimer/settings.py
COPY wait-for-it.sh /shortimer/wait-for-it.sh
EXPOSE 8000
CMD cd /shortimer && ./wait-for-it.sh mysql:3306 \
  && echo 'DROP DATABASE IF EXISTS jobs4lib; CREATE DATABASE jobs4lib CHARACTER SET utf8;' | mysql -uroot -hmysql \
  && source ENV/bin/activate && python manage.py syncdb --migrate --noinput && echo 'Done migrating' \
  && python manage.py runserver 0.0.0.0:8000
