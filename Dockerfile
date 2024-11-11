FROM node:18 
#Add a work directory
WORKDIR /app
#Copy dependencies
COPY ./check.txt ./package*.json ./package-lock.json[t] ./yarn.lock[t] ./
#Copy sub workspace dependencies
COPY ./check.txt ./workspace-b/package*.json ./workspace-b/package-lock[t].json  ./workspace-b/yarn.lock[t] ./workspace-b/
COPY ./check.txt ./workspace-a/package*.json ./workspace-a/package-lock[t].json  ./workspace-a/yarn.lock[t] ./workspace-a/


#Install dependencies
RUN npm install
#Copy app files
COPY . .
#Cache and Install dependencies



#.env Source destination argument
ARG source_file=./.env
ARG destination_dir=./workspace-b/.env

#.env copying management
RUN if [ -f "$source_file" ]; then \
        if [ "$source_file" != "$destination_dir" ]; then \
            echo "Copying $source_file to $destination_dir"; \
            cp "$source_file" "$destination_dir"; \
        else \
            echo "Source and destination paths are the same; skipping copy."; \
        fi \
    else \
        echo ".env has been added to dockerignore; skipping copy; if you want to copy it, remove it from dockerignore."; \
    fi

#Change a work directory
WORKDIR ./workspace-b/

#Expose port
EXPOSE 3000 
#Build command


#Start the app
CMD npm run serve
