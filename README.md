#  TDD in the real world

In this demo we are going to develop a tiny M3U file parser. These are the requeriments that it should fulfill:


# M3U Format Specifications

## Overview
M3U (MP3 URL or Moving Picture Experts Group Audio Layer 3 Uniform Resource Locator) is a file format for multimedia playlists. It exists in two variants:
- M3U: encoded in ISO-8859-1
- M3U8: encoded in UTF-8

## Basic Structure

### 1. Header
```
#EXTM3U
```
- The first line should be `#EXTM3U` to identify the file as an extended M3U playlist
- Optional but recommended
- Must be in uppercase

### 2. Track Entries
Each track can have two components:

#### 2.1 Metadata (Optional)
```
#EXTINF:123,Artist - Title
```
- Starts with `#EXTINF:`
- Followed by duration in seconds (integer)
- A comma
- Track information (typically "Artist - Title")
- Must be on a single line

#### 2.2 File Path (Required)
```
/path/to/file.mp3
```
- Can be:
  - Absolute path
  - Relative path
  - URL
- One path per line
- No leading or trailing spaces

## Extended Tags

### 3. Extended Tags

#### 3.1 #EXTGRP
```
#EXTGRP:Group Name
```
- Defines a group for subsequent tracks

#### 3.2 #PLAYLIST
```
#PLAYLIST:Playlist Name
```
- Defines the playlist name

#### 3.3 #EXTIMG
```
#EXTIMG:path/to/image.jpg
```
- Specifies an image associated with the track

## Complete Example
```
#EXTM3U
#PLAYLIST:My Playlist

#EXTGRP:Rock
#EXTINF:342,Queen - Bohemian Rhapsody
/music/bohemian_rhapsody.mp3

#EXTGRP:Jazz
#EXTINF:163,Miles Davis - So What
#EXTIMG:covers/kind_of_blue.jpg
http://example.com/so_what.mp3

#EXTINF:-1,Online Radio
http://radio.example.com/stream
```

## Rules and Considerations

### 4. General Rules
1. One entry per line
2. Empty lines are ignored
3. Comments start with #
4. Case sensitive
5. Must not contain control characters

### 5. Special Values
- Duration `-1`: Indicates live stream or unknown duration
- URLs can use any protocol (http://, https://, ftp://, file://)

### 6. Limitations
- No limit on number of entries
- Maximum line length not specified
- Allowed characters depend on encoding (ISO-8859-1 for M3U, UTF-8 for M3U8)

### 7. Best Practices
1. Use relative paths when possible
2. Always include #EXTM3U header
3. Provide metadata for each track
4. Avoid special characters in paths
5. Keep paths consistent (all URLs or all local files)

## Common Use Cases

### 8. Typical Scenarios
1. Local music playlists
2. Online radio streams
3. Podcast episode lists
4. Video playlists
5. IPTV streams

### 9. Compatibility
- Supported by most media players:
  - VLC
  - Windows Media Player
  - iTunes
  - Winamp
  - MPV
  - MPlayer

## Parsing Considerations

### 10. Key Parsing Points
1. Line endings can be both Unix (\n) and Windows (\r\n)
2. Duration must be parsed as integer
3. Metadata may contain commas within the title portion
4. URLs must be properly encoded
5. Relative paths should be resolved against playlist location

### 11. Error Handling
- Invalid duration formats
- Missing file paths
- Malformed URLs
- Unknown extended tags


