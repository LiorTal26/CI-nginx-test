FROM nginx:alpine 
COPY index.html /user/share/nginx/html/ 
EXPOSE 80
