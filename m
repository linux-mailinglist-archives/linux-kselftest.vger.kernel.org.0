Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 291FE41BDE3
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Sep 2021 06:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbhI2ETV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Sep 2021 00:19:21 -0400
Received: from esa20.fujitsucc.c3s2.iphmx.com ([216.71.158.65]:54597 "EHLO
        esa20.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233387AbhI2ETU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Sep 2021 00:19:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1632889061; x=1664425061;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PSyByEAJwZZTx81cBA3dvhQJ5MBYwXVdC6KXGcWqjdY=;
  b=zgkyEat33QZZIDFaXzkpJFfvpnrxqb7SG4PNU54DmBKgOvFX6tSkZMsZ
   UefYVHk5a+H5ahxQyzKl30TKwxJKs+33BRcenZJ8k9LdACPWTaYKGt8Zq
   ETWbZiWl6qXTjzOE2drgKqtDT6QWUJTjqmpYJ9Yyoygi+LfUA1pSG7/Ll
   IvEFCMcjtMqKy5XdYWRXzs6GSjc79M60w34wHlqUAi/AOyRw3O7VPUvBa
   GVQdFRwqJo5C732ekG9BazzeYAs5fV15XQu25/BGOXEzl8ny2NpVX2LzN
   9ZIGiHJIz3sna4llKrjownx9DvkEqWlF7M1u9ZL1vLO4fehGgJPExu76F
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="40003009"
X-IronPort-AV: E=Sophos;i="5.85,331,1624287600"; 
   d="scan'208";a="40003009"
Received: from mail-ty1jpn01lp2053.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.53])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 13:17:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PwWGJH5ZjQ3CB/AGSf9yfKzmc6zSTVOvm5pM/mt2q8W92BeRiG8C/jC3sboFIZ0HNeQu+JdbYSHlUFgCvj0tsD6J0tVXzyY9rcoqR2te25BwIGLn2myIlDEEyEfY+etr2y6tLhuNRCKbEbZoLlBO3KHw+yuxcBIkx48REgtPGwsK/kT5q1dox2emLLfpPQUiSHFXH6AG57AEbcCWTuagpeSh/FJ+6HEg2bMkT6TjOVHO48EhltY7WMpS/GvOsHoY1kHBtLk5pA5NDOvlWaYovi4FQQpnJrhQ688t54/jMjIAJhkCY0yM56dAFtZXFviMI7cxyUsakl7JrZFA1U4FDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=PSyByEAJwZZTx81cBA3dvhQJ5MBYwXVdC6KXGcWqjdY=;
 b=HCsj0B/HBz1SznesMOfmzWshFUOcglpmYdYiQPSkAxw4aEFQIj2+bpA7u/4QdwnWYoVBg4qglLJ6KRc8Md0v8tWNqmV/Kz0sfN3cXulRAxKcd/iLJPIRMLiQ6ndiLmGCVL3T4uop9YVxUHAAK/VXZSDI4L4qTYqFNuu2Gw3OZPMfUJjWQXpr15d/Xzy7OQhcfHmTzKVc+eS/ZfkZ7GLEsF4iGHO3rWfZKy2I4Nad4Q4mfxFtgEK2OmypVB/ZNTXC1obNR/ru6s5tnpHd4jAWT9XEtqGMupMgGd6dz9N3wJDT1JmZKskh4g0Yc/bCuiO841HlEBXtvjXaWcSF92XU5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSyByEAJwZZTx81cBA3dvhQJ5MBYwXVdC6KXGcWqjdY=;
 b=PaQXJtIPRUki38ssZ0psDhMuyo+vei2IK7But7wZpsa1RBQY2ysatgNGMv75QGvTdsIqrPA1GvKC5qJ3BkClSrsWucHbA2bDCJPGDlpzJ3HGwMvPILbzWi8labpHuViHhG07U2ul0dXRky71RES7UV2O5us7jW9hMmuSHh8iOzc=
Received: from OS3PR01MB7706.jpnprd01.prod.outlook.com (2603:1096:604:17b::10)
 by OSZPR01MB8499.jpnprd01.prod.outlook.com (2603:1096:604:16e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Wed, 29 Sep
 2021 04:17:31 +0000
Received: from OS3PR01MB7706.jpnprd01.prod.outlook.com
 ([fe80::bca0:815f:1da0:911]) by OS3PR01MB7706.jpnprd01.prod.outlook.com
 ([fe80::bca0:815f:1da0:911%6]) with mapi id 15.20.4544.018; Wed, 29 Sep 2021
 04:17:30 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     "shuah@kernel.org" <shuah@kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Philip Li <philip.li@intel.com>,
        kernel test robot <lkp@intel.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Subject: Re: [PATCH v2] selftests/gpio: Fix gpio compiling error
Thread-Topic: [PATCH v2] selftests/gpio: Fix gpio compiling error
Thread-Index: AQHXoGGMyOR2V4tIgEyR0polL3iCW6u6kOmA
Date:   Wed, 29 Sep 2021 04:17:30 +0000
Message-ID: <72e833c4-1d33-c4a5-fb11-c029d5857515@fujitsu.com>
References: <20210903012236.160858-1-lizhijian@cn.fujitsu.com>
In-Reply-To: <20210903012236.160858-1-lizhijian@cn.fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5c1a474-aec4-4a27-b145-08d983000e20
x-ms-traffictypediagnostic: OSZPR01MB8499:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSZPR01MB8499FE5574EA6D8F3F63C622A5A99@OSZPR01MB8499.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GwcvyRlTHDprhpgTSJrxXv1ajxNa40U8KBt1k5iYqVpcz5q6+CtYBah5pe/VkNdayoLFfuhv2LNx6dLf4Xn3RcKwWX5LcIzuqRMMsWl0bECAjQOak6wrfxo57GSNA0qJzHZ2A4Xtq+yM5fyT2Kf1fYYxwXlknRDcNapJYf23/mQ8gCHNAKX0B9ujj531v5V9HZPGHwdCBQIybCPSJXSlkjesmE9fRaeDkfpdGfSaAiOPy2jtT1CeiC16gMseYnXt4F+mhtk7LQCn0SCEHtbaz//ftIgO1W7h5phv2HZvCfCEpPDnCR6/cLEz4er/TOnHHTwRSNaFMMfjvMDPhcblUc74MRZam2DWmxoMl7f3CSZnaJQldJm5YbxRSY/Rk9fa/fNEOikOt0Da9HQjQZXiGjqpLvj01c9KndtcWDT6/ll6qF5CQVMn6Wg6F7CLhMiewJYBBCZMRCOuwa0nc+DSKGyeMU6UxwcA2Gxs1/ADg8f8zkF7N79IM5xlDAWMYt0u1H7/Nyrqwzn14nWkBMvS7JgG2aFeGM9Aw57+hV0K6thJXnpDbxngoGKXSO1FDjvDCJKRlGMb1bSU24IVtj+Tc3vvdAhPeWbBjXETUY1Meg+UEHHbbQtY3jMjNxBzAMM/5m9HPqgLNG4I8UodHfpdOnYlm3loM0cG7pKyY4Cae30fJ2unREiXHQpFU+WFnIhWdAnNwP1fQroQNc/RiXIGBWmRFUTT7JjMSP9WWQNGZ7l6EtpwXfAUpCrHUNDAHrSoz94tzmdYvuxA5sYNsxMWXQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB7706.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(107886003)(53546011)(31696002)(4326008)(8676002)(6506007)(6512007)(186003)(36756003)(86362001)(2906002)(31686004)(83380400001)(508600001)(91956017)(316002)(26005)(5660300002)(38100700002)(38070700005)(66476007)(85182001)(8936002)(76116006)(66556008)(64756008)(6486002)(54906003)(66446008)(2616005)(110136005)(66946007)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVkvbWdqbDNqWTRlS0xUOHNXdXhFSGxYUVlFeVFTOHduTnRYTkpac2JXRytv?=
 =?utf-8?B?QWU3d0J2alA1RnA3c21KYnRjQ3pFcEc0YUxvL2V5NzFWOHhGT2h6UXBndUwv?=
 =?utf-8?B?SGlPeHRERTEwTkRVZnp4aFB4V3NLMlMvSmJka296Q2xvNEF1Wjdkblo2R2ND?=
 =?utf-8?B?SEt4a3VZUXNwNVpCbDdUZjFBRUN6eWQrUkw3cjJGeVBvZ1YvWUlUQ3J6aGg5?=
 =?utf-8?B?dUJkaWtBeGMxU2dpRFNFRC9qVkxTRUtGMEZGdHFFc1p6ZmFlb1EzaC85NG1C?=
 =?utf-8?B?SWpBOEV2elNhWnRrZFF4SGdHZkpWQktmV3dsQXpsYUhuUHl2ZThCWFRrampk?=
 =?utf-8?B?M2tIa0I1TWpPcFVQWkxpMSszcmR6MmZaSk9UZUtCZko5YnpKWmJEY2R3aC9R?=
 =?utf-8?B?b1BucDJ5UmVuTkJIdDQzNy9JbkhxTlBKZDhHbkYwQjlZZ0VFVG1ZM1FzQ3c2?=
 =?utf-8?B?R0prVEFyL3JnT01yVEpzS3dKV0FpQkxDUkVVWFI0THdCdFVxL2ZIUkxjUmtr?=
 =?utf-8?B?d1I3Tmo5WlY5OXBOMllWaDU2WVI2NlJ2eE04eWJvdnAzVnRPQXZUUjFJTitt?=
 =?utf-8?B?d3lKOW5BbGtXV2x6UDRrZDI0NVl2VFB4dXJUS1dTckdabTVneis4ZDQ5aE9m?=
 =?utf-8?B?QUJubDVUbW54Nmg3V2ZrQVF2RkV1VG8rdFhZQ29JOTdZR0FQcHN2bDlBTTBq?=
 =?utf-8?B?NFVBaU5EbFFEczlaQVcrRkd2RGtjL2NDT1JZS25zMFg0WjFQa3VLMHM1Y3pF?=
 =?utf-8?B?ZmVodGthbFRkcnBnVndvdURTUWVUOUdjcUY0STQvRFY0dmc1U0tuTjdMZVkv?=
 =?utf-8?B?cXExZUpkVUgvUURvbmNnVWhybHovSG9nczVHMVIvd0kya0o1a3NndG81QWRY?=
 =?utf-8?B?MlBxeGVORUlObUQydlJwaTk1SEIwR0MzUTR2aUZTekw0cHZoRFdwSUR2djVD?=
 =?utf-8?B?WmhJMmY0eG5Ick9VVVFGU0w0eG9ocG5MSkFZUmZIUDUzNDN3cmhjUzNIY1BY?=
 =?utf-8?B?YmIzdW15T1lmcmduYXNrOUo4SlFOeFlVQ2dHYUVjd2tqbXlhTXgwY0N6alh1?=
 =?utf-8?B?ZmYwZVF4YzM2aXhremZwakx4QUdFM0pqV2EzMEdzRitKR0hoRW9lbkdiT0Jz?=
 =?utf-8?B?ZnFnQ2VyRCtQbmFOU1RPQTE4bE1CSkwzbGtVSEsvUEo1alViRGVaeWs1Mm9R?=
 =?utf-8?B?RklDT0dicmR5a2hkTm5Kdk1UNFl1NzUvTEdWWDhyV29ic2RHaFFmK2dHQXBm?=
 =?utf-8?B?MVNxZW5zMUtWSFNKOVlwNmgrUlJoQjBhSUFWQ2k3d2thTmhaekFwaHRGb3lD?=
 =?utf-8?B?UXpyVUNRY0pKZXdUZHVBcFNOWHFoZy8xSlMxaE8zbUhiUkM3YkZUdlI0cTVh?=
 =?utf-8?B?N1VwNmRXaWliUlF3QTVRK0J2dXRpOEsyellPM0VpQ1BocmlVTGhYV1E3NFRa?=
 =?utf-8?B?Y000djQ2a0pBem9jZ2lJRU5WU0Ivem9DT0JYS0NieFFlSTRKMVRGYVIvNWZS?=
 =?utf-8?B?Z1VrZVNHUjFHVlRlY3h5cWVzamc0WllHbFlZY3F1cm1VeWlqQytpOW5hZ3p3?=
 =?utf-8?B?Y2xWWlk5VUhZemxkQ1NjUVdKTmtVZ0dTUEYwOTQvaVNzT3dJbnd0aFNiSVRT?=
 =?utf-8?B?cjlLR0o0MExCZTVqNVNqMEMydlhKTlI2MWUyMkREM0Z1VWIxWERrMUlYMWJQ?=
 =?utf-8?B?UmF4YTBHdlROVHloZjNLbTZiSzdoR0cxR0hZUmZsS2NHR3pwQ2lDWVRLU2px?=
 =?utf-8?B?Uy9yODhYL2tZMTk1T0VjZU1BN3MxeUFFc1grWUpRNmwyOThkNDl0WFF5YmtL?=
 =?utf-8?B?QkQvWHM5cktOdk15Y2NCZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6588149642A944EA622C2E9C474DD69@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB7706.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c1a474-aec4-4a27-b145-08d983000e20
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2021 04:17:30.8962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NYciTdSEUyoP64rGXL1XXu1qVE5cMduyXa+vwx2rH5cdqI1tUXvm9YQn39tHNw6jW/cZxJSvz0QUp7FQPBhTgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8499
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

cGluZw0KDQoNCk9uIDAzLzA5LzIwMjEgMDk6MjIsIExpIFpoaWppYW4gd3JvdGU6DQo+IFtyb290
QGlhYXMtcnBtYSBncGlvXSMgbWFrZQ0KPiBnY2MgICAgIGdwaW8tbW9ja3VwLWNkZXYuYyAgLW8g
L2hvbWUvbGl6aGlqaWFuL2xpbnV4L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2dwaW8vZ3Bpby1t
b2NrdXAtY2Rldg0KPiBncGlvLW1vY2t1cC1jZGV2LmM6IEluIGZ1bmN0aW9uIOKAmHJlcXVlc3Rf
bGluZV92MuKAmToNCj4gZ3Bpby1tb2NrdXAtY2Rldi5jOjI0OjMwOiBlcnJvcjogc3RvcmFnZSBz
aXplIG9mIOKAmHJlceKAmSBpc27igJl0IGtub3duDQo+ICAgICAyNCB8ICBzdHJ1Y3QgZ3Bpb192
Ml9saW5lX3JlcXVlc3QgcmVxOw0KPiAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIF5+fg0KPiBncGlvLW1vY2t1cC1jZGV2LmM6MzI6MTQ6IGVycm9yOiDigJhHUElPX1YyX0xJ
TkVfRkxBR19PVVRQVVTigJkgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24p
OyBkaWQgeW91IG1lYW4g4oCYR1BJT0xJTkVfRkxBR19JU19PVVTigJk/DQo+ICAgICAzMiB8ICBp
ZiAoZmxhZ3MgJiBHUElPX1YyX0xJTkVfRkxBR19PVVRQVVQpIHsNCj4gICAgICAgIHwgICAgICAg
ICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPg0KPiBncGlvLW1vY2t1cC1jZGV2LmMg
aW5jbHVkZXMgPGxpbnV4L2dwaW8uaD4gd2hpY2ggY291bGQgYmUgcHJvdmlkZWQgYnkNCj4ga2Vy
bmVsLWhlYWRlcnMgcGFja2FnZSwgYW5kIHdoZXJlIGl0J3MgZXhwZWN0ZWQgdG8gZGVjbGFyZQ0K
PiBHUElPX1YyX0xJTkVfRkxBR19PVVRQVVQuIEhvd2V2ZXIgZGlzdHJvcyBvciBkZXZlbG9wZXJz
IHdpbGwgbm90IGFsd2F5cw0KPiBpbnN0YWxsIHRoZSBzYW1lIGtlcm5lbC1oZWFkZXIgYXMgd2Ug
YXJlIGNvbXBpbGluZy4NCj4NCj4gU28gd2UgY2FuIHRlbGwgY29tcGlsZXIgdG8gc2VhcmNoIGhl
YWRlcnMgZnJvbSBsaW51eCB0cmVlIHNpbXBseSBsaWtlIG90aGVycywNCj4gc3VjaCBhcyBzY2hl
ZC4NCj4NCj4gQ0M6IFBoaWxpcCBMaSA8cGhpbGlwLmxpQGludGVsLmNvbT4NCj4gUmVwb3J0ZWQt
Ynk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBM
aSBaaGlqaWFuIDxsaXpoaWppYW5AY24uZnVqaXRzdS5jb20+DQo+DQo+IC0tLQ0KPiBWMjogYWRk
IG1vcmUgZGV0YWlscyBhYm91dCB0aGUgZml4DQo+IC0tLQ0KPiAgIHRvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL2dwaW8vTWFrZWZpbGUgfCAxICsNCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKykNCj4NCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2dwaW8vTWFr
ZWZpbGUgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9ncGlvL01ha2VmaWxlDQo+IGluZGV4IDM5
ZjJiYmU4ZGQzZC4uNDJlYTdkMmFhODQ0IDEwMDY0NA0KPiAtLS0gYS90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy9ncGlvL01ha2VmaWxlDQo+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2dw
aW8vTWFrZWZpbGUNCj4gQEAgLTMsNSArMyw2IEBADQo+ICAgVEVTVF9QUk9HUyA6PSBncGlvLW1v
Y2t1cC5zaA0KPiAgIFRFU1RfRklMRVMgOj0gZ3Bpby1tb2NrdXAtc3lzZnMuc2gNCj4gICBURVNU
X0dFTl9QUk9HU19FWFRFTkRFRCA6PSBncGlvLW1vY2t1cC1jZGV2DQo+ICtDRkxBR1MgKz0gLUku
Li8uLi8uLi8uLi91c3IvaW5jbHVkZQ0KPiAgIA0KPiAgIGluY2x1ZGUgLi4vbGliLm1rDQo=
