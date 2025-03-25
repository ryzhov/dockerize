#!/usr/bin/env node

const shutdown = message => {
    console.log(message);
    process.exit(0);
};

process.on('SIGINT',  () => shutdown('Exit on SIGINT'));
process.on('SIGTERM', () => shutdown('Exit on SIGTERM'));

const fn = timeout => setTimeout(fn, timeout, timeout);
fn(3600000);
