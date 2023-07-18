Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FC975749C
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 08:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjGRGrm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 02:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjGRGrl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 02:47:41 -0400
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com [68.232.152.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC8512D;
        Mon, 17 Jul 2023 23:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1689662860; x=1721198860;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xqnRgsFIRw+1Ys/R1RIiPEvNmkONsD6Q2A7tECTOAbA=;
  b=NvJBTMRuvj5U5FW4IpAfZM3MkF38VkiNzbJJ4EGu1zv8cqg9JKZYxEU4
   GI8WVV6w8uniAAK/pm/hD1S6ErGX14j35ynDwegoe/aSVfjp9nnJMDQml
   lN+Yrma5xAlxt7YPpwAgO59X6bEwWOx95lnN2pw4AmkfzqUNqhBaIE1Ha
   idl4BNWTqslXbnJbtxbuCBbULgYMpl3GZFgeoF3u/yZR+bikwlCbdXbF1
   f+zvLdJmnlEYftQEiaP9xbT+CO+qu+E/nLFXyVpdR3kxIn//lM1TLAjjC
   iRKlW2pp3J6EFB9/dXu6av8Pr/j8YBwHozwAnrxPgLMBE1VUHKkWBprGL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="971542"
X-IronPort-AV: E=Sophos;i="6.01,213,1684767600"; 
   d="scan'208";a="971542"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 15:47:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0RsEJuVxhJ8Bg0x+CdDwfnlnue4MTNd/6cGmZqCibVVuMX2VtSdGz6Yv6A9cm3KtlCb5Dnix78C5pbbMNybl05PglnxYpX+VwI9mjn/8XObcVFdwwSUUAmjAAJIpDJjxdgI7iYODvMVM+McNh8tdHN6MNigyFfuD+5yNfgdE9Bmgmeo1Cu6e+NkGXhRRyKYFw9ytojDDV6YSUTZgfl0lz8rVB7u/UoXw51Y8RfTUZbfurbZ5aXDuj5ZS9xncPs4mJ7woNEIT5eizmlSmhZ8qjZMQnSfIIhJTGMkQLKY8OH6yi2n71dNKcdUvpoFsjAo0DlkIq6AHnGUD89jVWAWUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqnRgsFIRw+1Ys/R1RIiPEvNmkONsD6Q2A7tECTOAbA=;
 b=GhivqXEn8irhhLIp0av+pNRrx1J5VsgpDLRPAPIuBKMEbPC3XkdDlMsGKFQLxY8LoajQCb1fqdSrrizT0P9Wz8KAnngva37pMeuqEoLdJwUFo/3RgtLuSpD3ZOWLtUmoPvlALo0X8w8n/pFVnUWR/Ml642jwe30f+m3R5x9Djhiy9nVtE3SUTuiCOYbeSMapeDiYJ12wTveYCoL8jrUPpC1KzTw+gK/Il+UYFNEZScGZVvkW4s5usfT1z7Pl+eg9LvEq8CEpg2CZpBPOMMehQS66T8bz1xWtudxt4L4iwPSGz3KmjnSMzlIpX+GNc5kP8RPHi9SRC3DQiAut6uPHEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TY3PR01MB9682.jpnprd01.prod.outlook.com (2603:1096:400:22d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 06:47:32 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::429e:802f:eaf8:81b8]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::429e:802f:eaf8:81b8%4]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 06:47:32 +0000
From:   "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To:     =?utf-8?B?J0lscG8gSsOkcnZpbmVuJw==?= 
        <ilpo.jarvinen@linux.intel.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 00/19] selftests/resctrl: Fixes and cleanups
Thread-Topic: [PATCH v5 00/19] selftests/resctrl: Fixes and cleanups
Thread-Index: AQHZuLDBS7y2cTn1UEi5QurNJ30ajK+/FLMw
Date:   Tue, 18 Jul 2023 06:47:32 +0000
Message-ID: <TYAPR01MB63309A2D1CF5FBEF58F5502F8B38A@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20230717131507.32420-1-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20230717131507.32420-1-ilpo.jarvinen@linux.intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjMtMDctMThUMDY6NDI6?=
 =?utf-8?B?MzdaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD03N2QzYjQ0MS1hMDNkLTQwODkt?=
 =?utf-8?B?OTczMC05MmNlNTg2YzhjYzA7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 18d7dfc6750b4081baa08f51531372df
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|TY3PR01MB9682:EE_
x-ms-office365-filtering-correlation-id: bcf5c7fc-7e2a-403d-2f15-08db875add16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xygbqKR8aV5asy+1G/8QMYXfAk3TjibYeKJl9i7pdpmQKo8bqmQD1cwiJbQpo4kZjHBBKM2UR3dnl7dNXabqSO/jd47pQ5BQQ/kPGDBkXn8xtq1OiP2+UpH23EvHmmSw/QyJ1tKBE9SXxpaMTjnZYca7krQOoCV4ZlQZjDd6QSjwyOWFj80mbCPr7JQss4Tj6kqOl29aqXkLZT45EPJkbbPgI3rMScWQn+hBH6OBSUrAxB9S93luddJOpkLTNcp9fSc/gDc60FkHiRvCwLEju9ARu544c46mkgZlTHnwKxPt6GLQAuo5RyvXy2a+NLZ8lZ3VfmbC9lhuxHjQQBHoNJE+WquuOOus+Re6dZPbJDVaE72ZsJXIYI95Kyl+YxGRZkbbypGXos/dQTIqzLOD1cGFqVY9uPL0il9sZjhUvOgOyg0oX7STLjQy/2+rcAuhSHyH4R4+/mO8lkgQTQI3I6WwIuobGr6mqhaY7PXoHosxxLpYLAh+HBlz2exOJU+hV2rw92GeXah5tsVQk/O42dfaYtdTnFRviQW+stFvBrdcWMEmlS2BML8u9E14hQ9N6ZT+JF6PF6q7bMV/a/p4BWsIk+XpPyzDT+iU87zaHVCm1BU+UHVV71iWhvYWCTJJSUia0GW3spkeSH4KEOyNyw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(451199021)(1590799018)(38070700005)(38100700002)(8936002)(8676002)(85182001)(33656002)(558084003)(2906002)(83380400001)(52536014)(6506007)(26005)(5660300002)(55016003)(82960400001)(122000001)(186003)(86362001)(316002)(7696005)(71200400001)(4326008)(110136005)(66946007)(66556008)(64756008)(66476007)(76116006)(66446008)(478600001)(1580799015)(41300700001)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGtGcmVvVkVlQXFrWjRna0FuQkEvSlhEdXhaVkRJRkpNaFkrbGZ6UlJGcWlp?=
 =?utf-8?B?Y0hoZzJ4eS8ySktqcUNoc0ZFNXNVRlN3QmI2SnpWTDlndzRlSFl4TkNkVmVh?=
 =?utf-8?B?ek1zYzdlZEhncXBQVWZUR1YrUnJKOVZFeFJJYVNsdGpCanFsOW0veSs1Y2dO?=
 =?utf-8?B?ODk3NmxXd3ZyYTJ6Z2NXNWNFZm44a2lIV2ExYmtuU3Y0aTVVVTBFSHJ0T3ln?=
 =?utf-8?B?WUZNbkNLMVQ2K2pIejZBSHFPSndiTU11RXlldUpUaDZmZlN1aldYM3p1OG1X?=
 =?utf-8?B?SU1oSHd4elFadFo4UmxKL0NKOTd6NFpSTkJ6SUlTVUNnTDJYSjViVTFVbDhJ?=
 =?utf-8?B?bVRvb3dzL0ZKcGVPM2dWUmVScjNRWksrbHZDN3pFZU1rWFQ0bjZHejg3M1JB?=
 =?utf-8?B?VzhmVU9VUlZwZENHMkVSZW9ZcktweXAydlVvVVlMMFM5RnNScEV1YlViOUt3?=
 =?utf-8?B?dGdFZDd1b25OZFNoZCtWVWtpS2ptZ1RkUGJBSU1VeTNCdU1wSDNrVysvamg4?=
 =?utf-8?B?TTlsdmhaakZuQ1pCclh5QjhXRTZXb1gvQ3MvRWl4WklMR3k3RndxRjF6bWtw?=
 =?utf-8?B?dUhKeHFkeGZJekxEUUVSRnR5cUV6RUM4Mm1FV1BOdzlXc2IwZE5CSEhrOGE4?=
 =?utf-8?B?eTZobTdVRGc3cjNTeDlXMDZDZjJtQzFjMGIxa212TmdIb1hNUDN4dmZQQyt3?=
 =?utf-8?B?ZC9iczFEK1QzT1lwSDJwM2gzVkRUMmUxbkNQMDJpb2xpRU9VcjJ1RUlKUUZW?=
 =?utf-8?B?VGRCd2RqcFk0d0V6ejBWQVlSMTF0MDBIdTJONi9sc2oyZ1o5UUo4Vk83ckZ3?=
 =?utf-8?B?bGwyWkJtT0h4VTZxcFVjeVpkendoQmhnZndRcjVUNFpLSTc5cUhPelBCc0Ja?=
 =?utf-8?B?VXlPeFE3REp2aXpkYVBDZzdwOG43eXdWcGE5aGNvTU5zdU5PQzdNelBQSzRG?=
 =?utf-8?B?Mm1CVjV2djdHTWVscmNmSlFtMUM3VFhpZVdOcDFtbysrTE5OcTF4cmNPT2wv?=
 =?utf-8?B?Um5mVVdWdURxSVp2dmJIN0E5OUZMZGFXbWdBU1JxbFNVTXRHNHdFVDRFUkU1?=
 =?utf-8?B?bFVoMlY2SG1UWFNZcDhIUTZBUXovYWJVQytlbDhBSU1VdjNYNjlkMUE4OXBy?=
 =?utf-8?B?SC9JQkdOcXBkRFFtQjFGWDl0TUlDL0YwM3dMcmROOXVzWFh0LzFZU3BNRk1W?=
 =?utf-8?B?NUZ5REYzSGM2bFY5V211c3pqczREaU40cHA0ZWF5Z1hicGcvWHJvdTBWQjRC?=
 =?utf-8?B?NGNYVi9EUVNYbkZYTjV0L0hyZTRRVjBFQ3NKQmgxRGp0aTBBMk8rNG1zazhI?=
 =?utf-8?B?NjlRNjA5d1BDa0d6UE5MSGlZR0N0bGZzbGhCL0JNMTlUMndmQ1BmczJCOFA3?=
 =?utf-8?B?bHdvT3U2eDRJNmt0SWlxWTh5dUFESW9iUXpzemlxcTl4VnArSDVXQ2FiTGp6?=
 =?utf-8?B?RkVwSUtUKzNZbXM2VE5TVHc5VVdCYjNIa3FQcUtISEQ3SFFQaFQxcjdUM2dp?=
 =?utf-8?B?ZS9QZ0hpWmMyL3kvVE5kbUNJeGZSVzMvcG5CRVNJeDdkZHVuMnpVRXVadC82?=
 =?utf-8?B?TWJhQ01rU3VzWUVORytuYkw1M1hIVjZuUWxjVnAvWWN0UjhCVUxmWTZoNm9X?=
 =?utf-8?B?Z1FtSG5qNzh3UE1oMk1VeEZMMUFCWXJMdmh2TjIxL09YYW53Q0VlSU1iSko4?=
 =?utf-8?B?d2dZcjdJeXZpM3pMbVQwbk5DdTg0ZXlXSWZYbDQ5TnR1ZHRoUC9iRStTNUsw?=
 =?utf-8?B?RDIwN05haFFFWlhKL1dpUDdYY2l4SjlxcGIvOVY2M0lCYnVlZ2U2eC8xMVl3?=
 =?utf-8?B?bVYrMisraVltMFJnMmhqZk9IT2pVa281UHBUaUFnQ0F3NFI5L1ZjUy81M2hU?=
 =?utf-8?B?UkNhcjdvbys1Qzd6eCszMU5EWHJxcFRhbEc3MHlpZHUvSFdaODdURDRNNFpS?=
 =?utf-8?B?SVFtdTBCejRuTG51a0ZjUVI5RUpGWU0yMlRsL09ubmdINEhnWGxtcmtSV29L?=
 =?utf-8?B?K0lZeG9jZWNQYWNpOFlaWEdSTTE5czJXT1pqWE14bURMSFpyRTBkeDNFbTdW?=
 =?utf-8?B?eHVwWjRCOFV5NDM0bkhxKy9FeFdwNTBKNERDRENQVXprbWVVM2IzK2VmVTk4?=
 =?utf-8?B?dlV6ZjVROHdCYXltQWZNZlJWem9WbHVUdk9hYlR0bFRIaEUwSk9JWGRRKytu?=
 =?utf-8?B?R0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JQz/AynEf+HzRXkjeQmfzsg/D3sAcfuqQJlSQU2z951ZFPYfbwlFBLSCN/Mpy1wFAmS5ySk0L9j0DyOUUFsJ/+/Sl3maiiPjPsfRhwmQkePHgtidCJLWfmsA5VTiZ5IYWP+xksgKzaCu9r4pQqRjl6mqPRbMl66pYllxi9XeMtF2SQqjcHk2HNhe9PMjOiLHlk+6hNlXS6kQV+ZSB1gn7c1VRDBd9Dsoew8B0f93LxDK17FjRmVZyi8tXIdENhZSoqYyVKUjPuIl8oANYZe/opqogJXPlz2604SJNVWW05OH5yp5tVJI/AHx0y9LiOK7n6v7c7SbIIEzjjKKOIcE2Uk5eQyDLOw/y1ChJrAWH+IezYnmLMy5uMz9V6ZqVvmKQqB0PuJnmcS5WitgQM+RKxRpmw2qG/+Mfd8CB8kqAMPA16OTr0vaNpiW65QR7ZzgS7CuROFmQB/8upOWwW6vvxtOUNhvCyOqBfaBQQ7wbsD3MURQ1PeXEz5gODl18WN0rCzxQbR6TBHS9s5v5CbvCfrvqRq0kXObrNO+AGsyFf4+vqcVpj/HQ9HOwfPIJgciDYLPKydMa70DkrSicB/aj7i3QZPN6mxEc6yyIWKaR951h6KLFx6nIdTgQIx5n1caOuUD5y/1msPs39shoxL/FsAKIY+Z7vxsQLZ+ZDBTrf9+/eelNdgLzauQK41O6t1Vnk0W91y/Y7EHKTj0sc4vYnuEAIgzdo9wLivH/ZQ14X2HCZygE8U7NR2a2fNUpnz7h8IYXFSlxp+HF82Nm9KWjZDzgEOvh8Ny05Kfqw1/v071HyRnffsdSQGoW9WuP1lwNMmzlBfr6clKMnPxTSYxEupgoBQQmfIdykMoYdBgD9IEnXXbN7OYf64Yrq86PBBz
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcf5c7fc-7e2a-403d-2f15-08db875add16
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 06:47:32.8764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y51Lbhqgc2ilWXRjjynv7Ant6nwjtdJzfclJfSJl71vsRyGfpEF5+FcsLJEafgnCR6v1LqeW/M2mnz5hBrSVLbJt/0NSqaDzrkcyCmFeOsQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9682
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGkgSWxwbywNCg0KPiBIZXJlIGlzIGEgc2VyaWVzIHdpdGggc29tZSBmaXhlcyBhbmQgY2xlYW51
cHMgdG8gcmVzY3RybCBzZWxmdGVzdHMuDQo+IA0KPiB2NToNCj4gLSBJbXByb3ZlIGNoYW5nZWxv
Z3MNCj4gLSBDbG9zZSBmZF9sbSBvbmx5IGluIGNhdF92YWwoKQ0KPiAtIEltcHJvdmUgdW5tb3Vu
dCBlcnJvciBoYW5kbGluZw0KPiANCg0KSSByZXZpZXdlZCB0aGlzIHBhdGNoIHNlcmllcywNCmFu
ZCByYW4gcmVzY3RybCBzZWxmdGVzdCBvbiBJbnRlbChSKSBYZW9uKFIpIEdvbGQgNjI1NCBDUFUs
IA0KdGhleSBsb29rIGdvb2QuDQoNCjxUZXN0ZWQtYnk6dGFuLnNoYW9wZW5nQGpwLmZ1aml0c3Uu
Y29tPg0KPFJldmlld2VkLWJ5OnRhbi5zaGFvcGVuZ0BqcC5mdWppdHN1LmNvbT4NCg==
