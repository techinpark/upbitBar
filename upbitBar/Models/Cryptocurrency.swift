//
//  Cryptocurrency.swift
//  upbitBar
//
//  Created by Fernando on 2021/03/08.
//

import Foundation

enum Cryptocurrency: String, Equatable {
    
    case BTC
    case ETH
    case XHR
    case XEM
    case EMC2
    case LBC
    case CHZ
    case BORA
    case PCI
    case ENJ
    case GRS
    case META
    case SRM
    case POWR
    case ONG
    case SAND
    case ADA
    case DOT
    case HUNT
    case CRO
    case DMT
    case UPP
    case EOS
    case ETC
    case ANKR
    case MANA
    case SXP
    case XLM
    case BCH
    case MLK
    case VET
    case GAS
    case OMG
    case STEEM
    case WAXP
    case BTT
    case DKA
    case NPXS
    case MTL
    case SOLVE
    case ICX
    case QTUM
    case BTG
    case MOC
    case CRE
    case TFUEL
    case TRX
    case HBAR
    case MFT
    case LTC
    case GLM
    case SSX
    case STRAX
    case XTZ
    case HIVE
    case TON
    case POLY
    case LINK
    case MVL
    case ONT
    case MED
    case BSV
    case SBD
    case QTCON
    case CVC
    case AQT
    case TT
    case IOST
    case PXL
    case CBK
    case DOGE
    case AHT
    case SNT
    case RFR
    case STPT
    case THETA
    case ZPX
    case BAT
    case ARK
    case ADX
    case AERGO
    case FCT2
    case NEO
    case MARO
    case STORJ
    case JST
    case SRN
    case ELF
    case MBL
    case HUM
    case LOOM
    case OBSR
    case ZIL
    case KAVA
    case ARDR
    case KMD
    case LAMB
    case TSHP
    case ATOM
    case STMX
    case LSK
    case BCHA
    case EDR
    case QKC
    case ORBS
    case SC
    case IGNIS
    case SPND
    case REP
    case IQ
    case WAVES
    case KNC
    case IOTA
    
    var name: String {
        switch self {
        
        case .BTC: return "비트코인"
        case .ETH: return "이더리움"
        case .XHR: return "리플"
        case .XEM: return "넴"
        case .EMC2: return "아인스타이늄"
        case .LBC: return "엘비와이크레딧"
        case .CHZ: return "칠리즈"
        case .BORA: return "보라"
        case .PCI: return "페이코인"
        case .ENJ: return "엔진코인"
        case .GRS: return "그로스톨코인"
        case .META: return "메타디움"
        case .SRM: return "세럼"
        case .POWR: return "파워렛저"
        case .ONG: return "온톨로지가스"
        case .SAND: return "샌드박스"
        case .ADA: return "에이다"
        case .DOT: return "폴카닷"
        case .HUNT: return "헌트"
        case .CRO: return ""
        case .DMT: return ""
        case .UPP: return ""
        case .EOS: return "이오스"
        case .ETC: return ""
        case .ANKR: return ""
        case .MANA: return ""
        case .SXP: return ""
        case .XLM: return ""
        case .BCH: return ""
        case .MLK: return ""
        case .VET: return ""
        case .GAS: return ""
        case .OMG: return ""
        case .STEEM: return ""
        case .WAXP: return ""
        case .BTT: return ""
        case .DKA: return ""
        case .NPXS: return ""
        case .MTL: return ""
        case .SOLVE: return ""
        case .ICX: return ""
        case .QTUM: return ""
        case .BTG: return ""
        case .MOC: return ""
        case .CRE: return ""
        case .TFUEL: return ""
        case .TRX: return ""
        case .HBAR: return ""
        case .MFT: return ""
        case .LTC: return ""
        case .GLM: return ""
        case .SSX: return ""
        case .STRAX: return ""
        case .XTZ: return ""
        case .HIVE: return ""
        case .TON: return ""
        case .POLY: return ""
        case .LINK: return ""
        case .MVL: return ""
        case .ONT: return ""
        case .MED: return ""
        case .BSV: return ""
        case .SBD: return ""
        case .QTCON: return ""
        case .CVC: return ""
        case .AQT: return ""
        case .TT: return ""
        case .IOST: return ""
        case .PXL: return ""
        case .CBK: return ""
        case .DOGE: return ""
        case .AHT: return ""
        case .SNT: return ""
        case .RFR: return ""
        case .STPT: return ""
        case .THETA: return ""
        case .ZPX: return ""
        case .BAT: return ""
        case .ARK: return ""
        case .ADX: return ""
        case .AERGO: return ""
        case .FCT2: return ""
        case .NEO: return ""
        case .MARO: return ""
        case .STORJ: return ""
        case .JST: return ""
        case .SRN: return ""
        case .ELF: return ""
        case .MBL: return ""
        case .HUM: return ""
        case .LOOM: return ""
        case .OBSR: return ""
        case .ZIL: return ""
        case .KAVA: return ""
        case .ARDR: return ""
        case .KMD: return ""
        case .LAMB: return ""
        case .TSHP: return ""
        case .ATOM: return ""
        case .STMX: return ""
        case .LSK: return ""
        case .BCHA: return ""
        case .EDR: return ""
        case .QKC: return ""
        case .ORBS: return ""
        case .SC: return ""
        case .IGNIS: return ""
        case .SPND: return ""
        case .REP: return ""
        case .IQ: return ""
        case .WAVES: return ""
        case .KNC: return ""
        case .IOTA: return ""
        }
    }
}
