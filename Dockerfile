FROM python:3.9.7-slim-buster

# 1. Archive repositories set karna kyunki Buster end-of-life hai
RUN sed -i 's/deb.debian.org/archive.debian.org/g' /etc/apt/sources.list && \
    sed -i 's/security.debian.org/archive.debian.org/g' /etc/apt/sources.list && \
    sed -i '/buster-updates/d' /etc/apt/sources.list

# 2. Update aur necessary packages install karna
# Upgrade ko hata diya hai (best practice) aur cache clean kiya hai
RUN apt-get update && apt-get install -y \
    git \
    curl \
    python3-pip \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# 3. Pip update karna
RUN pip3 install --no-cache-dir --upgrade pip

# 4. App files copy aur setup
WORKDIR /app
COPY . /app/

# 5. Requirements install karna
RUN pip3 install --no-cache-dir -U -r requirements.txt

CMD ["bash", "start.sh"]
