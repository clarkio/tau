# Build stage
FROM node:16 as build-stage
WORKDIR /app
COPY ./tau-dashboard/package*.json ./
RUN npm install
COPY ./tau-dashboard /app
RUN npm run build

# Prododuction stage
FROM python:3.9.5 as prod-stage
ENV PYTHONUNBUFFERED=1 PYTHONHASHSEED=random \
    PYTHONDONTWRITEBYTECODE=1 PIP_NO_CACHE_DIR=1

# Install git CLI
RUN apt-get update && apt-get install -y git && apt-get clean all

# Install supervisord (supervisor-stdout is not py3 compatible in pypi)
RUN pip install supervisor git+https://github.com/coderanger/supervisor-stdout

# Sets work directory to /code
WORKDIR /code

# Allows docker to cache installed dependencies between builds
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY supervisord.conf /etc/supervisord.conf

# Adds our application code to the image
COPY . /code
COPY --from=build-stage /app/dist /code/tau-dashboard/dist

CMD bash -c "./scripts/start.sh"
