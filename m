Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9D948D222
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jan 2022 06:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiAMF6t (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jan 2022 00:58:49 -0500
Received: from esa12.fujitsucc.c3s2.iphmx.com ([216.71.156.125]:56068 "EHLO
        esa12.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229622AbiAMF6s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jan 2022 00:58:48 -0500
X-Greylist: delayed 431 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Jan 2022 00:58:48 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1642053528; x=1673589528;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2cc7gvnfRp6u0oKhWt0Lu801ZaJyFFf+QJ4/RrxG9AU=;
  b=lm9ON6YfDf3X42ImuuLi1WWTzTJdhK3AtX9oTzKD3KGcrFMEcanlkqwT
   pWVECyAijH40zajCsecPiePjx26hb6uOhYys4CCeXtMegzPIMokXLtVYy
   RvDQsoOCPFaYePg7kcalWwHU6y1PYtj1KPNmpmMXVuX42Wbj5geiLkmud
   2ItmpAzagzWGe6GK8jFCkiNTUg6BIBR2deWaSvH+jNNQGapPuhpxNNAGm
   VGoE/HNiRTsGoPrOaPz0VZgi5ByDoxzzcN3ZfAnv4a/8EhAer24JwNWrI
   +SkBUfJp2jmp2quqIfG/dC+AE8T2V0lIY6+WwypZBgmuDF29N25lHLsjl
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="47706859"
X-IronPort-AV: E=Sophos;i="5.88,284,1635174000"; 
   d="scan'208";a="47706859"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 14:51:34 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMJ+/k4BaD9p1fTH73kBkvRzxA/0zKzuTNBht3ehJwnZIq0/1W8ZjnoJRsu/chqTnWQnT17qsq50dUzyvW76n8idUdtTZWDVCYwmi68YTFac0v+vw0mav7Vmh7Lc9+CC85hFazW9GlT/ndU6oMr2wZK/J7koyfnemUUnFlFkS0NI8kHRnHwO1TN2aJ69OtO4CWHlEonVF/RZJHCzRsHn39JONvFbvIjPV+3KmV6WVDvgZexMlXZyX1JWVfwjGJoZ42L1FXSTfNtD0bfI4X4m6hrgzoSzGorpJW3tcO3G38IR3OTe2y/rOb6qTrEEPeD4xafuDj3psmtRrgpMnrIqEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cc7gvnfRp6u0oKhWt0Lu801ZaJyFFf+QJ4/RrxG9AU=;
 b=MXKNh9VlpdHftHMfSag3PJZZwGkB6fpVlqmoLGQvicI+rmXPDn1apCS1YywPkCzx/PdLjV3M+mWHia7id2QhYmuZwWOBkCO9TvpoxwQ7K7VpcrCLeukANTnfhRlxA0lXgrKkdVT647Djv38oq+vBa3nP/+qY912BAkON7rwyg8/flfnPsprg2sOiOpKZ45MzN1bjOt3IgUisHCx68TygLxK+YrqWFH7RlAK+M4hYIZkZ8NTTBvhhaXCZP/qbch7rECM0QKwtHPwH7BnVM7HnUhrUpuzTrqPV46eMcldSZU3+azoWbz/aNNbCaze0i3DgW7exDpp9aPD8OwAb4AYCGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cc7gvnfRp6u0oKhWt0Lu801ZaJyFFf+QJ4/RrxG9AU=;
 b=cgcxz5GhZ88Sc5dn6Ne5Dgvc0oO+bj7BqBF6loF7fr/1SNFXLBFNpcifPvrgqzA+NMoHi6G8+kwIbcEYNn6vD+Pym9tUJ3aXJefH4XOJ4b1gkfzkV0Ih+NSZzH9g0c41TEZw5FNLXMz+tc/iz3Q0Y1TvgUYM4CSbNp0PvLFXViI=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by OS0PR01MB5668.jpnprd01.prod.outlook.com (2603:1096:604:b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 13 Jan
 2022 05:51:31 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8110:65ae:1467:2141]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8110:65ae:1467:2141%4]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 05:51:31 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "christian@brauner.io" <christian@brauner.io>,
        "shuah@kernel.org" <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Philip Li <philip.li@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] ksefltest: pidfd: Fix wait_states: Test terminated by
 timeout
Thread-Topic: [PATCH v2] ksefltest: pidfd: Fix wait_states: Test terminated by
 timeout
Thread-Index: AQHX8yjb95rJFFQ+NUOhlVJdwV+aZqxgnOkA
Date:   Thu, 13 Jan 2022 05:51:31 +0000
Message-ID: <d8961bd4-d2fd-6db3-345c-1ad930d03e3f@fujitsu.com>
References: <20211217093040.9530-1-lizhijian@cn.fujitsu.com>
In-Reply-To: <20211217093040.9530-1-lizhijian@cn.fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54b39053-3b73-4368-88bd-08d9d658c01d
x-ms-traffictypediagnostic: OS0PR01MB5668:EE_
x-microsoft-antispam-prvs: <OS0PR01MB5668F81240B9E722E8E70C91A5539@OS0PR01MB5668.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YjLCM6ohbCGWBJ7GEY1mAmY11YdqRbclXOwiWcxXkfsUqHrD0FVu0Pwzc2o2wkR+vMNV0aqo7l7MvkqQRHtytBXmUj6ry6xizCnih+TYmPfjoddYhXzq6ywiwmlN9WMPYrQ0x9J2XEObQqnC6HwxRGscUOYZv1VTcKvQRjaTfpG/vJz8nodxtbGYSG/6SDzyp39Y2L5HAB0JjmfNWJ484ccu9ntbPlIG8bXh51vBSBBW6muPO9fvlUI33HclMfv6iZxSSDPH4KMSeI485e8DfbgCGAs4lbYvkvVrO5YItl63BcBR/rHzFI+ooARUjiQk+vz1CjqbA+gkVVZnkrZs7oz/9jhsfkKVrSqYH2l2qfPQam23vHY0nbEb/B77bf6I7ptM4MvD4Rx+jivZupikE/l6GOTM/O0Cx0/FZB3L0xrklcpaEFpI6C8MeeqNxBC4AwmPgTpAHWKMydlDXQVi2JjAZZInQ1NdxczEUYmjFmLomN98THhdxzH0K5CDETy852p7vBhklZJN94XyH4kxi8ysPkor9mUKY4kWcXq8silLLoGjrwjjJNC86lnQNRigC2q/T7sA60KFS4SKkux+7q0omsjeGG+v8E3RNbxt2GIfDCVaBtiD9pXafNeoKR0fiE4CuIvAnV2IK4XCGcGBFAvYsHW+rbsl+EJBwX/MxDKzfNcLCbbo1Z12ugW8CpDnEVqybltJ5DTQztFVavs4LezrS3KfzpTXBG89u32Oma0K+gKt0xu5K8M8U5B+10rqXVLIfJtLIbgee/163NdhIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(91956017)(6506007)(66946007)(76116006)(86362001)(316002)(8936002)(64756008)(4326008)(66476007)(53546011)(66446008)(6486002)(66556008)(2616005)(85182001)(2906002)(71200400001)(38070700005)(31696002)(26005)(6512007)(31686004)(8676002)(38100700002)(36756003)(54906003)(5660300002)(110136005)(508600001)(186003)(122000001)(83380400001)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEtRTC9YMi94ZVB3QlE3KzBRbDhUMVdnbWgwTnpZUWFEdE5EcEZEOGFjUUFO?=
 =?utf-8?B?T28yU3R4cGVRdjNMOUR1eWE4TXVZeUozL2pvRmJLSyszTG8xQUplblk2Qk84?=
 =?utf-8?B?RmMxYkhKdWdDR0FVZjdQUlZweVFSQ3BWRDFlbDNpSTBqb2dTME1DODNuQ2FE?=
 =?utf-8?B?cFhXbU9TS0JNSHJZa1BCN3lzaENsYjhjdDNSbGJMd0dRR20yeXEvREZmUmln?=
 =?utf-8?B?eTBmcHArUHZ4SVZrbTNoUkEra1ZqeENib2lzeGZCQlltQ2I2bnJRVW9XRjQ3?=
 =?utf-8?B?M3N2a0c0aHVBNHc0L2w2UWszbEE1S1pSWDRadW84a0ZBVE04UEdoUEdyRHpx?=
 =?utf-8?B?WGJtTThMNWxaSk52OWsrRHJRZGhKbzdzeU1zb1BxWTBadS9kdUtrWU5HVHVB?=
 =?utf-8?B?RDljS2VycUcwYVAwMXpXQjdaL2pJb0QwK0NuNk0yZEdURXRyanltTTB1QjNv?=
 =?utf-8?B?c1BxbzZqVzk4S25rSjBGV29FRzF6UVFBSCs3K2pBRklHR0hobmRaaWZTQjdK?=
 =?utf-8?B?RkIwTXpwWkM2WkJVRVFkZ0I0ZXhmWFFzMFBWOEZ4dkVENEtKdW9ialNSOWgz?=
 =?utf-8?B?cHViY2NQeGoveEdHU3pRNDA5aTFLRXc3dndjbWxyVmdxT1diZWthVWo5WW0r?=
 =?utf-8?B?WVRZdkV1Q2J3THVEZVdlcTFQTTZwT3VCT1dVK1krTWJBVDBYWDY0RVFTREtz?=
 =?utf-8?B?Q3hqUENQL3FIY2RQVGYyZDhWanpWeEFvRnRsQUNlVTdRd3JiYXVzZnhxT05I?=
 =?utf-8?B?Q2lUanhSakNKTGFWb01jQWZqZ014QUdBN3ZPOUxueGZXdnphQ3BjN01hRkdI?=
 =?utf-8?B?MUdWSU1FcUF2bWdFc3V1bmtRMTByb3I2K3Z1SFdYNHVmU3lCMWFSdStMYXlQ?=
 =?utf-8?B?dFROTllhaGFpc1BFKzNXYVFVWWhvR3o1K3Z3ajVPZDlEc1A5NXN5TlRiUDhR?=
 =?utf-8?B?RFQzQkpUejRHZk84MGV5WG5aV2FzaVN4UFk1b1dZVFNtc2RjNnRSMmVSR0FV?=
 =?utf-8?B?OFpJUk5vYVQ0VUs4VlA1NTZmd1M0YlNVWVV5amU1bG1NbVNSTTFRUkR4b0Rx?=
 =?utf-8?B?MFBiWk9ocDFDNWcxNzlPd2VrdGw2YXA5RFpVVHlvS3VEbU1pMVpPL3FjNjRV?=
 =?utf-8?B?Vys3VEZEaHZXQzUxeGt0WGZKb01MUWU1OTdMRHdYL1lxOStocis2TzJZRG9m?=
 =?utf-8?B?c2ZPRXRnT1pQVmZReExVMXNWOWxXVWY4ZDh4NGxEaGxNSDFScFUrMmt0R0Vv?=
 =?utf-8?B?NjNjclVxcFgxZ1kwRkE2Z3diVTY2Z29iYXB5Z1pPbk1EckdCZ1AraFBaR2xQ?=
 =?utf-8?B?SDNOZ0hoL2d4ek5ET011bjhGYUVENTM5S0JDWXNvc2l5RFE3VjJHQ0xZRURJ?=
 =?utf-8?B?cGZmcUV3MVB0bVlHSDQ1WVdMNUNjbjJkOGw3c2wvMm9LTHhHZXdrMmhPWFYr?=
 =?utf-8?B?ZXdtSmtzVllTc2xxSkZEcENiUWd1Z2RUTDR6UDJRNFBZbEJDK1JQR013R1Fy?=
 =?utf-8?B?RHNKczFCWXdKdGtkQTd5andOSHNZb25KZ0hjekRsSlNYMm8vN05SVHorVzFI?=
 =?utf-8?B?amhaRWkxRHVtc05uUzA1S3hqRTU3MS9MeWE4ZitramtudXBNYWt3Zkh0aFJl?=
 =?utf-8?B?ZzZqUk13K2UzWU43V3JTZFZzTHFmeG9DMTNJdkt5TmR5TG55OWFxZEs4K0hG?=
 =?utf-8?B?ZTQyN0ovaDEyWmQ0cFI4ZEE4VG0wN21uWUM5QnFWN1dDbFdvakE0aUdnQlFP?=
 =?utf-8?B?RmphWWdZeGJ1bTEvaVBkaE5BbnhFSUQwU3BDV1V0KzhCdkRJRTlDT2dlTE8z?=
 =?utf-8?B?SjI5MGFEWm5IMTltWlE2eTAzWDRBL1o1T2ZGTFhaNVI4YjlqRE9PeXIrNFUr?=
 =?utf-8?B?N2VDbXEwSTRvclFvMEdLTDVmV2oyYnpqNlRoalRFQVdWM2xaMGlzNGMxZEpv?=
 =?utf-8?B?VFRnRFVrTDVTYUI5VzNxZzJ4eWRrY2dsMGY1QlpPUWloQVE1aHlMT29ONUlu?=
 =?utf-8?B?cm00ZTdRNVAzblp2S0pLSlRkbXBwRS9vczFMMy94S2tuV3ZpUGppL3dhU0t1?=
 =?utf-8?B?dUswNnlTR1dtS1EraWNINVBMUXJIblpDaWlMNGo0U0JwdlFnYUgyWDVUNmlt?=
 =?utf-8?B?bEZWdTBveXJIWHlQVmZseVAxdEdIOEtEdVREYzRJNlREMnFFd2hSbSt3Tlpq?=
 =?utf-8?Q?AiUhaJsYceVJOw+e+1I8tGs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4251D2E87D4B074181BE2FA19FD92B4D@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b39053-3b73-4368-88bd-08d9d658c01d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2022 05:51:31.7794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m9Rz1M9WgCyWTL+5+EFmZK8sRCwDoJLpIkwk+YFA6wySz3OuY3QPXPByN39CRrHTVPh74XCmbZXoPpAzWO0XfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5668
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

cGluZw0KDQoNCk9uIDE3LzEyLzIwMjEgMTc6MzAsIExpIFpoaWppYW4gd3JvdGU6DQo+IDBEYXkv
TEtQIG9ic2VydmVkIHRoYXQgdGhlIGtzZWxmdGVzdCBibG9ja3MgZm9ldmVyIHNpbmNlIG9uZSBv
ZiB0aGUNCj4gcGlkZmRfd2FpdCBkb2Vzbid0IHRlcm1pbmF0ZSBpbiAxIG9mIDMwIHJ1bnMuIEFm
dGVyIGRpZ2dpbmcgaW50bw0KPiB0aGUgc291cmNlLCB3ZSBmb3VuZCB0aGF0IGl0IGJsb2NrcyBh
dDoNCj4gQVNTRVJUX0VRKHN5c193YWl0aWQoUF9QSURGRCwgcGlkZmQsICZpbmZvLCBXQ09OVElO
VUVELCBOVUxMKSwgMCk7DQo+DQo+IHdlIGNhbiByZXByb2R1Y2UgaXQgYnk6DQo+ICQgd2hpbGUg
dHJ1ZTsgZG8gbWFrZSBydW5fdGVzdHMgLUMgcGlkZmQ7IGRvbmUNCj4NCj4gSW50cm9kdWNlIGEg
YmxvY2tpbmcgcmVhZCBpbiBjaGlsZCBwcm9jZXNzIHRvIG1ha2Ugc3VyZSB0aGUgcGFyZW50IGNh
bg0KPiBjaGVjayBpdHMgV0NPTlRJTlVFRC4NCj4NCj4gQ0M6IFBoaWxpcCBMaSA8cGhpbGlwLmxp
QGludGVsLmNvbT4NCj4gUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwu
Y29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AY24uZnVqaXRzdS5j
b20+DQo+IC0tLQ0KPiBWMjogcmV3cml0ZSB3aXRoIHBpcGUgdG8gYXZvaWQgdXNsZWVwDQo+IC0t
LQ0KPiAgIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3BpZGZkL3BpZGZkX3dhaXQuYyB8IDExICsr
KysrKysrKy0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3BpZGZkL3Bp
ZGZkX3dhaXQuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3BpZGZkL3BpZGZkX3dhaXQuYw0K
PiBpbmRleCBiZTI5NDNmMDcyZjYuLmQ1YzBmZmEyNmMzMiAxMDA2NDQNCj4gLS0tIGEvdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvcGlkZmQvcGlkZmRfd2FpdC5jDQo+ICsrKyBiL3Rvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL3BpZGZkL3BpZGZkX3dhaXQuYw0KPiBAQCAtOTYsMjEgKzk2LDI2IEBAIFRF
U1Qod2FpdF9zdGF0ZXMpDQo+ICAgCQkuZmxhZ3MgPSBDTE9ORV9QSURGRCB8IENMT05FX1BBUkVO
VF9TRVRUSUQsDQo+ICAgCQkuZXhpdF9zaWduYWwgPSBTSUdDSExELA0KPiAgIAl9Ow0KPiAtCWlu
dCByZXQ7DQo+ICsJaW50IHJldCwgcGZkWzJdOw0KPiAgIAlwaWRfdCBwaWQ7DQo+ICAgCXNpZ2lu
Zm9fdCBpbmZvID0gew0KPiAgIAkJLnNpX3NpZ25vID0gMCwNCj4gICAJfTsNCj4gLQ0KPiArCUFT
U0VSVF9FUShwaXBlKHBmZCksIDApOw0KPiAgIAlwaWQgPSBzeXNfY2xvbmUzKCZhcmdzKTsNCj4g
ICAJQVNTRVJUX0dFKHBpZCwgMCk7DQo+ICAgDQo+ICAgCWlmIChwaWQgPT0gMCkgew0KPiArCQlj
aGFyIGJ1ZlsyXTsNCj4gKwkJY2xvc2UocGZkWzFdKTsNCj4gICAJCWtpbGwoZ2V0cGlkKCksIFNJ
R1NUT1ApOw0KPiArCQlBU1NFUlRfRVEocmVhZChwZmRbMF0sIGJ1ZiwgMSksIDEpOw0KPiArCQlj
bG9zZShwZmRbMF0pOw0KPiAgIAkJa2lsbChnZXRwaWQoKSwgU0lHU1RPUCk7DQo+ICAgCQlleGl0
KEVYSVRfU1VDQ0VTUyk7DQo+ICAgCX0NCj4gICANCj4gKwljbG9zZShwZmRbMF0pOw0KPiAgIAlB
U1NFUlRfRVEoc3lzX3dhaXRpZChQX1BJREZELCBwaWRmZCwgJmluZm8sIFdTVE9QUEVELCBOVUxM
KSwgMCk7DQo+ICAgCUFTU0VSVF9FUShpbmZvLnNpX3NpZ25vLCBTSUdDSExEKTsNCj4gICAJQVNT
RVJUX0VRKGluZm8uc2lfY29kZSwgQ0xEX1NUT1BQRUQpOw0KPiBAQCAtMTE5LDYgKzEyNCw4IEBA
IFRFU1Qod2FpdF9zdGF0ZXMpDQo+ICAgCUFTU0VSVF9FUShzeXNfcGlkZmRfc2VuZF9zaWduYWwo
cGlkZmQsIFNJR0NPTlQsIE5VTEwsIDApLCAwKTsNCj4gICANCj4gICAJQVNTRVJUX0VRKHN5c193
YWl0aWQoUF9QSURGRCwgcGlkZmQsICZpbmZvLCBXQ09OVElOVUVELCBOVUxMKSwgMCk7DQo+ICsJ
QVNTRVJUX0VRKHdyaXRlKHBmZFsxXSwgIkMiLCAxKSwgMSk7DQo+ICsJY2xvc2UocGZkWzFdKTsN
Cj4gICAJQVNTRVJUX0VRKGluZm8uc2lfc2lnbm8sIFNJR0NITEQpOw0KPiAgIAlBU1NFUlRfRVEo
aW5mby5zaV9jb2RlLCBDTERfQ09OVElOVUVEKTsNCj4gICAJQVNTRVJUX0VRKGluZm8uc2lfcGlk
LCBwYXJlbnRfdGlkKTsNCg==
