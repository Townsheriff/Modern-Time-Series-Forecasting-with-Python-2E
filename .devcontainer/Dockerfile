FROM ubuntu:24.04 AS data_stage

# Install dependencies required for downloading and extracting
RUN apt-get update && apt-get install -y --no-install-recommends \
  curl unzip ca-certificates \
  && rm -rf /var/lib/apt/lists/*

RUN update-ca-certificates

# Create the /data directory
RUN mkdir -p /data

# Download and unzip the file
RUN curl -o /data/data.zip https://packt-modern-time-series-py.s3.eu-west-1.amazonaws.com/data.zip \
  && unzip /data/data.zip -d /data \
  && rm /data/data.zip

# Stage 1: Application Setup
FROM ubuntu:24.04

# Install application dependencies
RUN apt-get update && apt-get upgrade -y && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  openssh-client \
  make cmake cmake-curses-gui ninja-build build-essential \
  wget curl locales tree xz-utils \
  zlib1g-dev libbz2-dev libreadline-dev \
  libsqlite3-dev \
  tk-dev libxml2-dev libxmlsec1-dev \
  libffi-dev liblzma-dev libssl-dev \
  git net-tools vim iputils-ping zip unzip \
  lldb lsof ca-certificates iproute2 \
  meson file \
  && rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV DISPLAY=:0

# Update CA certificates
RUN update-ca-certificates

# Install pyenv and Python
ENV HOME="/root"
ENV PYENV_ROOT="${HOME}/.pyenv"
ENV PATH="${PYENV_ROOT}/shims:${PYENV_ROOT}/bin:${PATH}"

RUN git clone --depth=1 https://github.com/pyenv/pyenv.git $PYENV_ROOT \
  && $PYENV_ROOT/bin/pyenv install 3.10 \
  && $PYENV_ROOT/bin/pyenv global 3.10

# Install Poetry
RUN curl -sSL https://install.python-poetry.org | python3 -

# Install VirtualEnv and ipykernel
RUN pip install virtualenv ipykernel

# Create the /data directory
RUN mkdir -p /data

# Copy data from the data_stage
COPY --from=data_stage /data /data

# Set up aliases and prompt
RUN echo 'alias ll="ls -alF"' >> /etc/bash.bashrc \
  && echo 'export PS1="\[\033[01;32m\]\u@\h:\w\$ \[\033[00m\]"' >> ~/.bashrc \
  && echo 'alias ll="ls --color=auto -lh"' >> ~/.bashrc \
  && echo 'alias grep="grep --color=auto"' >> ~/.bashrc

CMD ["/usr/bin/bash"]
