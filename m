Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A22371930E
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jun 2023 08:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjFAGQB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Jun 2023 02:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjFAGQA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Jun 2023 02:16:00 -0400
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com [216.71.158.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085A4E2;
        Wed, 31 May 2023 23:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1685600160; x=1717136160;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Xb6xjjx94OHMPsEzf3QlShgdz0UHylkWyULljpsJQ5g=;
  b=CR9hAKxtT1Yqrh/d168+y6ORSq1VqGUVcb4pBOHxXVptjL75lSNnCE/3
   JA81ZcP/dvAwzSmkv1H6FStOz2qzpS7r17RFa2nsw6ZW9qu4bEWo2rvsQ
   NCXReD5uogNJwYcKLnfOeSssIM2XpVi08zH6T7+9ImpeeBoa86o1CT/ah
   4w6BiWMrMoEGW0OIYO5uHWUFvBiXS3poelxHZWIW9lD6R5BEcvBnWL4fP
   TYXt0wOzb5+OUxRFNEvDsIztQXUgzR/MCCdeXsEnsiDudArM1Bq9oYwx8
   W5j2maf3ysJwqvj7ESO9IqRMWFufHRW2tLHWev46UCkUVH5Fe/8581+S6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="88604233"
X-IronPort-AV: E=Sophos;i="6.00,209,1681138800"; 
   d="scan'208";a="88604233"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 15:15:55 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FRseGpsudG47/aaG/HOFkeOgMibtUcZNNwADTiQROjpwZNUtkPdKUPOs2KC+/02s0SU3HIETAEuAeDKKjdEj5USAhV0AajO2sQQQpgdq4HY22Ety2dyz05hjEBXKuGumbtBRLVFsf0jx2v7SN+EXLpUtsi15OZff55JQiHLaOIsf+tql+U6HKFQpXZwu5e/lAQBBmfWsd5xDbp9UZEpA6Y02AhHWxKUnShgrf6GbvjdOVhb9KjOBlHjwKjBln0hufAO5qg6x6wLfu78j0OT4mxcJL3We0NzA98zChGHHkOxeO5wLPOC+XbgL4OaBArWR28fsIRqZvWKVmtUADA7jTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xb6xjjx94OHMPsEzf3QlShgdz0UHylkWyULljpsJQ5g=;
 b=QqloXMxrEb2CieCDsHuoGYFJfpT/Jf6Ep135TA+EWykS+Az4v33sKYknwkhNGiNX36x0f5GDwDULFy9zk82xNGACNo/WopB5p4rG5oMs/o/5HQPtAnwtPAJYWuQHcVs/PQPESDbUbe7H+b4bpAQHXpUCanU6H4vVT6zOgOJ4A5dwuOaf86lJwFQr5LvxcuAvPdR5VaYl3UduDBanmCmABlCT1CZOO3iqyGCqVRJ/0GRolDR1rdIzWayY0vPqWmzuwrxXdmxNKtEAGYZjnxT9N9ez2HpzIRo99/QiJMMYYnbVNpnREy3ojq1M9QKU1Gy6Blu5LLx1gu8/V4Wpeu/xhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYBPR01MB5439.jpnprd01.prod.outlook.com (2603:1096:404:8029::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Thu, 1 Jun
 2023 06:15:52 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::cc02:64af:18c2:cd83]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::cc02:64af:18c2:cd83%7]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 06:15:52 +0000
From:   "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To:     =?utf-8?B?J0lscG8gSsOkcnZpbmVuJw==?= 
        <ilpo.jarvinen@linux.intel.com>
CC:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 21/24] selftests/resctrl: Read in less obvious order to
 defeat prefetch optimizations
Thread-Topic: [PATCH v2 21/24] selftests/resctrl: Read in less obvious order
 to defeat prefetch optimizations
Thread-Index: AQHZcet39cAuWUDzBE6QdI939640H690HFtggABBOICAAUS3UA==
Date:   Thu, 1 Jun 2023 06:15:52 +0000
Message-ID: <TYAPR01MB6330025B5E6537F94DA49ACB8B499@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com>
 <20230418114506.46788-22-ilpo.jarvinen@linux.intel.com>
 <OSZPR01MB6328F2713E40CC7D383035A48B489@OSZPR01MB6328.jpnprd01.prod.outlook.com>
 <c21fb16d-d3ad-bbcb-daed-28f153b64525@linux.intel.com>
In-Reply-To: <c21fb16d-d3ad-bbcb-daed-28f153b64525@linux.intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjMtMDYtMDFUMDQ6Mzk6?=
 =?utf-8?B?MzVaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD1kYzgzMTU0Yy1hMzNhLTQ2MjUt?=
 =?utf-8?B?ODc2NC00NGYxMDc1ODg1ODY7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 384bae86b76e4863894a9142e4c3b73c
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|TYBPR01MB5439:EE_
x-ms-office365-filtering-correlation-id: 028b29d5-e2f1-4bdd-93b9-08db6267a6f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lu7azwnkre+emIqDrulbpBTgvM4ndDnsWfTvMvH48gAzngOSA8Oo3ujtwdbaO+C/EJRHmhSZhghxIx9mTrB3oV4Tr4zNXPMdbp9SgKYjhJ1GSD1sozMUV3twn3sWuK3QyHeCXWT2vlBlnZnp1LtLVQNqxBW6sz3a99G3ItGVQaapAF60LVLr51rEY8YoYl9t5AnMErgioAyR/EATnKiZauILOGYNLQ5mjkwZQrbmuhYud1lt0hQwVqHhdpChrEu2wS/7+TknvZKopAFwkhtO6ifG37ZJOWZOmIibBzGImfs79RAquB1Nq5tzP0gALHrkvL7f/IpZ+VRZMrZmLHHnEuoitQfk4gp5RtVe59XI5G9KkaZO9uwJWLkkBdvLmOfs+AK1Ds6ujpDzwNBQ4Aup+B3EFv3/KfS9WeDrNtFzuzen3YHDWnt3PT9XVO5qRwPTGsswdJvidAmPFeEq/82hTgVZikzrqE5gr7LRp3p228fpVFZ8od4KXh8GrW63eJeDv3p01lifSVDEKmfAQu/oucPj/JsiIyEfIWG+G/xGHprhky5h/4tZZSCiw9oadi8mDTaXjzRJP2ZurfgfYNiuhvecLBcRkbjwChT/n4AVNqglpoPtyFKmk7bt3uaQIOgiDksUxGaBLjbrs6NjNd0IWQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(451199021)(1590799018)(82960400001)(38100700002)(85182001)(122000001)(86362001)(38070700005)(33656002)(1580799015)(8936002)(8676002)(41300700001)(26005)(52536014)(5660300002)(6506007)(9686003)(55016003)(2906002)(186003)(66574015)(83380400001)(316002)(66556008)(66476007)(76116006)(66446008)(66946007)(71200400001)(7696005)(478600001)(54906003)(4326008)(6916009)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTJmNyt5VzZvbVZHb01GNDREWk5oL0p4ZnNVaTNaQS9jVVg3NzR4NTN3c1BT?=
 =?utf-8?B?cEo4bUZkbmhlTmE5amJsQ3JtK1ZpLzNjd1VTQ1k4OEhUdUxSalR0TGQ5cVE5?=
 =?utf-8?B?QkFlRHpBeGVPUWM3ZE8zcnZab29ISDdnSVdQNEEyaHovbGM0ZzhkQlZOU3o1?=
 =?utf-8?B?M29tcmlIOGhyZm5iRjhCTkY4ZkVnMktWaTQxbCt2N2hmRnhBRjZqNjhiaWdT?=
 =?utf-8?B?cDRqNWpxcnFOaExTUzI0K0VZaDlwTGNNUko4WEduNHdTdHNRWEZwakJUK05R?=
 =?utf-8?B?RlFVS1IyZ2dOeEZxZVMzbTR0dmdnSWp6dDg3OTVWTjJzdGY3TVd6L3FweDI1?=
 =?utf-8?B?VmphdXJiMHNpM1RadWJQTk41czB1dFA0NE9KOUtGUnl5K1lFaFFPKy9sNDg5?=
 =?utf-8?B?VlNrL1hIb1hpTndiL0hZQWVuaDlGUVVJQ1NSNXpYLzZRRFZTUTVvZG4xQVhF?=
 =?utf-8?B?TmN5YjQxR2VuYzZZNmk1N3BKNU9lYWlMYWhENm9ybmFoYnZ3TXFuUTVTajhK?=
 =?utf-8?B?MEIrdUYzMGdoYkdqdERIb01WU2NkM3dZV2I1RVFUbW9HOTN2UkJrZkxpUWt5?=
 =?utf-8?B?cTg4MnBoNlBibFNWTDBTenVGOHFkUVhDZmxsWWt2V0JuTEtvMFNFdTFPTjE3?=
 =?utf-8?B?cmtoVGEvT3pVUkNJVEpqUkRRc05uZmpHSm5BWkNIVGZSVlVSWXpWUGo5Qm9t?=
 =?utf-8?B?MzZ3L2dDdzlCUnRpTEV5TFdnQmFHeWhHdGNUZ1FTVll4aUJGWVhNOWlOL3Bt?=
 =?utf-8?B?ZzRNd3BhcE9EQ0w2OXN4eVRWOW42VElyL1pOTEE3eTNIbDNVc1ZYVThQUnNl?=
 =?utf-8?B?UTB1Umw1b25NVGx1cm85QS81RllBaHAwU290TnAraUlpQnlPbE0vU3ZHejNx?=
 =?utf-8?B?QkZSOXJsS2dBeUpCZXdXUGp1Z3ZITGpYak5FOU1Ea2hjOFdkeU5GVHZwOENr?=
 =?utf-8?B?KzA0a1YwSW5RVEpUUWIzbWVJMzZVZXAwT1pNWW5GejBybHh0a3RqLzRhNktl?=
 =?utf-8?B?bWZmU2xIOCtRYlJzdGdCRFlhYjVuUXV6ZWxMWDgzbzBBcXR1VkltU291V2dt?=
 =?utf-8?B?aVllcFlicjg2dXU0bmE1N1l3TkN2a1B5SktiUVkxMUh3Q3VaRHVkckdPTUc4?=
 =?utf-8?B?VDRkTlF4cUJnWS9JemE4Zkg4ZElReElnOXg3K0dhamxXVTFHeGlPdTJ2aTls?=
 =?utf-8?B?ZDNWaExnQUV0UTU2anBsWm9JTXBTY0pWWlZkbjBEc3c5amR5V2ZETGs5NzRv?=
 =?utf-8?B?MkRvOXpUd1dYcFJvYk5RZlYyRmNzV0VBRHN0SXFhbDZCNVphcXp5Und4RWJ5?=
 =?utf-8?B?R3FFa1RGUWs3Q1k0SjBCZmtZT05xWGdCMEVOdDlPMlV1VmZnSHVjRjRUNGNL?=
 =?utf-8?B?SXhNLzlTRnhLU0NQaUhacWNZUkxIY0dJdXM2V2J3SUZTd3liM2s1eURYZE1X?=
 =?utf-8?B?U2hVRVkyWmhXU21yWDgrcVAzRW1oUTJUZW96RUhmbVY5cUFSSHNoYnhyVEZP?=
 =?utf-8?B?UDBBMzY0TFRvVXp4VC96TVFqSit6VmdEY0xURDd0VkgydloxREtyQ00zZTVY?=
 =?utf-8?B?Y3I4OU4wMGo1RHdCRWtMY3RUNDFNTkwyektZNTErQi84MWVYekpsVUk5NDVH?=
 =?utf-8?B?N1pxM3BDRGdYSVF5K1F5VldkSTA1RDZyNEM4azBPQVo3U2hINmUrU3RBWkw3?=
 =?utf-8?B?d0pGUWNwYjBOUXUxRlA2RFk5NUlaSldtWXlGb3gxYnJxSVVPTk5HNmJ5Vzlh?=
 =?utf-8?B?eHBLNmhmakNGSDFRc1ZuOGU5TUtsZGgzdjZFUUFtd0hsV0JwaXpZZ2k2Nm43?=
 =?utf-8?B?NnU1OXRmOXJXUmpLM3p3V1lvTmRNRHpmTW9OUWhWaWMzT2Vlb1VxaHkvZW5U?=
 =?utf-8?B?dWswOWpiYlc5Wkh5dlc3WmFWZ04rSjQwSVd4bFF1cktaNENCNlFkV2VOaTRC?=
 =?utf-8?B?TEoxZUhRUFZZOEExWHArak5KRXlaeFhIZHBRZkVvV1B2RnZWSGNKYmpySnBI?=
 =?utf-8?B?bnNuU3RGZ3R2ZGlXL3lLcmkzOWoxSW1mTDZVM1YrZTNnalB2Zld3K0lzdVdJ?=
 =?utf-8?B?cGx1SzNIRjJxUEJjRkFpUTJNaW9BTEgyeTNRby95SXNmVzhHK2RHT0R5Szdp?=
 =?utf-8?B?dGNscDlydEF5dVNUMXhGREVQWEJnK1lBOHBYejJUT2V1SFJYdmZPdkozb0t4?=
 =?utf-8?B?c2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VsPmrkitSOXRh16knaUwVyQhmTcMX+ZIFeLPq28LtenVnMWxa2B6BXSc8j0gzqJnUbCkCkKWOY+2+PXZq2KRUNlW+V4JQlL0yB1/U08dKBaQcrC4eb5v6EIL8T69GxL+2vwAe9yfwAPlPHG32WxgyHorUX9eoSa6whROUmmG/sJkTJOaNI4IbzgQdLlVtooNYSagLxQAb2bXy9cDIe1BrhucsvaCWCw7LIfEYI2OxoP8ru8hJJKk13cojfiA7kaMBx0ISRT/blXHYGhv3jicRBKM2yNnIUY0okM9g+1D/Z8EwEdz2JPqQITqhzP7e+R8d8RMzH9f7iq6nAaqNtIPl9+rDQCDnT8N1OAKyTCsKF4C+5MMRWbcQLUA1Q1EBUh5/Ear2WanVmzawx/ufv+JuKgGP1y+ZaPI4rQdpwu7hEwcOjnOQBMQJQBXZPXXyFw4bIRmtfr0PCGfFBYm7picHAhnAen6bGxpO5YQaNHWRNouQI4M5uOWm3bwghP437WoipKDs3B3L1wXtceqJ8GWcNrKpwHDM1ERyU54w/ivYu0lYG1h5AMqpv42iYbPaHqcuuVHkGZika5JKR5Vb8VH0l61OHUEdx5+B9aBUg6pA+fo+I5X2BynUDqd8wnBevuV0q3Y1WnINrrHF0HjHkIyLSahgdm9eGGNV7yyy1fGsYQaAe7NPcvfE2EDOwzlZ6P/JdUGnZsHyprh3Lvp+oHAsYkJme/qtoc2y8H646bkU4FktZqQGFoQKmTXnlj3KwMYJE4A/sUjLJ8Xn6oX8C1T81o4PQ2s5nu04eDrsFhSsMpny71x34j5Xf31FqzkxfnwMhe5xj6oAZu54AywctYNSTmfpo0Mk7mnXdUZOLIunRlUHGYoN8jqJppNbv409dwy
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 028b29d5-e2f1-4bdd-93b9-08db6267a6f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 06:15:52.4971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PHjY/fyXjdhM2z/3JT4mfGOJYsIrUayq5NzAjBZQgC2wYp9T4iRCxxZosxH8gF5nkpVriL+XklmniCX4nHOV25rGAv0lp/0RsKTqvue/t/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5439
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGkgSWxwbywNCg0KPiA+ID4gV2hlbiByZWFkaW5nIG1lbW9yeSBpbiBvcmRlciwgSFcgcHJlZmV0
Y2hpbmcgb3B0aW1pemF0aW9ucyB3aWxsDQo+ID4gPiBpbnRlcmZlcmUgd2l0aCBtZWFzdXJpbmcg
aG93IGNhY2hlcyBhbmQgbWVtb3J5IGFyZSBiZWluZyBhY2Nlc3NlZC4NCj4gPiA+IFRoaXMgYWRk
cyBub2lzZSBpbnRvIHRoZSByZXN1bHRzLg0KPiA+ID4NCj4gPiA+IENoYW5nZSB0aGUgZmlsbF9i
dWYgcmVhZGluZyBsb29wIHRvIG5vdCB1c2UgYW4gb2J2aW91cyBpbi1vcmRlcg0KPiA+ID4gYWNj
ZXNzIHVzaW5nIG11bHRpcGx5IGJ5IGEgcHJpbWUgYW5kIG1vZHVsby4NCj4gPiA+DQo+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBJbHBvIErDpHJ2aW5lbiA8aWxwby5qYXJ2aW5lbkBsaW51eC5pbnRlbC5j
b20+DQo+ID4gPiAtLS0NCj4gPiA+ICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL2Zp
bGxfYnVmLmMgfCAxNyArKysrKysrKysrLS0tLS0tLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAx
MCBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQg
YS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL2ZpbGxfYnVmLmMNCj4gPiA+IGIvdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9maWxsX2J1Zi5jDQo+ID4gPiBpbmRleCA3ZTBk
M2ExZWE1NTUuLjA0OWE1MjA0OThhOSAxMDA2NDQNCj4gPiA+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL3Jlc2N0cmwvZmlsbF9idWYuYw0KPiA+ID4gKysrIGIvdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvcmVzY3RybC9maWxsX2J1Zi5jDQo+ID4gPiBAQCAtODgsMTQgKzg4LDE3IEBAIHN0
YXRpYyB2b2lkICptYWxsb2NfYW5kX2luaXRfbWVtb3J5KHNpemVfdCBzKQ0KPiA+ID4NCj4gPiA+
ICBzdGF0aWMgaW50IGZpbGxfb25lX3NwYW5fcmVhZCh1bnNpZ25lZCBjaGFyICpzdGFydF9wdHIs
IHVuc2lnbmVkDQo+ID4gPiBjaGFyDQo+ID4gPiAqZW5kX3B0cikgIHsNCj4gPiA+IC0JdW5zaWdu
ZWQgY2hhciBzdW0sICpwOw0KPiA+ID4gLQ0KPiA+ID4gKwl1bnNpZ25lZCBpbnQgc2l6ZSA9IChl
bmRfcHRyIC0gc3RhcnRfcHRyKSAvIChDTF9TSVpFIC8gMik7DQo+ID4gPiArCXVuc2lnbmVkIGlu
dCBjb3VudCA9IHNpemU7DQo+ID4gPiArCXVuc2lnbmVkIGNoYXIgc3VtOw0KPiA+ID4gKw0KPiA+
ID4gKwkvKg0KPiA+ID4gKwkgKiBSZWFkIHRoZSBidWZmZXIgaW4gYW4gb3JkZXIgdGhhdCBpcyB1
bmV4cGVjdGVkIGJ5IEhXIHByZWZldGNoaW5nDQo+ID4gPiArCSAqIG9wdGltaXphdGlvbnMgdG8g
cHJldmVudCB0aGVtIGludGVyZmVyaW5nIHdpdGggdGhlIGNhY2hpbmcgcGF0dGVybi4NCj4gPiA+
ICsJICovDQo+ID4gPiAgCXN1bSA9IDA7DQo+ID4gPiAtCXAgPSBzdGFydF9wdHI7DQo+ID4gPiAt
CXdoaWxlIChwIDwgZW5kX3B0cikgew0KPiA+ID4gLQkJc3VtICs9ICpwOw0KPiA+ID4gLQkJcCAr
PSAoQ0xfU0laRSAvIDIpOw0KPiA+ID4gLQl9DQo+ID4gPiArCXdoaWxlIChjb3VudC0tKQ0KPiA+
ID4gKwkJc3VtICs9IHN0YXJ0X3B0clsoKGNvdW50ICogNTkpICUgc2l6ZSkgKiBDTF9TSVpFIC8g
Ml07DQo+ID4NCj4gPiBDb3VsZCB5b3UgcGxlYXNlIGVsYWJvcmF0ZSB3aHkgNTkgaXMgdXNlZD8N
Cj4gDQo+IFRoZSBtYWluIHJlYXNvbiBpcyB0aGF0IGl0J3MgYSBwcmltZSBudW1iZXIgZW5zdXJp
bmcgdGhlIHdob2xlIGJ1ZmZlciBnZXRzIHJlYWQuDQo+IEkgcGlja2VkIHNvbWV0aGluZyB0aGF0
IGRvZXNuJ3QgbWFrZSBpdCB0byB3cmFwIG9uIGFsbW9zdCBldmVyeSBpdGVyYXRpb24uDQoNClRo
YW5rcyBmb3IgeW91ciBleHBsYW5hdGlvbi4gSXQgc2VlbXMgdGhlcmUgaXMgbm8gcHJvYmxlbS4N
Cg0KUGVyaGFwcyB5b3UgaGF2ZSBhbHJlYWR5IHRlc3RlZCB0aGlzIHBhdGNoIGluIHlvdXIgZW52
aXJvbm1lbnQgYW5kIGdvdCBhIHRlc3QgcmVzdWx0IG9mICJvayIuIA0KQmVjYXVzZSBIVyBwcmVm
ZXRjaGluZyBkb2VzIG5vdCB3b3JrIHdlbGwsDQp0aGUgSU1DIGNvdW50ZXIgZmx1Y3R1YXRlcyBh
IGxvdCBpbiBteSBlbnZpcm9ubWVudCwNCmFuZCB0aGUgdGVzdCByZXN1bHQgaXMgIm5vdCBvayIu
IA0KDQpJbiBvcmRlciB0byBlbnN1cmUgdGhpcyB0ZXN0IHNldCBydW5zIGluIGFueSBlbnZpcm9u
bWVudHMgYW5kIGdldHMgIm9rIiwNCndvdWxkIHlvdSBjb25zaWRlciBjaGFuZ2luZyB0aGUgdmFs
dWUgb2YgTUFYX0RJRkZfUEVSQ0VOVCBvZiBlYWNoIHRlc3Q/DQpvciBjaGFuZ2luZyBzb21ldGhp
bmcgZWxzZT8NCg0KYGBgDQpFbnZpcm9ubWVudDoNCiBLZXJuZWw6IDYuNC4wLXJjMg0KIENQVTog
SW50ZWwoUikgWGVvbihSKSBHb2xkIDYyNTQgQ1BVIEAgMy4xMEdIeg0KDQpUZXN0IHJlc3VsdChN
Qk0gYXMgYW4gZXhhbXBsZSk6DQojICMgU3RhcnRpbmcgTUJNIEJXIGNoYW5nZSAuLi4NCiMgIyBN
b3VudGluZyByZXNjdHJsIHRvICIvc3lzL2ZzL3Jlc2N0cmwiDQojICMgQmVuY2htYXJrIFBJRDog
ODY3MQ0KIyAjIFdyaXRpbmcgYmVuY2htYXJrIHBhcmFtZXRlcnMgdG8gcmVzY3RybCBGUw0KIyAj
IFdyaXRlIHNjaGVtYSAiTUI6MD0xMDAiIHRvIHJlc2N0cmwgRlMNCiMgIyBDaGVja2luZyBmb3Ig
cGFzcy9mYWlsDQojICMgRmFpbDogQ2hlY2sgTUJNIGRpZmYgd2l0aGluIDUlDQojICMgYXZnX2Rp
ZmZfcGVyOiA5JQ0KIyAjIFNwYW4gaW4gYnl0ZXM6IDI2MjE0NDAwMA0KIyAjIGF2Z19id19pbWM6
IDYyMDINCiMgIyBhdmdfYndfcmVzYzogNTU4NQ0KIyBub3Qgb2sgMSBNQk06IGJ3IGNoYW5nZQ0K
YGBgDQoNCkJlc3QgcmVnYXJkcywNClNoYW9wZW5nIFRBTg0K
