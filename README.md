# WheelSteal

A car marketplace for CS3600. Vue 3 + Vite frontend, PHP API, MySQL database.

## Requirements

- Node.js 22.18+ or 24.12+
- PHP 8.1+ (with the `pdo_mysql` extension, included by default in most installs)
- MySQL 8

On macOS with Homebrew:

```sh
brew install node php mysql@8.0
```

## Setup

1. **Clone and install dependencies**

   ```sh
   git clone https://github.com/Narwhale14/CS3600-Final.git
   cd CS3600-Final
   npm install
   ```

2. **Start MySQL** (Homebrew: `brew services start mysql@8.0`)

3. **Create the database and load the demo data**

   ```sh
   mysql -u root -p < database/schema.sql
   mysql -u root -p < database/seed.sql
   ```

   Leave off `-p` if your MySQL root user has no password. To reset the database to the demo data later, run `npm run db:clear` then `npm run db:seed`.

4. **Add your database login**

   ```sh
   cp .env.example .env
   ```

   Then fill in `DB_PASS` in `.env` with your MySQL password, in quotes (e.g. `DB_PASS="my;pass"`), since `;` or `#` would otherwise cut it off. `.env` is gitignored, so never commit it.

## Running

```sh
npm run full
```

This starts the PHP API on `localhost:8000` and the Vite dev server on `localhost:5173`. Open http://localhost:5173. Vite forwards `/api` requests to PHP.

To run them separately, use `npm run api` and `npm run dev` in two terminals.

To check the API on its own, open http://localhost:5173/api/cars. You should see the cars as JSON.

## Other commands

- `npm run build`: type-check and build for production into `dist/`
- `npm run type-check`: type-check only
- `npm run db:clear`: deletes the database and recreates it with empty tables from `schema.sql` (DANGEROUS, deletes all data)
- `npm run db:seed`: loads the demo data. Only works on empty tables, so run `db:clear` first
