-- This file is a part of the SteamWar software.
--
-- Copyright (C) 2021  SteamWar.de-Serverteam
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU Affero General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
-- GNU Affero General Public License for more details.
--
-- You should have received a copy of the GNU Affero General Public License
-- along with this program.  If not, see <https://www.gnu.org/licenses/>.

---
--- This file contains the definitions for the SteamWar.de script API.
--- It is used by the IDE to provide code completion and type checking.
--- Created by Chaoscaot
---

inventory = {}

---@param title string
---@param size number
---@return Inventory
function inventory.create(title, size) return nil end

---@alias InventoryClick 'LEFT' | 'SHIFT_LEFT' | 'RIGHT' | 'SHIFT_RIGHT' | 'MIDDLE' | 'NUMBER_KEY'

---@class Inventory
local Inventory = {}

---@overload fun(slot: number, material: string, name: string, handler: fun(click: InventoryClick)): void
---@overload fun(slot: number, material: string, name: string, handler: fun(click: InventoryClick), lore: string[]): void
---@overload fun(slot: number, material: string, name: string, handler: fun(click: InventoryClick), lore: string[], enchanted: boolean): void
---@param slot number
---@param material string
---@param name string
---@param handler fun(click: InventoryClick): void
---@param lore string[]
---@param enchanted boolean
---@param amount number

function Inventory.item(slot, material, name, handler, lore, enchanted, amount) end

---@param handler fun(): void

function Inventory.setCloseHandler(handler) end

function Inventory.open() end

player = {}

---@return string
---Get the name of the player.
function player.name() return "" end

function player.chat(...) end

---Send a message to the actionbar of the player.
function player.actionbar(...) end

---@overload fun(): number
---@param newX number
function player.x(newX) end

---@overload fun(): number
---@param newY number
function player.y(newY) end

---@overload fun(): number
---@param newZ number
function player.z(newZ) end

---@overload fun(): number
---@param newYaw number
function player.yaw(newYaw) end

---@overload fun(): number
---@param newPitch number
function player.pitch(newPitch) end

---@return boolean
function player.sneaking() return nil end

---@return boolean
function player.sprinting() return nil end

---@overload fun(): number
---@param newSlot number
function player.slot(newSlot) end

---@return string
function player.item() return nil end

---@return string
function player.offHandItem() return nil end

function player.closeInventory() end

---@field nextBool fun(): boolean
random = {}

---@overload fun(): number
---@overload fun(bound: number): number
---@param origin number
---@param bound number
---@return number
function random.nextInt(origin, bound) return nil end

---@overload fun(): number
---@overload fun(bound: number): number
---@param origin number
---@param bound number
---@return number
function random.nextDouble(origin, bound) return nil end

---@return boolean
function random.nextBool() return nil end

---@alias RegionType 'wg' | 'mwg' | 'as' | 'ws' | 'ws_inner' | 'ws_rumpf' | 'ws_rahmen' | 'spawn'

---@class iregion
---@field tnt tnt
---@field trace trace
local iregion = {}

---@class region: iregion
region = {}

---@return string
function iregion.name() return nil end

---@return RegionType
function iregion.type() return nil end

---@return boolean
function iregion.fire() return nil end

---@return boolean
function iregion.freeze() return nil end

---@return boolean
function iregion.protect() return nil end

---@return string
function iregion.loader() return nil end

---@return Position
function iregion.copyPoint() return nil end

---@return Position
function iregion.minPointBuild() return nil end

---@return Position
function iregion.maxPointBuild() return nil end

---@return Position
function iregion.minPointBuildExtension() return nil end

---@return Position
function iregion.maxPointBuildExtension() return nil end

---@return Position
function iregion.testblockPoint() return nil end

---@return Position
function iregion.minPointTestblock() return nil end

---@return Position
function iregion.maxPointTestblock() return nil end

---@return Position
function iregion.minPointTestblockExtension() return nil end

---@return Position
function iregion.maxPointTestblockExtension() return nil end

---@alias TNTMode 'ALLOW' | 'DENY' | 'ONLY_TB'

---@class tnt
local tnt = {}

---@return TNTMode
function tnt.mode() return nil end

---@return boolean
function tnt.enabled() return nil end

---@return boolean
function tnt.onlyTb() return nil end

---@return boolean
function tnt.onlyBuild() return nil end

---@param name string
---@return iregion
function region.get(name) return nil end

---@return iregion[]
function region.list() return nil end

---@class tracer
tracer = {}

---@class TraceRecord
---@field pos Position
---@field vel Position
---@field ticksSinceStart number
---@field fuse number
---@field isExplosion boolean
---@field isInWater boolean
---@field hasDestroyedBuild boolean
---@field hasDestroyedTestblock boolean

---@class Trace
---@field getId fun(): string
---@field getRecords fun(): {[number]: TraceRecord}

---@return {[number]: Trace}
function tracer.getTraces() end

---@class Position
---@field x number
---@field y number
---@field z number

---@class server
---@field tps tps
server = {}

---@return string
function server.time() return nil end

---@return number
function server.ticks() return nil end

---@param position Position
---@param material string
function server.setBlockAt(position, material)
  return nil
end

---@param position Position
function server.interactAt(position)
  return nil
end

---@param position Position
---@return string
function getBlockAt(position) return nil end

---@param position Position
---@param material string

function setBlockAt(position, material) return nil end

---@class tps
local tps = {}

---@return number
function tps.oneSecond() return nil end

---@return number
function tps.tenSecond() return nil end

---@return number
function tps.oneMinute() return nil end

---@return number
function tps.fiveMinute() return nil end

---@return number
function tps.tenMinute() return nil end

---@return number
function tps.current() return nil end

---@return number
function tps.limit() return nil end

---@class storage
---@field global storageLib
---@field player storageLib
---@field region storageLib
storage = {}

---@class storageLib
---Any Primitive, Array or Table will be saved across restarts, everything else will be discarded
local storageLib = {}

---@param key string
---@return any
function storageLib.get(key) return nil end

---@param key string
---@param value any

function storageLib.set(key, value) end

---@param key string
---@return boolean
function storageLib.has(key) return nil end

---@param key string

function storageLib.remove(key) end

---@param key string
---@return Accessor
function storageLib.accessor(key) return nil end

---@class Accessor
---@overload fun(): any
---@overload fun(value: any)

---@class Selection
---@field max Position
---@field min Position

---@class _worldedit
_worldedit = {}

---@overload fun(pos: Position[]): void
---@return Selection
function _worldedit.selection() return nil end

---@param msg string
---@param callback fun(value: string): void

function input(msg, callback) end

---@param ticks number
---@param callback fun(): void

function delayed(ticks, callback) end

---@param x number
---@param y number
---@param z number
---@return Position
function pos(x, y, z) return nil end

function exec(...) end

---@param obj any
---@return number
function length(obj) return 0 end

---@param separator string
---@param table any[]
---@return string
function join(separator, table) return "" end

---@class EventType
---@class events
---@field DoubleSwap EventType
---@field PlaceBlock EventType
---@field BreakBlock EventType
---@field RightClick EventType
---@field LeftClick EventType
---@field TNTSpawn EventType
---@field TNTExplode EventType
---@field TNTExplodeInBuild EventType
---@field SelfJoin EventType
---@field SelfLeave EventType
---@field DropItem EventType
---@field EntityDeath EventType
events = {}


---@param id EventType
---@param handler fun(params: any): void

function event(id, handler) end

---@param command string
---@param handler fun(params: string[]): void

function command(command, handler) end

---@param trigger string
---@param handler fun(pressed: boolean): void

function hotkey(trigger, handler) end

---@class bossbar
bossbar = {}

---@alias BossBarColor 'PINK' | 'BLUE' | 'RED' | 'GREEN' | 'YELLOW' | 'PURPLE' | 'WHITE'
---@alias BossBarStyle 'SEGMENTED_6' | 'SEGMENTED_10' | 'SEGMENTED_12' | 'SEGMENTED_20' | 'SOLID'
---@alias BossBarFlag 'DARKEN_SKY' | 'PLAY_BOSS_MUSIC' | 'CREATE_FOG'

---@class BossBar
local BossBar = {}

---@param title string
---@param color BossBarColor
---@param style BossBarStyle
---@return BossBar
function bossbar.create(title, color, style) return nil end

---@return string
---@overload fun(title: string): void
function BossBar.title() end

---@return BossBarColor
---@overload fun(color: BossBarColor): void
function BossBar.color() end

---@return BossBarStyle
---@overload fun(style: BossBarStyle): void
function BossBar.style() end

---@return number
---@overload fun(progress: number): void
function BossBar.progress() end

---@return boolean
---@overload fun(visible: boolean): void
function BossBar.visible() end

---@return boolean
---@param flag BossBarFlag
function BossBar.hasFlag(flag) return nil end

---@param flag BossBarFlag
function BossBar.addFlag(flag) end

---@return boolean
---@param flag BossBarFlag
function BossBar.removeFlag(flag) return nil end

function BossBar.destroy() end
