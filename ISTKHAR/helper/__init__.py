import os
import sys
from pyrogram import Client



def restart():
    os.execvp(sys.executable, [sys.executable, "-m", "ISTKHAR"])

async def join(client):
    try:
        await client.join_chat("PURVI_SUPPORT")
    except BaseException:
        pass
