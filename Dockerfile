FROM node:24-bookworm-slim@sha256:2fe369e969550cde8e867afc3fe370b260140cab4a23d467074295b42163d553

ARG MINTLIFY_VERSION=4.2.882

RUN npm install --global "mintlify@${MINTLIFY_VERSION}" \
    && npm cache clean --force \
    && mkdir -p /home/node/.mintlify /home/node/.config/mintlify \
    && chown -R node:node /home/node/.mintlify /home/node/.config

USER node
WORKDIR /docs

EXPOSE 3000

CMD ["mintlify", "dev", "--host", "0.0.0.0", "--port", "3000", "--no-open"]
