docker run -it --rm -p 8888:8888 -v ~/:/local local/fbprophet /bin/bash -c "jupyter notebook --allow-root --ip='*' --no-browser --NotebookApp.token=''"
