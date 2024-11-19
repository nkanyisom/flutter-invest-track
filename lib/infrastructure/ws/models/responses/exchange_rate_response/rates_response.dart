import 'dart:core';

import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rates_response.g.dart';

@JsonSerializable()
class RatesResponse {
  factory RatesResponse.fromJson(Map<String, dynamic> json) =>
      _$RatesResponseFromJson(json);

  const RatesResponse({
    this.cad,
    this.aed,
    this.afn,
    this.all,
    this.amd,
    this.ang,
    this.aoa,
    this.ars,
    this.aud,
    this.awg,
    this.azn,
    this.bam,
    this.bbd,
    this.bdt,
    this.bgn,
    this.bhd,
    this.bif,
    this.bmd,
    this.bnd,
    this.bob,
    this.brl,
    this.bsd,
    this.btn,
    this.bwp,
    this.byn,
    this.bzd,
    this.cdf,
    this.chf,
    this.clp,
    this.cny,
    this.cop,
    this.crc,
    this.cup,
    this.cve,
    this.czk,
    this.djf,
    this.dkk,
    this.dop,
    this.dzd,
    this.egp,
    this.ern,
    this.etb,
    this.eur,
    this.fjd,
    this.fkp,
    this.fok,
    this.gbp,
    this.gel,
    this.ggp,
    this.ghs,
    this.gip,
    this.gmd,
    this.gnf,
    this.gtq,
    this.gyd,
    this.hkd,
    this.hnl,
    this.hrk,
    this.htg,
    this.huf,
    this.idr,
    this.ils,
    this.imp,
    this.inr,
    this.iqd,
    this.irr,
    this.isk,
    this.jep,
    this.jmd,
    this.jod,
    this.jpy,
    this.kes,
    this.kgs,
    this.khr,
    this.kid,
    this.kmf,
    this.krw,
    this.kwd,
    this.kyd,
    this.kzt,
    this.lak,
    this.lbp,
    this.lkr,
    this.lrd,
    this.lsl,
    this.lyd,
    this.mad,
    this.mdl,
    this.mga,
    this.mkd,
    this.mmk,
    this.mnt,
    this.mop,
    this.mru,
    this.mur,
    this.mvr,
    this.mwk,
    this.mxn,
    this.myr,
    this.mzn,
    this.nad,
    this.ngn,
    this.nio,
    this.nok,
    this.npr,
    this.nzd,
    this.omr,
    this.pab,
    this.pen,
    this.pgk,
    this.php,
    this.pkr,
    this.pln,
    this.pyg,
    this.qar,
    this.ron,
    this.rsd,
    this.rub,
    this.rwf,
    this.sar,
    this.sbd,
    this.scr,
    this.sdg,
    this.sek,
    this.sgd,
    this.shp,
    this.sle,
    this.sll,
    this.sos,
    this.srd,
    this.ssp,
    this.stn,
    this.syp,
    this.szl,
    this.thb,
    this.tjs,
    this.tmt,
    this.tnd,
    this.top,
    this.ttd,
    this.tvd,
    this.twd,
    this.tzs,
    this.uah,
    this.ugx,
    this.usd,
    this.uyu,
    this.uzs,
    this.ves,
    this.vnd,
    this.vuv,
    this.wst,
    this.xaf,
    this.xcd,
    this.xdr,
    this.xof,
    this.xpf,
    this.yer,
    this.zar,
    this.zmw,
    this.zwl,
  });

  @JsonKey(name: 'CAD')
  final int? cad;
  @JsonKey(name: 'AED')
  final double? aed;
  @JsonKey(name: 'AFN')
  final double? afn;
  @JsonKey(name: 'ALL')
  final double? all;
  @JsonKey(name: 'AMD')
  final double? amd;
  @JsonKey(name: 'ANG')
  final double? ang;
  @JsonKey(name: 'AOA')
  final double? aoa;
  @JsonKey(name: 'ARS')
  final double? ars;
  @JsonKey(name: 'AUD')
  final double? aud;
  @JsonKey(name: 'AWG')
  final double? awg;
  @JsonKey(name: 'AZN')
  final double? azn;
  @JsonKey(name: 'BAM')
  final double? bam;
  @JsonKey(name: 'BBD')
  final double? bbd;
  @JsonKey(name: 'BDT')
  final double? bdt;
  @JsonKey(name: 'BGN')
  final double? bgn;
  @JsonKey(name: 'BHD')
  final double? bhd;
  @JsonKey(name: 'BIF')
  final double? bif;
  @JsonKey(name: 'BMD')
  final double? bmd;
  @JsonKey(name: 'BND')
  final double? bnd;
  @JsonKey(name: 'BOB')
  final double? bob;
  @JsonKey(name: 'BRL')
  final double? brl;
  @JsonKey(name: 'BSD')
  final double? bsd;
  @JsonKey(name: 'BTN')
  final double? btn;
  @JsonKey(name: 'BWP')
  final double? bwp;
  @JsonKey(name: 'BYN')
  final double? byn;
  @JsonKey(name: 'BZD')
  final double? bzd;
  @JsonKey(name: 'CDF')
  final double? cdf;
  @JsonKey(name: 'CHF')
  final double? chf;
  @JsonKey(name: 'CLP')
  final double? clp;
  @JsonKey(name: 'CNY')
  final double? cny;
  @JsonKey(name: 'COP')
  final double? cop;
  @JsonKey(name: 'CRC')
  final double? crc;
  @JsonKey(name: 'CUP')
  final double? cup;
  @JsonKey(name: 'CVE')
  final double? cve;
  @JsonKey(name: 'CZK')
  final double? czk;
  @JsonKey(name: 'DJF')
  final double? djf;
  @JsonKey(name: 'DKK')
  final double? dkk;
  @JsonKey(name: 'DOP')
  final double? dop;
  @JsonKey(name: 'DZD')
  final double? dzd;
  @JsonKey(name: 'EGP')
  final double? egp;
  @JsonKey(name: 'ERN')
  final double? ern;
  @JsonKey(name: 'ETB')
  final double? etb;
  @JsonKey(name: 'EUR')
  final double? eur;
  @JsonKey(name: 'FJD')
  final double? fjd;
  @JsonKey(name: 'FKP')
  final double? fkp;
  @JsonKey(name: 'FOK')
  final double? fok;
  @JsonKey(name: 'GBP')
  final double? gbp;
  @JsonKey(name: 'GEL')
  final double? gel;
  @JsonKey(name: 'GGP')
  final double? ggp;
  @JsonKey(name: 'GHS')
  final double? ghs;
  @JsonKey(name: 'GIP')
  final double? gip;
  @JsonKey(name: 'GMD')
  final double? gmd;
  @JsonKey(name: 'GNF')
  final double? gnf;
  @JsonKey(name: 'GTQ')
  final double? gtq;
  @JsonKey(name: 'GYD')
  final double? gyd;
  @JsonKey(name: 'HKD')
  final double? hkd;
  @JsonKey(name: 'HNL')
  final double? hnl;
  @JsonKey(name: 'HRK')
  final double? hrk;
  @JsonKey(name: 'HTG')
  final double? htg;
  @JsonKey(name: 'HUF')
  final double? huf;
  @JsonKey(name: 'IDR')
  final double? idr;
  @JsonKey(name: 'ILS')
  final double? ils;
  @JsonKey(name: 'IMP')
  final double? imp;
  @JsonKey(name: 'INR')
  final double? inr;
  @JsonKey(name: 'IQD')
  final double? iqd;
  @JsonKey(name: 'IRR')
  final double? irr;
  @JsonKey(name: 'ISK')
  final double? isk;
  @JsonKey(name: 'JEP')
  final double? jep;
  @JsonKey(name: 'JMD')
  final double? jmd;
  @JsonKey(name: 'JOD')
  final double? jod;
  @JsonKey(name: 'JPY')
  final double? jpy;
  @JsonKey(name: 'KES')
  final double? kes;
  @JsonKey(name: 'KGS')
  final double? kgs;
  @JsonKey(name: 'KHR')
  final double? khr;
  @JsonKey(name: 'KID')
  final double? kid;
  @JsonKey(name: 'KMF')
  final double? kmf;
  @JsonKey(name: 'KRW')
  final double? krw;
  @JsonKey(name: 'KWD')
  final double? kwd;
  @JsonKey(name: 'KYD')
  final double? kyd;
  @JsonKey(name: 'KZT')
  final double? kzt;
  @JsonKey(name: 'LAK')
  final double? lak;
  @JsonKey(name: 'LBP')
  final double? lbp;
  @JsonKey(name: 'LKR')
  final double? lkr;
  @JsonKey(name: 'LRD')
  final double? lrd;
  @JsonKey(name: 'LSL')
  final int? lsl;
  @JsonKey(name: 'LYD')
  final double? lyd;
  @JsonKey(name: 'MAD')
  final double? mad;
  @JsonKey(name: 'MDL')
  final double? mdl;
  @JsonKey(name: 'MGA')
  final double? mga;
  @JsonKey(name: 'MKD')
  final double? mkd;
  @JsonKey(name: 'MMK')
  final double? mmk;
  @JsonKey(name: 'MNT')
  final double? mnt;
  @JsonKey(name: 'MOP')
  final double? mop;
  @JsonKey(name: 'MRU')
  final double? mru;
  @JsonKey(name: 'MUR')
  final double? mur;
  @JsonKey(name: 'MVR')
  final double? mvr;
  @JsonKey(name: 'MWK')
  final double? mwk;
  @JsonKey(name: 'MXN')
  final double? mxn;
  @JsonKey(name: 'MYR')
  final double? myr;
  @JsonKey(name: 'MZN')
  final double? mzn;
  @JsonKey(name: 'NAD')
  final int? nad;
  @JsonKey(name: 'NGN')
  final double? ngn;
  @JsonKey(name: 'NIO')
  final double? nio;
  @JsonKey(name: 'NOK')
  final double? nok;
  @JsonKey(name: 'NPR')
  final double? npr;
  @JsonKey(name: 'NZD')
  final double? nzd;
  @JsonKey(name: 'OMR')
  final double? omr;
  @JsonKey(name: 'PAB')
  final double? pab;
  @JsonKey(name: 'PEN')
  final double? pen;
  @JsonKey(name: 'PGK')
  final double? pgk;
  @JsonKey(name: 'PHP')
  final double? php;
  @JsonKey(name: 'PKR')
  final double? pkr;
  @JsonKey(name: 'PLN')
  final double? pln;
  @JsonKey(name: 'PYG')
  final double? pyg;
  @JsonKey(name: 'QAR')
  final double? qar;
  @JsonKey(name: 'RON')
  final double? ron;
  @JsonKey(name: 'RSD')
  final double? rsd;
  @JsonKey(name: 'RUB')
  final double? rub;
  @JsonKey(name: 'RWF')
  final double? rwf;
  @JsonKey(name: 'SAR')
  final double? sar;
  @JsonKey(name: 'SBD')
  final double? sbd;
  @JsonKey(name: 'SCR')
  final double? scr;
  @JsonKey(name: 'SDG')
  final double? sdg;
  @JsonKey(name: 'SEK')
  final double? sek;
  @JsonKey(name: 'SGD')
  final double? sgd;
  @JsonKey(name: 'SHP')
  final double? shp;
  @JsonKey(name: 'SLE')
  final double? sle;
  @JsonKey(name: 'SLL')
  final double? sll;
  @JsonKey(name: 'SOS')
  final int? sos;
  @JsonKey(name: 'SRD')
  final double? srd;
  @JsonKey(name: 'SSP')
  final double? ssp;
  @JsonKey(name: 'STN')
  final double? stn;
  @JsonKey(name: 'SYP')
  final double? syp;
  @JsonKey(name: 'SZL')
  final int? szl;
  @JsonKey(name: 'THB')
  final double? thb;
  @JsonKey(name: 'TJS')
  final double? tjs;
  @JsonKey(name: 'TMT')
  final double? tmt;
  @JsonKey(name: 'TND')
  final double? tnd;
  @JsonKey(name: 'TOP')
  final double? top;
  @JsonKey(name: 'TTD')
  final double? ttd;
  @JsonKey(name: 'TVD')
  final double? tvd;
  @JsonKey(name: 'TWD')
  final double? twd;
  @JsonKey(name: 'TZS')
  final double? tzs;
  @JsonKey(name: 'UAH')
  final double? uah;
  @JsonKey(name: 'UGX')
  final double? ugx;
  @JsonKey(name: 'USD')
  final double? usd;
  @JsonKey(name: 'UYU')
  final double? uyu;
  @JsonKey(name: 'UZS')
  final double? uzs;
  @JsonKey(name: 'VES')
  final double? ves;
  @JsonKey(name: 'VND')
  final double? vnd;
  @JsonKey(name: 'VUV')
  final double? vuv;
  @JsonKey(name: 'WST')
  final double? wst;
  @JsonKey(name: 'XAF')
  final double? xaf;
  @JsonKey(name: 'XCD')
  final double? xcd;
  @JsonKey(name: 'XDR')
  final double? xdr;
  @JsonKey(name: 'XOF')
  final double? xof;
  @JsonKey(name: 'XPF')
  final double? xpf;
  @JsonKey(name: 'YER')
  final double? yer;
  @JsonKey(name: 'ZAR')
  final int? zar;
  @JsonKey(name: 'ZMW')
  final double? zmw;
  @JsonKey(name: 'ZWL')
  final double? zwl;

  @override
  String toString() {
    return 'RatesResponse('
        'cad: $cad, '
        'aed: $aed, '
        'afn: $afn, '
        'all: $all, '
        'amd: $amd, '
        'ang: $ang, '
        'aoa: $aoa, '
        'ars: $ars, '
        'aud: $aud, '
        'awg: $awg, '
        'azn: $azn, '
        'bam: $bam, '
        'bbd: $bbd, '
        'bdt: $bdt, '
        'bgn: $bgn, '
        'bhd: $bhd, '
        'bif: $bif, '
        'bmd: $bmd, '
        'bnd: $bnd, '
        'bob: $bob, '
        'brl: $brl, '
        'bsd: $bsd, '
        'btn: $btn, '
        'bwp: $bwp, '
        'byn: $byn, '
        'bzd: $bzd, '
        'cdf: $cdf, '
        'chf: $chf, '
        'clp: $clp, '
        'cny: $cny, '
        'cop: $cop, '
        'crc: $crc, '
        'cup: $cup, '
        'cve: $cve, '
        'czk: $czk, '
        'djf: $djf, '
        'dkk: $dkk, '
        'dop: $dop, '
        'dzd: $dzd, '
        'egp: $egp, '
        'ern: $ern, '
        'etb: $etb, '
        'eur: $eur, '
        'fjd: $fjd, '
        'fkp: $fkp, '
        'fok: $fok, '
        'gbp: $gbp, '
        'gel: $gel, '
        'ggp: $ggp, '
        'ghs: $ghs, '
        'gip: $gip, '
        'gmd: $gmd, '
        'gnf: $gnf, '
        'gtq: $gtq, '
        'gyd: $gyd, '
        'hkd: $hkd, '
        'hnl: $hnl, '
        'hrk: $hrk, '
        'htg: $htg, '
        'huf: $huf, '
        'idr: $idr, '
        'ils: $ils, '
        'imp: $imp, '
        'inr: $inr, '
        'iqd: $iqd, '
        'irr: $irr, '
        'isk: $isk, '
        'jep: $jep, '
        'jmd: $jmd, '
        'jod: $jod, '
        'jpy: $jpy, '
        'kes: $kes, '
        'kgs: $kgs, '
        'khr: $khr, '
        'kid: $kid, '
        'kmf: $kmf, '
        'krw: $krw, '
        'kwd: $kwd, '
        'kyd: $kyd, '
        'kzt: $kzt, '
        'lak: $lak, '
        'lbp: $lbp, '
        'lkr: $lkr, '
        'lrd: $lrd, '
        'lsl: $lsl, '
        'lyd: $lyd, '
        'mad: $mad, '
        'mdl: $mdl, '
        'mga: $mga, '
        'mkd: $mkd, '
        'mmk: $mmk, '
        'mnt: $mnt, '
        'mop: $mop, '
        'mru: $mru, '
        'mur: $mur, '
        'mvr: $mvr, '
        'mwk: $mwk, '
        'mxn: $mxn, '
        'myr: $myr, '
        'mzn: $mzn, '
        'nad: $nad, '
        'ngn: $ngn, '
        'nio: $nio, '
        'nok: $nok, '
        'npr: $npr, '
        'nzd: $nzd, '
        'omr: $omr, '
        'pab: $pab, '
        'pen: $pen, '
        'pgk: $pgk, '
        'php: $php, '
        'pkr: $pkr, '
        'pln: $pln, '
        'pyg: $pyg, '
        'qar: $qar, '
        'ron: $ron, '
        'rsd: $rsd, '
        'rub: $rub, '
        'rwf: $rwf, '
        'sar: $sar, '
        'sbd: $sbd, '
        'scr: $scr, '
        'sdg: $sdg, '
        'sek: $sek, '
        'sgd: $sgd, '
        'shp: $shp, '
        'sle: $sle, '
        'sll: $sll, '
        'sos: $sos, '
        'srd: $srd, '
        'ssp: $ssp, '
        'stn: $stn, '
        'syp: $syp, '
        'szl: $szl, '
        'thb: $thb, '
        'tjs: $tjs, '
        'tmt: $tmt, '
        'tnd: $tnd, '
        'top: $top, '
        'ttd: $ttd, '
        'tvd: $tvd, '
        'twd: $twd, '
        'tzs: $tzs, '
        'uah: $uah, '
        'ugx: $ugx, '
        'usd: $usd, '
        'uyu: $uyu, '
        'uzs: $uzs, '
        'ves: $ves, '
        'vnd: $vnd, '
        'vuv: $vuv, '
        'wst: $wst, '
        'xaf: $xaf, '
        'xcd: $xcd, '
        'xdr: $xdr, '
        'xof: $xof, '
        'xpf: $xpf, '
        'yer: $yer, '
        'zar: $zar, '
        'zmw: $zmw, '
        'zwl: $zwl,'
        ')';
  }

  Map<String, dynamic> toJson() => _$RatesResponseToJson(this);

  RatesResponse copyWith({
    int? cad,
    double? aed,
    double? afn,
    double? all,
    double? amd,
    double? ang,
    double? aoa,
    double? ars,
    double? aud,
    double? awg,
    double? azn,
    double? bam,
    double? bbd,
    double? bdt,
    double? bgn,
    double? bhd,
    double? bif,
    double? bmd,
    double? bnd,
    double? bob,
    double? brl,
    double? bsd,
    double? btn,
    double? bwp,
    double? byn,
    double? bzd,
    double? cdf,
    double? chf,
    double? clp,
    double? cny,
    double? cop,
    double? crc,
    double? cup,
    double? cve,
    double? czk,
    double? djf,
    double? dkk,
    double? dop,
    double? dzd,
    double? egp,
    double? ern,
    double? etb,
    double? eur,
    double? fjd,
    double? fkp,
    double? fok,
    double? gbp,
    double? gel,
    double? ggp,
    double? ghs,
    double? gip,
    double? gmd,
    double? gnf,
    double? gtq,
    double? gyd,
    double? hkd,
    double? hnl,
    double? hrk,
    double? htg,
    double? huf,
    double? idr,
    double? ils,
    double? imp,
    double? inr,
    double? iqd,
    double? irr,
    double? isk,
    double? jep,
    double? jmd,
    double? jod,
    double? jpy,
    double? kes,
    double? kgs,
    double? khr,
    double? kid,
    double? kmf,
    double? krw,
    double? kwd,
    double? kyd,
    double? kzt,
    double? lak,
    double? lbp,
    double? lkr,
    double? lrd,
    int? lsl,
    double? lyd,
    double? mad,
    double? mdl,
    double? mga,
    double? mkd,
    double? mmk,
    double? mnt,
    double? mop,
    double? mru,
    double? mur,
    double? mvr,
    double? mwk,
    double? mxn,
    double? myr,
    double? mzn,
    int? nad,
    double? ngn,
    double? nio,
    double? nok,
    double? npr,
    double? nzd,
    double? omr,
    double? pab,
    double? pen,
    double? pgk,
    double? php,
    double? pkr,
    double? pln,
    double? pyg,
    double? qar,
    double? ron,
    double? rsd,
    double? rub,
    double? rwf,
    double? sar,
    double? sbd,
    double? scr,
    double? sdg,
    double? sek,
    double? sgd,
    double? shp,
    double? sle,
    double? sll,
    int? sos,
    double? srd,
    double? ssp,
    double? stn,
    double? syp,
    int? szl,
    double? thb,
    double? tjs,
    double? tmt,
    double? tnd,
    double? top,
    double? ttd,
    double? tvd,
    double? twd,
    double? tzs,
    double? uah,
    double? ugx,
    double? usd,
    double? uyu,
    double? uzs,
    double? ves,
    double? vnd,
    double? vuv,
    double? wst,
    double? xaf,
    double? xcd,
    double? xdr,
    double? xof,
    double? xpf,
    double? yer,
    int? zar,
    double? zmw,
    double? zwl,
  }) {
    return RatesResponse(
      cad: cad ?? this.cad,
      aed: aed ?? this.aed,
      afn: afn ?? this.afn,
      all: all ?? this.all,
      amd: amd ?? this.amd,
      ang: ang ?? this.ang,
      aoa: aoa ?? this.aoa,
      ars: ars ?? this.ars,
      aud: aud ?? this.aud,
      awg: awg ?? this.awg,
      azn: azn ?? this.azn,
      bam: bam ?? this.bam,
      bbd: bbd ?? this.bbd,
      bdt: bdt ?? this.bdt,
      bgn: bgn ?? this.bgn,
      bhd: bhd ?? this.bhd,
      bif: bif ?? this.bif,
      bmd: bmd ?? this.bmd,
      bnd: bnd ?? this.bnd,
      bob: bob ?? this.bob,
      brl: brl ?? this.brl,
      bsd: bsd ?? this.bsd,
      btn: btn ?? this.btn,
      bwp: bwp ?? this.bwp,
      byn: byn ?? this.byn,
      bzd: bzd ?? this.bzd,
      cdf: cdf ?? this.cdf,
      chf: chf ?? this.chf,
      clp: clp ?? this.clp,
      cny: cny ?? this.cny,
      cop: cop ?? this.cop,
      crc: crc ?? this.crc,
      cup: cup ?? this.cup,
      cve: cve ?? this.cve,
      czk: czk ?? this.czk,
      djf: djf ?? this.djf,
      dkk: dkk ?? this.dkk,
      dop: dop ?? this.dop,
      dzd: dzd ?? this.dzd,
      egp: egp ?? this.egp,
      ern: ern ?? this.ern,
      etb: etb ?? this.etb,
      eur: eur ?? this.eur,
      fjd: fjd ?? this.fjd,
      fkp: fkp ?? this.fkp,
      fok: fok ?? this.fok,
      gbp: gbp ?? this.gbp,
      gel: gel ?? this.gel,
      ggp: ggp ?? this.ggp,
      ghs: ghs ?? this.ghs,
      gip: gip ?? this.gip,
      gmd: gmd ?? this.gmd,
      gnf: gnf ?? this.gnf,
      gtq: gtq ?? this.gtq,
      gyd: gyd ?? this.gyd,
      hkd: hkd ?? this.hkd,
      hnl: hnl ?? this.hnl,
      hrk: hrk ?? this.hrk,
      htg: htg ?? this.htg,
      huf: huf ?? this.huf,
      idr: idr ?? this.idr,
      ils: ils ?? this.ils,
      imp: imp ?? this.imp,
      inr: inr ?? this.inr,
      iqd: iqd ?? this.iqd,
      irr: irr ?? this.irr,
      isk: isk ?? this.isk,
      jep: jep ?? this.jep,
      jmd: jmd ?? this.jmd,
      jod: jod ?? this.jod,
      jpy: jpy ?? this.jpy,
      kes: kes ?? this.kes,
      kgs: kgs ?? this.kgs,
      khr: khr ?? this.khr,
      kid: kid ?? this.kid,
      kmf: kmf ?? this.kmf,
      krw: krw ?? this.krw,
      kwd: kwd ?? this.kwd,
      kyd: kyd ?? this.kyd,
      kzt: kzt ?? this.kzt,
      lak: lak ?? this.lak,
      lbp: lbp ?? this.lbp,
      lkr: lkr ?? this.lkr,
      lrd: lrd ?? this.lrd,
      lsl: lsl ?? this.lsl,
      lyd: lyd ?? this.lyd,
      mad: mad ?? this.mad,
      mdl: mdl ?? this.mdl,
      mga: mga ?? this.mga,
      mkd: mkd ?? this.mkd,
      mmk: mmk ?? this.mmk,
      mnt: mnt ?? this.mnt,
      mop: mop ?? this.mop,
      mru: mru ?? this.mru,
      mur: mur ?? this.mur,
      mvr: mvr ?? this.mvr,
      mwk: mwk ?? this.mwk,
      mxn: mxn ?? this.mxn,
      myr: myr ?? this.myr,
      mzn: mzn ?? this.mzn,
      nad: nad ?? this.nad,
      ngn: ngn ?? this.ngn,
      nio: nio ?? this.nio,
      nok: nok ?? this.nok,
      npr: npr ?? this.npr,
      nzd: nzd ?? this.nzd,
      omr: omr ?? this.omr,
      pab: pab ?? this.pab,
      pen: pen ?? this.pen,
      pgk: pgk ?? this.pgk,
      php: php ?? this.php,
      pkr: pkr ?? this.pkr,
      pln: pln ?? this.pln,
      pyg: pyg ?? this.pyg,
      qar: qar ?? this.qar,
      ron: ron ?? this.ron,
      rsd: rsd ?? this.rsd,
      rub: rub ?? this.rub,
      rwf: rwf ?? this.rwf,
      sar: sar ?? this.sar,
      sbd: sbd ?? this.sbd,
      scr: scr ?? this.scr,
      sdg: sdg ?? this.sdg,
      sek: sek ?? this.sek,
      sgd: sgd ?? this.sgd,
      shp: shp ?? this.shp,
      sle: sle ?? this.sle,
      sll: sll ?? this.sll,
      sos: sos ?? this.sos,
      srd: srd ?? this.srd,
      ssp: ssp ?? this.ssp,
      stn: stn ?? this.stn,
      syp: syp ?? this.syp,
      szl: szl ?? this.szl,
      thb: thb ?? this.thb,
      tjs: tjs ?? this.tjs,
      tmt: tmt ?? this.tmt,
      tnd: tnd ?? this.tnd,
      top: top ?? this.top,
      ttd: ttd ?? this.ttd,
      tvd: tvd ?? this.tvd,
      twd: twd ?? this.twd,
      tzs: tzs ?? this.tzs,
      uah: uah ?? this.uah,
      ugx: ugx ?? this.ugx,
      usd: usd ?? this.usd,
      uyu: uyu ?? this.uyu,
      uzs: uzs ?? this.uzs,
      ves: ves ?? this.ves,
      vnd: vnd ?? this.vnd,
      vuv: vuv ?? this.vuv,
      wst: wst ?? this.wst,
      xaf: xaf ?? this.xaf,
      xcd: xcd ?? this.xcd,
      xdr: xdr ?? this.xdr,
      xof: xof ?? this.xof,
      xpf: xpf ?? this.xpf,
      yer: yer ?? this.yer,
      zar: zar ?? this.zar,
      zmw: zmw ?? this.zmw,
      zwl: zwl ?? this.zwl,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! RatesResponse) return false;
    final bool Function(Object? e1, Object? e2) mapEquals =
        const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      cad.hashCode ^
      aed.hashCode ^
      afn.hashCode ^
      all.hashCode ^
      amd.hashCode ^
      ang.hashCode ^
      aoa.hashCode ^
      ars.hashCode ^
      aud.hashCode ^
      awg.hashCode ^
      azn.hashCode ^
      bam.hashCode ^
      bbd.hashCode ^
      bdt.hashCode ^
      bgn.hashCode ^
      bhd.hashCode ^
      bif.hashCode ^
      bmd.hashCode ^
      bnd.hashCode ^
      bob.hashCode ^
      brl.hashCode ^
      bsd.hashCode ^
      btn.hashCode ^
      bwp.hashCode ^
      byn.hashCode ^
      bzd.hashCode ^
      cdf.hashCode ^
      chf.hashCode ^
      clp.hashCode ^
      cny.hashCode ^
      cop.hashCode ^
      crc.hashCode ^
      cup.hashCode ^
      cve.hashCode ^
      czk.hashCode ^
      djf.hashCode ^
      dkk.hashCode ^
      dop.hashCode ^
      dzd.hashCode ^
      egp.hashCode ^
      ern.hashCode ^
      etb.hashCode ^
      eur.hashCode ^
      fjd.hashCode ^
      fkp.hashCode ^
      fok.hashCode ^
      gbp.hashCode ^
      gel.hashCode ^
      ggp.hashCode ^
      ghs.hashCode ^
      gip.hashCode ^
      gmd.hashCode ^
      gnf.hashCode ^
      gtq.hashCode ^
      gyd.hashCode ^
      hkd.hashCode ^
      hnl.hashCode ^
      hrk.hashCode ^
      htg.hashCode ^
      huf.hashCode ^
      idr.hashCode ^
      ils.hashCode ^
      imp.hashCode ^
      inr.hashCode ^
      iqd.hashCode ^
      irr.hashCode ^
      isk.hashCode ^
      jep.hashCode ^
      jmd.hashCode ^
      jod.hashCode ^
      jpy.hashCode ^
      kes.hashCode ^
      kgs.hashCode ^
      khr.hashCode ^
      kid.hashCode ^
      kmf.hashCode ^
      krw.hashCode ^
      kwd.hashCode ^
      kyd.hashCode ^
      kzt.hashCode ^
      lak.hashCode ^
      lbp.hashCode ^
      lkr.hashCode ^
      lrd.hashCode ^
      lsl.hashCode ^
      lyd.hashCode ^
      mad.hashCode ^
      mdl.hashCode ^
      mga.hashCode ^
      mkd.hashCode ^
      mmk.hashCode ^
      mnt.hashCode ^
      mop.hashCode ^
      mru.hashCode ^
      mur.hashCode ^
      mvr.hashCode ^
      mwk.hashCode ^
      mxn.hashCode ^
      myr.hashCode ^
      mzn.hashCode ^
      nad.hashCode ^
      ngn.hashCode ^
      nio.hashCode ^
      nok.hashCode ^
      npr.hashCode ^
      nzd.hashCode ^
      omr.hashCode ^
      pab.hashCode ^
      pen.hashCode ^
      pgk.hashCode ^
      php.hashCode ^
      pkr.hashCode ^
      pln.hashCode ^
      pyg.hashCode ^
      qar.hashCode ^
      ron.hashCode ^
      rsd.hashCode ^
      rub.hashCode ^
      rwf.hashCode ^
      sar.hashCode ^
      sbd.hashCode ^
      scr.hashCode ^
      sdg.hashCode ^
      sek.hashCode ^
      sgd.hashCode ^
      shp.hashCode ^
      sle.hashCode ^
      sll.hashCode ^
      sos.hashCode ^
      srd.hashCode ^
      ssp.hashCode ^
      stn.hashCode ^
      syp.hashCode ^
      szl.hashCode ^
      thb.hashCode ^
      tjs.hashCode ^
      tmt.hashCode ^
      tnd.hashCode ^
      top.hashCode ^
      ttd.hashCode ^
      tvd.hashCode ^
      twd.hashCode ^
      tzs.hashCode ^
      uah.hashCode ^
      ugx.hashCode ^
      usd.hashCode ^
      uyu.hashCode ^
      uzs.hashCode ^
      ves.hashCode ^
      vnd.hashCode ^
      vuv.hashCode ^
      wst.hashCode ^
      xaf.hashCode ^
      xcd.hashCode ^
      xdr.hashCode ^
      xof.hashCode ^
      xpf.hashCode ^
      yer.hashCode ^
      zar.hashCode ^
      zmw.hashCode ^
      zwl.hashCode;
}
