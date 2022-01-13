Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021FC48D24F
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jan 2022 07:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiAMG0c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jan 2022 01:26:32 -0500
Received: from esa17.fujitsucc.c3s2.iphmx.com ([216.71.158.34]:5780 "EHLO
        esa17.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229763AbiAMG0b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jan 2022 01:26:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1642055191; x=1673591191;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sBp1KjluJjRhD4g684nVn7AMbIbxDIyPrPwMXA1LMQU=;
  b=jVf9YBbazLpW/7A5hjkc/EYHjuFAOxBiZPn94UZuO9hslyt5r3tfDGoX
   /SCPnDv7woiNpzOdpuA0tIXWO92cV46MEO/BWwQZkEbirmRnvjppx5Iy0
   GamtOSI3gD1y8aDSxXpyAZFAzLjX7sLQQPlT6CS1oSINR7LzAeItJaZ/q
   +K5mdXZKATyX6RyddIE2S6tN8NQ+nN7HDeNH3ZKXVrIRh4nFSVkaECUEr
   4+T4CApBGZ30WlTtGy3kZrZtqtYWH+4WbMncPDSL8PkNhp9E/8KBgSQff
   OqLCRDsgdJX9jVi06onxZX8/1VBzmxS+mpo/4aGNTAxpBolWRqGmA+ook
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="47521258"
X-IronPort-AV: E=Sophos;i="5.88,284,1635174000"; 
   d="scan'208";a="47521258"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 15:26:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kw8OYJVQIHwBateFQKIUzZNYY/Y69nO4Ouz/w++WlEQV8XuOoQiPi1JyItUsY9EHQ/cG5Vcp8ci9ymbq4ihazwOJXXIu13tcLangGTz2f/l9XUincHNyc0ZQg6SOY8cNldOzPzqsXZD39aTfHYCepHMrAsED1i+H44YJFngh/tXTURyo+ReRkqPyqWNatmxfprptgxcJZlkUPChyWHwgfi42bqqVWiP/Hc9/EsQuIRBLDVIstlmrRUKS0yj4RVq7nmalUmoHulazi3nx/aUHp9JQPJff/LPlNtDHgM//1U5RH0Oiyc4EnocjodRn+wZSxLE74BGFrsi/q9qChUhG/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBp1KjluJjRhD4g684nVn7AMbIbxDIyPrPwMXA1LMQU=;
 b=LGbhyB6PwqjQ00sS9iPTGVJzoh5grl3is57K89V7Q2yb1H5IlYzkwbVUxT+kobVuV8fqwR+AIoTr8UlKZU6aerS+2EvNdI+8m1gG6/yoqrmeQN2YgmeuZ1PojqDI8n/nHczVyZfntcDBOUXCm+0Nm9jEJCyfcJKqSnHndUGigyX71Vn+obM956uDkKZb25D7y2OI4Rv90eP4pLtyiFtJSYYYp8MbTAE72LGufbHq5soA1lmrQCeGAEYAoVJN5L0iVvDR6w6tVb1ok7GV9cA8tDeIywA2DdmS9GfLM7c51rSWZ7mZesXPv6jsbnlff4vUQjE8d6t5y3BRM0J1tBvXEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBp1KjluJjRhD4g684nVn7AMbIbxDIyPrPwMXA1LMQU=;
 b=C+wq7lju5POFrO8RPOyU4ihjRwidr0PXvHVF5AmoIO9w5xADLgVW+0MRjt31FL76HU3MeF00s1Uz3NXVk2yqLUlwY/YTdfkL0ReVnYe3DTlqglGgvw5lXmEA4uwYUxHkCYst3P7oid+y6wb+K0PrJ5V8EqgJI4hidyGNPgaEr6Y=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYAPR01MB5371.jpnprd01.prod.outlook.com (2603:1096:404:8033::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 13 Jan
 2022 06:26:25 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c954:50fd:21b5:1c8f]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c954:50fd:21b5:1c8f%4]) with mapi id 15.20.4867.012; Thu, 13 Jan 2022
 06:26:25 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>
CC:     "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "naresh.kamboju@linaro.org" <naresh.kamboju@linaro.org>,
        Alexey Kodanev <aleksei.kodanev@bell-sw.com>,
        Petr Vorel <pvorel@suse.cz>
Subject: Re: [PATCH 1/3] selftests/zram: Remove obsolete max_comp_streams
 interface
Thread-Topic: [PATCH 1/3] selftests/zram: Remove obsolete max_comp_streams
 interface
Thread-Index: AQHX8ZoRccDmFZwZgUelgvXxKr2pqqxgqgUA
Date:   Thu, 13 Jan 2022 06:26:25 +0000
Message-ID: <61DFC646.7060707@fujitsu.com>
References: <1639562171-4434-1-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1639562171-4434-1-git-send-email-xuyang2018.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9792b80-6c4a-42e9-a3a3-08d9d65d9fed
x-ms-traffictypediagnostic: TYAPR01MB5371:EE_
x-microsoft-antispam-prvs: <TYAPR01MB53712B739327D0569D6B08E6FD539@TYAPR01MB5371.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:161;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D3z1ZrSK1fkN/xldRSp85IZQ0vDDQI7aEPuI6TH9ZXd3Mws6WUvnosjH3etxX9gbS/UyCbUkZIA9qBNqf4LRzSE8kY0KL37s3DptJEXl7I/YR34tOWZK5Fp4fYc83bBboI8IJ+hSSHFNFAsiCISjML9SbDhULzsZ8z1XlROEsYKlj6LPUIgIDdxx5iOFhXJw+fHqTrnEugEYqby89/aZl+tBc/Jf3l9/1fMjXse9G+rX3oaiZMRgvTQ352XPcHUvdfXs7gUyS8pOS+BUdh7yuR+qi9ar9MI5KiCpWwvIenP/ZpqqfY/+ElsN4lOgOR00vsMJVNVZdJu21Wxwhahr3I2pX4GYBlgH/CnkOsz5TXtC3nFGBoNZFpvVCwfofKkkiBeb578SCDwgQoP61Wg18QLbBLZhVGIUfwT85iQMzXhjg/5yPQkIYvecbJdtuLC0NL2k8ftKxvuv46+GERCzt/E1gjNfCnPK4KGNwgayCVm232FDKPyazlNdbfknYXILJwLij+/UG0R/yqemcBsrVfCaiLcvluBkb2NFLvGeuMYaYvTSOp92jBUKLthwX63UgDgu6quEAC1aaWKLloGDiOpAn9yA1qoCkWHXykXTAFO79ockaR2AlRHm5J6z3Gildd0ZqA+g2EzLU1WoUR5/oFbUXQGwVbphetn8UKItSwCT+ix7gGppGyYBOZmzhkbA/6ppl77Avnzn8gD+QzZM+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(508600001)(316002)(4326008)(122000001)(85182001)(38100700002)(2906002)(186003)(83380400001)(82960400001)(8936002)(86362001)(66946007)(87266011)(6506007)(71200400001)(91956017)(110136005)(38070700005)(54906003)(8676002)(76116006)(33656002)(36756003)(5660300002)(26005)(66556008)(66446008)(66476007)(64756008)(6512007)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ci9PVVBraWwyVXJKTlI1WE5CWlppcGl3OXBVYXloaUNHekRtdGxyMkJKc3Ir?=
 =?gb2312?B?SEhIRjNjWkhOQkRUN0xmR3NuUzNwYVMyNVhFM281bTJYL3E1YTZvMks4NERT?=
 =?gb2312?B?WVRpczNLYmRpSDA1UWs5UmZZRmw3LzhCbE5GdE5jRnZISFM5MndhL0NJM1Jv?=
 =?gb2312?B?dTBnb01mSjNKcWRCb3BxbDB4b2FRcHRkL2tHVjV2UTlqWU9TTjlwRkdoSWVD?=
 =?gb2312?B?OTZWQ24rSUVROXZ1SGpxbStVcjEzU3RiVnBjYnMzS1g5a1Y1dEFKeFU5c0hW?=
 =?gb2312?B?cC9OSllMeXl4UThkRW1qM25ENGdDd0cwamJtQSt0aFZqYVBWU2g1VHMwSWdm?=
 =?gb2312?B?OHYybW9pQm5odWZ5VDdCZW5PUjBqeEk2V2Nuajhzelo2cVdBdEU5WGtqS3Z0?=
 =?gb2312?B?MEhHc1pFMzk2OThiWmJ3U3pvbG0rT202dU80RnBvL0xCQitvdk1vbktjaTVJ?=
 =?gb2312?B?MGVZSkRXL0tpSEdKZ1pTM21TSmJaNjg3Yk8wTFh0OTV2M0Q3VUkzMncxSTZ4?=
 =?gb2312?B?cmFYMW1xRmNtbGxwNXQ4c2NNNUtkdmUrNzJVanIwaFcvVVNsb25ibXBiYXhL?=
 =?gb2312?B?YVU4RUVZS1ZZenYvd3IvR2lFZ3BIKzkwMXlhRHN6TW03cTlUcEo4c1RITlp0?=
 =?gb2312?B?TG5XYVo0eEtjZmdIV2d6M3EwdC9CUTJnVmNhd2tFWkt4cG5oYnpJNWxZUmtI?=
 =?gb2312?B?Rk44bDlDYUZNeEQ3VndseEF3bmlsSTJDOXVTQWliNXZDaDJtaXozY3ZrMmpG?=
 =?gb2312?B?eEF3czlNc24yREFlNXhQN0F4MytvL1BjNE1xc0owM0pSZzBzUHlQNCt0OWV0?=
 =?gb2312?B?U3pnVmxYTVdYRWtuQjBIVDZUaDBFWnhIMXhLcmpveVE3dHdDMGVOMjhZUFhq?=
 =?gb2312?B?RC9MZnpGS1JwQ0s3NVJJY0l6SVN1dGJKUUxvZWNLUGk2QVhvSlBEdjc5RlBT?=
 =?gb2312?B?bU53cWhESDkvZ0ZyYXg0eVFWbUVQRmRqdDlRbVFHa0xWUlBYckpDOFp6V09V?=
 =?gb2312?B?c0xMUVRQL2xVeFBHNlBnUk5BdWlncU15NStUU1RtODNWR1lFSVVVTVYxSUNL?=
 =?gb2312?B?dXV5V29JWjZ4VEFlMk5WelFVKzdoVjlLV2RsTVFTT0JKYXFzVzBqVERaU2g2?=
 =?gb2312?B?bG5yd2YxRVp0WW81Mk8rUVAwaURvRnpMRUpPNU1vRVN1elhFMnd3S3ZJcFgw?=
 =?gb2312?B?VnJvT016RE5jNUN5REp3RDVNVGg5dWFuQUxnS0FTckh2R2tLRnJvRTdiTm1S?=
 =?gb2312?B?aE1VRHplWGFmUTZNbEFYMFg1bFRTbmZ4MDUzNlZ3bkMxYWhFQ0puQnRKQkNN?=
 =?gb2312?B?SjYvbXRjSU0zWDlUSC8wQXM2WHhXWnNOdTFxQ2tKUXIvTkRIVG5XNlFvWGhP?=
 =?gb2312?B?YXFqWnlnMXBCTU56amNJRm1iRlJmOGtRRzJ3Z05Gc0xxdEtwdy92YkhCMDcw?=
 =?gb2312?B?U2tIamw3aGN5Y1JaUCsweGZZMGJUYTRxbzBDdXBXMTJwWStpRXRPVDBTcnlH?=
 =?gb2312?B?QmRBS2xKT0dBa3dmd2J6YlAxSG94UExQeWIxUlJRUFRtSkJDTnAvTVdnUmd5?=
 =?gb2312?B?UTVxMDlKeDVpZStMT2pPdUZlU3pDY3JSYXBZWm1pa3U5NUZ1VkgveGNJdC84?=
 =?gb2312?B?ZXpRVVNOb1c3MmxJc2t0akRZYzZYdW9qNzRxZVRrcFhsQ3M5Y2NTWXZIL2du?=
 =?gb2312?B?SlBLV3V0NzlDQXlrSWlmRzRndUZOUVJVN2E0MWQ5bzJob256ZnBBcUlTSkRx?=
 =?gb2312?B?MFVVb1RLREJPbTRwZExhcjZDNURGYWVuTkl2MFZsNzBlL3dZVmFwNk82S2J1?=
 =?gb2312?B?MWxJTEJiSjd0VHdybVJQVTdLWEswOWhIclluT0NxSkdTNm1Renh3SGo1UEZU?=
 =?gb2312?B?T3htTDN0TzBPeUdBRjM3aFJCVkxwKzRVMVZCYnRQdlI4dTNvM1RabzVNd25p?=
 =?gb2312?B?akV6ZWdWcHNrdnFudGZNTjBTSTdnUDUwc0VES2l0b21DYkZDNzV0QkpwdUM0?=
 =?gb2312?B?dlkzVnQ1U1FrbzM4V1ZOcTlzTzlrb2Q3K0hOSzBFNm96V0xnOXROUmJSbWZ3?=
 =?gb2312?B?NkhKNHpwd1UraWFWM3MrS0NQcEZSVVFEVUJFemtLaDZld3lLVkRFc2ZmSWRu?=
 =?gb2312?B?eUdBNEt2SDI3VE5mWmgrSVRWSUZLN1lmZEhIOVJFM3NZWnFudG5ZV0FqemNB?=
 =?gb2312?B?eWNqQ0lKeE9YL053Qk95cDJCenhqS3djNzhjcGtabDUyMmVOWGYrN085NkEr?=
 =?gb2312?Q?QP5OqMFjha6RGTDkGxXIvTIa9stuhvXvr214gUGZXQ=3D?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <1812C90D95D56C43BBECE5543FD73623@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9792b80-6c4a-42e9-a3a3-08d9d65d9fed
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2022 06:26:25.2464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lc6oxkKkgiRlcKob5RSNwDVjGUJ8eg5nPw0IOE75env9vR8Qui72riNL9zedVLBTmoj/3Hs488Y0RI4C+gNi1F/AXNP3bbJctgfflc4qPDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5371
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGkgUGluZw0KDQpCZXN0IFJlZ2FyZHMNCllhbmcgWHUNCj4gU2luY2Uga2VybmVsIGNvbW1pdCA0
MzIwOWVhMmQxN2EgKCJ6cmFtOiByZW1vdmUgbWF4X2NvbXBfc3RyZWFtcyBpbnRlcm5hbHMiKSwg
enJhbSBoYXMNCj4gc3dpdGNoZWQgdG8gcGVyLWNwdSBzdHJlYW1zLiBFdmVuIGtlcm5lbCBzdGls
bCBrZWVwIHRoaXMgaW50ZXJmYWNlIGZvciBzb21lIHJlYXNvbnMsIGJ1dA0KPiB3cml0aW5nIHRv
IG1heF9jb21wX3N0cmVhbSBkb2Vzbid0IHRha2UgYW55IGVmZmVjdC4gU28gcmVtb3ZlIGl0Lg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogWWFuZyBYdTx4dXlhbmcyMDE4Lmp5QGZ1aml0c3UuY29tPg0K
PiAtLS0NCj4gICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy96cmFtL3pyYW0wMS5zaCAgIHwgIDQg
LS0tLQ0KPiAgIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3pyYW0venJhbTAyLnNoICAgfCAgNCAt
LS0tDQo+ICAgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvenJhbS96cmFtX2xpYi5zaCB8IDIyIC0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gICAzIGZpbGVzIGNoYW5nZWQsIDMwIGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3pyYW0venJhbTAx
LnNoIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvenJhbS96cmFtMDEuc2gNCj4gaW5kZXggMTE0
ODYzZDlmYjg3Li4yODU4M2U0YWU1NDYgMTAwNzU1DQo+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL3pyYW0venJhbTAxLnNoDQo+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3py
YW0venJhbTAxLnNoDQo+IEBAIC0xNSw5ICsxNSw2IEBAIEVSUl9DT0RFPTANCj4gDQo+ICAgIyBU
ZXN0IHdpbGwgY3JlYXRlIHRoZSBmb2xsb3dpbmcgbnVtYmVyIG9mIHpyYW0gZGV2aWNlczoNCj4g
ICBkZXZfbnVtPTENCj4gLSMgVGhpcyBpcyBhIGxpc3Qgb2YgcGFyYW1ldGVycyBmb3IgenJhbSBk
ZXZpY2VzLg0KPiAtIyBOdW1iZXIgb2YgaXRlbXMgbXVzdCBiZSBlcXVhbCB0byAnZGV2X251bScg
cGFyYW1ldGVyLg0KPiAtenJhbV9tYXhfc3RyZWFtcz0iMiINCj4gDQo+ICAgIyBUaGUgenJhbSBz
eXNmcyBub2RlICdkaXNrc2l6ZScgdmFsdWUgY2FuIGJlIGVpdGhlciBpbiBieXRlcywNCj4gICAj
IG9yIHlvdSBjYW4gdXNlIG1lbSBzdWZmaXhlcy4gQnV0IGluIHNvbWUgb2xkIGtlcm5lbHMsIG1l
bQ0KPiBAQCAtNzIsNyArNjksNiBAQCB6cmFtX2ZpbGxfZnMoKQ0KPiANCj4gICBjaGVja19wcmVy
ZXFzDQo+ICAgenJhbV9sb2FkDQo+IC16cmFtX21heF9zdHJlYW1zDQo+ICAgenJhbV9jb21wcmVz
c19hbGcNCj4gICB6cmFtX3NldF9kaXNrc2l6ZXMNCj4gICB6cmFtX3NldF9tZW1saW1pdA0KPiBk
aWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvenJhbS96cmFtMDIuc2ggYi90b29s
cy90ZXN0aW5nL3NlbGZ0ZXN0cy96cmFtL3pyYW0wMi5zaA0KPiBpbmRleCBlODNiNDA0ODA3YzAu
LmQ2NjQ5NzRhMTMxNyAxMDA3NTUNCj4gLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvenJh
bS96cmFtMDIuc2gNCj4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvenJhbS96cmFtMDIu
c2gNCj4gQEAgLTE0LDkgKzE0LDYgQEAgRVJSX0NPREU9MA0KPiANCj4gICAjIFRlc3Qgd2lsbCBj
cmVhdGUgdGhlIGZvbGxvd2luZyBudW1iZXIgb2YgenJhbSBkZXZpY2VzOg0KPiAgIGRldl9udW09
MQ0KPiAtIyBUaGlzIGlzIGEgbGlzdCBvZiBwYXJhbWV0ZXJzIGZvciB6cmFtIGRldmljZXMuDQo+
IC0jIE51bWJlciBvZiBpdGVtcyBtdXN0IGJlIGVxdWFsIHRvICdkZXZfbnVtJyBwYXJhbWV0ZXIu
DQo+IC16cmFtX21heF9zdHJlYW1zPSIyIg0KPiANCj4gICAjIFRoZSB6cmFtIHN5c2ZzIG5vZGUg
J2Rpc2tzaXplJyB2YWx1ZSBjYW4gYmUgZWl0aGVyIGluIGJ5dGVzLA0KPiAgICMgb3IgeW91IGNh
biB1c2UgbWVtIHN1ZmZpeGVzLiBCdXQgaW4gc29tZSBvbGQga2VybmVscywgbWVtDQo+IEBAIC0z
MCw3ICsyNyw2IEBAIHpyYW1fbWVtX2xpbWl0cz0iMU0iDQo+IA0KPiAgIGNoZWNrX3ByZXJlcXMN
Cj4gICB6cmFtX2xvYWQNCj4gLXpyYW1fbWF4X3N0cmVhbXMNCj4gICB6cmFtX3NldF9kaXNrc2l6
ZXMNCj4gICB6cmFtX3NldF9tZW1saW1pdA0KPiAgIHpyYW1fbWFrZXN3YXANCj4gZGlmZiAtLWdp
dCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3pyYW0venJhbV9saWIuc2ggYi90b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy96cmFtL3pyYW1fbGliLnNoDQo+IGluZGV4IDZmODcyZjI2NmZkMS4uMGM0
OWY5ZDFkNTYzIDEwMDc1NQ0KPiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy96cmFtL3py
YW1fbGliLnNoDQo+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3pyYW0venJhbV9saWIu
c2gNCj4gQEAgLTgyLDI4ICs4Miw2IEBAIHpyYW1fbG9hZCgpDQo+ICAgCWZpDQo+ICAgfQ0KPiAN
Cj4gLXpyYW1fbWF4X3N0cmVhbXMoKQ0KPiAtew0KPiAtCWVjaG8gInNldCBtYXhfY29tcF9zdHJl
YW1zIHRvIHpyYW0gZGV2aWNlKHMpIg0KPiAtDQo+IC0JbG9jYWwgaT0wDQo+IC0JZm9yIG1heF9z
IGluICR6cmFtX21heF9zdHJlYW1zOyBkbw0KPiAtCQlsb2NhbCBzeXNfcGF0aD0iL3N5cy9ibG9j
ay96cmFtJHtpfS9tYXhfY29tcF9zdHJlYW1zIg0KPiAtCQllY2hvICRtYXhfcz4gICRzeXNfcGF0
aCB8fCBcDQo+IC0JCQllY2hvICJGQUlMIGZhaWxlZCB0byBzZXQgJyRtYXhfcycgdG8gJHN5c19w
YXRoIg0KPiAtCQlzbGVlcCAxDQo+IC0JCWxvY2FsIG1heF9zdHJlYW1zPSQoY2F0ICRzeXNfcGF0
aCkNCj4gLQ0KPiAtCQlbICIkbWF4X3MiIC1uZSAiJG1heF9zdHJlYW1zIiBdJiYgIFwNCj4gLQkJ
CWVjaG8gIkZBSUwgY2FuJ3Qgc2V0IG1heF9zdHJlYW1zICckbWF4X3MnLCBnZXQgJG1heF9zdHJl
YW0iDQo+IC0NCj4gLQkJaT0kKCgkaSArIDEpKQ0KPiAtCQllY2hvICIkc3lzX3BhdGggPSAnJG1h
eF9zdHJlYW1zJyAoJGkvJGRldl9udW0pIg0KPiAtCWRvbmUNCj4gLQ0KPiAtCWVjaG8gInpyYW0g
bWF4IHN0cmVhbXM6IE9LIg0KPiAtfQ0KPiAtDQo+ICAgenJhbV9jb21wcmVzc19hbGcoKQ0KPiAg
IHsNCj4gICAJZWNobyAidGVzdCB0aGF0IHdlIGNhbiBzZXQgY29tcHJlc3Npb24gYWxnb3JpdGht
Ig0K
