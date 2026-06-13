#!/bin/bash

mkdir -p ./data

case "$1" in
    build_generator)
        docker build -t hw_generator -f Dockerfile.generator .
        ;;
    run_generator)
        docker run --rm -v "$(pwd)/data:/data" hw_generator
        ;;
    create_local_data)
        mkdir -p ./local_data
        python3 generate.py ./local_data
        ;;
    build_reporter)
        docker build -t hw_reporter -f Dockerfile.reporter .
        ;;
    run_reporter)
        docker run --rm -v "$(pwd)/data:/data" hw_reporter
        ;;
    structure)
        ls -laR
        ;;
    clear_data)
        rm -rf ./data/*
        echo "Данные очищены"
        ;;
    inside_generator)
        docker run --rm -v "$(pwd)/data:/data" hw_generator ls -la /data
        ;;
    inside_reporter)
        docker run --rm -v "$(pwd)/data:/data" hw_reporter ls -la /data
        ;;
    report_server)
        docker run --rm -d -p 8080:80 -v "$(pwd)/data:/usr/share/nginx/html:ro" --name hw_server nginx:alpine
        echo "Сервер запущен. Отчет доступен на порту 8080. Чтобы остановить, используй 'docker stop hw_server'"
        ;;
    *)
        echo "Команда не найдена. Попробуй одну из: build_generator, run_generator, build_reporter, run_reporter и т.д."
        ;;
esac