Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E275C50FA91
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Apr 2022 12:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348955AbiDZKft (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Apr 2022 06:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349078AbiDZKeY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Apr 2022 06:34:24 -0400
X-Greylist: delayed 124 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 26 Apr 2022 03:12:51 PDT
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com [68.232.152.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0EC70923
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Apr 2022 03:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1650967973; x=1682503973;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4SwbGQ7e9Hd2YquKn27jHcI6JK7qVF2Q7hTOTMlPr7A=;
  b=Ns73gnsBLrSZL3f1gISlOW+gmd1x61br7weHtKYVRl9kYVHbSlIsBKh8
   M9tLd5CH1q/FdzW8/oCm+IDwCJ/35vrqeoBVOiHudqlMXk2czIznF+2cq
   6oiICIU7osY/Qnqu/S0UONnA48T11aktS2am4hiIjsYzGxtfbMONVGqxD
   oEKtB2gY9utBQZTtye02kY+F/UirHk+3g8DrFOvyZPItaD3IKIgvR1GV/
   O/vXi6b4kTtebVAGRGYW6TRN/70RSyo00Qs1qmuNsY2efCk8/JEyk9axR
   LQae4fzi+VjOS55O2hcehZG25/rC+H5RdyOkI9rCeFI/uf4jpKFzqUuvN
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="62951172"
X-IronPort-AV: E=Sophos;i="5.90,290,1643641200"; 
   d="scan'208";a="62951172"
Received: from mail-tycjpn01lp2172.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.172])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 19:09:34 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNqhugz4YNp0DEmvLqvMJazfP9JqyuJOdzMxqXRe4xt0hq4a4u6tYbn4PsMjJcpUoZHQC0ZyGckw8pTrxxZ697ZMnHYCl8U9P8QvaTr5gfZ1DEWMSGpCPGvyS1ITx0BKUHUODAKlWJop9drx9s4onWZ3fddfrK8BAySJzGLoRTrcd/vt0/X9wp0oXyAqbE2Ghlq+pK5Td/gku87iywdcxkNaOJEFY0aRSVIEP+Rs6YW/xOt6+6Oqt2Ec1xgdHOYD43Y12LtWM3uRmU7EHwVi4G90FRjWbUMKT+SpEGIS2+XttmcunE/264Z3pUovfIcVE/mwcnvwJR6HjsYK/I/cDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SwbGQ7e9Hd2YquKn27jHcI6JK7qVF2Q7hTOTMlPr7A=;
 b=E6UlWX7AMyQ5dwsLaMsea50ALWROzffGEC4krAvQan3snjiPuJ1ng8u6QsorVA5sXQ/xLb7oA4HOLK5T7QW6CQhqv+xnteWlRciwj93M9uUsm3g/ZIJy9PytNrc48bShkKjvtgAuKXF9wlyojkzKR3JoDZOtX8sYwu6ylT1eZRFTcY4atUGvbNt1n+5RCGfjunjClkGyrSN8ZK7sf6BX85yUD27cf0Tm2nfQWVfSPrfB+S8ZfKS/7mmXGT6Oe43c7JFdKF+j6OKYaiPEB41kqmyFetnpcOzkmUV6A60uy6Us4ZKVJLDvS3NGXnv4q0fEoA5nZUHDLGkmRore8g/25A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SwbGQ7e9Hd2YquKn27jHcI6JK7qVF2Q7hTOTMlPr7A=;
 b=hYCLYaP4Xa+57VmHyemn+J7aWEQRPo4oRZZ29SBQRjMjJViInmizZ0Twrx5NqWrSk+/IC9R3sMSTuNN32axLDrQSs02QvRl2OuwG8PMdMeGnDqSqQph3RxGb+mA4TFP26CmC105WzbejkNzmfbkyEnf/b+mZxSRCFoiGFdfcfRI=
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TY2PR01MB2505.jpnprd01.prod.outlook.com (2603:1096:404:71::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.18; Tue, 26 Apr
 2022 10:09:26 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::6135:4a6:edae:8c07]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::6135:4a6:edae:8c07%8]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 10:09:26 +0000
From:   "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>
To:     'Reinette Chatre' <reinette.chatre@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH v5 0/2] selftests/resctrl: Print a message if the result
 of MBM&CMT tests is failed on Intel CPU
Thread-Topic: [PATCH v5 0/2] selftests/resctrl: Print a message if the result
 of MBM&CMT tests is failed on Intel CPU
Thread-Index: AQHYPo2ctlSvEep3V0CWSd3qIyoutqzWiKKAgCrOngCAABwsAIAABakAgAC0ymA=
Date:   Tue, 26 Apr 2022 10:09:26 +0000
Message-ID: <TYAPR01MB633004E6DCC7476F047FF17A8BFB9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20220323080928.1586408-1-tan.shaopeng@jp.fujitsu.com>
 <1920a6b6-bc1b-31db-4c1b-efccc189daa5@linuxfoundation.org>
 <9a1d0420-d99a-e4a8-c6de-729b56e9c1f0@intel.com>
 <488995ee-2a00-321c-126f-8ed7f8b82635@linuxfoundation.org>
 <63386b10-fcc4-0672-4e0e-5d68f8c3b422@intel.com>
In-Reply-To: <63386b10-fcc4-0672-4e0e-5d68f8c3b422@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjItMDQtMjZUMTA6MDc6?=
 =?utf-8?B?NTJaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD1jMjlhNDY3Zi02MDMwLTQyNGYt?=
 =?utf-8?B?ODcwZi02OThhZTAzNGQ5OTU7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56a61601-b0bf-408a-517f-08da276cd84a
x-ms-traffictypediagnostic: TY2PR01MB2505:EE_
x-microsoft-antispam-prvs: <TY2PR01MB25051D2038B69DF55D0B98FF8BFB9@TY2PR01MB2505.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qI6slAT+jir4VHEivYBVMm8cW8voGHwBeqDHP9hzMvaL7XbRyNzbad/MEcunBZqiuUCNYOpG2UR7pV0qooQTFk1RO8f1g2Im3ZxiCC0rmQtB1yTI4902jDxYvIl5Qqh3T61LjtCHjDWBFZWdFG5tXwI07Kf8Hc0dQ7Y4wodvNQja0QRb8pj87EfxlNu58HO/iXuIC4ZjbvQ7JoM9JWdJz/ZPi84D6CL4+JsRR0+C1MFshBUIiRmi5/mSU008I2S7EhzUKJY+QWJJaCkMp88Rsc8DAkiYAG0l9OYn1sUHPhiqD+BSkAvJM2bGmZjHz4IFiqOTsABXNAEPYhlN+ZB7JBjMP1CpANtXL8m03958SHUYnucE+tcbgpCf1M6AYe+fGdZx4j7YcyStaTHfCYxrGgiyKNeE0oiYYDZSq6FjDY+zTdrAfiPB72zTuqlAkaRLuYKUiK7XcEIpvrscoR5A/ulqcfECvkq4tj5HT28pBiDxJgVqtJJLAAbOh7OG6wazZQOvAlmGOumCSNQNoLm3u8v89ZlL8ecDv96GmmHxPFw97dINUOoAdoya6FdVapSxlnd7395I2rrD2tHbDz8tlQ8v8QMm9+p7IcTebTm2AgeIbo3VdWyQLbygXW2YszuDL6tnDMAv5C5k6RM+gaNb/KTR3ENmlwCXBnQy1NXkW/ZqcZckXDTuNxxE7Xqt9plgPuS/dvx8aHvwTnsiZOcf8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55016003)(5660300002)(122000001)(38070700005)(86362001)(82960400001)(6506007)(7696005)(9686003)(53546011)(316002)(71200400001)(26005)(186003)(54906003)(508600001)(110136005)(52536014)(8936002)(2906002)(4744005)(4326008)(8676002)(76116006)(66946007)(66476007)(66556008)(66446008)(85182001)(33656002)(64756008)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NlNPUmRjd3ZRL2Q0aTdLdE5jMk1xSGZRdi9pRlF6Sm9scHpVODlaM04wVHpV?=
 =?utf-8?B?ckpvUWs5R3graTZQQ2ZjZnNwYzZXSDlLREdhNzU3YTFKaGN2R2F5OWo2Rjly?=
 =?utf-8?B?UUlzYzZCb2JUTEVtbnpnSnRoclZ0ei9BbUN4WTd1Ky9xTFdsdmtGaTViUDMr?=
 =?utf-8?B?V0txdVVKZnVwL21aQmxlVUE3VHIrbkdrM3VKbktLYzN5ZUgzNnJVdUljWS9B?=
 =?utf-8?B?dUgvTldNeHV2RkMrcDZ3VE9SYjRLSEVHTVJVSFQ2VHUrRVZHTDdCNTR1eVBN?=
 =?utf-8?B?VjU2ZzN1SHhBZWNGTWZTM1JPZks4K2YvTG9ZbkNySGs2ci9wem13eGMydTUr?=
 =?utf-8?B?dDY5RGR2QVh1ZGFKM3VBYlJNc2s4QWx1eGVTbTFYS3AzVlJkdzVrMEJtLzJL?=
 =?utf-8?B?K2dtd01SSXBmcy9ISHM1dFVQdDY1SzQ0SnlHcTJhSm1mN0NGK1BlNGhsMzlh?=
 =?utf-8?B?bUlFODdxcUJtRTRlYXllTW1KbHpwM1RId0UwWUZaUVYvSnBzbEcwRWVYY245?=
 =?utf-8?B?V3RoYjk3bCtmTlN1QVVjM25zT3RWZU1kY25pMlRxbmJKZHN4RXgxZ3pYTGdh?=
 =?utf-8?B?TjkwUktidkw5QUFpUG9ndU9PSmFhUVAveW9PVWF5UGpYZlhHdUJ4bmx2ejZ2?=
 =?utf-8?B?azVXTTh2VjJkN0R1SVBWZkFSdHg0cVZNNmJJNlVXbEVtUmhSeUZRa3k4aXE5?=
 =?utf-8?B?cll3a0lxUWpudnlUSHdPYm1oTzkvWEIwSnJCM2c5bWhVVUMxeDhybzFXOGYv?=
 =?utf-8?B?bzNGWldDM2NvVkpJRndoWEgyNVAyVzBuMThzdTlHRDNtV1RQcVdUT1VYcXlv?=
 =?utf-8?B?aXNBNllIbzVwRnBEcU5Nem0rdTJ3Q2NTdC84ZzJUNlNBdTRkeVVXRzQzSWY5?=
 =?utf-8?B?ODBtV0tpankxUEdWeVNZQ3orcXg1OVMwQlZ2RkFvby8zOHJGcXVmTUpDY1pS?=
 =?utf-8?B?VG9nenUya3ZBSGl4bk50eW1Od20xMndyaCtwN0FUODFQRUlDMi9RRGQwRDRK?=
 =?utf-8?B?ZGI0QWlCUzhaOGtoa3M2Nld3dDlXK2FNUTdwM2ZIS1Q4NEMrcTA1WDdyK0pU?=
 =?utf-8?B?Wm5IOTV6UjBDVmZla3JXeml5UjhRTzREM3IwbCtNTHg4WWlxOTZkcmpvRWtp?=
 =?utf-8?B?OWZuRnZQUFJ1QUhENDBxeC9uVE4zMCtITHNncTBaN1p6eUlrZmFkQ014emhS?=
 =?utf-8?B?alJWTmNWTDZtU2RzTnFXcFRuUEJmVVZ5dy9TZzVuWStrR1hPYkdtdVJNZHBB?=
 =?utf-8?B?bUFsaitqa2xGZnBheXM4WWQrMWxoL05TSTB2aXJuTkp3cFRLc3d3bFI4MlVE?=
 =?utf-8?B?bTNUb1RaSnRZT1dSSVRLS1NiSnN0Q0Y2MnRRY00xQXJsVlJvbXkzV0dnNDMv?=
 =?utf-8?B?SzIyYXRjMHZRdEtCWkRpbThDNEZyWmlsVW1HRXFYNmg2QVJ5ekR2WGFBZHZq?=
 =?utf-8?B?ZlhrZkVXQmd6N3A1TGVrQml5eWh2ay85WWw2SnRZTEZkK3pqSmN4MGQxRncr?=
 =?utf-8?B?REtjanpQcWdWRENFeWM1U3ZmNDhJdjlWajBjZm0vbEVZVmR2Yzk0bWh6and1?=
 =?utf-8?B?Z0g0TTlKQWtjZzdYc2xNN2dKVnUwK0UwTXJwRXRtVzlweW5PdGlxbWdZMTFK?=
 =?utf-8?B?azNmTXVuZW9DUEJaYTY3R3BTeE9ZM2Q0VnZsUk5tOVYyLzJPQVRlSFlYc2E4?=
 =?utf-8?B?ZGRjb3NGN0VMbGh4WUloZ0NzQ05EN1JTNDJiVGhnTnJqcnZvczBRT0J2eXU4?=
 =?utf-8?B?dG1La0dHL1Vhdm91b3o5aldXVWY1eUM2OUlnMXFaeFpCYzI3alhjYzMwRitC?=
 =?utf-8?B?ZTdsaERnM3lMQkdHUXF5MGFhTDdvNERXKzZnS1BXbitiLy8yaHR3WVIzTWtx?=
 =?utf-8?B?blZnRG5tVUxpdWZ3M3pqL0Z5OHZ2bHhxUFN5MGNMUy81S0pLT2lhVW5RL3VZ?=
 =?utf-8?B?M2Rid29xay9yL25RWVJGMVAwV3pXS2l6TTFqK2t0VlNDd3lwUStCckRvNGhQ?=
 =?utf-8?B?SnBjM0FWbVN1YVdWUFQyZ2wrTXNmWDNwRW1EdXVoWGh2a0VhQVY4OHJ3NGc5?=
 =?utf-8?B?endUbzBJMyszeWRzS2F6WlhpOEdaL1YvQjJGekczRWJ1Lyt1RkZTbmMzMCtl?=
 =?utf-8?B?L2dFUVhuTVhDVHZXa1hDSEdPaW8vUnJQc3VHcFZ6UUpDN0NTNFFHZ1hvRHVj?=
 =?utf-8?B?d1lkRDMxVEVmTmlVaU5NTWwySGU0Mi9Odjg4UmFCUStPaklGWnZSeXkzZDZ3?=
 =?utf-8?B?R1E5MDV4ODVwOXVxeEdoRjJybXJVZ3ZiVDdHQi9tWW9TQ0FlVXUxZEhNWGpZ?=
 =?utf-8?B?eitwY0Zqd2RGK2Rhb3JvVWE5N29CaHp5Tjgra2RBZHQ1RlBEYTNHZmUyWlZ4?=
 =?utf-8?Q?tdY3rkcS6X3NtbTI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a61601-b0bf-408a-517f-08da276cd84a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 10:09:26.4408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6bz6Mh/7zKwgchuR4Za2owKL3AfgDky2wJY71VuzMLXQEZcvHMch3iciE7DosWYzWdp+taEY1gfYPObR/WOpIfEFfjc4cdNyp1KTmO/giOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2505
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBPbiA0LzI1LzIwMjIgNDowMCBQTSwgU2h1YWggS2hhbiB3cm90ZToNCj4gPiBUaGFua3MgZm9y
IHRoZSBwaW5nLiBUaGUgY2hhbmdlcyBhcmUgYSBiaXQgbW9yZSBleHRlbnNpdmUgZm9yIGEgZml4
DQo+ID4gYmFzZWQgb24gbXkgcmV2aWV3IGNvbW1lbnRzLiBJIHF1ZXVlZCB0aGVzZSB0d28gaW4g
bGludXgta3NlbGZ0ZXN0DQo+ID4gbmV4dCBicmFuY2ggZm9yIDUuMTktcmMxLg0KPiANCj4gVGhh
dCdzIGdyZWF0LiBUaGFuayB5b3UgdmVyeSBtdWNoIFNodWFoLiBBbHNvIHRoYW5rIHlvdSBmb3Ig
cGlja2luZyB1cA0KPiBTaGFvcGVuZydzIG90aGVyIHJlc2N0cmwga3NlbGZ0ZXN0IHNlcmllcy4N
Cg0KVGhhbmsgeW91IHZlcnkgbXVjaCwgUmVpbmV0dGUgYW5kIFNodWFoLg0KDQpCZXN0IHJlZ2Fy
ZHMsDQpUYW4gU2hhb3BlbmcNCg==
