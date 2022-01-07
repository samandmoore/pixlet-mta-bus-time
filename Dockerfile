FROM ubuntu:latest
ARG FUNCTION_DIR="/"
RUN apt-get update
RUN apt-get install -y \
    libwebp-dev \
    curl \
    gzip \
    ruby
RUN curl -L https://github.com/tidbyt/pixlet/releases/download/v0.11.1/pixlet_0.11.1_linux_amd64.tar.gz | tar -xz
RUN mv pixlet /usr/bin/pixlet
RUN chmod 755 /usr/bin/pixlet
ADD https://github.com/aws/aws-lambda-runtime-interface-emulator/releases/download/v1.3/aws-lambda-rie-x86_64 /usr/bin/aws-lambda-rie
RUN chmod 755 /usr/bin/aws-lambda-rie
RUN gem install bundler
RUN gem install aws_lambda_ric
ADD bus_times.star ${FUNCTION_DIR}
ADD handler.rb ${FUNCTION_DIR}
WORKDIR ${FUNCTION_DIR}
ENTRYPOINT ["/usr/local/bin/aws_lambda_ric"]
CMD ["handler.render_and_push"]
