Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8C278DBC0
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Aug 2023 20:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238300AbjH3Shf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Aug 2023 14:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242682AbjH3JR2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Aug 2023 05:17:28 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2116.outbound.protection.outlook.com [40.107.20.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FEAD2;
        Wed, 30 Aug 2023 02:17:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErBUHfsu4SlFE7wCyJroziLuhyfq7opbl6GRHeAVtTlnTHDJz6m21ZDUi7u829iFcDSCaDwSp22wfdUy+LLxNRR2FGm3hPsc7SxOLMgecsDZVWdT8o76XSw/Gsz4iN51XVea59BW9Gg9xiyPQQI97F2UgBKLG9vKKX7x0vKS97Lm5LhDvLScCZZYhV4ZYWpBUaPgxJgD5Ul6z5/ThT4eIpxmwyr8DkSiCWPDxIQc8QspNUDMpeEc474Ii50K7S2KTKj+8v4CHOUf+eGNJfnGbpsEDOPxrb7AKGQVqKH3Lvjudz4BAhM8X0RwRX0odwUE0HBUamRaj02eWIZrKNZliw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bi45xbgJAnCqxG9+By6rhwzI4h8p240yYNwXmgkeuLE=;
 b=Iv3tOCebIVT5bQwJylwUJ2tRuyycsE3Ez4h2Hb/WAu/8bcxDN2K0TZHhmZ27CXRjc253dLws+IxRFwCLIXr8MrBcWgKegBgeprAQs/Y3b9tlqcQSCotgRioCeqAdQVU9IE/nQvzwfWn9K8G6dAhrMIqTQRfwTH288/3LrOIJBSqV6UxEIH768/vUWDtOl09cbrIAAepfU93UVLVihlpmxQl/hp4BKSPMD9nMTJKQ613Y//mVdpuV3prRh8OGB1de19oKRaA/PZ6vUF0V+jieMvObXPY9Sc9B4H5tyjQB3/hH+Z5AChxyd+UeCqGCbfHiGf18VVJzN11msRy+yolRiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com;
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bi45xbgJAnCqxG9+By6rhwzI4h8p240yYNwXmgkeuLE=;
 b=WeLh6B5lqk8BaTNNv7MYDu/beo1xyGy5Rwz2cGvBsnFxSyafZmlVWGIQ4elLKia8pGA7AxOHAiPy7oPRJxuJ7i/OgZMLCjGt+Q2fIiyTM7YT7kx0FboWU0a8gOEWoNfY66YozQRyxHsytWICRXWZA75aNJ5Gr1Rf+W+F6RKlJEg=
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
 by AS8P189MB1461.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:2a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Wed, 30 Aug
 2023 09:17:22 +0000
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670]) by DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670%6]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 09:17:22 +0000
From:   Sriram Yagnaraman <sriram.yagnaraman@est.tech>
To:     Ido Schimmel <idosch@idosch.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Ido Schimmel <idosch@nvidia.com>,
        Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>
Subject: RE: [PATCH net v3 3/3] selftests: fib_tests: Add multipath list
 receive tests
Thread-Topic: [PATCH net v3 3/3] selftests: fib_tests: Add multipath list
 receive tests
Thread-Index: AQHZ2asowRadWDnH70KJLUA9KVbLsa//1BgAgAK9RiA=
Date:   Wed, 30 Aug 2023 09:17:22 +0000
Message-ID: <DBBP189MB1433991FA2FC288F7274193995E6A@DBBP189MB1433.EURP189.PROD.OUTLOOK.COM>
References: <20230828113221.20123-1-sriram.yagnaraman@est.tech>
 <20230828113221.20123-4-sriram.yagnaraman@est.tech>
 <ZOy8JOjw9W4g8fYa@shredder>
In-Reply-To: <ZOy8JOjw9W4g8fYa@shredder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBP189MB1433:EE_|AS8P189MB1461:EE_
x-ms-office365-filtering-correlation-id: d5ae7c8c-af96-4850-e0db-08dba939eae5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1Ku7bmCVFPkdX+DMPahLd0sz8eMi17CTNpMeOO25hY7GfXnn/w55tcK+RBq/pLM/fnJNk62P/VAeg24jxP+SwuSUggm0nHGdPDfu/J/iQdufYmj3xjleHRb+eRa89GL8Q3n+kUOCcbKn9aFRZzRX2Ahd81bus1Ru0eAdtbuETk7+2nvUsJqRntVu/HIG7VW45F4tyB8fJgO03e37MNHM05rhvF3b8pA9PuobGQNW0ObPrJc6qrsuMPmwXBOGmiKlYcF3h2U6ML54e2NsW79+GcAL5ubrvMGvxCZZymHyN4vCs9LXMTnEDq4mHx+4789Tbwz8tPuW38gtbLODtOlMPZ/Yo8MtA/OIDoXRsAOSUu5DXbosQ9BZP4VFX7MiziidpDxJg3Dd3ZRTpreAL5iORC2LhV/2jD4prIuXmT96mnBwTwpFBtdD8g/y9L62Kb4kGNuyJfkVjQPLurWFhWcyKjGk6HlG0IzwsssK+oBtSA8Er/HCp7Y966MXk7+fNt+HWqEslOkSZ4Z4rQ0CXq1GskSOtQNBwgdNh/8G7aeQUWdyIBZReLh6NzK1E7DDTWCOk2OTdFgdxdnYc7jNHMup4LLXrn1woIzz6hGGq2RgWqaAhkNb3A9yrgE2LqVlrGG1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(376002)(366004)(39840400004)(1800799009)(186009)(451199024)(8936002)(122000001)(66946007)(76116006)(478600001)(110136005)(53546011)(7696005)(6506007)(71200400001)(66556008)(66476007)(64756008)(54906003)(66446008)(316002)(38070700005)(38100700002)(41300700001)(9686003)(5660300002)(8676002)(44832011)(26005)(83380400001)(2906002)(86362001)(52536014)(55016003)(7416002)(33656002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXEzOUNFK0IvKzRYMmNvTUlZVXhGNVN6UXpTOGZVcXNKNGZxRWI1M2NqSHpI?=
 =?utf-8?B?TWVVc1pzTURIOW1vMFd6Y24veUdTUTFjWkRqaGo0Q0JjSXUxVmtVa2pIb3hm?=
 =?utf-8?B?VFNzcmIybHhLUy9VOHB3SjVMMXhDOFVMRjhXMHlNS0xaWHBoTTZQeWlCN1Nu?=
 =?utf-8?B?UXdiODRpMGxzMUdqZWhzNUR6TFhmRkdXMXphdHhySFNhZ1lQV05JVTZlb0Jr?=
 =?utf-8?B?TE1vVFo3WklzTUJGeHdPWTlhaXpseGFFUmVkUWN3UkVKelhsL2c4cDFlUC9s?=
 =?utf-8?B?UDQ4N3pUZnZuM1VrL3RvcDg0ZU55OFdXZDlxUlFpL3V4ZUpjdXE1YlVjUUxW?=
 =?utf-8?B?ZElxdjAzSVJhMklPWWJlNzcwSDFtQktiZnpNN0NUVUpxOVNPVktIWWc5V1dx?=
 =?utf-8?B?TlBISG1rZkJjQ1BYakdtUTJTWjNNT3cybXVtUmMrTEhKRS9IWTNndFB0QlMz?=
 =?utf-8?B?ZFcwSkdGOGhxMUhPN3FnanVhcUJoS0psYzNvdUZ0MDdKOXMwbmNOZy9KcU90?=
 =?utf-8?B?bWVNVGp4WC95TVdDQk5CcndQcklXTUphYlZDdytFT2FraUw3Q3lZQXQwVWFY?=
 =?utf-8?B?ZEM1dzNmcFRwR0s4QURKcW5jUDNXWGpYcVdBeTN6N0ZUYkNnelNpc1gvbFpJ?=
 =?utf-8?B?ODMrd0xFUWNjbWpiNVVqUTFrU0MyZzRiZ1I5Y3RjMlJ4UTFha253aUU3clBE?=
 =?utf-8?B?em5SYXMyRGt5b2FuanJnTHZGUFRtaURsVkhjOUtqRk5YNnBMUG9Qd1BZUGRi?=
 =?utf-8?B?dGxCVlEzbTRpUXFQL2xhZ1M2ZGpldkQ1ZlkwODB3OTZ2Qm94dm5YcVkxVUdF?=
 =?utf-8?B?V25BaUVUbDdCRmxMa2VreWxnOFNkMmlZdi8zS1FFc1pKaXFlSytyc0N0Um9R?=
 =?utf-8?B?cEhNbXRUUjJEME8xWkNJYlh4MjlLbThCejhMNlVac3RlL0J5RFVSSmFpNHFJ?=
 =?utf-8?B?WndrUWN3emhWU081UVFyYUx0ZkZ5U21XeU9pVXB0RDZxQkdWbDYvQ29FTWdi?=
 =?utf-8?B?NTJWMXhZcVM3MzJDSHpMTjNZVysrSGJlRzVYYzJPNFBlVEtkL3lQcjR3WDNU?=
 =?utf-8?B?NjltMy9Qc3lUMzlPdjV5ZlRyVUFjeGl5ZG5aV1NQNXR0WXc1MFVndEpvZUll?=
 =?utf-8?B?L0hNNnJnTXBoZGhRQjk1U2FWTm01dkRxWjRORHI0RUE5c25OYm4yUXBRaytB?=
 =?utf-8?B?QnpIbVVVNTZQNTlHQWZHSGNFWFdMd0dsZU5oUC9EQkxLYnNuaC8zNjFKWEF2?=
 =?utf-8?B?TzRJdzNPUTEzemNqUm85cnRCb0E5OGl2VFIycDdYajNYWWI4ZlcyQkkxeXNl?=
 =?utf-8?B?SWxhaGpQZENIcGZCZkVuelExeWZ0bUh4a04rV3ptaDJzYUsxazc5NkdlN0R0?=
 =?utf-8?B?SFVubzZSZXNsYWRweDk2RnNrWkNnKzRybVd3OFNWVUk1NHllNklVNjdjMTlZ?=
 =?utf-8?B?MWViK1hjRUZxNk84TXV3ejNMN09aeCtabmhiWXNualltUG1KOXN6YnplSGRV?=
 =?utf-8?B?Y3ZUeVBNb2JIN0YvUUdkQ2VuOVoxZWpMZXhkQXJscVowOW52TVBqZzNCamRz?=
 =?utf-8?B?N3poVEtLWGJ2bjJabk11bG1UYzExREtlbXhaYnRvYTc0RVB1UHd2SXoyQkE5?=
 =?utf-8?B?cEloQThQVjFWcUk0YkI4K202ODVLMDhkc0NWU2labGVVbEtyUmpqNFRPMWhl?=
 =?utf-8?B?VjM0UGxRQU42ZUR1N2dBMy9kMmF3SnFrT3NPeWVCM25TekxET0VxTGY1RGlJ?=
 =?utf-8?B?aUl5UkpCbVFFTy9VbWdYNFNLOXlWOVNWWUtIWjNxeUE2cjlPUm1udEl1a3FR?=
 =?utf-8?B?MzZxdm03ekhDSmtRVSsvVHA5ck5RNXFucFBkNFlYUVFpbVN1V2M4Z0FPNHZx?=
 =?utf-8?B?dmhpa251bXJ2aXEwNnpIaWpFTkJPNjBNOEtjT0oxY3g1Ukl2ajc4RXN1Ry9O?=
 =?utf-8?B?c1ExMGMvUzFMNS9SWmZhRGVHV1dtY040N3doU2QvVmx4bTRBbFV0elFxQm41?=
 =?utf-8?B?eHZFdWd5cllaYXZkWlB5Y2RyTWxYZ1JoQ0dReVg2Mm8zakpCMkJNUGMwa3hJ?=
 =?utf-8?B?TXdWczBvN3NpbklvRlhibWoyQ29EK1hjVWl1Wm5JRU9QU2FGaEpIb1VNanJC?=
 =?utf-8?Q?MQ8kKgRMVBSw+GEJHAbk7+RxF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ae7c8c-af96-4850-e0db-08dba939eae5
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2023 09:17:22.1608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s0bRTBS7A2GfaCmMkly/lj9pCPHT7C9L9hr2DKCaDGLblWNy5jKzh0dFi/DYPeonKIfcsIJEVNJjwQEZn6XU9fhZbxSEKhUXh1daIjKdQd0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P189MB1461
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSWRvIFNjaGltbWVsIDxp
ZG9zY2hAaWRvc2NoLm9yZz4NCj4gU2VudDogTW9uZGF5LCAyOCBBdWd1c3QgMjAyMyAxNzoyNA0K
PiBUbzogU3JpcmFtIFlhZ25hcmFtYW4gPHNyaXJhbS55YWduYXJhbWFuQGVzdC50ZWNoPjsga3Vi
YUBrZXJuZWwub3JnOw0KPiBwYWJlbmlAcmVkaGF0LmNvbQ0KPiBDYzogbmV0ZGV2QHZnZXIua2Vy
bmVsLm9yZzsgbGludXgta3NlbGZ0ZXN0QHZnZXIua2VybmVsLm9yZzsgRGF2aWQgUyAuIE1pbGxl
cg0KPiA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xl
LmNvbT47IEpha3ViDQo+IEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBQYW9sbyBBYmVuaSA8
cGFiZW5pQHJlZGhhdC5jb20+OyBEYXZpZCBBaGVybg0KPiA8ZHNhaGVybkBrZXJuZWwub3JnPjsg
SWRvIFNjaGltbWVsIDxpZG9zY2hAbnZpZGlhLmNvbT47IFNodWFoIEtoYW4NCj4gPHNodWFoQGtl
cm5lbC5vcmc+OyBQZXRyIE1hY2hhdGEgPHBldHJtQG52aWRpYS5jb20+DQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggbmV0IHYzIDMvM10gc2VsZnRlc3RzOiBmaWJfdGVzdHM6IEFkZCBtdWx0aXBhdGgg
bGlzdCByZWNlaXZlDQo+IHRlc3RzDQo+IA0KPiBPbiBNb24sIEF1ZyAyOCwgMjAyMyBhdCAwMToz
MjoyMVBNICswMjAwLCBTcmlyYW0gWWFnbmFyYW1hbiB3cm90ZToNCj4gPiBUaGUgdGVzdCB1c2Vz
IHBlcmYgc3RhdCB0byBjb3VudCB0aGUgbnVtYmVyIG9mIGZpYjpmaWJfdGFibGVfbG9va3VwDQo+
ID4gdHJhY2Vwb2ludCBoaXRzIGZvciBJUHY0IGFuZCB0aGUgbnVtYmVyIG9mIGZpYjY6ZmliNl90
YWJsZV9sb29rdXAgZm9yDQo+ID4gSVB2Ni4gVGhlIG1lYXN1cmVkIGNvdW50IGlzIGNoZWNrZWQg
dG8gYmUgd2l0aGluIDUlIG9mIHRoZSB0b3RhbA0KPiA+IG51bWJlciBvZiBwYWNrZXRzIHNlbnQg
dmlhIHZldGgxLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogU3JpcmFtIFlhZ25hcmFtYW4gPHNy
aXJhbS55YWduYXJhbWFuQGVzdC50ZWNoPg0KPiANCj4gSSBqdXN0IHRlc3RlZCB0aGlzIHdpdGgg
YSBkZWJ1ZyBjb25maWcgYW5kIG5vdGljZWQgdGhhdCB0aGUgc2luZ2xlIHBhdGggdGVzdCBpcyBu
b3QNCj4gdmVyeSBzdGFibGUuIEl0J3Mgbm90IHJlYWxseSByZWxhdGVkIHRvIHRoZSBidWcgZml4
LCBzbyBJIHRoaW5rIHlvdSBjYW4gc2ltcGx5DQo+IHJlbW92ZSBpdC4NCj4gDQoNClNlbnQgdjQg
d2l0aCBqdXN0IHRoZSBtdWx0aXBhdGggdGVzdCBhbmQgcmViYXNlZCB0byBsYXRlc3QgYWZ0ZXIg
dGhlIG1lcmdlIHdpdGggbmV0LW5leHQuIA0KDQpJZiBpdCBpcyBPSyB3aXRoIGFsbCBvZiB5b3Ug
aGVyZSwgc2hvdWxkIEkgdHJ5IHRvIGltcHJvdmUgdGhpcyB0ZXN0IHRvIHZlcmlmeSBUQ1AgcmVz
ZXRzIGRvbid0IGhhcHBlbiB3aGVuIHRoZSBuZXh0aG9wIGlzIGluIGEgbXVsdGlwYXRoIGdyb3Vw
LCBwZXJoYXBzIHVzaW5nIGlwZXJmMz8gSSBjYW4gc2VuZCBhbm90aGVyIHBhdGNoIGlmL3doZW4g
SSBnZXQgc29tZXRoaW5nIHdvcmtpbmcuDQo=
