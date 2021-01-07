//
//  ID3v1+Genre.swift
//  ShigatsuTags
//
//  Created by Alexander Lim on 1/4/21.
//  Copyright 2021 Alexander Lim
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import Foundation

public extension ID3v1 {
    /// All the possible genres represented in an ID3v1 tag.
    ///
    /// ID3v1 genres are mapped from a 1-byte value to a static list.
    ///
    /// - See: Appendix A of https://id3.org/d3v2.3.0
    public enum Genre: Hashable {
        // 0-79 are Eric Kemp's original genres defined in ID3v1.
        case blues
        case classicRock
        case country
        case dance
        case disco
        case funk
        case grunge
        case hipHop
        case jazz
        case metal
        case newAge
        case oldies
        case other
        case pop
        case rB
        case rap
        case reggae
        case rock
        case techno
        case industrial
        case alternative
        case ska
        case deathMetal
        case pranks
        case soundtrack
        case euroTechno
        case ambient
        case tripHop
        case vocal
        case jazzFunk
        case fusion
        case trance
        case classical
        case instrumental
        case acid
        case house
        case game
        case soundClip
        case gospel
        case noise
        case altRock
        case bass
        case soul
        case punk
        case space
        case meditative
        case instrumentalPop
        case instrumentalRock
        case ethnic
        case gothic
        case darkwave
        case technoIndustrial
        case electronic
        case popFolk
        case eurodance
        case dream
        case southernRock
        case comedy
        case cult
        case gangstaRap
        case top40
        case christianRap
        case popFunk
        case jungle
        case nativeAmerican
        case cabaret
        case newWave
        case psychedelic
        case rave
        case showtunes
        case trailer
        case loFi
        case tribal
        case acidPunk
        case acidJazz
        case polka
        case retro
        case musical
        case rockRoll
        case hardRock

        // 80-141 were defined by Winamp and are technically unofficial, but will probably be
        // understandable by other programs.
        case folk
        case folkRock
        case nationalFolk
        case swing
        case fastFusion
        case bebop
        case latin
        case revival
        case celtic
        case bluegrass
        case avantgarde
        case gothicRock
        case progressiveRock
        case psychedelicRock
        case symphonicRock
        case slowRock
        case bigBand
        case chorus
        case easyListening
        case acoustic
        case humour
        case speech
        case chanson
        case opera
        case chamberMusic
        case sonata
        case symphony
        case bootyBass
        case primus
        case pornGroove
        case satire
        case slowJam
        case club
        case tango
        case samba
        case folklore
        case ballad
        case powerBallad
        case rhythmicSoul
        case freestyle
        case duet
        case punkRock
        case drumSolo
        case aCappella
        case euroHouse
        case danceHall
        case goa
        case drumBass
        case clubHouse
        case hardcore
        case terror
        case indie
        case britPop
        case afroPunk
        case polskPunk
        case beat
        case christianGangstaRap
        case heavyMetal
        case blackMetal
        case crossover
        case contemporaryChristian
        case christianRock
        case merengue
        case salsa
        case thrashMetal
        case anime
        case jPop
        case synthpop
        case abstract
        case artRock
        case baroque
        case bhangra
        case bigBeat
        case breakbeat
        case chillout
        case downtempo
        case dub
        case ebm
        case eclectic
        case electro
        case electroclash
        case emo
        case experimental
        case garage
        case global
        case idm
        case illbient
        case industroGoth
        case jamBand
        case krautrock
        case leftfield
        case lounge
        case mathRock
        case newRomantic
        case nuBreakz
        case postPunk
        case postRock
        case psytrance
        case shoegaze
        case spaceRock
        case tropRock
        case worldMusic
        case neoclassical
        case audiobook
        case audioTheatre
        case neueDeutscheWelle
        case podcast
        case indieRock
        case gFunk
        case dubstep
        case garageRock
        case psybient

        // Values beyond 191 aren't specified, but we'll attach the numeric value so you can write
        // it back to the file later if needed.
        case unknown(rawValue: UInt8)
    }
}

public extension ID3v1.Genre {
    // MARK: - Conversion

    // Initialize a genre from the byte value in the tag.
    init(rawValue: UInt8) {
        switch rawValue {
        case 0: self = .blues
        case 1: self = .classicRock
        case 2: self = .country
        case 3: self = .dance
        case 4: self = .disco
        case 5: self = .funk
        case 6: self = .grunge
        case 7: self = .hipHop
        case 8: self = .jazz
        case 9: self = .metal
        case 10: self = .newAge
        case 11: self = .oldies
        case 12: self = .other
        case 13: self = .pop
        case 14: self = .rB
        case 15: self = .rap
        case 16: self = .reggae
        case 17: self = .rock
        case 18: self = .techno
        case 19: self = .industrial
        case 20: self = .alternative
        case 21: self = .ska
        case 22: self = .deathMetal
        case 23: self = .pranks
        case 24: self = .soundtrack
        case 25: self = .euroTechno
        case 26: self = .ambient
        case 27: self = .tripHop
        case 28: self = .vocal
        case 29: self = .jazzFunk
        case 30: self = .fusion
        case 31: self = .trance
        case 32: self = .classical
        case 33: self = .instrumental
        case 34: self = .acid
        case 35: self = .house
        case 36: self = .game
        case 37: self = .soundClip
        case 38: self = .gospel
        case 39: self = .noise
        case 40: self = .altRock
        case 41: self = .bass
        case 42: self = .soul
        case 43: self = .punk
        case 44: self = .space
        case 45: self = .meditative
        case 46: self = .instrumentalPop
        case 47: self = .instrumentalRock
        case 48: self = .ethnic
        case 49: self = .gothic
        case 50: self = .darkwave
        case 51: self = .technoIndustrial
        case 52: self = .electronic
        case 53: self = .popFolk
        case 54: self = .eurodance
        case 55: self = .dream
        case 56: self = .southernRock
        case 57: self = .comedy
        case 58: self = .cult
        case 59: self = .gangstaRap
        case 60: self = .top40
        case 61: self = .christianRap
        case 62: self = .popFunk
        case 63: self = .jungle
        case 64: self = .nativeAmerican
        case 65: self = .cabaret
        case 66: self = .newWave
        case 67: self = .psychedelic
        case 68: self = .rave
        case 69: self = .showtunes
        case 70: self = .trailer
        case 71: self = .loFi
        case 72: self = .tribal
        case 73: self = .acidPunk
        case 74: self = .acidJazz
        case 75: self = .polka
        case 76: self = .retro
        case 77: self = .musical
        case 78: self = .rockRoll
        case 79: self = .hardRock
        case 80: self = .folk
        case 81: self = .folkRock
        case 82: self = .nationalFolk
        case 83: self = .swing
        case 84: self = .fastFusion
        case 85: self = .bebop
        case 86: self = .latin
        case 87: self = .revival
        case 88: self = .celtic
        case 89: self = .bluegrass
        case 90: self = .avantgarde
        case 91: self = .gothicRock
        case 92: self = .progressiveRock
        case 93: self = .psychedelicRock
        case 94: self = .symphonicRock
        case 95: self = .slowRock
        case 96: self = .bigBand
        case 97: self = .chorus
        case 98: self = .easyListening
        case 99: self = .acoustic
        case 100: self = .humour
        case 101: self = .speech
        case 102: self = .chanson
        case 103: self = .opera
        case 104: self = .chamberMusic
        case 105: self = .sonata
        case 106: self = .symphony
        case 107: self = .bootyBass
        case 108: self = .primus
        case 109: self = .pornGroove
        case 110: self = .satire
        case 111: self = .slowJam
        case 112: self = .club
        case 113: self = .tango
        case 114: self = .samba
        case 115: self = .folklore
        case 116: self = .ballad
        case 117: self = .powerBallad
        case 118: self = .rhythmicSoul
        case 119: self = .freestyle
        case 120: self = .duet
        case 121: self = .punkRock
        case 122: self = .drumSolo
        case 123: self = .aCappella
        case 124: self = .euroHouse
        case 125: self = .danceHall
        case 126: self = .goa
        case 127: self = .drumBass
        case 128: self = .clubHouse
        case 129: self = .hardcore
        case 130: self = .terror
        case 131: self = .indie
        case 132: self = .britPop
        case 133: self = .afroPunk
        case 134: self = .polskPunk
        case 135: self = .beat
        case 136: self = .christianGangstaRap
        case 137: self = .heavyMetal
        case 138: self = .blackMetal
        case 139: self = .crossover
        case 140: self = .contemporaryChristian
        case 141: self = .christianRock
        case 142: self = .merengue
        case 143: self = .salsa
        case 144: self = .thrashMetal
        case 145: self = .anime
        case 146: self = .jPop
        case 147: self = .synthpop
        case 148: self = .abstract
        case 149: self = .artRock
        case 150: self = .baroque
        case 151: self = .bhangra
        case 152: self = .bigBeat
        case 153: self = .breakbeat
        case 154: self = .chillout
        case 155: self = .downtempo
        case 156: self = .dub
        case 157: self = .ebm
        case 158: self = .eclectic
        case 159: self = .electro
        case 160: self = .electroclash
        case 161: self = .emo
        case 162: self = .experimental
        case 163: self = .garage
        case 164: self = .global
        case 165: self = .idm
        case 166: self = .illbient
        case 167: self = .industroGoth
        case 168: self = .jamBand
        case 169: self = .krautrock
        case 170: self = .leftfield
        case 171: self = .lounge
        case 172: self = .mathRock
        case 173: self = .newRomantic
        case 174: self = .nuBreakz
        case 175: self = .postPunk
        case 176: self = .postRock
        case 177: self = .psytrance
        case 178: self = .shoegaze
        case 179: self = .spaceRock
        case 180: self = .tropRock
        case 181: self = .worldMusic
        case 182: self = .neoclassical
        case 183: self = .audiobook
        case 184: self = .audioTheatre
        case 185: self = .neueDeutscheWelle
        case 186: self = .podcast
        case 187: self = .indieRock
        case 188: self = .gFunk
        case 189: self = .dubstep
        case 190: self = .garageRock
        case 191: self = .psybient
        default: self = .unknown(rawValue: rawValue)
        }
    }

    /// The byte value for the given genre in ID3v1.
    var rawValue: UInt8 {
        switch self {
        case .blues: return 0
        case .classicRock: return 1
        case .country: return 2
        case .dance: return 3
        case .disco: return 4
        case .funk: return 5
        case .grunge: return 6
        case .hipHop: return 7
        case .jazz: return 8
        case .metal: return 9
        case .newAge: return 10
        case .oldies: return 11
        case .other: return 12
        case .pop: return 13
        case .rB: return 14
        case .rap: return 15
        case .reggae: return 16
        case .rock: return 17
        case .techno: return 18
        case .industrial: return 19
        case .alternative: return 20
        case .ska: return 21
        case .deathMetal: return 22
        case .pranks: return 23
        case .soundtrack: return 24
        case .euroTechno: return 25
        case .ambient: return 26
        case .tripHop: return 27
        case .vocal: return 28
        case .jazzFunk: return 29
        case .fusion: return 30
        case .trance: return 31
        case .classical: return 32
        case .instrumental: return 33
        case .acid: return 34
        case .house: return 35
        case .game: return 36
        case .soundClip: return 37
        case .gospel: return 38
        case .noise: return 39
        case .altRock: return 40
        case .bass: return 41
        case .soul: return 42
        case .punk: return 43
        case .space: return 44
        case .meditative: return 45
        case .instrumentalPop: return 46
        case .instrumentalRock: return 47
        case .ethnic: return 48
        case .gothic: return 49
        case .darkwave: return 50
        case .technoIndustrial: return 51
        case .electronic: return 52
        case .popFolk: return 53
        case .eurodance: return 54
        case .dream: return 55
        case .southernRock: return 56
        case .comedy: return 57
        case .cult: return 58
        case .gangstaRap: return 59
        case .top40: return 60
        case .christianRap: return 61
        case .popFunk: return 62
        case .jungle: return 63
        case .nativeAmerican: return 64
        case .cabaret: return 65
        case .newWave: return 66
        case .psychedelic: return 67
        case .rave: return 68
        case .showtunes: return 69
        case .trailer: return 70
        case .loFi: return 71
        case .tribal: return 72
        case .acidPunk: return 73
        case .acidJazz: return 74
        case .polka: return 75
        case .retro: return 76
        case .musical: return 77
        case .rockRoll: return 78
        case .hardRock: return 79
        case .folk: return 80
        case .folkRock: return 81
        case .nationalFolk: return 82
        case .swing: return 83
        case .fastFusion: return 84
        case .bebop: return 85
        case .latin: return 86
        case .revival: return 87
        case .celtic: return 88
        case .bluegrass: return 89
        case .avantgarde: return 90
        case .gothicRock: return 91
        case .progressiveRock: return 92
        case .psychedelicRock: return 93
        case .symphonicRock: return 94
        case .slowRock: return 95
        case .bigBand: return 96
        case .chorus: return 97
        case .easyListening: return 98
        case .acoustic: return 99
        case .humour: return 100
        case .speech: return 101
        case .chanson: return 102
        case .opera: return 103
        case .chamberMusic: return 104
        case .sonata: return 105
        case .symphony: return 106
        case .bootyBass: return 107
        case .primus: return 108
        case .pornGroove: return 109
        case .satire: return 110
        case .slowJam: return 111
        case .club: return 112
        case .tango: return 113
        case .samba: return 114
        case .folklore: return 115
        case .ballad: return 116
        case .powerBallad: return 117
        case .rhythmicSoul: return 118
        case .freestyle: return 119
        case .duet: return 120
        case .punkRock: return 121
        case .drumSolo: return 122
        case .aCappella: return 123
        case .euroHouse: return 124
        case .danceHall: return 125
        case .goa: return 126
        case .drumBass: return 127
        case .clubHouse: return 128
        case .hardcore: return 129
        case .terror: return 130
        case .indie: return 131
        case .britPop: return 132
        case .afroPunk: return 133
        case .polskPunk: return 134
        case .beat: return 135
        case .christianGangstaRap: return 136
        case .heavyMetal: return 137
        case .blackMetal: return 138
        case .crossover: return 139
        case .contemporaryChristian: return 140
        case .christianRock: return 141
        case .merengue: return 142
        case .salsa: return 143
        case .thrashMetal: return 144
        case .anime: return 145
        case .jPop: return 146
        case .synthpop: return 147
        case .abstract: return 148
        case .artRock: return 149
        case .baroque: return 150
        case .bhangra: return 151
        case .bigBeat: return 152
        case .breakbeat: return 153
        case .chillout: return 154
        case .downtempo: return 155
        case .dub: return 156
        case .ebm: return 157
        case .eclectic: return 158
        case .electro: return 159
        case .electroclash: return 160
        case .emo: return 161
        case .experimental: return 162
        case .garage: return 163
        case .global: return 164
        case .idm: return 165
        case .illbient: return 166
        case .industroGoth: return 167
        case .jamBand: return 168
        case .krautrock: return 169
        case .leftfield: return 170
        case .lounge: return 171
        case .mathRock: return 172
        case .newRomantic: return 173
        case .nuBreakz: return 174
        case .postPunk: return 175
        case .postRock: return 176
        case .psytrance: return 177
        case .shoegaze: return 178
        case .spaceRock: return 179
        case .tropRock: return 180
        case .worldMusic: return 181
        case .neoclassical: return 182
        case .audiobook: return 183
        case .audioTheatre: return 184
        case .neueDeutscheWelle: return 185
        case .podcast: return 186
        case .indieRock: return 187
        case .gFunk: return 188
        case .dubstep: return 189
        case .garageRock: return 190
        case .psybient: return 191
        case .unknown(let rawValue): return rawValue
        }
    }

    /// A "nice" string to show in UI for this genre.
    var displayName: String {
        switch self {
        case .blues: return "Blues"
        case .classicRock: return "Classic Rock"
        case .country: return "Country"
        case .dance: return "Dance"
        case .disco: return "Disco"
        case .funk: return "Funk"
        case .grunge: return "Grunge"
        case .hipHop: return "Hip-Hop"
        case .jazz: return "Jazz"
        case .metal: return "Metal"
        case .newAge: return "New Age"
        case .oldies: return "Oldies"
        case .other: return "Other"
        case .pop: return "Pop"
        case .rB: return "R&B"
        case .rap: return "Rap"
        case .reggae: return "Reggae"
        case .rock: return "Rock"
        case .techno: return "Techno"
        case .industrial: return "Industrial"
        case .alternative: return "Alternative"
        case .ska: return "Ska"
        case .deathMetal: return "Death Metal"
        case .pranks: return "Pranks"
        case .soundtrack: return "Soundtrack"
        case .euroTechno: return "Euro-Techno"
        case .ambient: return "Ambient"
        case .tripHop: return "Trip-Hop"
        case .vocal: return "Vocal"
        case .jazzFunk: return "Jazz+Funk"
        case .fusion: return "Fusion"
        case .trance: return "Trance"
        case .classical: return "Classical"
        case .instrumental: return "Instrumental"
        case .acid: return "Acid"
        case .house: return "House"
        case .game: return "Game"
        case .soundClip: return "Sound Clip"
        case .gospel: return "Gospel"
        case .noise: return "Noise"
        case .altRock: return "Alt. Rock"
        case .bass: return "Bass"
        case .soul: return "Soul"
        case .punk: return "Punk"
        case .space: return "Space"
        case .meditative: return "Meditative"
        case .instrumentalPop: return "Instrumental Pop"
        case .instrumentalRock: return "Instrumental Rock"
        case .ethnic: return "Ethnic"
        case .gothic: return "Gothic"
        case .darkwave: return "Darkwave"
        case .technoIndustrial: return "Techno-Industrial"
        case .electronic: return "Electronic"
        case .popFolk: return "Pop-Folk"
        case .eurodance: return "Eurodance"
        case .dream: return "Dream"
        case .southernRock: return "Southern Rock"
        case .comedy: return "Comedy"
        case .cult: return "Cult"
        case .gangstaRap: return "Gangsta Rap"
        case .top40: return "Top 40"
        case .christianRap: return "Christian Rap"
        case .popFunk: return "Pop/Funk"
        case .jungle: return "Jungle"
        case .nativeAmerican: return "Native American"
        case .cabaret: return "Cabaret"
        case .newWave: return "New Wave"
        case .psychedelic: return "Psychedelic"
        case .rave: return "Rave"
        case .showtunes: return "Showtunes"
        case .trailer: return "Trailer"
        case .loFi: return "Lo-Fi"
        case .tribal: return "Tribal"
        case .acidPunk: return "Acid Punk"
        case .acidJazz: return "Acid Jazz"
        case .polka: return "Polka"
        case .retro: return "Retro"
        case .musical: return "Musical"
        case .rockRoll: return "Rock & Roll"
        case .hardRock: return "Hard Rock"
        case .folk: return "Folk"
        case .folkRock: return "Folk-Rock"
        case .nationalFolk: return "National Folk"
        case .swing: return "Swing"
        case .fastFusion: return "Fast-Fusion"
        case .bebop: return "Bebop"
        case .latin: return "Latin"
        case .revival: return "Revival"
        case .celtic: return "Celtic"
        case .bluegrass: return "Bluegrass"
        case .avantgarde: return "Avantgarde"
        case .gothicRock: return "Gothic Rock"
        case .progressiveRock: return "Progressive Rock"
        case .psychedelicRock: return "Psychedelic Rock"
        case .symphonicRock: return "Symphonic Rock"
        case .slowRock: return "Slow Rock"
        case .bigBand: return "Big Band"
        case .chorus: return "Chorus"
        case .easyListening: return "Easy Listening"
        case .acoustic: return "Acoustic"
        case .humour: return "Humour"
        case .speech: return "Speech"
        case .chanson: return "Chanson"
        case .opera: return "Opera"
        case .chamberMusic: return "Chamber Music"
        case .sonata: return "Sonata"
        case .symphony: return "Symphony"
        case .bootyBass: return "Booty Bass"
        case .primus: return "Primus"
        case .pornGroove: return "Porn Groove"
        case .satire: return "Satire"
        case .slowJam: return "Slow Jam"
        case .club: return "Club"
        case .tango: return "Tango"
        case .samba: return "Samba"
        case .folklore: return "Folklore"
        case .ballad: return "Ballad"
        case .powerBallad: return "Power Ballad"
        case .rhythmicSoul: return "Rhythmic Soul"
        case .freestyle: return "Freestyle"
        case .duet: return "Duet"
        case .punkRock: return "Punk Rock"
        case .drumSolo: return "Drum Solo"
        case .aCappella: return "A Cappella"
        case .euroHouse: return "Euro-House"
        case .danceHall: return "Dance Hall"
        case .goa: return "Goa"
        case .drumBass: return "Drum & Bass"
        case .clubHouse: return "Club-House"
        case .hardcore: return "Hardcore"
        case .terror: return "Terror"
        case .indie: return "Indie"
        case .britPop: return "BritPop"
        case .afroPunk: return "Afro-Punk"
        case .polskPunk: return "Polsk Punk"
        case .beat: return "Beat"
        case .christianGangstaRap: return "Christian Gangsta Rap"
        case .heavyMetal: return "Heavy Metal"
        case .blackMetal: return "Black Metal"
        case .crossover: return "Crossover"
        case .contemporaryChristian: return "Contemporary Christian"
        case .christianRock: return "Christian Rock"
        case .merengue: return "Merengue"
        case .salsa: return "Salsa"
        case .thrashMetal: return "Thrash Metal"
        case .anime: return "Anime"
        case .jPop: return "JPop"
        case .synthpop: return "Synthpop"
        case .abstract: return "Abstract"
        case .artRock: return "Art Rock"
        case .baroque: return "Baroque"
        case .bhangra: return "Bhangra"
        case .bigBeat: return "Big Beat"
        case .breakbeat: return "Breakbeat"
        case .chillout: return "Chillout"
        case .downtempo: return "Downtempo"
        case .dub: return "Dub"
        case .ebm: return "EBM"
        case .eclectic: return "Eclectic"
        case .electro: return "Electro"
        case .electroclash: return "Electroclash"
        case .emo: return "Emo"
        case .experimental: return "Experimental"
        case .garage: return "Garage"
        case .global: return "Global"
        case .idm: return "IDM"
        case .illbient: return "Illbient"
        case .industroGoth: return "Industro-Goth"
        case .jamBand: return "Jam Band"
        case .krautrock: return "Krautrock"
        case .leftfield: return "Leftfield"
        case .lounge: return "Lounge"
        case .mathRock: return "Math Rock"
        case .newRomantic: return "New Romantic"
        case .nuBreakz: return "Nu-Breakz"
        case .postPunk: return "Post-Punk"
        case .postRock: return "Post-Rock"
        case .psytrance: return "Psytrance"
        case .shoegaze: return "Shoegaze"
        case .spaceRock: return "Space Rock"
        case .tropRock: return "Trop Rock"
        case .worldMusic: return "World Music"
        case .neoclassical: return "Neoclassical"
        case .audiobook: return "Audiobook"
        case .audioTheatre: return "Audio Theatre"
        case .neueDeutscheWelle: return "Neue Deutsche Welle"
        case .podcast: return "Podcast"
        case .indieRock: return "Indie Rock"
        case .gFunk: return "G-Funk"
        case .dubstep: return "Dubstep"
        case .garageRock: return "Garage Rock"
        case .psybient: return "Psybient"

        // Special case: This doesn't actually represent a genre so don't display it.
        case .unknown: return ""
        }
    }
}
