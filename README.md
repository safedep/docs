# SafeDep Documentation

Built with [Mintlify](https://mintlify.com).

See [CONTRIBUTING.md](CONTRIBUTING.md) for more information and [CLAUDE.md](CLAUDE.md) for instructions on how to use AI code generation with the necessary context.

## Development

### Run with Docker

Mintlify does not document an official public container image. This repository builds a local image with the official Node 24 image and the Mintlify CLI.

You need Docker and Make. Start the local preview from the repository root.

```bash
make dev
```

Open [http://localhost:3000](http://localhost:3000).

The command mounts the current directory at `/docs`. Mintlify reloads the preview when you edit a file. The command stores the Mintlify runtime cache in a Docker volume.

Set `PORT` when port `3000` is not available.

```bash
make dev PORT=3333
```

The preview listens only on `127.0.0.1` by default. Set `PREVIEW_HOST=0.0.0.0` when another computer must access it.

```bash
make dev PREVIEW_HOST=0.0.0.0
```

The Dockerfile pins the Node 24 base image by digest. It also pins the Mintlify CLI version. Set `MINTLIFY_VERSION` to test another CLI version.

```bash
make dev MINTLIFY_VERSION=4.2.882
```

### Run with a local CLI

Install the [Mintlify CLI](https://www.npmjs.com/package/mintlify) to preview the documentation changes locally.

```bash
npm i -g mintlify
```

Run the command from the repository root.

```bash
mintlify dev
```

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for more information.
