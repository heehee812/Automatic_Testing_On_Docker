FROM marketsquare/robotframework-browser

LABEL maintainer="Charlotte Chen <charlottechen@atop.com.tw>"
CMD ["bash"]

USER root
RUN apt-get update && apt-get install
RUN apt install vim -y
RUN apt-get install -y iputils-ping

ENV PATH="/home/pwuser/.local/bin:${PATH}"
ENV NODE_PATH=/usr/lib/node_modules

USER pwuser
RUN pip3 install --no-cache-dir --user --upgrade robotframework-seleniumlibrary robotframework-appiumlibrary
