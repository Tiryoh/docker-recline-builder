FROM node:20-slim

RUN apt-get update && apt-get install -y \
    git \
    ripgrep \
    fd-find \
    python3 \
    && rm -rf /var/lib/apt/lists/*

RUN npm install -g pnpm @vscode/vsce

# https://stackoverflow.com/questions/36996046/how-to-prevent-dockerfile-caching-git-clone/39278224#39278224
ADD https://api.github.com/repos/julesmons/recline/git/refs/heads/main recline-version.json

WORKDIR /app

RUN git clone https://github.com/julesmons/recline.git .

RUN pnpm install

RUN pnpm run package

# output: /app/recline-*.vsix
CMD [ "sh", "-c", "cp /app/recline-*.vsix /output/" ]
