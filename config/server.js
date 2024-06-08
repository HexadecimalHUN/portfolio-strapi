module.exports = ({ env }) => ({
  proxy:true,
  host: env('HOST', '0.0.0.0'),
  port: env.int('PORT', 1337),
  app: {
    keys: env.array('APP_KEYS'),
  },
  watchIgnoreFiles: [
    '**/db.sqlite',
    '**/db.sqlite-journal'
  ],
  webhooks: {
    populateRelations: env.bool('WEBHOOKS_POPULATE_RELATIONS', false),
  },
});
