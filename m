Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768525EBE88
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Sep 2022 11:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbiI0J0c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Sep 2022 05:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbiI0J0M (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Sep 2022 05:26:12 -0400
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com [216.71.156.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F126587FA5
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Sep 2022 02:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1664270730; x=1695806730;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=usJbmXFSWeNd6cjsfJKDfwLcqBX5ojYINGEQP9b9UQw=;
  b=d6eoUpct+YhTEjYWVUFMkxGqLwVgELfpIRQT7PWdkb/B3rMPt0p+NSwA
   NLKEnVIEUzqwj8I7rcVPnH/bM0eAzDOpNQge+V2a4tVNjD0CWPOc/Dk/v
   xbF6zUixYax5ttSz4q+YKTs04wqSneyOGvMK+cXjroIxaCCfNJI0P+R2s
   YVM1GJ0A1m1EVD1JAxg8jvf+YNjgFLbOCFiKKwJ9dV9b7wqXgFZUH/kWU
   yeGTOww5vDJ5wv1ksIJC4swaXphh9iG4mlEdikL5mXZKEVjCRzPBX0ncf
   2cwq1jh7OPswtVcN80eF/qnkfum3t3W3Ys4yOyNo6Kwkc9iGdCNwGTQNp
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="66277418"
X-IronPort-AV: E=Sophos;i="5.93,348,1654527600"; 
   d="scan'208";a="66277418"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 18:01:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f13Y42rtIucz7q668LQcYsn3M4G/5UrptN0pBfczjKVDMGscpvQBdBThGyrK29hyURr7C7H9p1zlC1CXLZ6UE6bHRbYJqZyRxmdq2D4k3JWqlc75DXls7vPxz59ag9jy7uPBw7w8PIdUSSpg+uHXUpQNPpzIDmJiOZunRoqmGOgDkH8iMdSXqrp9M28AvLL+yCETBjQ97fkcmtoZZXddKn3RgKtT69e9ptG3BNW7wmjgvdR1zKS1z+Qk4pmfSb1QuiBwL0oMQkWNfxOSNlwF6tdf+clZXHmaaNLP9a4XbZ16pt8ALR7gyIEY54HlFUdUkkI/EWzgtxy/sRs1sGbxJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usJbmXFSWeNd6cjsfJKDfwLcqBX5ojYINGEQP9b9UQw=;
 b=YDoPI7EuBdXQKliW9QU7u6cD8Pwast0pOQwxoKRjgE47h/7CfeFtGuiQhI7NT5q1hoqMmOXDSaS1xQkOcAlWEL9BPvU63UB80bVbCUH0Hrhz/5JaeCksrExu/qmVYtW/6lO3AiYK45D/CDIgoT9peRlOcGNNr8gL9ji/DJqoJ1XqglBnMOCsWuLxYyGaUVVGJTkcQJ0zgPXZeCMs9rRa3ImiKBxEbN3f6kpc8L/yz0sVua7GMif5P6SI81A65qQ148WMsn5m39aB0KpRvGByPPufMeVjw++pv9ewAkea0yXfKbURHcf3+iAaUTuS7lvbvCBR+caNBa4XjuMcfaKjJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by OSZPR01MB6229.jpnprd01.prod.outlook.com (2603:1096:604:ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 09:01:23 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::b0c7:c573:a888:8099]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::b0c7:c573:a888:8099%5]) with mapi id 15.20.5654.026; Tue, 27 Sep 2022
 09:01:23 +0000
From:   "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>
To:     'Reinette Chatre' <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH 1/5] selftests/resctrl: Clear unused initalization code in
 MBM tests
Thread-Topic: [PATCH 1/5] selftests/resctrl: Clear unused initalization code
 in MBM tests
Thread-Index: AQHYx90ANVYDcoa1XUasHigKIwI5B63rxheAgAc+ARA=
Date:   Tue, 27 Sep 2022 09:01:23 +0000
Message-ID: <TYAPR01MB63300E751096E8F613CC7F398B559@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20220914015147.3071025-1-tan.shaopeng@jp.fujitsu.com>
 <20220914015147.3071025-2-tan.shaopeng@jp.fujitsu.com>
 <24cbb6e4-d853-6c7e-cffc-daa7412d1eab@intel.com>
In-Reply-To: <24cbb6e4-d853-6c7e-cffc-daa7412d1eab@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjItMDktMjdUMDg6MTk6?=
 =?utf-8?B?NTBaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD02NzAxYWQwOS0yMGE3LTQ5NjIt?=
 =?utf-8?B?YTZhNi1mN2FmMWY2YTIyMTY7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: c1585a76715c4ec8b4bcdb1461acd913
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|OSZPR01MB6229:EE_
x-ms-office365-filtering-correlation-id: 06e7f7cb-3add-4113-7a61-08daa066da4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UprgnAoVmyLVGYnTU+THqQJurikirnatwKUmMc4vQmwsGh+cspmPXnvZcZU7s0zzBQQ0W7kU1u/9dSi8a8q4iL3dpQ1MGChgdqmpOXtoT+VMWwtUqn6e9GlMGCVUxK+4qIuNUz/C+U4GMRIAU4nUyoSG4yiV+IkTTg2Gcx/XO966tEdzXT6ctrjU38e7fIohBOJOfDEpK1UsCAaRErPgBIlUO4ADyRSxKWJZKwzSQkQQxJfIP/O6hsLPE4p/1U3nXXkLFlbWg+h1S6LQ7ReBAbbgha6RIOTR9XLfXE7spwC+Rgk1butu3JPpraY/EN9hqu4ZOaUTA535xtcIaYQMrAR/I+kBvOh7hBoblt2NpIL2kZilBC+hO4AE7Gty5fQdhYSY2WJSY15Ba3/Sde2nwkHZr8GE6E1RBteWXL8TUWC+NdtoN5ETvKmHAl9zhFnFbmLY9e6zZtyOCG2ZrAZT7be4hqEtVbnMbunIe3Z3cOAD8cqL3bNkDZaXIe4+a3J8bkx+guEarWckbKzrX+5W/JnbA3nWq14/VpkGR0wGaLE4ZBsN2+dFbAXFNhIIZfnusxRkmVoGgOfnzln8bhseFk7ZKKOoLok5ZlkkC+M80+UUqTomLYMJA1jiwXLMPoBA64cy/lVKRRb1DNumfTWlhUmfVT3EkF6WaY80d/CrCipJRvTOkni7LADc7ZrFz82hNMOUJh6Z8/jqaBV4Kp04W1XgJXV1G/tNDVd/V6Jo85QSAis7tYE3n4qaijRW9tJVuJAQxCHKz+zixN8SkEbwA6Yf2ZWAvGo4+XKdkMxWoC4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(1590799012)(451199015)(55016003)(83380400001)(186003)(122000001)(38070700005)(82960400001)(38100700002)(8676002)(4326008)(64756008)(66446008)(54906003)(316002)(2906002)(76116006)(41300700001)(5660300002)(66476007)(26005)(52536014)(6506007)(53546011)(8936002)(71200400001)(66946007)(9686003)(110136005)(66556008)(7696005)(478600001)(33656002)(85182001)(1580799009)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTl5VkQvWUpqWXROTGMxVWJBbkpjTUNQMTBsWmFLMkxTUkdvWmYvajZ3eFlU?=
 =?utf-8?B?T0tMZzdCcit4VnM4T0dmTU9xaFNmczlsajBQSmRiN2pVd3NOcmEzZkNBcGho?=
 =?utf-8?B?KzdNdjFnek91SzdxaXdDZktRNlZHZ1lUV1U2R3lHZTkrZnFiMFcwUTQwWFY3?=
 =?utf-8?B?bXpKZGdTVE5pQ3V3Q29pQ2J2NXM4OGprY2pSZ3NGQm9VTnNUY2ZpZ1BsQTVB?=
 =?utf-8?B?cExUNWlDN1ZzbFA3MDZ2a0MyOENvaTdlV0Uvd3h2WGJia29DLys0ODltRTU2?=
 =?utf-8?B?cnhEUkJ2ZHFkY09zSU5UNTU3NFNGTVVBdEw3WlpFb0hGczVTT0FVRmVKZFNQ?=
 =?utf-8?B?NGFPazl4V0RiRlJVTk9BZGxxK04yZ3RJbzdZbDlJM3dXUkk3d3dTb29KZEdp?=
 =?utf-8?B?N1ZuVG9xT0hpOXdkOFA1K1k2UUg0MnpYQjQxWXl2M1ZIV0pyeTl6Z2FpaHJG?=
 =?utf-8?B?Z0UzUWsrNGhoa210SjB6YjlJbjBqakpiU0pCbmNGRXNadGJsREpLMERFTG50?=
 =?utf-8?B?SnhGeUU1Q3g1VXZiS2dYaDRwUjdjdXR2NGdYemF5OVZWWDkxOU01QTAxeTB1?=
 =?utf-8?B?cmpHako2YktYTjltNm5WRHplMVBSb3dKaGw4YlNpRHZhN0FxYjU5ZlV5SWhi?=
 =?utf-8?B?N0VSM0IxeVE2Y1hjeGR0N09IUnExa0xTYVhmMURkalh4dW81VHZ3Q2RDaXJI?=
 =?utf-8?B?Qnl2TFhZdVdLTzg4bjFmdGdDWG1acjU5djI5VTFlcG0rNFdiMUh2R1Uzd0Jm?=
 =?utf-8?B?QjFHZDZadjNCaFpYZy9EdlNnV2ZsSStzbG4wcVRjb2oxaXM1bXR2RUJ0RC9Q?=
 =?utf-8?B?S1B4M2Vqd09uRWp2M295OUgxUDJQT0MrbjF5ZU10eXFxeGRvTHUwemlrZTJQ?=
 =?utf-8?B?V1l1WmhVelV6RjVTZXMxWFJIT1VGSm12UDNUbzBxOEM2WWFCakFVaWFWd1Ry?=
 =?utf-8?B?WW1mcys4MGFDVzlHenY4SDQ4OUtlUFFyVzlmVUVoSDVWZ2JXTk9selJoclZk?=
 =?utf-8?B?RUdLRkxTdXp1MS9GaGdjQ3dUaS95N05OV3FIUlZaSllFbnUyWW9nSzUzbXps?=
 =?utf-8?B?aHk2bVNDZysyNFlqUHp6S0pMVnlMK1c5eWtlT0NTczgyV3IwRkNmaDYzMmtS?=
 =?utf-8?B?SlVoZUU1YkdZQno5UE5Qbk9GK1BIU210L3BoaCtMWnBkY0RyM2V1Y20yUlJt?=
 =?utf-8?B?YmdpRElhOXVtcU5qLzVocFk3dnVlMUZyOS9NbW54VDZ0bmZyWTJJckJPMXdV?=
 =?utf-8?B?M28wcXI5OUdoakptTVZnWjlvRGRrUTZXZEhkd1A3a2JLWlZkQmtHSGhTcUtS?=
 =?utf-8?B?Q2w5eStZZHFCT0JQay9OWWdZN3RtOHh2c1lQekxyNC9RaUd5NzU5QnNKSWlR?=
 =?utf-8?B?VjNiZnR3MDJQM21WcW9yVzJ4VTgxRUlvNEZpcGtROWhSSHlISSt0cnF0Y0NZ?=
 =?utf-8?B?VWExV1JRWWNlVFZhZzc1TjJFNVNtMHMwV2VrT0M0VWx2NzJUczdlaGY0dm9Y?=
 =?utf-8?B?R1NkenZHUi9ybjFNOWR1RFUxN3ppaHMwVWtldXdtWWVrRk1xYkVQeDBIL21q?=
 =?utf-8?B?MTN3MytxemZUTWFWbVk3ODFuQTdiR0pNTm4wdm9oZEtNYVlNdElDblo3VUd4?=
 =?utf-8?B?TWZvN3JKNWVyNis0U2pkcitMSUtUcG93NFlFTDNnQjIyTHBjZnhLQlpnS2RQ?=
 =?utf-8?B?NTA0QjlQbzZpbkFvWGlDUGFkZXlkK0dURGZuOWJmMWVyRFZqUHB1QzdaQUxV?=
 =?utf-8?B?dno3dTlZOWZzRW1CMkZaN1IyYlV4UGhiaXNxODQrYlRncGpSWVlnNXBzeFYz?=
 =?utf-8?B?eXZQbUtiTHNlckFYakRrWkRpcVZtQmJrY2xlS0NKcFBIYWplMTA4L045ejNK?=
 =?utf-8?B?cUFMN0xRM0ZwNGdUa0plVHZhOGZ1RXEwUk1DbFRSL0FpVWVnSmFoWlc1QWVk?=
 =?utf-8?B?ZDNtT0N4dm5GS3hNV1pVRm42TWFxYk93U2NKNVlJMGVwWlhscWRMMTJHYWFq?=
 =?utf-8?B?UytzSFVEQThpaU9ZNWtRRmJaWDJwQWNjalNwTHhzK3VWUWFwL29KaUpHMy80?=
 =?utf-8?B?TFp2L3MzZ0prY2RhNWZYdkFMT2hOWk11dFNCc3NTdDhuQVZwL2NPS0grczNT?=
 =?utf-8?B?VFgwZHh2d2NvNnZjc1U5UDlCd1A3Tjc4VnEyNmE3cHFPWUQ2YlM2dUtyVUNI?=
 =?utf-8?B?RVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e7f7cb-3add-4113-7a61-08daa066da4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 09:01:23.5275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J9kyaNYj6JvWRzUhmA94tMXG4ukWbEeh5UKCv6yTHu2KXaU2rsMVY4aqcNwSj0Pdj/GcFznAyFo4ahnViupI6kz9oPlXeQTCqlEtYrEGFqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6229
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGkgUmVpbmV0dGUsDQoNCj4gKHR5cG8gaW4gU3ViamVjdDogaW5pdGFsaXphdGlvbiAtPiBpbml0
aWFsaXphdGlvbikNCg0KVGhhbmtzLg0KDQo+IE9uIDkvMTMvMjAyMiA2OjUxIFBNLCBTaGFvcGVu
ZyBUYW4gd3JvdGU6DQo+ID4gVGhlcmUgaXMgYSBjb21tZW50ICJTZXQgdXAgc2hlbWF0YSB3aXRo
IDEwMCUgYWxsb2NhdGlvbiBvbiB0aGUgZmlyc3QgcnVuIg0KPiA+IGluIGZ1bmN0aW9uIG1ibV9z
ZXR1cCgpLCBidXQgdGhlIGNvbmRpdGlvbiAibnVtX29mX3J1bnMgPT0gMCIgd2lsbA0KPiA+IG5l
dmVyIGJlIG1ldCBhbmQgd3JpdGVfc2NoZW1hdGEoKSB3aWxsIG5ldmVyIGJlIGNhbGxlZCB0byBz
ZXQgc2NoZW1hdGENCj4gPiB0byAxMDAlLg0KPiANCj4gVGhhbmtzIGZvciBjYXRjaGluZyB0aGlz
Lg0KPiANCj4gPg0KPiA+IFNpbmNlIHVtb3VudC9tb3VudCByZXNjdHJsIGZpbGUgc3lzdGVtIGlz
IHJ1biBvbiBlYWNoIHJlc2N0cmwgdGVzdCwgYXQNCj4gPiB0aGUgc2FtZSB0aW1lIHRoZSBkZWZh
dWx0IHNjaGVtYXRhIHdpbGwgYWxzbyBiZSBzZXQgdG8gMTAwJS4NCj4gDQo+IFRoaXMgaXMgdGhl
IGNhc2Ugd2hlbiBhIHRlc3QgaXMgcnVuIHdpdGggc3RydWN0DQo+IHJlc2N0cmxfdmFsX3BhcmFt
LT5tdW1fcmVzY3RybGZzID09IDEsIGJ1dCBpZiB0aGUgdGVzdCBpcyBydW4gd2l0aCBzdHJ1Y3QN
Cj4gcmVzY3RybF92YWxfcGFyYW0tPm11bV9yZXNjdHJsZnMgPT0gMCB0aGVuIHJlc2N0cmwgZmls
ZXN5c3RlbSB3aWxsIG5vdCBiZQ0KPiByZW1vdW50ZWQuDQo+IA0KPiBJIGRvIHRoaW5rIHRoYXQg
dGhpcyBzZXR1cCBmdW5jdGlvbiBzaG91bGQgc3VwcG9ydCBib3RoIGNhc2VzLg0KDQpJbiBtYm0g
dGVzdChtYm1fdGVzdC5jKSwgcmVzY3RybF92YWxfcGFyYW0ubXVtX3Jlc2N0cmxmcyBpcyBzZXQg
dG8gMSBhbmQgbmV2ZXIgYmUgY2hhbmdlZCwNCmFuZCB1bW91bnQvbW91bnQgcmVzY3RybCBmaWxl
IHN5c3RlbSBpcyBhbHdheXMgZXhlY3V0ZWQuDQpTbyBpdCBpcyBub3QgbmVjZXNzYXJ5IHRvIHJ1
biAiaWYgKG51bV9vZl9ydW5zID09IDApIi4NCg0KPiA+DQo+ID4gQ2xlYXIgdW51c2VkIGluaXRp
YWxpemF0aW9uIGNvZGUgaW4gTUJNIHRlc3QsIHN1Y2ggYXMgQ01UIHRlc3QuDQo+IA0KPiBDb3Vs
ZCB0aGUgaW5pdGlhbGl6YXRpb24gY29kZSBiZSBmaXhlZCBpbnN0ZWFkIHRvIGluY3JlbWVudCB0
aGUgbnVtYmVyIG9mIHJ1bnMNCj4gbGF0ZXIsIHNpbWlsYXIgdG8gY2F0X3NldHVwKCk/DQoNCklu
IGNhdCB0ZXN0KGNhdF90ZXN0LmMpLCByZXNjdHJsX3ZhbF9wYXJhbS5tdW1fcmVzY3RybGZzIGlz
IHNldCB0byAwLA0KYW5kIGNhdCB0ZXN0IG5lZWQgdG8gcmVzZXQgc2NoZW1hdGEgYnkgd3JpdGVf
c2NoZW1hdGEoKS4NCk1CTSBhbmQgQ01UIGFyZSBtb25pdG9yaW5nIHRlc3QsIGFuZCB0aGVpciBy
ZXNjdHJsX3ZhbF9wYXJhbS5tdW1fcmVzY3RybGZzIGlzIHNldCB0byAxLA0KSSB0aGluayBpdCBp
cyBiZXR0ZXIgdG8gbWFrZSBtYm1fc2V0dXAoKSBzaW1pbGFyIHRvIGNtdF9zZXR1cCgpIC4NCg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2hhb3BlbmcgVGFuIDx0YW4uc2hhb3BlbmdAanAuZnVq
aXRzdS5jb20+DQo+ID4gLS0tDQo+ID4gIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwv
bWJtX3Rlc3QuYyB8IDE3ICsrKysrKy0tLS0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA2
IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL3Rv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwvbWJtX3Rlc3QuYw0KPiA+IGIvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvcmVzY3RybC9tYm1fdGVzdC5jDQo+ID4gaW5kZXggODM5MmU1YzU1ZWQw
Li4zOGEzYjNhZDFjNzYgMTAwNjQ0DQo+ID4gLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
cmVzY3RybC9tYm1fdGVzdC5jDQo+ID4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVz
Y3RybC9tYm1fdGVzdC5jDQo+ID4gQEAgLTg5LDI0ICs4OSwxOSBAQCBzdGF0aWMgaW50IGNoZWNr
X3Jlc3VsdHMoaW50IHNwYW4pICBzdGF0aWMgaW50DQo+ID4gbWJtX3NldHVwKGludCBudW0sIC4u
LikgIHsNCj4gPiAgCXN0cnVjdCByZXNjdHJsX3ZhbF9wYXJhbSAqcDsNCj4gPiAtCXN0YXRpYyBp
bnQgbnVtX29mX3J1bnM7DQo+ID4gIAl2YV9saXN0IHBhcmFtOw0KPiA+IC0JaW50IHJldCA9IDA7
DQo+ID4gLQ0KPiA+IC0JLyogUnVuIE5VTV9PRl9SVU5TIHRpbWVzICovDQo+ID4gLQlpZiAobnVt
X29mX3J1bnMrKyA+PSBOVU1fT0ZfUlVOUykNCj4gPiAtCQlyZXR1cm4gLTE7DQo+ID4NCj4gPiAg
CXZhX3N0YXJ0KHBhcmFtLCBudW0pOw0KPiA+ICAJcCA9IHZhX2FyZyhwYXJhbSwgc3RydWN0IHJl
c2N0cmxfdmFsX3BhcmFtICopOw0KPiA+ICAJdmFfZW5kKHBhcmFtKTsNCj4gPg0KPiA+IC0JLyog
U2V0IHVwIHNoZW1hdGEgd2l0aCAxMDAlIGFsbG9jYXRpb24gb24gdGhlIGZpcnN0IHJ1bi4gKi8N
Cj4gPiAtCWlmIChudW1fb2ZfcnVucyA9PSAwKQ0KPiA+IC0JCXJldCA9IHdyaXRlX3NjaGVtYXRh
KHAtPmN0cmxncnAsICIxMDAiLCBwLT5jcHVfbm8sDQo+ID4gLQkJCQkgICAgIHAtPnJlc2N0cmxf
dmFsKTsNCj4gPiArCS8qIFJ1biBOVU1fT0ZfUlVOUyB0aW1lcyAqLw0KPiA+ICsJaWYgKHAtPm51
bV9vZl9ydW5zID49IE5VTV9PRl9SVU5TKQ0KPiA+ICsJCXJldHVybiAtMTsNCj4gDQo+IFlvdSBz
ZWVtIHRvIGJlIGZpeGluZyB0d28gYnVncyBpbiB0aGlzIHBhdGNoLCB0aGUgZmlyc3QgaXMgZGVz
Y3JpYmVkIGluIHRoZQ0KPiBjb21taXQgbWVzc2FnZSBhbmQgdGhlIHNlY29uZCBpcyB0byB1c2Ug
cC0+bnVtX29mX3J1bnMgaW5zdGVhZCBvZiB0aGUNCj4gbG9jYWwgbnVtX29mX3J1bnMuIEFsdGhv
dWdoLCBhZnRlciBhIHF1aWNrIGxvb2sgSSBjYW5ub3Qgc2VlIGlmIHN0cnVjdA0KPiByZXNjdHJs
X3ZhbF9wYXJhbS0+bnVtX29mX3J1bnMgaXMgdXNlZCBhbnl3aGVyZS4gQ291bGQgeW91IHBsZWFz
ZSBhZGQNCj4gZGVzY3JpcHRpb24gb2YgdGhlc2UgY2hhbmdlcyB0byB0aGUgY2hhbmdlbG9nPw0K
DQpZb3VyIG9ic2VydmF0aW9uIGlzIHJpZ2h0Lg0KSSB3aWxsIGFkZCBkZXNjcmlwdGlvbiBvZiBu
dW1fb2ZfcnVucyB0byB0aGUgY2hhbmdlbG9nIGluIHRoZSBuZXh0IHZlcnNpb24uDQoNCkJlc3Qg
UmVnYXJkcywNClNoYW9wZW5nDQoNCj4gPiArDQo+ID4gKwlwLT5udW1fb2ZfcnVucysrOw0KPiA+
DQo+ID4gLQlyZXR1cm4gcmV0Ow0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gIH0NCj4gPg0KPiA+ICB2
b2lkIG1ibV90ZXN0X2NsZWFudXAodm9pZCkNCj4gDQo+IFRoYW5rIHlvdQ0KPiANCj4gUmVpbmV0
dGUNCg==
