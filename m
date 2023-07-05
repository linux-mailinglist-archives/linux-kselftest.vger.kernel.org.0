Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52BCF748528
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jul 2023 15:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbjGENib (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jul 2023 09:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjGENia (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jul 2023 09:38:30 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2125.outbound.protection.outlook.com [40.107.117.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C992171A;
        Wed,  5 Jul 2023 06:38:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TfWcE0hrApKRKjWZys1bad+UE5OGuP28n0s0h1uWrQFuV6K883huBiMg/RWLtrRXkGnNXF0rIR2kVV6OcjAVMfFCUobQY4QHopvAL6Cbe2p9cV1Yncm3kOe8UpOOKfEhw2r2k2dI17MSMr66sKF2ZRnwu8Re37/GCqA2Ki+xRlzor7dNlN7tQ+jX6rDfM0t2sM1OnCcdLVT28xZExFEFTXfkX/OA4ZPAFwYDO9EmdOD2gOssoiAIiM5vVArTM9k0PLtIQ06F4ylcl9cKBZokEmM6ywaPkW2WOzLCv4hZ+JMALA9m5guDvhUQauG2ZljkyKDwrLoMNxWFM+xhv6sYkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+HMfeRZH3VjhY+Z7LuQ8uNmnJ9/3sfQSn79HNVOrp2Q=;
 b=V2EbzoLlBAbfAJeymhLPZqZ5ujoYDaRRJ8q1QiXoSdwiXKyiqNihOREiIgwphOwlLFbdBEk7LYDKq2swm/Z0oJnqYG1qVed2YdCRjm/sbj5wAev/aR7i1KwPpAVUBEp61/7X8lh5y5Ws3i5YpZaNojS9leMqx4aF7lirlRVgZcJhE+ndeUHyeKc3xPs5RhJjBI6D9/vumOnHeIdI/zbkEpRW/21N13887D35/1LOtpYnGH6B1LPz+sMigppuX7V/d1oxppyx9fzA5wjJbS0T+oz3eyjTtxGHOiIjdo7Ras0SoQjPzZbZMvnAQxljFDlEGV0cAOLdBs04crnf5ARhAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HMfeRZH3VjhY+Z7LuQ8uNmnJ9/3sfQSn79HNVOrp2Q=;
 b=KkiR/PV3c6PJHUnKjzLi9AFRvg8uMl9ijH5a3P/EY1B2YiW+VUIiRfJNJjyxXogbnETJbKaztpwrRekQaiNJpeXr7DMEXp1ljSNjN9GB1dKitzN888SiOam8qcGm95VfT+Tx+zjuf6UlFMwwNUdX9dsg1XrNAtpSP24uUm8JdosozRZntp79YIYJXw2LF/X0mEY/KKxTTmmFoYBr4AeAFINVHszEAwUKCetDa+rDRWwIUyVh/kjt0FW5t24zsdYhi8mKimid9Y6HfhuPMpDHCdcgbA0bof3tcSJpe0ddm8JvOrwUkZIe8YNNmoiA5h8p81nlkvxAlWd378Xcx/hNfw==
Received: from PS1PR0601MB3737.apcprd06.prod.outlook.com
 (2603:1096:300:78::18) by TYSPR06MB6337.apcprd06.prod.outlook.com
 (2603:1096:400:42b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 13:38:25 +0000
Received: from PS1PR0601MB3737.apcprd06.prod.outlook.com
 ([fe80::9531:2f07:fc59:94e]) by PS1PR0601MB3737.apcprd06.prod.outlook.com
 ([fe80::9531:2f07:fc59:94e%4]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 13:38:25 +0000
From:   =?utf-8?B?546L5piOLei9r+S7tuW6leWxguaKgOacr+mDqA==?= 
        <machel@vivo.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjFdIHNlbGZ0ZXN0czpicGY6Rml4IHJlcGVhdGVk?=
 =?utf-8?Q?_initialization?=
Thread-Topic: [PATCH v1] selftests:bpf:Fix repeated initialization
Thread-Index: AQHZrz0qTuH0jRB4B06ECD8z5mytd6+rK7YAgAABT/A=
Date:   Wed, 5 Jul 2023 13:38:24 +0000
Message-ID: <PS1PR0601MB37373945FE6F9EC0A42AD590BD2FA@PS1PR0601MB3737.apcprd06.prod.outlook.com>
References: <20230705123432.1655-1-machel@vivo.com>
 <cfc5f09e-7af1-abb9-aee9-737e3fe09c77@iogearbox.net>
In-Reply-To: <cfc5f09e-7af1-abb9-aee9-737e3fe09c77@iogearbox.net>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PS1PR0601MB3737:EE_|TYSPR06MB6337:EE_
x-ms-office365-filtering-correlation-id: 97557cd4-5544-4872-2002-08db7d5d1b89
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yEjwO87ptAlaE+Dx6bHHsGzEVxjik3AwV+s3f4Zp5i3qrvOhXdTCGcJL1UPqepKUXllts/z7+mIFkpz2+ypg8fpyehwRCxqhPFPToxahaIw7WrSwLi7Vpjce32O9YIVCYaPHmYjlVXW/lPS+fD3bApH8LVoQP2nwNryvK+gKmh0rpIZhY2aw3JldsGKFxZOd4ZxEsYSKfE2z4LnTuVOwKYRj+47Qq2uCNinieZ3n8QY9Dv1Yg4KpG2dacjCPu9JQ4UehlR0SO6Bcq50sQ9L5VF/l0ViILEH+7Prqhk32vJK5wak7ycpmZV96RFsdFy51pAAcKoAEWOZp0o3iINPT5M8/KO4QeW5ZSG2zpUWoXzBm9kW80lzgcYn1pLVEQzbo1T62LOy3reyXtdPk/d3gkRvCxU2fkbezVEXZoR7c7ebMuRPQG/vyZUtsj94U2wCGd9TEh+abbRuwRSueX5nhBmSeDS3reHbTtU0ZrgzUFrD6Y4ty0YEXozFCCrmdi0m9r1ngU+vsTkOnXIfpr9h3r4O4d718oXB/L4Xsafny2+Vd/h6wizYLoaTurm1mlL+w+YnM/HxpuG1bm9uef1XzVQ+emRGKEKJ0AcCzL81cEieB87a13yGB4wk16uj+NeLL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR0601MB3737.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199021)(41300700001)(316002)(7696005)(186003)(83380400001)(53546011)(9686003)(6506007)(26005)(52536014)(54906003)(478600001)(33656002)(71200400001)(122000001)(38100700002)(66446008)(76116006)(66946007)(64756008)(66476007)(6916009)(55016003)(4326008)(66556008)(224303003)(5660300002)(7416002)(38070700005)(86362001)(8936002)(2906002)(85182001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akdlUDIzTERUak80V1h6WU41eENGS2MwVHpvY1B6SDErT0JjNzlkSktxb3Zp?=
 =?utf-8?B?MUlpdk9PVGY5MEJtK2puWjliTjVxUk4zRzFmek1DTWYzeGVLTys2YmxaMFB5?=
 =?utf-8?B?aGZVYldoRktPK09tVEpjVnNrT0IrWnlRZU93QlRtcFV1VGNPNVdoNDVOQUZT?=
 =?utf-8?B?N0RTSnVmWi9tbXJqZUlDUTZad281bWUzZ29GUS9lb095ZDJaalRTcjN5TFFZ?=
 =?utf-8?B?WFU4QklHU1ZMOWx3VDZxTjEwczd0WVBKNHppVU51OW84MjhodTRYSU1neVVj?=
 =?utf-8?B?ajdZVkJmTVA5elVaeVd6Rk0zcWhRRStETFNTNTRaQlV2SVBTREhKQjc3NDdj?=
 =?utf-8?B?bEZoT0J0bEM4MXBaT1ZuOXFOSnIvWCtET3dXZ1F3YVV2UllScXlnWDdvRSt6?=
 =?utf-8?B?cnF5Vmp6cWVucmZFNWZoWnMwWU9zNXAycDVaRGUydnF3QSs3c3I4aHNsL1Bh?=
 =?utf-8?B?ODBJMU5UTU9PYUJUVFBiTkJQYUJzL0xSWko4YVorVzJGZDdFSnc0aXpOTlBl?=
 =?utf-8?B?MlFKL2hXR1JvUGgrRUFhMGs2cWNXejJxekJGSEtjdkNNSzZvZUxVRUdyaUtZ?=
 =?utf-8?B?d3QzZlVNOUVEUUVSWWlwTkFNOWFQTHRvaUZXSEFvRXRPMytaalFqR3I4NEtF?=
 =?utf-8?B?QmtzR0ZiKzg2NEdTZ0hQREVUMmQvcjQvMmg0eTdnUzd2NHAvQTU5eDg0bnZE?=
 =?utf-8?B?WEd1Z2FiQ3lWSXJOZHFBTzl6dFpUMk5pSHFUREtiOVlnWEN0d2NYekY0ZFFt?=
 =?utf-8?B?emVEK3hMSHZaSU4zcGpwYXpzNjVubEluNmN5UHhzdVRCbndFZEpPQm1oZG5z?=
 =?utf-8?B?dzBPeEpCTjNFOWg0aHBaVFZuVjdoQXhJZlYvZzBVNmVnYmwrUzZkVVpJZXRh?=
 =?utf-8?B?SzBiZXZEVzVpTkZoWDN6aFpXeHo2eDE3T05UeE1TNGdvVmE0dVZMVHdjK3FE?=
 =?utf-8?B?aTc5ZllORWhuVEtIeTZ5UkNVV0RTQTJBaXhLaDBzdnAxR0hqQk01MHA2Sktj?=
 =?utf-8?B?cXE4ditYRUM2c2ozbmo2UG9yVFFaTkxIM3lFQTlTQjBONzlrSlBuR01zNTBT?=
 =?utf-8?B?b2ZOKzFISjNtTFhFdnc1Zi9FWnU1Mit0c05paDVKQjhtVVM5M25RdnZRWll1?=
 =?utf-8?B?TDJWbEVwNGxGeFZJdWZmZWtHOE1rVHd2WEFhV0FaWU1UdU9QRG5UeUc0VWgr?=
 =?utf-8?B?QXNNTkJTdEhCMERVTzQ3Tm9QSFAvcTR6OXdkVDBIUWE2NWorc2p6ODN0aFNG?=
 =?utf-8?B?WlgvbDJMN2ZjUmtCdkRKUlFJdWc5NnMzdHdOOSttVktraHVFVzhsSnJGL2Yv?=
 =?utf-8?B?SUpoYStqV2VCWXpmaW4raXEvQlhLQ3piRzdPWjM3d1dYbHRxTHByaUdUbDRi?=
 =?utf-8?B?Uk9PNm9ubHJJeS9idEt2dlpPYkk0YitXbHNZeGUxSURRTVVKRFQ4MHBmSnY1?=
 =?utf-8?B?SXBMVTdOZG5RaExqaThxbHVWZHpxMyt4QUJFWEVsUzUwUnNJN1pKVXRmQmxj?=
 =?utf-8?B?ZWRRRFdJa1VXdy94RkFHdVBkanlQSTZLZWJTeWZDTWxoTmZWQlNBcmV5QnAy?=
 =?utf-8?B?ZzdnK3dEL3JYYjFZREhzMkJFOENlc1VsWkcvdWp3a3E1bkZxNlo0OXZKcWgv?=
 =?utf-8?B?SXJNZXRJd1FZK0YzRUZpbjFiVWlrcitDYTliLzlrWERnWTM0RERUK2hKOXY4?=
 =?utf-8?B?TUhHbjhXTGcwYVJvVnZ3elkrZVptUW8ya3p3U1pXaUUwd0w2RjFrRkcrK1g4?=
 =?utf-8?B?WjJ6YzNqRUg4bjluNVc2dk1VUVdRR2xyN09QZnNKajhYbEE4Y2EvbWp2bDdQ?=
 =?utf-8?B?blhjRFN1bnkybU9HcjBsVFlINFVOWCtoOXI2RUlZZXcvbzYxTmdrMWdOSFJk?=
 =?utf-8?B?RVAzOFg1YVAvVlRhdzJHSlkrdUVXVmZyWlZWV3VaM05zaHJRYno1MFQyZWdv?=
 =?utf-8?B?M3VvaFJyRTVRSE05dmlFSlVKNjFLa1FyMGxneTZ4M2lUZURDdmMyK1NtSFdj?=
 =?utf-8?B?Z0lnWXVuWHNrMTYzbWsyQ2dQODR2bmdUZy9KNmJUbm1GTHo5VkNNa0hRc0x0?=
 =?utf-8?B?M2kzV2U4SDRSZEd3eDBuLytLUWgvMWtCaWZuZ3hlcW4vQVNYNHlONkQyTWFo?=
 =?utf-8?Q?dsTM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS1PR0601MB3737.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97557cd4-5544-4872-2002-08db7d5d1b89
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 13:38:25.0084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pQEYMbgFJTz2yr1Lg5Hpodpeuhfoq4DHOqfptFHOVlsHoNIlS4Sck9yXsFhyT05UKPGmSxn8tBGprZrPVZUb8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6337
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

VGhhbmsgeW91LCBidXQgSSBkb24ndCB1bmRlcnN0YW5kIHRoZSBlcnJvci4NCg0KLS0tLS3pgq7k
u7bljp/ku7YtLS0tLQ0K5Y+R5Lu25Lq6OiBEYW5pZWwgQm9ya21hbm4gPGRhbmllbEBpb2dlYXJi
b3gubmV0PiANCuWPkemAgeaXtumXtDogMjAyM+W5tDfmnIg15pelIDIxOjMyDQrmlLbku7bkuro6
IOeOi+aYji3ova/ku7blupXlsYLmioDmnK/pg6ggPG1hY2hlbEB2aXZvLmNvbT47IEFsZXhlaSBT
dGFyb3ZvaXRvdiA8YXN0QGtlcm5lbC5vcmc+OyBBbmRyaWkgTmFrcnlpa28gPGFuZHJpaUBrZXJu
ZWwub3JnPjsgTWFydGluIEthRmFpIExhdSA8bWFydGluLmxhdUBsaW51eC5kZXY+OyBTb25nIExp
dSA8c29uZ0BrZXJuZWwub3JnPjsgWW9uZ2hvbmcgU29uZyA8eWhzQGZiLmNvbT47IEpvaG4gRmFz
dGFiZW5kIDxqb2huLmZhc3RhYmVuZEBnbWFpbC5jb20+OyBLUCBTaW5naCA8a3BzaW5naEBrZXJu
ZWwub3JnPjsgU3RhbmlzbGF2IEZvbWljaGV2IDxzZGZAZ29vZ2xlLmNvbT47IEhhbyBMdW8gPGhh
b2x1b0Bnb29nbGUuY29tPjsgSmlyaSBPbHNhIDxqb2xzYUBrZXJuZWwub3JnPjsgTXlrb2xhIEx5
c2Vua28gPG15a29sYWxAZmIuY29tPjsgU2h1YWggS2hhbiA8c2h1YWhAa2VybmVsLm9yZz47IGJw
ZkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtzZWxmdGVzdEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCuaKhOmAgTogb3BlbnNvdXJjZS5rZXJuZWwgPG9wZW5z
b3VyY2Uua2VybmVsQHZpdm8uY29tPg0K5Li76aKYOiBSZTogW1BBVENIIHYxXSBzZWxmdGVzdHM6
YnBmOkZpeCByZXBlYXRlZCBpbml0aWFsaXphdGlvbg0KDQpPbiA3LzUvMjMgMjozMyBQTSwgV2Fu
ZyBNaW5nIHdyb3RlOg0KPiBJbiB1c2VfbWlzc2luZ19tYXAgZnVuY3Rpb24sIHZhbHVlIGlzDQo+
IGluaXRpYWxpemVkIHR3aWNlLlRoZXJlIGlzIG5vDQo+IGNvbm5lY3Rpb24gYmV0d2VlbiB0aGUg
dHdvIGFzc2lnbm1lbnQuDQo+IFRoaXMgcGF0Y2ggY291bGQgZml4IHRoaXMgYnVnLg0KDQpQbGVh
c2UgbmV2ZXIgc3VibWl0IHBhdGNoZXMgd2hlcmUgeW91IGFyZSBqdXN0IHNwZWN1bGF0aW5nIGFu
ZCBkaWQgbm90IGV2ZW4gYm90aGVyIHRvIHJ1biBCUEYgc2VsZnRlc3RzICENCg0KT3RoZXJ3aXNl
IHlvdSB3b3VsZCBoYXZlIHNlZW4gdGhhdCB5b3VyIGNoYW5nZSBpcyBicmVha2luZyBpdCA6DQoN
CkVycm9yOiAjMTI2IGxvZ19maXh1cA0KRXJyb3I6ICMxMjYvNSBsb2dfZml4dXAvbWlzc2luZ19t
YXANCiAgIEVycm9yOiAjMTI2LzUgbG9nX2ZpeHVwL21pc3NpbmdfbWFwDQogICBtaXNzaW5nX21h
cDpQQVNTOnNrZWxfb3BlbiAwIG5zZWMNCiAgIGxpYmJwZjogcHJvZyAndXNlX21pc3NpbmdfbWFw
JzogQlBGIHByb2dyYW0gbG9hZCBmYWlsZWQ6IEludmFsaWQgYXJndW1lbnQNCiAgIGxpYmJwZjog
cHJvZyAndXNlX21pc3NpbmdfbWFwJzogZmFpbGVkIHRvIGxvYWQ6IC0yMg0KICAgbGliYnBmOiBm
YWlsZWQgdG8gbG9hZCBvYmplY3QgJ3Rlc3RfbG9nX2ZpeHVwJw0KICAgbGliYnBmOiBmYWlsZWQg
dG8gbG9hZCBCUEYgc2tlbGV0b24gJ3Rlc3RfbG9nX2ZpeHVwJzogLTIyDQogICBtaXNzaW5nX21h
cDpQQVNTOmxvYWRfZmFpbCAwIG5zZWMNCiAgIG1pc3NpbmdfbWFwOlBBU1M6ZXhpc3RpbmdfbWFw
X2F1dG9jcmVhdGUgMCBuc2VjDQogICBtaXNzaW5nX21hcDpQQVNTOm1pc3NpbmdfbWFwX2F1dG9j
cmVhdGUgMCBuc2VjDQogICBtaXNzaW5nX21hcDpGQUlMOmxvZ19idWYgdW5leHBlY3RlZCBsb2df
YnVmOiAnODogPGludmFsaWQgQlBGIG1hcCByZWZlcmVuY2U+DQogICBCUEYgbWFwICdtaXNzaW5n
X21hcCcgaXMgcmVmZXJlbmNlZCBidXQgd2Fzbid0IGNyZWF0ZWQNCiAgICcgaXMgbm90IGEgc3Vi
c3RyaW5nIG9mICdyZWcgdHlwZSB1bnN1cHBvcnRlZCBmb3IgYXJnIzAgZnVuY3Rpb24gdXNlX21p
c3NpbmdfbWFwIzIwDQogICAwOiBSMT1jdHgob2ZmPTAsaW1tPTApIFIxMD1mcDANCiAgIDsgaW50
IHVzZV9taXNzaW5nX21hcChjb25zdCB2b2lkICpjdHgpDQogICAwOiAoYjQpIHcxID0gMCAgICAg
ICAgICAgICAgICAgICAgICAgIDsgUjFfdz0wDQogICA7IGludCB6ZXJvID0gMDsNCiAgIDE6ICg2
MykgKih1MzIgKikocjEwIC00KSA9IHIxICAgICAgICAgOyBSMV93PTAgUjEwPWZwMCBmcC04PTAw
MDA/Pz8/DQogICAyOiAoYmYpIHIyID0gcjEwICAgICAgICAgICAgICAgICAgICAgIDsgUjJfdz1m
cDAgUjEwPWZwMA0KICAgOw0KICAgMzogKDA3KSByMiArPSAtNCAgICAgICAgICAgICAgICAgICAg
ICA7IFIyX3c9ZnAtNA0KICAgOyByZXR1cm4gYnBmX21hcF9sb29rdXBfZWxlbSgmbWlzc2luZ19t
YXAsICZ6ZXJvKSAhPSBOVUxMOw0KICAgNDogPGludmFsaWQgQlBGIG1hcCByZWZlcmVuY2U+DQog
ICBCUEYgbWFwICdtaXNzaW5nX21hcCcgaXMgcmVmZXJlbmNlZCBidXQgd2Fzbid0IGNyZWF0ZWQN
CiAgIHByb2Nlc3NlZCA1IGluc25zIChsaW1pdCAxMDAwMDAwKSBtYXhfc3RhdGVzX3Blcl9pbnNu
IDAgdG90YWxfc3RhdGVzIDAgcGVha19zdGF0ZXMgMCBtYXJrX3JlYWQgMA0KDQo+IFNpZ25lZC1v
ZmYtYnk6IFdhbmcgTWluZyA8bWFjaGVsQHZpdm8uY29tPg0KPiAtLS0NCj4gICB0b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ3MvdGVzdF9sb2dfZml4dXAuYyB8IDggKystLS0tLS0NCj4g
ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9ncy90ZXN0X2xvZ19m
aXh1cC5jIA0KPiBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9ncy90ZXN0X2xvZ19m
aXh1cC5jDQo+IGluZGV4IDFiZDQ4ZmVhYWE0Mi4uMWM0OWIyZjliZTZjIDEwMDY0NA0KPiAtLS0g
YS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ3MvdGVzdF9sb2dfZml4dXAuYw0KPiAr
KysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ3MvdGVzdF9sb2dfZml4dXAuYw0K
PiBAQCAtNTIsMTMgKzUyLDkgQEAgc3RydWN0IHsNCj4gICBTRUMoIj9yYXdfdHAvc3lzX2VudGVy
IikNCj4gICBpbnQgdXNlX21pc3NpbmdfbWFwKGNvbnN0IHZvaWQgKmN0eCkNCj4gICB7DQo+IC0J
aW50IHplcm8gPSAwLCAqdmFsdWU7DQo+ICsJaW50IHplcm8gPSAwOw0KPiAgIA0KPiAtCXZhbHVl
ID0gYnBmX21hcF9sb29rdXBfZWxlbSgmZXhpc3RpbmdfbWFwLCAmemVybyk7DQo+IC0NCj4gLQl2
YWx1ZSA9IGJwZl9tYXBfbG9va3VwX2VsZW0oJm1pc3NpbmdfbWFwLCAmemVybyk7DQo+IC0NCj4g
LQlyZXR1cm4gdmFsdWUgIT0gTlVMTDsNCj4gKwlyZXR1cm4gYnBmX21hcF9sb29rdXBfZWxlbSgm
bWlzc2luZ19tYXAsICZ6ZXJvKSAhPSBOVUxMOw0KPiAgIH0NCj4gICANCj4gICBleHRlcm4gaW50
IGJwZl9ub25leGlzdGVudF9rZnVuYyh2b2lkKSBfX2tzeW0gX193ZWFrOw0KPiANCg0K
