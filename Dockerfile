FROM python:3.9.7-slim-buster

# 1. Repositories ko archive links par switch karein aur security check bypass karein
RUN sed -i 's/deb.debian.org/archive.debian.org/g' /etc/apt/sources.list && \
    sed -i 's/security.debian.org/archive.debian.org/g' /etc/apt/sources.list && \
    sed -i '/buster-updates/d' /etc/apt/sources.list

# 2. Update aur Install (Yahan Acquire::Check-Valid-Until=false zaroori hai)
RUN apt-get -o Acquire::Check-Valid-Until=false update && \
    apt-get install -y --no-install-recommends \
    git \
    curl \
    python3-pip \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# 3. Pip upgrade aur App setup
RUN pip3 install --no-cache-dir --upgrade pip
WORKDIR /app
COPY . /app/
RUN pip3 install --no-cache-dir -U -r requirements.txt

CMD ["bash", "start.sh"]
