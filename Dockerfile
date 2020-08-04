FROM python:3.8.5-buster

RUN apt-get update \
    && apt-get install -y git

RUN pip install numpy
RUN pip install lxml
RUN pip install matplotlib
RUN pip install seaborn
RUN pip install pandas
RUN pip install xarray
RUN pip install jupyterlab
RUN pip install black
RUN pip install plotly
RUN pip install cython
RUN pip install scikit-learn
RUN pip install sktime
RUN pip install pmdarima
RUN pip install yfinance
RUN pip install catboost
RUN pip install shap
RUN pip install tensorflow
RUN pip install numba
RUN pip install pytest
RUN pip install missingno
RUN pip install jupyterlab_templates

RUN apt-get -y install curl gnupg
RUN curl -sL https://deb.nodesource.com/setup_12.x  | bash -
RUN apt-get -y install nodejs
RUN npm install

EXPOSE 8888
EXPOSE 8080

RUN jupyter labextension install jupyterlab-plotly  --minimize=False --no-build
RUN jupyter labextension install @aquirdturtle/collapsible_headings --minimize=False --no-build
RUN jupyter labextension install @ijmbarr/jupyterlab_spellchecker --minimize=False --no-build
RUN jupyter labextension install jupyterlab_templates --minimize=False --no-build
RUN jupyter lab build --minimize=False

RUN jupyter serverextension enable --py jupyterlab_templates

RUN jupyter notebook --generate-config
RUN echo "c.JupyterLabTemplates.template_dirs = ['/workdir/']" >> /root/.jupyter/jupyter_notebook_config.py
RUN echo "c.JupyterLabTemplates.include_default = True" >> /root/.jupyter/jupyter_notebook_config.py
RUN echo "c.JupyterLabTemplates.include_core_paths = True" >> /root/.jupyter/jupyter_notebook_config.py

#COPY requirements.txt requirements.txt
#RUN pip install -r requirements.txt

WORKDIR /workdir
CMD ["jupyter", "lab", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root"]
