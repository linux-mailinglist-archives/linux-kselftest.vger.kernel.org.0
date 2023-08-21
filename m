Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146DA78318C
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Aug 2023 21:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjHUTgx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Aug 2023 15:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjHUTgw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Aug 2023 15:36:52 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2091.outbound.protection.outlook.com [40.107.105.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF95DC2;
        Mon, 21 Aug 2023 12:36:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eEFQMCVVSuoDwEJdcMTdJB9pa1yjDNXAQ0V6R5OUWcIMEFDwBgJTiY6ZdQ9UAAP0lrPdLvjqOWObYwPGXkaDw6yDzMHTT297b6FzIsT3JqbU/ljCkPO1A8+PvuY+JRmgi1kfXMNbO5qDM1mj4L9LHslYLMoIChNFV0NsnTk05iVV0zrBZAjnYvGCtzXIXz8N3Ch71Q8Dl931OxyAvirKV+jthvUUzFdIwCZ8qR6KMHPZ0/f+zbjndkIEk43WmA5yd5JqcNdO3qQ+70JK8Op7x7TTJp+VUTFbsuhl0rAUjIKnef9IOLSf9jNQDbzMQCs50LD+HKVIlw6Ovo9J6efPHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x839lx/pjEUJ9bRSygHkBwRfR+kOtWxNjLlCAd5834E=;
 b=Dyq10LFGcUrAASOIEW/N1Bjz68rk5x/UmPRpjiXP1kPymN+iGC+Ttx1WTocn/nc+39/R4bAGUfUSko3nDtGwjIXoXWs+hRn2dqXlMzYGytWnhXuVevujUg1Rp2vMpWwKAkt75VqPAJgXay1JYkqO7y+z4SYRhtFrKYRAuA9HWhVQ0kc4IB+RKftM8onmQN5xrEzki8Wi9+p2jcbDFJIdl6JFvjmb91OxSsajCMFJ98W9ruj1ELMumVcblvLzFOUUlBHSsKdDAdpiKIJhWLkVXnzWklJB1vc3OS9tS9d+X+2ScTv9ZZmMFAe4sHKqOrp2KbWpzozu5ZXplNpnBIodEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com;
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x839lx/pjEUJ9bRSygHkBwRfR+kOtWxNjLlCAd5834E=;
 b=hGuMg0guW9cGvuHxwQ45hTfj1rhXq+KP7HOrGkKpW/sf2d8715Eok5/uaqnXKrYbKCV4voJxXpGaustwZjv1rDr44rJRoyetFrPcqZExGu7pLN+Jm7aHl7zln5eGnsheRyAnjcZFrgK9YAVPTAdvfCNhRAt9+qfZndZ/OFAziPc=
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
 by PAWP189MB2611.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:336::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 19:36:48 +0000
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670]) by DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670%6]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 19:36:47 +0000
From:   Sriram Yagnaraman <sriram.yagnaraman@est.tech>
To:     Ido Schimmel <idosch@idosch.org>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>
Subject: RE: [PATCH 3/3] selftests: forwarding: Add test for load-balancing
 between multiple servers
Thread-Topic: [PATCH 3/3] selftests: forwarding: Add test for load-balancing
 between multiple servers
Thread-Index: AQHZ0pMUlNN+cgUkKUqzv/5j/AbJm6/0ocqAgACCNMA=
Date:   Mon, 21 Aug 2023 19:36:47 +0000
Message-ID: <DBBP189MB1433714989BBE41321848336951EA@DBBP189MB1433.EURP189.PROD.OUTLOOK.COM>
References: <20230819114825.30867-1-sriram.yagnaraman@est.tech>
 <20230819114825.30867-4-sriram.yagnaraman@est.tech>
 <ZONLz5IyaG+XnUSJ@shredder>
In-Reply-To: <ZONLz5IyaG+XnUSJ@shredder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBP189MB1433:EE_|PAWP189MB2611:EE_
x-ms-office365-filtering-correlation-id: feab7b78-17d4-4294-cd33-08dba27df59b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0+XhQExWFsKWtkbTAwH1xrXcBTVIwQAYYqfKWoPlln8SqKT3ae2oCSnW6lyvStcxcmv+haYDWQ5IIT4X013QWC4IqFsRoa32ho6oLzV25zAAecu960DbdB0lDQXf3swmWOYtPslLSYpTEPeE72zbxOeDAvdQmnY4ab2MSJSzR/zw8bBAcYr1O4Pmq6BkAqSVZ/JflHGXfTJYF5f4qmYyuyB1aPiFFHFoKpOgr6GeySqOdMlzCR0e3j804+xBQPIdTbHkSbn2kChZNqHFvI+rg2/zf1uIWQB93PUxI0sbDKSWuMxCbj2m0OE8p4Q9OPbD7oQDjzV0OG96RZej4IHhH5lH2mE7ojfwtOaf+lt6D7aeFgt9vhL4U2ipnWXarbsd68qwT/ypL0piRBDGSkVD7LMFbm6C7INFc3IfYs3niFAPaaA91cf3h5PVYGmHV8KzCfU/zelyjoOc1ukHK+XwFMuy8Wd3qt9zysSFERgraNn687EerOnv1RKdIs7elApb9d7o+wv+hxMM9YJF0y65psrOmoCbDN8CKjYHHd5wn+/6G3dFON2+BNabdw7W/V3qga4O24bCOkUpal7o5tdBVAHlKWAokSu5PoXYS9OyF90=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(136003)(39840400004)(346002)(186009)(1800799009)(451199024)(26005)(9686003)(33656002)(66574015)(122000001)(55016003)(38070700005)(86362001)(38100700002)(83380400001)(41300700001)(316002)(8936002)(8676002)(66946007)(6916009)(66476007)(66446008)(64756008)(54906003)(66556008)(2906002)(52536014)(44832011)(5660300002)(4326008)(76116006)(7416002)(71200400001)(7696005)(6506007)(966005)(53546011)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0RRRFZhZ21WdDNoMkZUQ2ZSOWxCS0cxWXlKQ2drRFo3anVNRmNLU1pPOWw3?=
 =?utf-8?B?dE5DVTlHc2FyYU5YVXBud2d0a1FRcHJuNU51ck9VMDFJbzFSQ21lbnFJRHdR?=
 =?utf-8?B?UWhibnBwSkt5cE9xekFxeXI4UG12RHhkaVdTTjVxTDJjQVltS2JrRDBpRk45?=
 =?utf-8?B?ZUxVNFE2TFlMc1VoV25wZWsyNzJLcnI4dVVlc0lnQnZIWmUxanhlOEphaU5k?=
 =?utf-8?B?VUJBMkRtbFhQZTdsRGFsd2VDTE9yYjg1YUJWV2VMSUNINzY3QmxldGs0bmFo?=
 =?utf-8?B?aWVPRTkxY1VKNHdXek5mQkNmR1ZtRGszSGNEY0xpTjBLcDhnK1FVdnoxMVk2?=
 =?utf-8?B?UWVKQ3VNNDFyVjlpL0R6WHVaemFQcjE0WTF1UjFMQ3k2LzgvNGp1aFlSMW1E?=
 =?utf-8?B?TVhidnFUWUxYdjBrZ0pvQ1BSZ2hyaWs4VHlFSjU4MnpKVDM0ZUc0cWZ0cDhC?=
 =?utf-8?B?V3p2VXVIQkRqeUFhTFVUY2xGREFhRnJ4OW5KZEhYL1dFUmNFZmtWcnZuaE5R?=
 =?utf-8?B?OUJwZDdZVHRaR0hYaDBYc0FxcUJrTlo2ZTByTlZoZnkzVHhyVTZrUjVnOEd0?=
 =?utf-8?B?eklJTkxPajZEYzM0MkplVE5JMU5CTlZWMnZUVVRGRTVZd0ZsQmpsa3hoTFpa?=
 =?utf-8?B?c0oxdkV0ZDhtOTRXRzg2VnVZZy9jMTlMaVZVa3RXdktyQmtScjFTQzNlSDRz?=
 =?utf-8?B?bmNvSGlYaUNLTFZxRkc2eDVLUk5HakppSUEzRkx3RDRtSlNYRGt1UjE1dlU5?=
 =?utf-8?B?bjljaCt0akZ6TkcxS0lPSDBRM3Fwek9TQXNYeFNNaXNYTGRteHUyQlRzYkIw?=
 =?utf-8?B?bXVFQUtic3lkR2RyUnpIRER0dVFCOXc1a3ROZ3o3ekVkZ0tGM1kxdlhEV1hP?=
 =?utf-8?B?QXpoS2ttQkxhV2YvYmtFeFlPRDZSR3cvVzZXajNta1R6LzJBVndkb1lDVStK?=
 =?utf-8?B?cVFBMjNyQUluMGdxRTBPTnM2VVBjdmp0OGpIQ3ZZM1dmdHQ2UVFEMVYyMzRH?=
 =?utf-8?B?WEExR2JXMFFJQWxzU29jOFlQUmpRM2dNa2daRW5oVXQ3UUJKUW44Q1ZNNVIw?=
 =?utf-8?B?WTZQeVVYemxXaXRYRlR0elpRUVRnYmwyWlVzNnpzT0Z4MUo3c21hTExldG1v?=
 =?utf-8?B?WVpIeGIrd0xSaUg1QjdYWnUyWVZnSmcwV2NLWnlVdjBudWdjbnhSZ0sxSm1o?=
 =?utf-8?B?a0d5c1BEdVJxTGtjeG1xeVJwVm5TUGN4SUxnR2RxMUlnb2t6YjN0TzVBVDY2?=
 =?utf-8?B?a2c4VVJoOVJzV1FSZGlBSDhwUFlQa2hac05ySjdrdDhZTWZTamU5eVNjY3l4?=
 =?utf-8?B?N05FMVNqQTM5L3BnSDY2dU4xMVk5WE1YNFM0WE4vYzRUQzl3T21zRlF0WHFj?=
 =?utf-8?B?QzBYZ2VBNjBrVkFlL0c3UU41bDZjVXpWdWJhUmJqZlJGSUZEUnZKejRQbDhL?=
 =?utf-8?B?UkhQa3B5aFpwWGxTVXBUWjB3cStma3d0NTI3c3hSeHNESklyTm9Ib0NwUGps?=
 =?utf-8?B?MlorUFdNQjZmd1ZBT2t5OUNVd1gzMEtXNExPemtBb1NtKzFNTGFlTG5ZY1l5?=
 =?utf-8?B?OVNtc295alhJRE9hRzlWQ3hBei95NWVHemgvVU5CV2F1cjUvWjQybGdRa204?=
 =?utf-8?B?NkdzekJoMSszbGpERlBoaDFQYXZnbU5neU44V3J6WUM4MXBvcmhrQjR0S0po?=
 =?utf-8?B?OERGcEZ4MXY3ZHFwMzhpVXkwaVpQdURKdGR0V2ozYUk3Y05oUjZVZGdqeDlQ?=
 =?utf-8?B?bnhBb21XZDlzOWlMTDlGa0o0azhTbCtjMkliRGlBZ0RKdlRMbVF0cTNYNURF?=
 =?utf-8?B?QVhFS05YN3ZiZGZRZE1xWFJUV2pkZlNOeHljWUE3dXdDMmdMRHA4ZU9yd1RD?=
 =?utf-8?B?U1ozbEt4NXJoRnRneWNEMDJnQlF4YmNjdWtMQmYvTFRTMU5TWTlEbVd1dTdB?=
 =?utf-8?B?YnRPVWpVZXh6UnZFQzgzQndzQ2tuS2VEbUdLRldtTzdlb2R6VTBBUGk1Z2dF?=
 =?utf-8?B?Zjc1V2pmNitlQVY1dEIyeU00dzk1cEdyMUNmcmhRNFBtVnVwdHAzZXpsZmtJ?=
 =?utf-8?B?VUNoaHlwSlg0cXhNTVZkb29MSVdhNVpsRUJKd0tlN2xpOCtWMG5JUTB2OXRt?=
 =?utf-8?Q?NSI8p1/3ZITnfnFJ6HmOLQtjz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: feab7b78-17d4-4294-cd33-08dba27df59b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 19:36:47.4426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LDkRw2JTV5xiAGtCufYLi2H7CQ34E3bmRq+NqndA3I99QoGgW7R9FD3pHC9fXGCq0C0OMFieTBPXRZe9S6S6WmnPPQCHF/CHZFcNva6WPSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWP189MB2611
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSWRvIFNjaGltbWVsIDxp
ZG9zY2hAaWRvc2NoLm9yZz4NCj4gU2VudDogTW9uZGF5LCAyMSBBdWd1c3QgMjAyMyAxMzozNQ0K
PiBUbzogU3JpcmFtIFlhZ25hcmFtYW4gPHNyaXJhbS55YWduYXJhbWFuQGVzdC50ZWNoPg0KPiBD
YzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgta3NlbGZ0ZXN0QHZnZXIua2VybmVsLm9y
ZzsgRGF2aWQgUyAuIE1pbGxlcg0KPiA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IEVyaWMgRHVtYXpl
dCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IEpha3ViDQo+IEtpY2luc2tpIDxrdWJhQGtlcm5lbC5v
cmc+OyBQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+OyBEYXZpZCBBaGVybg0KPiA8ZHNh
aGVybkBrZXJuZWwub3JnPjsgSWRvIFNjaGltbWVsIDxpZG9zY2hAbnZpZGlhLmNvbT47IFNodWFo
IEtoYW4NCj4gPHNodWFoQGtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMy8zXSBz
ZWxmdGVzdHM6IGZvcndhcmRpbmc6IEFkZCB0ZXN0IGZvciBsb2FkLWJhbGFuY2luZw0KPiBiZXR3
ZWVuIG11bHRpcGxlIHNlcnZlcnMNCj4gDQo+IE9uIFNhdCwgQXVnIDE5LCAyMDIzIGF0IDAxOjQ4
OjI1UE0gKzAyMDAsIFNyaXJhbSBZYWduYXJhbWFuIHdyb3RlOg0KPiA+IENyZWF0ZSBhIHRvcG9s
b2d5IHdpdGggMyBob3N0cywgYSByb3V0ZXIgZWFjaCBpbiBpdCdzIG93biBuZXR3b3JrDQo+ID4g
bmFtZXNwYWNlLiBUZXN0IElQdjQgYW5kIElQdjYgbXVsdGlwYXRoIHJvdXRpbmcgZnJvbSBoMSB0
byBoMi9oMyB2aWENCj4gPiByb3V0ZXIgcjEgd2hlcmUgYSBtdWx0aXBhdGggcm91dGUgaXMgc2V0
dXAgdG8gbG9hZC1iYWxhbmNlIGJldHdlZW4gaDINCj4gPiBhbmQgaDMuDQo+ID4NCj4gPiBTZWUg
ZGlhZ3JhbSBpbiB0aGUgdGVzdCBmb3IgbW9yZSBpbmZvcm1hdGlvbi4NCj4gDQo+IEhvdyBhcmUg
eW91IHJ1bm5pbmcgdGhpcyB0ZXN0PyBBdCBsZWFzdCB3aXRoIHZldGggcGFpcnMgaXQgaXMgcGFz
c2luZyBib3RoIGJlZm9yZQ0KPiBhbmQgYWZ0ZXIgdGhlIHBhdGNoZXMuIEkgZGlkbid0IGxvb2sg
aW50byB0aGUgdmV0aCBkcml2ZXIsIGl0IG1pZ2h0IG5vdCBldmVuIHVzZQ0KPiB0aGUgbGlzdGlm
aWVkIHBhdGguDQoNCkkgYWdyZWUsIHRoZSB0ZXN0IGlzIGZsYWt5LCBhbmQgaXQgZG9lc24ndCBk
ZWZpbml0aXZlbHkgZmFpbCBiZWZvcmUgdGhlIHBhdGNoLCBub3IgZG9lcyBpdCBkZWZpbml0aXZl
bHkgcGFzcyBhZnRlciB0aGUgcGF0Y2guIENoZWNraW5nIHRoZSBwYWNrZXQgdHJhbnNtaXQgY291
bnRlcnMgaXMgcHJvYmFibHkgbm90IHRoZSBiZXN0IHdheSB0byB0ZXN0IHRoaXMuIEkgd2lsbCB0
cnkgdG8gcmV3cml0ZSB0aGlzIHNlbGZ0ZXN0IHVzaW5nIG5jYXQuDQpJIHVzZSBtY29ubmVjdCBb
MF0sIGFub3RoZXIgdGVzdCB1dGlsaXR5IHRvIHRlc3QgdGhhdCBhIFRDUCBjb25uZWN0aW9uIHN1
Y2NlZWRzIGZvciBteSBvd24gdGVzdGluZywgYnV0IEkgZ3Vlc3MgdXNpbmcgdGhhdCBpbiBzZWxm
dGVzdCBpcyBub3QgYW4gb3B0aW9uLg0KDQpEbyB5b3UgdGhpbmsgaXQgd291bGQgYmUgT0sgdG8g
ZHJvcCB0aGlzIHBhdGNoIGZyb20gdGhlIHNlcmllcyBmb3Igbm93PyBJIGNhbiBjb21lIGJhY2sg
d2l0aCB0aGUgc2VsZnRlc3Qgd2hlbiBJIGhhdmUgc29tZXRoaW5nIHdvcmtpbmcgY29ycmVjdGx5
Pw0KDQo+IA0KPiBBbHNvLCBJJ20gc2VlaW5nIHRoZSBmb2xsb3dpbmcgZXJyb3JzIGR1cmluZyB0
aGUgdGVzdDoNCj4gDQo+IHN5c2N0bDogc2V0dGluZyBrZXkgIm5ldC5pcHY0LmZpYl9tdWx0aXBh
dGhfaGFzaF9wb2xpY3kiOiBJbnZhbGlkIGFyZ3VtZW50DQo+IHN5c2N0bDogc2V0dGluZyBrZXkg
Im5ldC5pcHY2LmZpYl9tdWx0aXBhdGhfaGFzaF9wb2xpY3kiOiBJbnZhbGlkIGFyZ3VtZW50DQoN
ClswXTogaHR0cHM6Ly9naXRodWIuY29tL05vcmRpeC9tY29ubmVjdA0K
