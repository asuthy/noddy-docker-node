const http = require('http')
const port = process.env.PORT || 3000

let server = http.createServer((req, res) => {
  if (req.url !== '/favicon.ico') {
    const params = require('url').parse(req.url, true).query
    const publication = params.publication
    const start = params.start
    const end = params.end

    processRequest(publication, start, end)
      .then(function (response) {
        res.writeHead(200, {
          'content-type': 'text/html'
        })

        return res.end(response)
      })
  }
})

// start listening
server.listen(port)
console.log(`Server running on port ${port}`)

async function processRequest (publication, start, end) {
  const knexDb = require('knex')({
    client: 'pg',
    connection: {
      port: 5432,
      host: 'postgres',
      user: 'postgres',
      password: 'postgres',
      database: 'prospect'
    },
    pool: {
      min: 1,
      max: 10
    }
  })

  const publicationResult = await knexDb.raw(`select * from publication where LOWER(publication_ref) = LOWER('${publication}')`)

  return `${publication} ${start} ${end} ${publicationResult.rows[0].id}`
}
