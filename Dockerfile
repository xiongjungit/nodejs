#
# Node.js Dockerfile
#
# https://github.com/dockerfile/nodejs
#

# Pull base image.
FROM dockerfile/python

# Install Node.js
RUN \
  cd /tmp && \
  wget http://npm.taobao.org/mirrors/node/v0.10.40/node-v0.10.40.tar.gz  && \
  tar xvzf node-v0.10.40.tar.gz && \
  rm -f node-v0.10.40.tar.gz && \
  cd node-v* && \
  ./configure && \
  CXX="g++ -Wno-unused-local-typedefs" make && \
  CXX="g++ -Wno-unused-local-typedefs" make install && \
  cd /tmp && \
  rm -rf /tmp/node-v* && \
  npm config set registry https://registry.npm.taobao.org && \
  npm install -g npm && \
  printf '\n# Node.js\nexport PATH="node_modules/.bin:$PATH"' >> /root/.bashrc

# Define working directory.
WORKDIR /data

# Define default command.
CMD ["bash"]
