# SteamWar.de - Script System

---
<!-- TOC -->
* [SteamWar.de - Script System](#steamwarde---script-system)
  * [Einleitung](#einleitung)
  * [Nutzung mit einer IDE](#nutzung-mit-einer-ide)
* [Basis-Apis](#basis-apis)
* [SteamWar.de-Api](#steamwarde-api)
    * [player](#player)
    * [random](#random)
    * [region](#region)
      * [tnt](#tnt)
      * [trace](#trace)
  * [server](#server)
      * [tps](#tps)
  * [storage](#storage)
  * [inventory](#inventory)
* [SteamWar.de-Global-Api](#steamwarde-global-api)
  * [Commands](#commands)
  * [Hotkeys](#hotkeys)
  * [Eventtypen](#eventtypen)
    * [BlockEvent](#blockevent)
    * [InteractEvent](#interactevent)
    * [Position](#position)
* [Instabile APIs](#instabile-apis)
  * [_worldedit](#worldedit)
* [Beispiele](#beispiele)
  * [Hello, World!](#hello-world)
      * [Code](#code)
      * [Ausgabe](#ausgabe)
  * [BauGUI on DoubleSwap](#baugui-on-doubleswap)
      * [Code](#code-1)
  * [SL Command](#sl-command)
      * [Code](#code-2)
  * [Paste Hotkey](#paste-hotkey)
      * [Code](#code-3)
  * [Inventory](#inventory-1)
      * [Code](#code-4)
<!-- TOC -->


## Einleitung
Das Script System auf SteamWar.de basiert auf [Lua](https://www.lua.org/docs.html). 
Der Code wird einfach in ein Minecraft Buch geschrieben und kann mit einem Links-Klick ausgeführt werden.

## Nutzung mit einer IDE
Im Repository liegen [Lua-Definitionen](sw.def.lua) für [Luanalysis](https://plugins.jetbrains.com/plugin/14698-luanalysis).
Diese können in der IDE genutzt werden, um die APIs zu nutzen. 

Einfach die `sw.def.lua` in denselben Ordner wie das Script legen und die IDE sollte die APIs erkennen.

# Basis-Apis
Es werden folgende Standard-Apis zur Verfügung gestellt:
- [`math`](https://www.lua.org/manual/5.4/manual.html#6.7)
- [`string`](https://www.lua.org/manual/5.4/manual.html#6.4)
- [`table`](https://www.lua.org/manual/5.4/manual.html#6.6)
- [`bit32`](https://www.lua.org/manual/5.2/manual.html#6.7)

# SteamWar.de-Api
APIs, die mit einem `_` beginnen sind noch nicht stabil und können sich jederzeit ändern. 
Sie sollten daher nicht verwendet werden, da sie sich noch in der Entwicklung befinden.
Diese können auch undokumentierte Funktionen enthalten, die nicht in der Dokumentation aufgeführt sind.

In den Scripten gibt es dazu noch folgende globale Variablen:
- [`player`](#player)
- [`random`](#random)
- [`region`](#region)
- [`server`](#server)
- [`storage`](#storage)
- [`inventory`](#inventory)
- `_worldedit`

Ohne eine Kategorie sind folgende Funktionen verfügbar, die nicht allgemein sind:

| Name      | Signature                         | Beschreibung                                                                                                      |
|-----------|-----------------------------------|-------------------------------------------------------------------------------------------------------------------|
| `print`   | print(String...)                  | @see chat(String...)                                                                                              |
| `input`   | input(String, Function\<String>)  | Fragt den User nach einer Eingabe mit der Nachricht und called die zugehörige Funktion nach dieser                |
| `delayed` | delayed(Number, Function\<Void>)  | Wartet die angegebene Anzahl an Ticks und führt danach die zugehörige Funktion aus                                |
| `pos`     | pos(Number, Number, Number)       | Erstellt aus drei Zahlen eine Position-Table. Die Koordinaten sind unter den Namen `x`, `y` und `z` abgespeichert |
| `exec`    | exec(String...)                   | Führt den angegebenen Befehl als Spieler aus                                                                      |
| `length`  | length(Any): Int                  | Gibt die Länge des Objekts zurück                                                                                 |
| `join`    | length(String, String...): String | Füge die Texte mit den ersten Parameter zusammen                                                                  |

### player
Das `player`-Modul stellt Funktionen zur Verfügung, die den Spieler betreffen.
Es gibt folgende Funktionen:

| Name             | Signature                      | Beschreibung                                                                                                              |
|------------------|--------------------------------|---------------------------------------------------------------------------------------------------------------------------|
| `name`           | name(): String                 | Gibt den `displayName` des Spielers zurück                                                                                |
| `chat`           | chat(String...)                | Sendet den Text in den Chat des Spielers                                                                                  |
| `actionbar`      | actionbar(String...)           | Sendet den Text in die ActionBar des Spielers                                                                             |
| `x`              | x(Number), x(): Number         | Setzt oder gibt die X-Koordinate des Spielers                                                                             |
| `y`              | y(Number), y(): Number         | Setzt oder gibt die Y-Koordinate des Spielers                                                                             |
| `z`              | z(Number), z(): Number         | Setzt oder gibt die Z-Koordinate des Spielers                                                                             |
| `yaw`            | yaw(Number), yaw(): Number     | Setzt oder gibt die Gierung des Spielers                                                                                  |
| `pitch`          | pitch(Number), pitch(): Number | Setzt oder gibt die Steigung des Spielers                                                                                 |
| `sneaking`       | sneaking(): Boolean            | Wahr, wenn der Spieler am Sneaken ist                                                                                     |
| `sprinting`      | sprinting(): Boolean           | Wahr, wenn der Spieler am Sprinten ist                                                                                    |
| `slot`           | slot(Number), slot(): Number   | Setzt oder gibt den Slot des gehaltenden Items des Spielers [(Wiki)](https://minecraft.fandom.com/wiki/Slot#Java_Edition) |
| `item`           | item(): String                 | Gibt den Itemtyp der Main-Hand zurück                                                                                     |
| `offHandItem`    | offHandItem(): String          | Gibt den Itemtyp der Off-Hand zurück                                                                                      |
| `closeInventory` | closeInventory()               | Schließe das aktuell geöffnete Inventar des Spielers                                                                      |

### random
Das `random`-Modul stellt Funktionen zur Verfügung, die Zufallszahlen betreffen.
Es gibt folgende Funktionen:

| Name       | Signature                          | Beschreibung                                                                  |
|------------|------------------------------------|-------------------------------------------------------------------------------|
| nextInt    | nextInt(): Int                     | Gibt eine Zufallszahl zurück zwischen Integer.MIN_VALUE und Integer.MAX_VALUE |
| -"-        | nextInt(Int): Int                  | Gibt eine Zufallszahl zurück zischen 0 und dem Argument                       |
| -"-        | nextInt(Int, Int): Int             | Gibt eine Zufallszahl zurück zwischen dem ersten und zweiten Argument         |
| nextDouble | nextDouble(): Double               | Gibt eine Zufallszahl zurück zwischen 0 und 1                                 |
| -"-        | nextDouble(Double): Double         | Gibt eine Zufallszahl zurück zwischen 0 und dem Argument                      |
| -"-        | nextDouble(Double, Double): Double | Gibt eine Zufallszahl zurück zwischen ersten und zweiten Argument             |
| nextBool   | nextBool(): Boolean                | Gibt true oder false zurück                                                   |

### region
Das `region`-Modul stellt Funktion zur Verfügung, die die Region des Spielers betreffen.
Es gibt folgende Funktionen: 

| Name      | Signature           | Beschreibung                                                                                               |
|-----------|---------------------|------------------------------------------------------------------------------------------------------------|
| `name`    | name(): String      | Gibt den Regionsnamen                                                                                      | 
| `type`    | type(): String      | Gibt den Regionstyp                                                                                        |
| `fire`    | fire(): Boolean     | Gibt den Fire-Modus der Region zurück                                                                      |
| `freeze`  | freeze(): Boolean   | Gibt den Freeze-Modus der Region zurück                                                                    |
| `protect` | protect(): Boolean  | Gibt den Protect-Modus der Region zurück                                                                   |
| `loader`  | loader(): String    | Gibt den Status des Loaders des Spielers zurück, die Werte sind: `OFF`, `SETUP`, `RUNNING`, `PAUSE`, `END` |
| `get`     | get(String): Region | Gibt die Region mit dem Namen zurück. Die Region ist gleich aufgebaut wie das Regions-Modul                |
| `list`    | list(): Region[]    | Gibt alle Region zurück. Die Region ist gleich aufgebaut wie das Regions-Modul                             |

Es gibt folgende weitere Module:

| Name    | Beschreibung    |
|---------|-----------------|
| `tnt`   | [tnt](#tnt)     |
| `trace` | [trace](#trace) |

#### tnt
Das `tnt`-Modul stellt Funktionen zur Verfügung, die den TNT-Modus in der Region des Spielers betreffen.
Es gibt folgende Funktionen:

| Name        | Signature            | Beschreibung                                                                        |
|-------------|----------------------|-------------------------------------------------------------------------------------|
| `mode`      | mode(): String       | Gibt den Aktuellen TNT-Modus zurück, die werte sind: `ALLOW`, `DENY` oder `ONLY_TB` |
| `enabled`   | enabled(): Boolean   | Gibt zurück, ob der TNT-Modus in der Region des Spielers aktiviert ist oder nicht   |
| `onlyTb`    | onlyTb(): Boolean    | Gibt zurück, ob der TNT-Modus auf Only-Tb ist                                       |
| `onlyBuild` | onlyBuild(): Boolean | Gibt zurück, ob der TNT-Modus auf Only-Build ist                                    |


#### trace
Das `trace`-Modul stellt Funktionen zur Verfügung, die den Status des Tracers der Region betreffen.
Es gibt folgende Funktionen:

| Name     | Signature         | Beschreibung                                                                   |
|----------|-------------------|--------------------------------------------------------------------------------|
| `active` | active(): Boolean | Gibt zurück, ob der Tracer in der Region des Spielers aktiviert ist oder nicht |
| `auto`   | auto(): Boolean   | Gibt zurück, ob der Tracer in der Region ein Auto-Tracer ist                   |
| `status` | status(): String  | Gibt den Status des Tracers zurück                                             |
| `time`   | time(): String    | Gibt die Zeit des Tracers zurück                                               |

## server
Das `server`-Modul stellt Funktionen zur Verfügung, die den Server betreffen.
Es gibt folgende Funktionen:

| Name         | Signature               | Beschreibung                                                        |
|--------------|-------------------------|---------------------------------------------------------------------|
| `time`       | time(): String          | Gibt die aktuelle Zeit im Format `HH:mm:ss` zurück                  |
| `ticks`      | ticks(): Number         | Gibt die Ticks seit start des Serverstarts zurück                   |
| `getBlockAt` | getBlockAt(Pos): String | Gibt das Material an der Position zurück                            |
| `setBlockAt` | setBlockAt(Pos, String) | Setzt das Material an der angegebenen Stelle (z.B. Stein = `STONE`) |

Es gibt folgende weitere Module:

| Name  | Beschreibung |
|-------|--------------|
| `tps` | [tps](#tps)  |

#### tps
Das `tps`-Modul stellt Funktionen zur Verfügung, die die TPS des Servers betreffen.
Es gibt folgende Funktionen:

| Name         | Signature            | Beschreibung                                                      |
|--------------|----------------------|-------------------------------------------------------------------|
| `current`    | current(): Number    | Gibt die aktuelle TPS zurück (Das selbe wie `oneSecound()`)       |
| `oneSecond`  | oneSecond(): Number  | Gibt die durchschnittliche TPS über die letzte Sekunde zurück     |
| `tenSecond`  | tenSecond(): Number  | Gibt die durchschnittliche TPS über die letzte 10 Sekunden zurück |
| `oneMinute`  | oneMinute(): Number  | Gibt die durchschnittliche TPS über die letzte Minute zurück      |
| `fiveMinute` | fiveMinute(): Number | Gibt die durchschnittliche TPS über die letzte 5 Minuten zurück   |
| `tenMinute`  | tenMinute(): Number  | Gibt die durchschnittliche TPS über die letzte 10 Minuten zurück  |
| `limit`      | limit(): Number      | Gibt das TPS-Limit zurück                                         |

## storage
Das `storage`-Modul stellt Funktionen zur Verfügung, mit welchen man Werte speichern kann.

Es gibt folgende Module:

| Name     | Beschreibung        |
|----------|---------------------|
| `player` | Spieler abhängig    |
| `region` | Region des Spielers |
| `global` | Alle Skripte        |

Alle Module haben folgende Funktionen:

| Name       | Signature                  | Beschreibung                                           |
|------------|----------------------------|--------------------------------------------------------|
| `get`      | get(String): Any           | Gibt den Wert des Schlüssels zurück                    |
| `set`      | set(String, Any)           | Setzt den Wert des Schlüssels auf den angegebenen Wert |
| `has`      | has(String): Boolean       | Prüft ob ein Wert vorhanden ist                        |
| `remove`   | remove(String)             | Löscht den Schlüssel                                   |
| `accessor` | accessor(String): Accessor | Gibt einen Accessor zurück                             |

Ein Accessor ist ein Objekt, womit du direkt auf einen Wert zugreifen kannst und es ändern kannst.
Es geht wie folgt:
```lua
keyAccessor = storage.player.accessor("key")

keyAccessor("Hello World") -- Setzt den Wert auf "Hello World"
print(keyAccessor()) -- Gibt den Wert zurück
```

## inventory
Das `inventory`-Modul stellt Funktionen zur Verfügung, um ein Inventar zu öffnen.
Es gibt folgende Funktionen:

| Name     | Signature                         | Beschreibung                                                      |
|----------|-----------------------------------|-------------------------------------------------------------------|
| `create` | create(String, Number): Inventory | Erstellt ein Inventar mit dem Title und der Anzahl an Zeilen      |

Das `Inventory`-Objekt hat folgende Funktionen:

| Name              | Signature                                                                      | Beschreibung                                                                                                                                                                                                            |
|-------------------|--------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `item`            | item(Number, String, String, Function\<String>)                                | Setze ein Item mit dem Typen des ersten Strings an den Slot (Startet bei 0) mit dem Namen des zweiten Strings mit einem Klick-Handler der den Klick-Typen rein gibt (z.B. `LEFT`, `SHIFT_LEFT`, `RIGHT`, `SHIFT_RIGHT`) | 
| -"-               | item(Number, String, String, Function\<String>, List<String>)                  | Füge eine Lore an das Item hinzu                                                                                                                                                                                        |
| -"-               | item(Number, String, String, Function\<String>, List<String>, Boolean)         | Gebe an, ob das Item enchanted sein soll                                                                                                                                                                                |
| -"-               | item(Number, String, String, Function\<String>, List<String>, Boolean, Number) | Gebe die Anzahl der Items an                                                                                                                                                                                            |
| `setCloseHandler` | setCloseHandler(Function\<Void>)                                               | Gebe einen Handler an, der beim schließen des Inventares ausgeführt wird                                                                                                                                                |
| `open`            | open()                                                                         | Öffne das Inventar                                                                                                                                                                                                      |

Siehe auch: [Inventory Beispiel](#inventory-1)

Siehe auch: [Liste an Materials](https://hub.spigotmc.org/javadocs/bukkit/org/bukkit/Material.html)

```
⚠️⚠️⚠️

Wenn eine Barrier statt des richtigen Items angezeigt wird, dann ist das angegebene Material nicht gültig.

⚠️⚠️⚠️
```

# SteamWar.de-Global-Api
Mit `/script` kann man Script-Bücher global abspeichern. Diese haben dann zugrif auf die `global`-Api.
Die `global`-Api stellt Funktionen zur Verfügung um auf Events, Commands und Hotkeys mit einem Script zu reagieren.

Es gibt folgende Funktionen:

| Name      | Signature                         | Beschreibung                                                                |
|-----------|-----------------------------------|-----------------------------------------------------------------------------|
| `event`   | event(EventType, Function(Any))   | Registriere einen Event Listener                                            |
| `command` | command(String, Function(Args))   | Registriere einen Befehl                                                    |
| `hotkey`  | hotkey(String, Function(Boolean)) | Registriere einen Hotkey, the function gets a boolean if the key is pressed |

Es gibt folgende Variablen:

| Name     | Beschreibung                     |
|----------|----------------------------------|
| `events` | Siehe: [Event Type](#eventtypen) |

## Commands
Der Command Handler kriegt eine Liste aller angegeben argumenten. Die Argumente sind vom Typ `String`. Mit dem Wert gespeichert unter `args.alias` oder `args["alias"]` erhältst du, welcher command eingegeben wurde. Wenn ein handler für mehrere Befehle registriert wurde kannst du es hiermit erkennen.
Du kannst `args.hasShortFlag(String)` um herauszufinden ob eine Flag angegeben wurde wie zum Beispiel `-f`. Mit `args.removeShortFlag(String)` kannst du die Flag entfernen und erhältst ob sie angegeben wurde.

## Hotkeys

Hotkeys werden im folgenden Format angegeben: `MODIFIER+KEY`. Bei den Hotkey erstellung ist die Großschreibung egal. Es gibt folgende Modifier:
- `ctrl`
- `shift`
- `alt`
- `meta`

Es können auch mehrere Modifier angegeben werden, z.B. `ctrl+shift+alt+c`. Die Reihenfolge der Modifier und des Keys ist egal.

## Eventtypen
Einige Events sind auch abbrechbar, dazu muss die Funktion `setCancelled()` aufgerufen werden.

| Name                | Wenn                                                | Parameter                       | Abbrechbar |
|---------------------|-----------------------------------------------------|---------------------------------|------------|
| `DoubleSwap`        | Beim Doppelten Drücken der Swap-Hands taste         | NIL                             | false      |
| `PlaceBlock`        | Beim Platzieren von Blöcken                         | [BlockEvent](#blockevent)       | true       |
| `BreakBlock`        | Beim Zerstören von Blöcken                          | [BlockEvent](#blockevent)       | true       |
| `RightClick`        | Beim Rechtsklick                                    | [InteractEvent](#interactevent) | true       |
| `LeftClick`         | Beim Linksklick                                     | [InteractEvent](#interactevent) | true       |
| `TNTSpawn`          | Wenn ein TNT in der aktuellen Region spawnt         | NIL                             | false      |
| `TNTExplode`        | Wenn ein TNT in der aktuellen Region explodiert     | [Position](#position)           | true       |
| `TNTExplodeInBuild` | Wenn ein TNT in der aktuellen Bau Region explodiert | [Position](#position)           | true       |
| `SelfJoin`          | Wenn man selbst den Server betritt                  | NIL                             | false      |
| `SelfLeave`         | Wenn man den Server verlässt                        | NIL                             | false      |
| `DropItem`          | Wenn man ein Item droppt                            | (type: Material)                | true       |
| `EntityDeath`       | Wenn ein Entity stirbt                              | (type: Entity Type)             | false      |

### BlockEvent
Das übergebene Objekt an den Handler hat folgende Variablen:

| Name   | Beschreibung                |
|--------|-----------------------------|
| `x`    | Die X-Koordinate des Blocks |
| `y`    | Die Y-Koordinate des Blocks |
| `z`    | Die Z-Koordinate des Blocks |
| `type` | Das Material des Blocks     |

### InteractEvent
Das übergebene Objekt an den Handler hat folgende Variablen:

| Name       | Beschreibung                                                                                                                  |
|------------|-------------------------------------------------------------------------------------------------------------------------------|
| `action`   | Die Action die ausgeführt wurde, Mögliche Werte: `RIGHT_CLICK_BLOCK`, `RIGHT_CLICK_AIR`, `LEFT_CLICK_BLOCK`, `LEFT_CLICK_AIR` |
| `hand`     | Die Hand die zum ausführen genutzt wird, Mögliche Werte: `HAND`, `OFF_HAND`, `null`                                           |
| `block`    | Der Typ des Items mit dem geklickt wurde                                                                                      |
| `hasBlock` | Wahr, wenn auf einen Block geklickt wurde                                                                                     |

Wenn `hasBlock` wahr ist, gibt es folgende Variablen:

| Name        | Beschreibung                            |
|-------------|-----------------------------------------|
| `blockX`    | Die X-Koordinate des Blocks             |
| `blockY`    | Die Y-Koordinate des Blocks             |
| `blockZ`    | Die Z-Koordinate des Blocks             |
| `blockFace` | Die Seite des Blocks die geklickt wurde |


### Position
Die Position ist ein Objekt mit folgenden Variablen:

| Name | Beschreibung     |
|------|------------------|
| `x`  | Die X-Koordinate |
| `y`  | Die Y-Koordinate |
| `z`  | Die Z-Koordinate |

# Instabile APIs
Hier sind einige APIs aufgelistet, die nicht stabil sind und sich jederzeit ändern können.

## _worldedit

| Name        | Signatur                                                  | Beschreibung                      |
|-------------|-----------------------------------------------------------|-----------------------------------|
| `selection` | selection(Liste\<Pos>), selection(): {min: Pos, max: Pos} | Die aktuelle auswahl des Spielers |



# Beispiele

## Hello, World!
Ein einfaches Hello, World!-Script.

#### Code
```lua
print("Hello, World!")
```

#### Ausgabe
```
Hello, World!
```

## BauGUI on DoubleSwap
Das Standardskript für das Öffnen des BauGUIs

#### Code
```lua
function handler(event) 
  exec("gui")
end

event(events.DoubleSwap, handler)
```

## SL Command
Ein einfacher Command Redefiner.

#### Code
```lua
function handler(args)
  exec("stoplag")
end

command("sl", handler)
```

## Paste Hotkey
Ein Hotkey zum Pasten des Clipboard-Inhalts.

#### Code
```lua
function handler(pressed)
  if pressed then
    exec("/paste -o")
  end
end

hotkey("ctrl+v", handler)
```

## Inventory
Ein Beispiel für ein Inventar.

#### Code
```lua
inv = inventory.create("Test Inv", 3)
inv.item(13, "STONE", "Ich bin ein Stein", function(e) player.chat(e) end, {"Die Lore", "Die Zweite Zeile"}, true)
inv.open()
```