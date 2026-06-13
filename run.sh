#!/bin/bash

case "$1" in
  build_generator)
    docker build -t hs-generator ./generator
    ;;
    
  run_generator)
    mkdir -p data
    docker run --rm -v "$(pwd)/data:/data" hs-generator
    ;;
    
  create_local_data)
    mkdir -p local_data
    python3 generator/generate.py local_data
    ;;
    
  build_reporter)
    docker build -t hs-reporter ./reporter
    ;;
    
  run_reporter)
    mkdir -p data
    docker run --rm -v "$(pwd)/data:/data" hs-reporter
    ;;
    
  structure)
    if command -v tree &> /dev/null; then
      tree .
    else
      find . -not -path '*/.*'
    fi
    ;;
    
  clear_data)
    rm -f data/*.csv data/*.html
    echo "Папка data очищена."
    ;;
    
  inside_generator)
    docker run --rm -v "$(pwd)/data:/data" hs-generator ls -la /data
    ;;
    
  inside_reporter)
    docker run --rm -v "$(pwd)/data:/data" hs-reporter ls -la /data
    ;;
    
  report_server)
    echo "Запуск сервера. Если вы в GitHub Codespaces, откройте проброшенный порт 8080."
    docker run -d --name local-web-server -p 8080:80 -v "$(pwd)/data:/usr/share/nginx/html:ro" nginx:alpine
    ;;
    
  *)
    echo "Использование: ./run.sh {build_generator|run_generator|create_local_data|build_reporter|run_reporter|structure|clear_data|inside_generator|inside_reporter|report_server}"
    exit 1
    ;;
esac