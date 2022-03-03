FROM alpine:latest

RUN apk update && \
	apk add nginx
EXPOSE 443

ENTRYPOINT [ "executable" ] ["/etc/init.d/nginx", "start"]
CMD ["nginx", "-g", "daemon off;"]