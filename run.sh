mkdir -p ./data

case "$1" in
  build_generator)
    docker build -t hs-generator ./generator
    ;;
    
  run_generator)
    mkdir -p data
    docker run --rm -v "$(pwd)/data:/data" hs-generator
    echo "Файл data.csv успешно создан в папке data/"
    ;;
    
  create_local_data)
    mkdir -p local_data
    python3 generator/generate.py local_data
    echo "Файл data.csv успешно создан в папке local_data/"
    ;;

  build_reporter)
    docker build -t hs-reporter ./reporter
    ;;

  run_reporter)
    mkdir -p data
    docker run --rm -v "$(pwd)/data:/data" hs-reporter
    echo "Отчет report.html успешно создан в папке data/"
    ;;
    
  *)
    show_help
    exit 1
    ;;
esac