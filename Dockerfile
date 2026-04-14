FROM python:3.9.7-slim-buster

# 1. Archive links set karna aur Expired Repository check bypass karna
RUN sed -i 's/deb.debian.org/archive.debian.org/g' /etc/apt/sources.list && \
    sed -i 's/security.debian.org/archive.debian.org/g' /etc/apt/sources.list && \
    sed -i '/buster-updates/d' /etc/apt/sources.list

# 2. Update aur Packages (Bypass flag ke saath)
RUN apt-get -o Acquire::Check-Valid-Until=false update && \
    apt-get install -y --no-install-recommends \
    git \
    curl \
    python3-pip \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# 3. Workdir aur Pip setup
WORKDIR /app
RUN pip3 install --no-cache-dir --upgrade pip

# 4. Files copy aur Requirements
COPY . /app/
RUN pip3 install --no-cache-dir -U -r requirements.txt

CMD ["bash", "start.sh"]
