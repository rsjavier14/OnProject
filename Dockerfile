FROM phusion/passenger-customizable:0.9.27
RUN /pd_build/ruby-2.4.*.sh

# Set basic ENV vars
ENV HOME=/root TERM=xterm-color

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

# enable nginx
RUN rm -f /etc/service/nginx/down

RUN apt-get update -qq && apt-get install -y build-essential tzdata libpq-dev nodejs

# Add "virtual host" config to Nginx
RUN rm /etc/nginx/sites-enabled/default
COPY webapp.conf /etc/nginx/sites-enabled/webapp.conf

# Create dir for sources
ENV APP_HOME=/home/app/onproject
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# Install Gemfile so its cache doesn't get invalidated by copying the rest of the sources
COPY Gemfile Gemfile.lock $APP_HOME/
ENV BUNDLE_PATH=/home/app/bundle
ENV BUNDLE_GEMFILE=$APP_HOME/Gemfile
ENV BUNDLE_JOBS=2
RUN bundle install

#default DB_HOST
ENV DB_HOST=db

# Avoid losing some ENV vars because of Nginx (by default Nginx deletes all ENV vars)
RUN echo "env BUNDLE_PATH;" >> /etc/nginx/main.d/default.conf; \
  echo "env DB_PORT;" >> /etc/nginx/main.d/default.conf; \
	echo "env MAILER_HOST;" >> /etc/nginx/main.d/default.conf; \
	echo "env ASSET_HOST;" >> /etc/nginx/main.d/default.conf; \
	echo "env FB_APP_ID;" >> /etc/nginx/main.d/default.conf; \
	echo "env DB_HOST;" >> /etc/nginx/main.d/default.conf; \
	echo "env EMAIL_FROM;" >> /etc/nginx/main.d/default.conf; \
	echo "env EMAIL_REPLY;" >> /etc/nginx/main.d/default.conf; \
	echo "env MAILER_ADDRESS;" >> /etc/nginx/main.d/default.conf; \
	echo "env MAILER_DOMAIN;" >> /etc/nginx/main.d/default.conf; \
	echo "env MAILER_PASSWORD;" >> /etc/nginx/main.d/default.conf;

COPY --chown=app:app . $APP_HOME

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Enable SSH
RUN rm -f /etc/service/sshd/down
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh
COPY authorized_keys /tmp/authorized_keys
RUN cat /tmp/authorized_keys >> /root/.ssh/authorized_keys && rm -f /tmp/authorized_keys

LABEL author="rsjavier14@gmail.com"
