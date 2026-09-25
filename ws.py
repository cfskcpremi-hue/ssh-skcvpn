import asyncio
import websockets
import socket

async def tcp_proxy(ws, reader, writer):
    try:
        while True:
            data = await asyncio.wait_for(reader.read(4096), timeout=30)
            if not data:
                break
            await ws.send(data)
    except:
        pass

async def handler(ws):
    try:
        # Sambungkan ke SSH lokal di port 2222
        reader, writer = await asyncio.open_connection('127.0.0.1', 2222)

        # Buat jembatan bolak-balik antara WebSocket dan SSH TCP
        async def forward_ws_to_tcp():
            try:
                async for message in ws:
                    if isinstance(message, str):
                        message = message.encode()
                    writer.write(message)
                    await writer.drain()
            except:
                pass

        asyncio.create_task(forward_ws_to_tcp())
        await tcp_proxy(ws, reader, writer)
    except:
        pass

async def main():
    # Jalankan server WebSocket di port 443
    async with websockets.serve(handler, "0.0.0.0", 443):
        await asyncio.Future()

if __name__ == "__main__":
    asyncio.run(main())
