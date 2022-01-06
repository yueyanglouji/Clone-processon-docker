FROM alpine:edge
LABEL maintainer="yueyanglouji<343468684@qq.com>"
RUN apk update \
    && apk --no-cache add git nodejs yarn

RUN mkdir /apps \
&& touch /apps/touch.txt \
&& export http_proxy=http://10.48.211.3:8118 \
&& export https_proxy=http://10.48.211.3:8118 \
&& git clone https://github.com/yueyanglouji/Clone-processon.git \
&& mv -f Clone-processon /apps \
&& cd /apps/Clone-processon \
&& cp .env.example .env \
&& yarn install \
&& yarn build \
&& echo 0

EXPOSE 3000
WORKDIR /apps/Clone-processon

ENTRYPOINT ["yarn", "start"]