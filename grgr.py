import asyncio
from discord import Interaction
from discord.ext.commands.core import has_permissions
import discord
from discord.ext import commands
import os
from discord.ui import Item
import time

import yt_dlp

intents = discord.Intents.default()
intents.members = True
intents.message_content = True
bot = discord.Client(intents=intents)
tree = discord.app_commands.CommandTree(bot)
bot = commands.Bot(command_prefix='!', intents=intents)
bot.remove_command('help')

@bot.command(name='reel')
async def download_reel(ctx, url: str):
    try:
        # Options for yt-dlp to download Instagram Reels
        ydl_opts = {
            'format': 'best',
            'outtmpl': '%(title)s.%(ext)s',
            'nooverwrites': True,
            'no_color': True,
            'no_warnings': True,
            'ignoreerrors': False,
            'extract_flat': False,
        }
        
        # Send initial message
        messagee = await ctx.send("Downloading Reel... Please wait.")
        
        # Download the Reel
        with yt_dlp.YoutubeDL(ydl_opts) as ydl:
            info_dict = ydl.extract_info(url, download=True)
            file_name = ydl.prepare_filename(info_dict)
        
        # Check if file exists
        if not os.path.exists(file_name):
            await ctx.send("Failed to download the Reel.")
            return
        
        # Send the downloaded file to Discord
        await ctx.message.delete()
        await messagee.delete()
        await ctx.send(file=discord.File(file_name))
        
        # Delete the local file after sending
        os.remove(file_name)
        
    except Exception as e:
        print(f"An error occurred: {str(e)}")
@bot.command(name='gank', description='for summoning a user')
async def send_dm(ctx, member: discord.Member):
    message_list =[]
    message_list.append(ctx.message)
    for i in range(20):
        message = await ctx.send(member.mention)
        message_list.append(message)
        time.sleep(0.7)
    time.sleep(2)
    await ctx.channel.delete_messages(message_list)
    channel = await member.create_dm()
    await channel.send(f"{ctx.author.mention} needs you right now")

@bot.hybrid_command(name="clear", description="Clean up conversations")
async def clear(ctx, amount: int):
    if amount == 0:
        await ctx.send("Please enter the amount of message that you want to clear")
    if amount < 1 or amount > 100:
        await ctx.send("you can delete between 1 and 100  ")
    await ctx.channel.purge(limit=int(amount))
@bot.command()
async def give_role(ctx, member: discord.Member):
    role_id = 1323736266822652038  # معرف الرول المطلوب
    role = ctx.guild.get_role(role_id)  # جلب الرول من السيرفر

    if role is None:
        await print("❌ Role not found!")
        return

    if role in member.roles:
        await print(f"{member.mention} already has this role! ✅")
    else:
        await member.add_roles(role)
        await print(f"✅ {member.mention} has been given the role `{role.name}`!")
    

    


# Bot token - replace with your actual bot token

BOT_TOKEN = os.getenv("BOT_TOKEN")

bot.run(BOT_TOKEN)