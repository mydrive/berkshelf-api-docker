FROM ruby:2.2

RUN apt-get update
RUN apt-get install -y libarchive-dev python-pip && pip install awscli

RUN gem install berkshelf-api --no-rdoc --no-ri --version 2.1.1

RUN mkdir -p /etc/config/berkshelf/api-server

CMD ["/bin/sh", "-c", "rm -rf /etc/berkshelf/cerch; aws s3 cp --region eu-west-1 s3://${CONFIG_BUCKET}/config/berkshelf-api/config.json /etc/berkshelf/config.json; aws s3 cp --region eu-west-1 s3://${CONFIG_BUCKET}/config/berkshelf-api/${CHEF_CERT} /etc/berkshelf/${CHEF_CERT}; chmod 600 /etc/berkshelf/${CHEF_CERT}; berks-api --port ${PORT} --config /etc/berkshelf/config.json"]

