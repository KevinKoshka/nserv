import { Colors, DenoMysql } from "../deps.ts";
import { EndpointHandler, RequestMethod } from "./requestHandler.ts";
import { Users } from './models/schemas.ts';

const server = Deno.listen({ port: 8080 });
console.warn(
    Colors.yellow(`HTTP web server running at: http://localhost:8080/`),
);

const eHandler = new EndpointHandler([
    {
        method: RequestMethod.POST,
        url: "/index/login",
        callbackFn: async (reqEvent: Deno.RequestEvent, dbClient: DenoMysql.Client) => {
            const body: Users = await reqEvent.request.json();
            let dbUser = await dbClient.execute(`
                SELECT * FROM mkdb.users
                WHERE username='${body.username}' AND password=MD5('${body.password}')
                LIMIT 1
            `);

            if (dbUser.rows?.length) {
                const user: Users = {
                    name: dbUser.rows[0].name,
                    username: dbUser.rows[0].username,
                    uid: dbUser.rows[0].uid,
                };

                reqEvent.respondWith(new Response(
                    new Blob(
                        [JSON.stringify(user)],
                        { type: 'application/json' }
                    ),
                    { status: 201 }
                ));
            } else {
                reqEvent.respondWith(new Response(null, { status: 401, statusText: 'Incorrect username and/or password.'}));
            }
        },
    },

    {
        method: RequestMethod.GET,
        url: "/get-meals",
        callbackFn: async (reqEvent: Deno.RequestEvent, dbClient: DenoMysql.Client) => {
            let dbMeals = await dbClient.execute(`
                SELECT * FROM mkdb.meals
            `);

            if (dbMeals.rows?.length) {

                reqEvent.respondWith(new Response(
                    new Blob(
                        [JSON.stringify(dbMeals.rows)],
                        { type: 'application/json' }
                    ),
                    { status: 200 }
                ));
            } else {
                reqEvent.respondWith(new Response(null, { status: 204, statusText: 'No meals were found'}));
            }
        },
    },
]);

async function serverHttp(conn: Deno.Conn, dbClient: DenoMysql.Client) {
    const httpConn = Deno.serveHttp(conn);

    for await (const reqEvent of httpConn) {
        eHandler.switchHandler(reqEvent, dbClient);
    }
}

async function launch() {
    const client = await new DenoMysql.Client().connect({
        hostname: "127.0.0.1",
        username: "root",
        db: "mkdb",
        password: Deno.env.get('MYSQL_ROOT_PASSWORD'),
        port: 4008
    })
    for await (const conn of server) {
        serverHttp(conn, client);
    }
}

launch();
