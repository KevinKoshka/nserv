import { Colors, DenoMysql } from '../deps.ts';
import { baseHeaders } from './main.ts';

export enum RequestMethod {
    GET = 'GET',
    POST = 'POST',
    UPDATE = 'UPDATE',
    OPTIONS = 'OPTIONS',
    DELETE = 'DELETE'
}

export interface IRequestHandler {
    method: RequestMethod,
    url: string,
    callbackFn: (req: Deno.RequestEvent, dbClient: DenoMysql.Client) => void,
}

export class EndpointHandler {
    handlers: Array<IRequestHandler>;
    private endpointsUrls: Array<string>;
    private reqEvent?: Deno.RequestEvent;
    private uri?: URL;
    private method?: string;

    constructor(handlers: Array<IRequestHandler>) {
        this.handlers = handlers;
        this.endpointsUrls = this.handlers.map(val => val.url);
    }

    switchHandler(reqEvent: Deno.RequestEvent, dbClient: DenoMysql.Client) {
        this.reqEvent = reqEvent;
        this.uri = new URL(this.reqEvent.request.url);
        this.method = this.reqEvent.request.method;

        if (this.method === RequestMethod.OPTIONS && this.endpointsUrls.find(val => val === this.uri?.pathname)) {
            console.info(Colors.brightCyan(this.uri?.toString()));
            this.reqEvent?.respondWith(new Response(
                null,
                {
                    'status': 200,
                    'statusText': 'Probe accepted.',
                    headers: baseHeaders
                }
            ));
            return;
        }

        const endpoint = this.handlers.find((val) => {
            if (val.url === this.uri?.pathname && val.method === this.method) {
                return val;
            }
            return;
        });

        if (endpoint) {
            console.info(Colors.brightCyan(this.uri?.toString()));
            endpoint?.callbackFn(this.reqEvent, dbClient);
        } else {
            console.error(Colors.brightRed('Request failed at: ' + this.uri?.toString()));
            this.reqEvent?.respondWith(new Response(
                null,
                {
                    'status': 404,
                    'statusText': 'URL not found.',
                    headers: baseHeaders
                }
            ));
        }
    }
}
