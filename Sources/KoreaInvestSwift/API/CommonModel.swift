//
//  CommonModel.swift
//  KoreaInvestSwift
//
//  Created by kin on 3/29/25.
//

public enum EXCG_ID_DVSN_CD_ENUM:String, Codable {
    case 한국거래소 = "KRX"
    case 넥스트레이드 = "NXT"
}

/// 조건 시장 분류 코드
/// J:KRX, NX:NXT, UN:통합
enum FID_COND_MRKT_DIV_CODE_ENUM : String, Codable {
    ///J
    case KRX = "J"
    ///NX
    case NXT = "NX"
    ///UN
    case 통합 = "UN"
    ///W
    case ELW = "W"
    ///U
    case 업종 = "U"
    ///I
    case I = "I"
    ///V
    case 시세분석 = "V"
}
enum FID_DIV_CLS_CODE_ENUM : String, Codable {
    case 전체 = "0"
    case 콜 = "1"
    case 풋 = "2"
}
enum FID_INPUT_ISCD_ENUM:String,Codable {
    case 전체 = "00000"
    case 한국투자증권 = "00003"
    case KB증권 = "00017"
    case 미래에셋주식회사 = "00005"
}
enum FID_INPUT_ISCD_2_ENUM:String,Codable {
    case 한국투자증권 = "00003"
    case KB증권 = "00017"
    case 미래에셋주식회사 = "00005"
}
enum FID_BLNG_CLS_CODE_ENUM:String, Codable {
    case 전체 = "0"
    case 일반 = "1"
    case 조기종료 = "2"
}
