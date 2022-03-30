# nginx 이미지
FROM nginx

# work directory 지정
COPY . /sniffeed-content-image-creator/build/web
WORKDIR /sniffeed-content-image-creator

# nginx 설정 파일 교체
RUN rm /etc/nginx/conf.d/default.conf
COPY ./nginx.conf /etc/nginx/conf.d

# 포트 개방
EXPOSE 80

# nginx 실행
CMD ["nginx", "-g", "daemon off;"]