import { Colors, DenoMysql } from '../deps.ts';
import { EndpointHandler, RequestMethod } from './requestHandler.ts';
import { Users, Meals, GuestsView } from './models/schemas.ts';

export const baseHeaders = new Headers({
    'Access-Control-Allow-Origin': Deno.env.get('ORIGIN') as string,
    'Access-Control-Allow-Methods': 'POST, GET, PATCH, OPTIONS, PUT, DELETE',
    'Access-Control-Allow-Headers': '*',
    'Access-Control-Allow-Credentials': 'true'
});
console.log(Deno.env.get('ORIGIN'))

// const server = Deno.listenTls({ port: 8080, certFile: './cert.pem', keyFile: './private.pem' });
const server = Deno.listen({ port: 8080});
console.warn(
    Colors.yellow(`HTTP web server running at: http://localhost:8080/`),
);

const eHandler = new EndpointHandler([
    {
        method: RequestMethod.POST,
        url: '/index/login',
        callbackFn: async (reqEvent: Deno.RequestEvent, dbClient: DenoMysql.Client) => {
            const body: Users = await reqEvent.request.json();
            const dbUser = await dbClient.execute(`
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
                        {type: 'application/json' }
                    ),
                    {
                        status: 202,
                        headers: baseHeaders
                    }
                ));
            } else {
                reqEvent.respondWith(new Response(null, {
                    status: 401,
                    statusText: 'Incorrect username and/or password.',
                    headers: baseHeaders
                }));
            }
        },
    },

    {
        method: RequestMethod.GET,
        url: '/get-meals',
        callbackFn: async (reqEvent: Deno.RequestEvent, dbClient: DenoMysql.Client) => {
            const dbMeals = await dbClient.execute(`
                SELECT * FROM mkdb.meals
            `);
            const dbGuests = await dbClient.execute(`
                SELECT * FROM mkdb.v
            `);

            if (dbMeals.rows?.length) {
                const guestList = dbGuests.rows as Array<GuestsView>;
                const sortedMealsList: Array<Meals> = dbMeals.rows.sort((a: Meals, b: Meals) => {
                    return a.mid - b.mid;
                }).map((el) => {
                    const guests = guestList.filter((g: GuestsView) => {
                        return g.meal_id === el.mid
                    }).map((g) => {
                        return {
                            username: g.username,
                            name: g.name,
                            uid: g.uid,
                        }
                    });
                    return Object.assign(el, { guest_list: guests.length ? guests : [] });
                });

                reqEvent.respondWith(new Response(
                    new Blob(
                        [JSON.stringify(sortedMealsList)],
                        { type: 'application/json' }
                    ),
                    { status: 200, headers: baseHeaders }
                ));
            } else {
                reqEvent.respondWith(new Response(null, {
                    status: 204,
                    statusText: 'No meals were found',
                    headers: baseHeaders
                }));
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
        hostname: '127.0.0.1',
        username: 'root',
        db: 'mkdb',
        password: Deno.env.get('MYSQL_ROOT_PASSWORD'),
        port: 4008
    })
    for await (const conn of server) {
        serverHttp(conn, client);
    }
}

launch();
