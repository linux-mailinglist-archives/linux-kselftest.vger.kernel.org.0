Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F63483F52
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jan 2022 10:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiADJm7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Jan 2022 04:42:59 -0500
Received: from esa8.fujitsucc.c3s2.iphmx.com ([68.232.159.88]:7135 "EHLO
        esa8.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230216AbiADJm5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Jan 2022 04:42:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1641289377; x=1672825377;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8vkrwKdSWycAILEOqtkRbJJ4oumxAK/rRQ1mVEq9ndE=;
  b=B4LfCMHMGmAlf/KJh/rc5uAOmqStQzMrlWmj5cH4cPM/oc09OUFi1xGg
   iPeu0CyWpVhY35kHcF5ZwGw4vMPbaHFg0B80rtG+HT3vmLSfRZj7xi07Q
   RRwyR701KzaH2kfR3JsOckRcs3ZlYw8t41QSUtklS3NqFnmRI1CYl+B8V
   9S/4KNsWcGmcs5jgO+15ZWyZ6ZHWYulbJfrRdQvdeC4ERaSIibrXbYhpo
   jYxKXlstF4dRt/XUT9iBasgCGQXQ0L1wE7+pUJCqW1RmImO9arsrPiOGs
   FNc5fZrCb0qYi0pdszf80/T+myo6M7e5Ia958u6pdzEeTIC7Wh8bHgUF2
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="46950569"
X-IronPort-AV: E=Sophos;i="5.88,260,1635174000"; 
   d="scan'208";a="46950569"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 18:35:46 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EpstjNAQod9QHlSt5JWYbTo63wgSknDOFZKHUQCChHGigEJQpTzpImMQrl0YcuBw6KQzDctJtUDOKnSCE7lNsmMQ62jbz8yGWRVcip4UvBGkmZ2nt733X5UtUKG8PtgDk2vdyp/pzuCO1OVROcehIX+H93RSKJxSgdNEiGUgCYekxWiIzlMVYQ9jmKDoHv/vmXXNqBUqNW9vPAj/gq9CBoYP728JiiQ5Fsi/OSpLEdbzQuXWm3n1xPbOvztDNurAXKgZ2dUatcq+7XqacmcE0EDAwX1M1+e3PUB5UwciQwTkf0Mg6nwDV20Lf+cHJ5iXIv0URhY4Zfb2WZPZwveKtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+dybe34UMu5zqugpLn4zNXwJsEtn4VzeOzX/XRQ8Xs=;
 b=Hm90QpQ7DAqmgwidqe/eAsOCoIFMo9mbKhFXD61sEbafYMNAhRInzj7280Auper0jI6bI/yYMLcfREOuQXAOz8ePSGWyerGPJ1kni6oMuzRrYlyAvS0H7n10ISVyFw4K23z0s2o9TYLfA8z9v7oMSJsHyPhTDdiUPKaReddmVb5uVg0QxOHJFPRkCnJw20V6Nh41u+PAhWdSANB6lLK5vElky/Dfn9Ss6nBPL7wscCb/u0FkqbYPeUtSqcNgzZy09wSnk0/itR9N/AE+cgKzOcDy06IG33C3a1g0tnQ7W5ytaf+TOdJwgQ/AioyhLjZdlVZh/2DVaBfNeYtUZkZB0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+dybe34UMu5zqugpLn4zNXwJsEtn4VzeOzX/XRQ8Xs=;
 b=PgI5nMTZfgu+JwD0B+w6gf1Q+5pfnbfXJ89g61xTxtXcVDEqRe3aeYPWs30GBzVd9Di1hqvOhSklC9WzHgjOEcP2shdP6h5XRRuImUCADg6wZmmQ4ELM/Q5AQ1mE+UbLvEuZ37fvSXdjGEiPASGHMbV1mGMfYSAFoXPrFxHGFLI=
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYAPR01MB1967.jpnprd01.prod.outlook.com (2603:1096:404:7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 09:35:43 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::1c9c:6e45:49b:757c]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::1c9c:6e45:49b:757c%5]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 09:35:43 +0000
From:   "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>
To:     "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH v2] selftests/resctrl: Print a message if the result of
 MBM&CMT tests is failed when Intel Sub-NUMA is enabled
Thread-Topic: [PATCH v2] selftests/resctrl: Print a message if the result of
 MBM&CMT tests is failed when Intel Sub-NUMA is enabled
Thread-Index: AQHX8Ajkoh1qZfqmsUSkznAFwBN9i6xSvE2w
Date:   Tue, 4 Jan 2022 09:35:42 +0000
Message-ID: <TYAPR01MB633033036DB3C6BA82E085828B4A9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20211213100321.181408-1-tan.shaopeng@jp.fujitsu.com>
In-Reply-To: <20211213100321.181408-1-tan.shaopeng@jp.fujitsu.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?iso-2022-jp?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZl?=
 =?iso-2022-jp?B?Y2UwNTBfQWN0aW9uSWQ9MWEzNWExMWEtMmQxMi00ZTk4LTg5OTAtOTcy?=
 =?iso-2022-jp?B?OTE4ZjRmZDQ0O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFi?=
 =?iso-2022-jp?B?NGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9h?=
 =?iso-2022-jp?B?NzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxl?=
 =?iso-2022-jp?B?ZD10cnVlO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQt?=
 =?iso-2022-jp?B?M2IwZjRmZWNlMDUwX01ldGhvZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9OYW1lPUZV?=
 =?iso-2022-jp?B?SklUU1UtUkVTVFJJQ1RFRBskQiJMJT8lUhsoQjtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRl?=
 =?iso-2022-jp?B?PTIwMjItMDEtMDRUMDk6MzM6NTJaO01TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?iso-2022-jp?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?iso-2022-jp?B?ZC04MWUxLTQ4NTgtYTlkOC03MzZlMjY3ZmQ0Yzc7?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 49d8b50e-f366-4265-0f36-08d9cf6593f0
x-ms-traffictypediagnostic: TYAPR01MB1967:EE_
x-microsoft-antispam-prvs: <TYAPR01MB19675EB3925737DACE6B4AA38B4A9@TYAPR01MB1967.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tid0t1MuNpqf2SOTLRpbvvB3mO9K5/5UZxOLJUR0R8EoDi0rnjcmDjrh0zrGmidK68fuhuypmHEqQxKc+IwtDwzCJpp7cirGCo6Ehx6JLucjRKixHGV2QISk4kLT5+xwUDFAMnSMt9YYKF7V20Ipd0GsdGBE6TGubNDW1XR8iDt50E99S8h8yQC5LmarqY3KOG18RYpRvoZ4ii6En8LQMD1Rv13JAjCbw1G5GTAPwhku2iRjqRKdk5HjPhEC2lnCiRTiM9RsEkmpctkcI7YxQhP/qGxpkjcJ+mQQOcIppn4VolwJP6JH9QVoE4wLLSKTicaIi3g82jsKSzimnn4InjYvyHZxLsVcrwy1epcV9WQ4LSHRqyRl++BLlCUear8dJ/6aLy5fayppg6+k2X4PCyjZLc33vQD11mxvC5wKCuiDFFq0kkhPL8ffKLYghFO+DFqjq3PsS+y4kgZkMXMC4Py+lr1SWFJLaIoH/ljV/ZEUPAkZCLa17FnN68+zgJzX+Y8MDG9WtuBgsfrsC8n8czeUUKKsoLcGBQELE5eXbv2YXf0jh+FVI3xqWhSrIYdDxRGLJn74iSrICtu5KizwJHiyMy4PASoWDZOMp2PSZdqUv3BHGhhGgQaaPJ+QKXoXtNR2woOgX8ka/8Fntfo6RIP0CJ6scJuFptlkKyG3GZsx8ksI0uieEqSjrChsoKj/q6xFzs43HKcuDGezRhNEt2nXTHY1Eutn0pIGWBaMpmg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(110136005)(4326008)(5660300002)(82960400001)(66946007)(6506007)(55016003)(85182001)(9686003)(83380400001)(54906003)(186003)(86362001)(66446008)(52536014)(38100700002)(8676002)(8936002)(33656002)(64756008)(38070700005)(7696005)(76116006)(26005)(316002)(15650500001)(122000001)(66556008)(71200400001)(66476007)(2906002)(485434002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?RTBLRXVsbXJxSDJqa3E4NnF1ZGxka3ZNN09ZK0tUTlFSd3Z5K0ZNYjVP?=
 =?iso-2022-jp?B?eXd1VWNZak52cDJ1NmNPenduc2JPNEdxUzdrVGFUVlRlbkNvM0lHaXEw?=
 =?iso-2022-jp?B?bVdPTSswVm42bSs0NFY2TlZSTG1UblkyUVdJR21FN1Blb2cyNVlPYm9j?=
 =?iso-2022-jp?B?V1QxM0UxVXRldWZ1SWhqaFdCMXBCdERzYzcreXh1ejRmZHhvRENTQWFm?=
 =?iso-2022-jp?B?WTJKSHJsSk9hbzN6YUY5VVI4dFZTRVRyakQxUDJibzVRNEdjWHp2dDAw?=
 =?iso-2022-jp?B?NUUwSlNEM3dkMjA0OHRKYVpqY0FqMjRET2cwMWxVZWNTNGpydVdHdWNs?=
 =?iso-2022-jp?B?NU1uSmtRaG1uUXZ1SS85Vnd6QjRxeC94UmRPNFpNYzdsd3BkK21mYUNH?=
 =?iso-2022-jp?B?QzBRaUdqU25aV3NNTFl0SEF3bW45Zk03K2dFcHRmMnlTL1MxeXVmM29D?=
 =?iso-2022-jp?B?SHE5WVNSQmRydEQ4enhsaGdGbmhOOEtCT0xsYWh0bXpwVndJSDZkazl1?=
 =?iso-2022-jp?B?dHl2MGRma0RhQllIN0pUSWhoYWpGWW9rTk96Rmlmd3NNem00cVNQRzlk?=
 =?iso-2022-jp?B?UWpzYmdrY3VnNitJYVBJUW80SzQzVVgrUklkeXFtMXJ3VnhuOFhIdHVn?=
 =?iso-2022-jp?B?WlRUNmtmYlBDSGRFWWh2aDgwS0FnbEJlWXRtZ25RYnRJUmc1NTBoMTVi?=
 =?iso-2022-jp?B?RW9TMXRzU2NnN2phOEptRW43elJWc0JKaXhFZnZlblgycVB4djB2VGNx?=
 =?iso-2022-jp?B?ZnNkWUE5MnBhNzFxSEF1Q2JyUGF3ZXZ5K3JVeWZYb004Rk5aM3FpWWp6?=
 =?iso-2022-jp?B?VWZla1RsKzlrQWo3dm9qYWFxNlkvN3BTendRbEdNYnoyU3pOSm9haE5t?=
 =?iso-2022-jp?B?NFcrQm9lc3VjZE1jUjk3eU5oM0U4ZVQ4LyswUEliQlBnek5QbHd2aHhM?=
 =?iso-2022-jp?B?WnVRSTBxOUY2R0Z3blN3d3B0LzRGUmVJMEJJLzdZR1JvNk1pNzE1QmhG?=
 =?iso-2022-jp?B?UUV3VGNrdFVaMGRUcnFCeGQyOE96cGRER2NKaEVqZGJFcGFMNjA0MzBC?=
 =?iso-2022-jp?B?c0YxZ0h3dkhQZWZSZ05SVllhSndER3lhbHQwcDVNVkJDQ2x3VStibm8x?=
 =?iso-2022-jp?B?R0RDYUhHN0pMY0hHODVBZitFYzc2eTVnNC9scURSQko2c3VJZVhBRTdS?=
 =?iso-2022-jp?B?MEpFcTk3bEpEazZEWjlTME04VHFTVUNUMzNod1hHRkllSVVHRzJvYXRj?=
 =?iso-2022-jp?B?bk1ITUZKZFgvK1cwVllMeGhjVHNDNDEzWjE1eGt3Y3VyclpXeWFhcmZ0?=
 =?iso-2022-jp?B?ZUVoYnRZaGdHcnBkaVhwaGE0VW1NcDZFWlZCTVN5UkJ5MXI0U3ptY1lY?=
 =?iso-2022-jp?B?WThRSnFZQmhpdUtvczdiNnJMUEx1MDB6Qm5tYVlDeldtUjFETjByMzRK?=
 =?iso-2022-jp?B?WG04VnBFbXFuajEwQkpIc0NPTlhxWU5Kb242dlJZUXREUFBzZmkveGJC?=
 =?iso-2022-jp?B?MDYvUFJ2ZEhJL25RQ0tiazVMbWd0WFd6SlM1YVdWbVkzZVAvUWxUOUtt?=
 =?iso-2022-jp?B?VFVQUEg3bUNQRGlPSjBTTnNvdkc2aTBOUTBrS3lrZnNJY2I1ejRvY09u?=
 =?iso-2022-jp?B?R1B6bjZDalYwai9CRWRGZHBKTzVnb1pXVVg0TTNUTW9vQlAvV3VjMFdl?=
 =?iso-2022-jp?B?ZFROOGVEaU9IMDVjeGpPNU0rUFdzSHpLSENLbkxURksrV0NKdG1mc25x?=
 =?iso-2022-jp?B?c01RcGVESDFMOG12SXhmQlc1RFNReHkySURuc1duRkt6VjJyZnJHUzVl?=
 =?iso-2022-jp?B?QTV2TDNweU1aUmNucVVneFQyTVZmbmhyZGwzN0M4OTJ5Znk2bnEwdUFC?=
 =?iso-2022-jp?B?UWhSeUw0cWdtL09PaGpERUNBWXo3ZGNyLzE5RmE3cXoxRDNKSzRwTnpi?=
 =?iso-2022-jp?B?WlNHdTQ3QnUrcTZ4SHRxRWJXd2lQY1VvRitmODJ4NUNjQU96R0psZXps?=
 =?iso-2022-jp?B?VitaemlnNEVpWmNNZFY5dW5WeDBXMERGdW14d3R1WXZZOU1qOXNZTVBo?=
 =?iso-2022-jp?B?amovOEVObmdEa1l2ZWV4MG9FalJtemRWTWh3WlZENWhhSDF6d0IwRUMx?=
 =?iso-2022-jp?B?V3hVNzRna3RqV05MYkNuSDJqcFhrUG9sWjJ2VTYxYm4xL1pOMXA5L21F?=
 =?iso-2022-jp?B?RnorcVdob2M2STRWQkdUeDNwNFkrRTBBbEcrRnVJVG9RVmM0SzRuc2xC?=
 =?iso-2022-jp?B?KzNNcUN5d0tVUldPNSttWjFCeUttZFpoUEVVUngxalo0QzRQU1ZOUjI0?=
 =?iso-2022-jp?B?TTFDT1JXdElRaDk3ZGpMZ0s2djRTWjhqYnk4RVNYd2hCajhaYWZDVThI?=
 =?iso-2022-jp?B?M3A3OUlzdXhQbGVuNktGZjlzL0VxYm9kQnBMeDUxWDJRNTE3K255UEx6?=
 =?iso-2022-jp?B?TUJkTFBRPT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d8b50e-f366-4265-0f36-08d9cf6593f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2022 09:35:42.9640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zxNLhCPQalxAMirrULZ1eoZ29RFFCKWAInfmq1fvk1oCgGzsndwb/VFa8TBs7jxhBzf2fL+PuvO5iNiShYvSUHohlQpt6CyPip5+Rl1wnUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB1967
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

Friendly ping for a review.

>=20
> If the result of MBM&CMT tests is failed when Intel Sub-NUMA is enabled,
> print a possible causes of failure.
> Since when the Intel Sub-NUMA Clustering(SNC) feature is enabled, the CMT
> and MBM counters may not be accurate.
>=20
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
> Hello,
>=20
> According to the Intel RDT reference Manual, when the sub-numa clustering
> feature is enabled, the CMT and MBM counters may not be accurate.
> When running CMT tests and MBM tests on 2nd Generation Intel Xeon
> Scalable Processor, the result may be "not ok".
> If result of MBM&CMT tests is failed when Intel Sub-NUMA is enabled, fix =
it to
> print a possible cause of failure, instead of SKIP these tests in v1.
>=20
> Thanks,
>=20
>  tools/testing/selftests/resctrl/Makefile      |  1 +
>  tools/testing/selftests/resctrl/cmt_test.c    |  5 ++-
>  tools/testing/selftests/resctrl/mbm_test.c    |  5 ++-
>  tools/testing/selftests/resctrl/resctrl.h     |  2 ++
>  .../testing/selftests/resctrl/resctrl_tests.c | 36
> +++++++++++++++++++
>  tools/testing/selftests/resctrl/resctrlfs.c   | 26 ++++++++++++++
>  6 files changed, 73 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/testing/selftests/resctrl/Makefile
> b/tools/testing/selftests/resctrl/Makefile
> index adfd92145e12..6d257f40e6ac 100644
> --- a/tools/testing/selftests/resctrl/Makefile
> +++ b/tools/testing/selftests/resctrl/Makefile
> @@ -1,6 +1,7 @@
>  #SPDX-License-Identifier: GPL-2.0
>=20
>  CFLAGS +=3D -g -Wall -O2 -D_FORTIFY_SOURCE=3D2
> +LDLIBS +=3D -lnuma
>=20
>  TEST_GEN_PROGS :=3D resctrl_tests
>  EXTRA_SOURCES :=3D $(wildcard *.c)
> diff --git a/tools/testing/selftests/resctrl/cmt_test.c
> b/tools/testing/selftests/resctrl/cmt_test.c
> index 8968e36db99d..c5a49444c5a0 100644
> --- a/tools/testing/selftests/resctrl/cmt_test.c
> +++ b/tools/testing/selftests/resctrl/cmt_test.c
> @@ -136,8 +136,11 @@ int cmt_resctrl_val(int cpu_no, int n, char
> **benchmark_cmd)
>  		return ret;
>=20
>  	ret =3D check_results(&param, n);
> -	if (ret)
> +	if (ret) {
> +		if (sub_numa_cluster_enable)
> +			ksft_print_msg("Sub-NUMA Clustering(SNC) feature
> is enabled, the CMT
> +counters may not be accurate.\n");
>  		return ret;
> +	}
>=20
>  	cmt_test_cleanup();
>=20
> diff --git a/tools/testing/selftests/resctrl/mbm_test.c
> b/tools/testing/selftests/resctrl/mbm_test.c
> index 8392e5c55ed0..7dc1bdf2d0b8 100644
> --- a/tools/testing/selftests/resctrl/mbm_test.c
> +++ b/tools/testing/selftests/resctrl/mbm_test.c
> @@ -136,8 +136,11 @@ int mbm_bw_change(int span, int cpu_no, char
> *bw_report, char **benchmark_cmd)
>  		return ret;
>=20
>  	ret =3D check_results(span);
> -	if (ret)
> +	if (ret) {
> +		if (sub_numa_cluster_enable)
> +			ksft_print_msg("Sub-NUMA Clustering(SNC) feature
> is enabled, the MBM
> +counters may not be accurate.\n");
>  		return ret;
> +	}
>=20
>  	mbm_test_cleanup();
>=20
> diff --git a/tools/testing/selftests/resctrl/resctrl.h
> b/tools/testing/selftests/resctrl/resctrl.h
> index 1ad10c47e31d..4b8ad4fbd016 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -76,6 +76,7 @@ extern pid_t bm_pid, ppid;
>=20
>  extern char llc_occup_path[1024];
>  extern bool is_amd;
> +extern bool sub_numa_cluster_enable;
>=20
>  bool check_resctrlfs_support(void);
>  int filter_dmesg(void);
> @@ -85,6 +86,7 @@ int umount_resctrlfs(void);  int
> validate_bw_report_request(char *bw_report);  bool
> validate_resctrl_feature_request(const char *resctrl_val);  char *fgrep(F=
ILE
> *inf, const char *str);
> +char *fgrep_last_match_line(FILE *inf, const char *str);
>  int taskset_benchmark(pid_t bm_pid, int cpu_no);  void run_benchmark(int
> signum, siginfo_t *info, void *ucontext);  int write_schemata(char *ctrlg=
rp,
> char *schemata, int cpu_no, diff --git
> a/tools/testing/selftests/resctrl/resctrl_tests.c
> b/tools/testing/selftests/resctrl/resctrl_tests.c
> index 3be0895c492b..bbab4a7f37ed 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -8,12 +8,15 @@
>   *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
>   *    Fenghua Yu <fenghua.yu@intel.com>
>   */
> +#include <numa.h>
> +#include <string.h>
>  #include "resctrl.h"
>=20
>  #define BENCHMARK_ARGS		64
>  #define BENCHMARK_ARG_SIZE	64
>=20
>  bool is_amd;
> +bool sub_numa_cluster_enable;
>=20
>  void detect_amd(void)
>  {
> @@ -34,6 +37,35 @@ void detect_amd(void)
>  	fclose(inf);
>  }
>=20
> +void check_sub_numa_cluster(void)
> +{
> +	FILE *inf =3D fopen("/proc/cpuinfo", "r");
> +	char *res, *s;
> +	int socket_num =3D 0;
> +	int numa_nodes =3D 0;
> +
> +	if (!inf)
> +		return;
> +
> +	res =3D fgrep_last_match_line(inf, "physical id");
> +
> +	if (res) {
> +		s =3D strpbrk(res, "1234567890");
> +		socket_num =3D atoi(s) + 1;
> +		free(res);
> +	}
> +	fclose(inf);
> +
> +	numa_nodes =3D numa_max_node() + 1;
> +
> +	/*
> +	 * when the Sub-NUMA Clustering(SNC) feature is enabled,
> +	 * the number of numa nodes is twice the number of sockets.
> +	 */
> +	if (numa_nodes =3D=3D (2 * socket_num))
> +		sub_numa_cluster_enable =3D true;
> +}
> +
>  static void cmd_help(void)
>  {
>  	printf("usage: resctrl_tests [-h] [-b \"benchmark_cmd [options]\"]
> [-t test list] [-n no_of_bits]\n"); @@ -210,6 +242,10 @@ int main(int arg=
c, char
> **argv)
>  	/* Detect AMD vendor */
>  	detect_amd();
>=20
> +	/* check whether sub numa clustering is enable or not */
> +	if (!is_amd)
> +		check_sub_numa_cluster();
> +
>  	if (has_ben) {
>  		/* Extract benchmark command from command line. */
>  		for (i =3D ben_ind; i < argc; i++) {
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c
> b/tools/testing/selftests/resctrl/resctrlfs.c
> index 5f5a166ade60..1908ecb14b70 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -605,6 +605,32 @@ char *fgrep(FILE *inf, const char *str)
>  	return NULL;
>  }
>=20
> +/*
> + * Find the last matched line.
> + * Return a pointer to the string of the matched line,
> + * else retuen NULL if no matched line
> + */
> +char *fgrep_last_match_line(FILE *inf, const char *str) {
> +	char line[256];
> +	char result_line[256];
> +	int slen =3D strlen(str);
> +
> +	while (!feof(inf)) {
> +		if (!fgets(line, 256, inf))
> +			break;
> +		if (strncmp(line, str, slen))
> +			continue;
> +
> +		strcpy(result_line, line);
> +	}
> +
> +	if (strlen(result_line) >=3D slen)
> +		return strdup(result_line);
> +
> +	return NULL;
> +}
> +
>  /*
>   * validate_resctrl_feature_request - Check if requested feature is vali=
d.
>   * @resctrl_val:	Requested feature
> --
> 2.27.0

