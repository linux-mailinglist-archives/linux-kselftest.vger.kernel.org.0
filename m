Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43675EED3B
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Sep 2022 07:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbiI2F3T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Sep 2022 01:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbiI2F3S (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Sep 2022 01:29:18 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 28 Sep 2022 22:29:16 PDT
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A59121673;
        Wed, 28 Sep 2022 22:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1664429357; x=1695965357;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tCmIumm/ubsFnE3r+m7wJ8EQaMK96KMWsyYecpkO6gM=;
  b=aUrGaniCPNrROmvLOy9K8PrS9LQWdv8br+g+qECw07FL5fxxhsA8/11r
   5E8R/7Z/8sV3aHBRcPr2ZG/ugkedOb+zfcXYjV96sKneft9f4bC5c9nWx
   m4Thq7wD83aFted4ymwejPQh18jbpxt6l1iVrlCeXL2437ByiCfY4S022
   Aohn3I7ksNaeRyQBMqjw0VrldRpPq6EyjOcyyYRMY7lL49Fzy7BredFRq
   ACd51VgDwm2gd+P/6cLcJTyWbTji55QT9PeApnXfeHSU52Z7FdOvginy5
   yApTMul3QrQFJtrAGoUoBcFzgaXtbuT5lwhl0rUg67XavQ79/+HR5wmzH
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="66410955"
X-IronPort-AV: E=Sophos;i="5.93,354,1654527600"; 
   d="scan'208";a="66410955"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 14:28:10 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imkM+4ZfpPcP+pSJFfH92DLbTmGVsqwdOUv42MgS+grmuxXIbrEez6my/a3ibvLysHLOS5AogGh20rG3RHbzPd+PZ57u3deqlcfpWnHYn5cqk9MnOyYK24gNGGwCdL9mQVg7l4kg4Oif12nNYMddpzBISiSR2qUriHQDINXF/dx4mqOKsXUyBfX1SbiHkFRg2bntPZq/TCMyOm4J7u1NPXl+1oyILDU2eBjXiaxvmImg/QH+H55S6yF40BrDPZQRdp7SG6HvpGq3T2GhpdKTam42Yvgc8DHK9IKbz+iMk5a95L1prIxFx0eB62AJLcjapOC1gZ6P+XHBWKfiLzRfEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCmIumm/ubsFnE3r+m7wJ8EQaMK96KMWsyYecpkO6gM=;
 b=kECNv+WLeZPlftkCJ1mh6Oqq8tGyt5BNOgn3JfgeRPJAhK9HcQFaRWTk6IDS5/FoS7Hun9EGEwMDC/dHWe+D1hdmCBAcTpqMphF3IyXat5Zp+HoAbe0j0HTdcQ1jW1DuXk0kl0sUrCEGbH6guIMntzyyj7iDzqDi/KNXtOb+NBQY4MLj6npK8GBk7PvxO0gUhC6QU8VVnKUacpCoZ8Eetq4I8BxcBVCqf3XPX8TX2Sz/fsnvHcqdRTR3YI7mzAFca5+i+5OeDHcuyrFlStrbte+PbELowuM8NPtpgJdnYFPux+XmX14pZ++Cd7iDrg/U2RCdosG8Dg9IwfbaXXpo3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYCPR01MB8501.jpnprd01.prod.outlook.com (2603:1096:400:156::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.19; Thu, 29 Sep
 2022 05:28:07 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::b0c7:c573:a888:8099]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::b0c7:c573:a888:8099%5]) with mapi id 15.20.5676.019; Thu, 29 Sep 2022
 05:28:07 +0000
From:   "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>
To:     'Reinette Chatre' <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH 3/5] selftests/resctrl: Remove duplicate codes that clear
 each test result file
Thread-Topic: [PATCH 3/5] selftests/resctrl: Remove duplicate codes that clear
 each test result file
Thread-Index: AQHYx90D18NEehSOQUCX8ddKN/e4oK3rxsWAgAc+rMCAAg5lgIAA41ow
Date:   Thu, 29 Sep 2022 05:28:07 +0000
Message-ID: <TYAPR01MB6330E178F0D86ED8ACE075378B579@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20220914015147.3071025-1-tan.shaopeng@jp.fujitsu.com>
 <20220914015147.3071025-5-tan.shaopeng@jp.fujitsu.com>
 <bdb19cf6-dd4b-2042-7cda-7f6108e543aa@intel.com>
 <TYAPR01MB6330988D96E4CD00C9A03DAA8B559@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <a0841d1f-fcc1-f307-7e2d-b9cce534455d@intel.com>
In-Reply-To: <a0841d1f-fcc1-f307-7e2d-b9cce534455d@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjItMDktMjlUMDU6MjI6?=
 =?utf-8?B?MjVaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD1jYWI2YzE4OS1mNzMzLTRlN2Et?=
 =?utf-8?B?OWViNC0xNTFiOWVlZDYzOGE7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: e6c4b25fdcc441379a06b3383f715f4d
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|TYCPR01MB8501:EE_
x-ms-office365-filtering-correlation-id: a3add700-7929-4778-b470-08daa1db63fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MxhzOzhLq/UEZ4GfQdCNvnxVsYnrIAVNlfSOKM6/pJlAH7ytZOG/rEP0g4wgL4vLesCfsbm6Skihg4FyWbZGtfXpzZESMOl7q6LAEEalenfD4i78ymtRQeEwzph5m4oXMN+CF5oxVSn3xxXllM8z20WuOy56M6BC/w/V+jQWRPLaM7iK8vPEVkTl6YyPp1MUZDiz50uPgAL+rcf9QnGBwSw3KSJuOMgRugyrkat/t/qIDw/KxW/cRxwK6AdX4WeKl/35QwNpZf/trgOY94NdA7lrthe5KXK7khxKbZdpQaVd5xVmNn3SvJF/6bj4RFxbH6MVZIxnDWwcp2DKhQB3QhS5uD6zq3orxeVG4s1lnm3upQK4B2iHWRTs93gocLapKWu74rqHVd6dz3JbDZt5VikUeo3tZhSI07XyXh9a2fqAS15UOwvGosb9EOt7VEaqRdAt8Xml0ksMSy4ichImcVpclS8FXsD4dhlzV80bAMRNT2IHdGwVSU/ClCjg+yhQwp51lgsixRzeeQBipGl4omOFa5lvs0MWIl2LLYmuob83l7psoRo+TDZ/xlp5BpIGaFrhYJnPPawaOUQRcYhM0VWh8xA3wnWIxmmoCqH5mxBPN6U8jC61hGuMJ7iXe4a9CKrCVqPsOzHBTn/hcxBL6TK4w+x079jFKv7WMln8gKrcyF9P+jbXULWiSMN9wDiL9N61D/Gfl7eC5wdT9rx4+pyFN3GuNl7IcTImxFxILobpeJD2ED9z0JKNFMrX5HA2rn2y+M13RoAAZozWeiL0H8K17GRAlXruBd66PP9Ojas=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199015)(1590799012)(1580799009)(55016003)(38070700005)(38100700002)(71200400001)(122000001)(478600001)(86362001)(41300700001)(52536014)(7696005)(8936002)(316002)(54906003)(110136005)(2906002)(53546011)(6506007)(66446008)(9686003)(26005)(5660300002)(8676002)(186003)(33656002)(76116006)(4326008)(85182001)(82960400001)(64756008)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UktwRHhUQWhYcXhwaitzOTQwdXVWTkQ3cDhIMmZSejh6bEdPZXFQRnBHZWth?=
 =?utf-8?B?aWx0dWhKd3JtTlZKM1RwZVlDMjM3VlJpMndibUFrK1BlS3FrTXFUbm1QeWho?=
 =?utf-8?B?QWtMYjVRZkRlUithT2F4T00rSFAwdmFQK2JuOTBvS1BZMjM0TnlYeDhOTWph?=
 =?utf-8?B?cEROYU43ajdyZEZDZEhOcWVWdGFqNW9QekJ3NVRrbEthUGx2cHd1ZWRXYXEw?=
 =?utf-8?B?dHBKdUhoTnZISGlYMzlEdzlPNHNpcldQdTg0MjZ4SCtwUi94WDYvWDRxbnNM?=
 =?utf-8?B?MElsVHF6M3ZLb3poUkV6M3Z2TmEzL21FUUQxcFZZNUlWQjJ2SFpZSDhXNmtR?=
 =?utf-8?B?YmdieHhFQWhBKzZ1T3NZeHgrbU95dTczbk1oTWZLa01IM3plKzcwcDZsZzhr?=
 =?utf-8?B?QjdLYkRSUmE5NzV4bThkdi90c2N3VUNYSFlRMmtUSURHeTRwbzFDS1ErQnJV?=
 =?utf-8?B?NGhJOVBoWWRlSHpJKzVvQ1BVWUI4RXRRcXN3L0hCbkUzVUtWSnBoU3NnWm1N?=
 =?utf-8?B?bm53YlZyVHI2K2owNTNGZ2tmVVdmYjRJNWZTZWxLaUNyYzg2TWNkS3B0d3k5?=
 =?utf-8?B?clhDRjk3REc1eUpYQWtnYld1N0lpNWg4U25oNkRKdzFnZlgweWVVejdWTExa?=
 =?utf-8?B?MFFzdkRDZVJtMjR1OVh5bzR6WDRzeHBHd2FNK3lPTXVLYVhSRDJFZW5HSkpQ?=
 =?utf-8?B?aWlTc3hBbmh0WnAzYU1ZZnA3cGhBZE1hcjAxTU5Damt3cXJQVml5alYySE51?=
 =?utf-8?B?OTNUUTQwaHhUZ3dPRVVrQUFZdTdNMXcyNTA4b0YrVUNoYzk2WUw2OG9ZWHFS?=
 =?utf-8?B?WUlzbzJmS05GRHhvcjRVVVJEVVFseTB1U2pGbUxCSExYRTdTRzE4OUJuT1NG?=
 =?utf-8?B?Z1p2cVJ2YjlGR2F5RUJlREFiSVNZbnZIVHlSWnhreVNzSzI5Qy9NOStpR3I2?=
 =?utf-8?B?bndxT1pmSkVYb1Vjb0hKMVIxK0lQU1FKSzRNNmw3T3RYQUFpMDF6VTF5Tkdr?=
 =?utf-8?B?WVRBQTVObjUzMDRwSVp4RjVXNGFyWDBxdXdLRXNQSXhEK1hocFlqbGhwK3BC?=
 =?utf-8?B?djUvZHdYV0hKUTdjYWUrcTQwWFM3NjdYUTcwbmlaUXFsNk9vVktrWE9NTEda?=
 =?utf-8?B?cVNaYW5hNkhaaXUwUTZPS0laQVYvT3ZtQzlCWStCVXFiTnJZRlZDRjRXZEpR?=
 =?utf-8?B?SnEyRjk0Mi9zNTNwZzhnNmJiKzViR2FoZjVmeEQ2b2lScjJ4TWZnckIvM1lT?=
 =?utf-8?B?eDh4NS91b0NxY2Q2a0xEdDRXWFRPZkNLdEZJdE81RGorMEZqN2x4TlNhVTMr?=
 =?utf-8?B?aXVXb21VVDJLL2NJTjdld082bEhjR01LT0tSbmZoVkhhUEoxQ1hoY2w0MVpu?=
 =?utf-8?B?Y0FkbUtVdkdOU0hTSDRESVdPeFNBRjNtcENMcXNtSVpMM3pCbVVjS05KdCtU?=
 =?utf-8?B?NC82UGgrNFNYdVgxUi9QVXZMSlE1dmhMVkZmM0F4SWZZRjdBaVVUSDA3MGs1?=
 =?utf-8?B?UDYyRmsvNUtHb0pRUytJWXhySTZhMmZ4anMrd2xuVHZoU3pDNUF3bFlnVm5v?=
 =?utf-8?B?OFhVakJzRy9EcmlMdFZrbEk5enNscTZ6cTVXenhGVkdHeFVVaEVac1hIUFB6?=
 =?utf-8?B?NVJyQjJMS01MMHNWZXRYOW5KZXRJVWwxY2ZzRkxXRStoS2xVRXRtOFRSVUx5?=
 =?utf-8?B?VkpmcldxdklzZTZnY29MVTUzclp5TUlTNzRKbURlNHFmbkhiZGtmemZFQzM1?=
 =?utf-8?B?UmJRbnRzVGI4byswMXNDUDR1TVJySkNnd3FjNGt1S2UzVXp1OCswRnpXeFZH?=
 =?utf-8?B?OHlZbDNsK2hUV3VlWXVtbTdTdHJmenFUUWFuUVJ3YTNGcFREaVhlcjFHN3FB?=
 =?utf-8?B?R2wzS01xYkF0M3JSZWROSklsVmpBY1JlSlpvQjhKU1dTaDc4dlROWC9tbkNJ?=
 =?utf-8?B?T1Z3bHh3TWJDd2JwUE1XbU5UYUNPQUtzSTQzRWZBVW5USHZ1Um1JNE4wbzg3?=
 =?utf-8?B?bGJ0Q0RnNFJpd3dLSUtjMk1TMjBwT0s2K3RRQy96VmFDek5mOHpJZ3ZxMXk3?=
 =?utf-8?B?bXYvUTRHZlBWUVdzTWMrRzNDdGM4UmFaT3FTYk82M2NCaCszck5NTjhSdWlG?=
 =?utf-8?B?K09kOVNadXFBTU8xS1g5aDNETmhVS0d5US9Tek5GMkY5R3M4OTBFbVZHUENk?=
 =?utf-8?B?dWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3add700-7929-4778-b470-08daa1db63fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2022 05:28:07.3202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NOFOAf0L/naFkffeI2u6nMxreTXDGq+oA+kMj1c6NNphx+dvm9enMc7VWoc4QTBOb0CmhvQu8ikv3CoSO5d9PD/6UYF/A0fki99tJEm8f5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8501
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGkgUmVpbmV0dGUsDQoNCj4gT24gOS8yNy8yMDIyIDI6MDEgQU0sIHRhbi5zaGFvcGVuZ0BmdWpp
dHN1LmNvbSB3cm90ZToNCj4gPiBIaSBSZWluZXR0ZSwNCj4gPg0KPiA+PiBPbiA5LzEzLzIwMjIg
Njo1MSBQTSwgU2hhb3BlbmcgVGFuIHdyb3RlOg0KPiA+Pj4gQmVmb3JlIGV4aXRpbmcgZWFjaCB0
ZXN0IGZ1bmN0aW9uKHJ1bl9jbXQvY2F0L21ibS9tYmFfdGVzdCgpKSwNCj4gPj4+IHRlc3QgcmVz
dWx0cyBhcmUgcHJpbnRlZCBieSBrc2Z0X3ByaW50X21zZygpIGFuZCB0aGVuIHRlbXBvcmFyeQ0K
PiA+Pj4gcmVzdWx0IGZpbGVzIGFyZSBjbGVhbmVkIGJ5IGZ1bmN0aW9uIGNtdC9jYXQvbWJtL21i
YV90ZXN0X2NsZWFudXAoKS4NCj4gPj4+IEhvd2V2ZXIsIGJlZm9yZSBydW5uaW5nIGtzZnRfcHJp
bnRfbXNnKCksIGZ1bmN0aW9uDQo+ID4+DQo+ID4+IGJlZm9yZSAtPiBhZnRlcj8NCj4gPg0KPiA+
IEkgdGhpbmsgaXQgaXMgImJlZm9yZSIuDQo+IA0KPiBobW1tIC4uLiBpZiBjbXQvY2F0L21ibS9t
YmFfdGVzdF9jbGVhbnVwKCkgd2FzIHJ1biBiZWZvcmUNCj4ga3NmdF9wcmludF9tc2coKSB0aGVu
IHRoZXJlIHdvdWxkIGJlIG5vIHRlc3QgcmVzdWx0cyB0byBwcmludCwgbm8/DQo+IFRoZSBjdXJy
ZW50IGltcGxlbWVudGF0aW9uIHJ1bnMgY210L2NhdC9tYm0vbWJhX3Rlc3RfY2xlYW51cCgpIGFm
dGVyDQo+IGtzZnRfcHJpbnRfbXNnKCkgLi4uIGFsYmVpdCB0d2ljZS4NCg0KDQpJIGFtIHNvcnJ5
IEkgbWFkZSBhIG1pc3Rha2UgaW4gY2hhbmdlbG9nLg0KSXQgc2hvdWxkIGJlIGtzZnRfdGVzdF9y
ZXN1bHQoKSBpbnN0ZWFkIG9mIGtzZnRfcHJpbnRfbXNnKCkuDQoNCkNoYW5nZWxvZzoNCkJlZm9y
ZSBleGl0aW5nIGVhY2ggdGVzdCBmdW5jdGlvbihydW5fY210L2NhdC9tYm0vbWJhX3Rlc3QoKSks
DQp0ZXN0IHJlc3VsdHMgKOKAnG9r4oCdL+KAnW5vdCBva+KAnSkgYXJlIHByaW50ZWQgYnkga3Nm
dF90ZXN0X3Jlc3VsdCgpIGFuZCB0aGVuIHRlbXBvcmFyeSByZXN1bHQNCmZpbGVzIGFyZSBjbGVh
bmVkIGJ5IGZ1bmN0aW9uIGNtdC9jYXQvbWJtL21iYV90ZXN0X2NsZWFudXAoKS4NCkhvd2V2ZXIs
IGJlZm9yZSBydW5uaW5nIGtzZnRfdGVzdF9yZXN1bHQoKSwgZnVuY3Rpb24gY210L2NhdC9tYm0v
bWJhX3Rlc3RfY2xlYW51cCgpDQpoYXMgYmVlbiBydW4gaW4gZWFjaCB0ZXN0IGZ1bmN0aW9uIGFz
IGZvbGxvd3M6DQogIGNtdF9yZXNjdHJsX3ZhbCgpDQogIGNhdF9wZXJmX21pc3NfdmFsKCkNCiAg
bWJhX3NjaGVtYXRhX2NoYW5nZSgpDQogIG1ibV9id19jaGFuZ2UoKQ0KDQpSZW1vdmUgZHVwbGlj
YXRlIGNvZGVzIHRoYXQgY2xlYXIgZWFjaCB0ZXN0IHJlc3VsdCBmaWxlLg0KDQpBbiBleGFtcGxl
IG9mIE1CTSB0ZXN0Og0KIHJlc2N0cmxfdGVzdHMuYw0KICA3MyBzdGF0aWMgdm9pZCBydW5fbWJt
X3Rlc3QoYm9vbCBoYXNfYmVuLCBjaGFyICoqYmVuY2htYXJrX2NtZCwgaW50IHNwYW4sDQogIDc0
ICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgY3B1X25vLCBjaGFyICpid19yZXBvcnQpDQog
IDc1IHsNCiAgODcgICAgICAgICByZXMgPSBtYm1fYndfY2hhbmdlKHNwYW4sIGNwdV9ubywgYndf
cmVwb3J0LCBiZW5jaG1hcmtfY21kKTsNCiAgODggICAgICAgICBrc2Z0X3Rlc3RfcmVzdWx0KCFy
ZXMsICJNQk06IGJ3IGNoYW5nZVxuIik7DQogIDg5ICAgICAgICAgaWYgKChnZXRfdmVuZG9yKCkg
PT0gQVJDSF9JTlRFTCkgJiYgcmVzKQ0KICA5MCAgICAgICAgICAgICAgICAga3NmdF9wcmludF9t
c2coIkludGVsIE1CTSBtYXkgYmUgaW5hY2N1cmF0ZSB3aGVuIFN1Yi1OVU1BIENsdXN0ZXJpbmcg
aXMgZW5hYmxlZC4gQ2hlY2sgQklPUyBjb25maWd1cmF0aW9uLlxuIik7DQogIDkxICAgICAgICAg
bWJtX3Rlc3RfY2xlYW51cCgpOw0KICA5MiB9DQogIA0KbWJtX3Rlc3QuYw0KIDExNyBpbnQgbWJt
X2J3X2NoYW5nZShpbnQgc3BhbiwgaW50IGNwdV9ubywgY2hhciAqYndfcmVwb3J0LCBjaGFyICoq
YmVuY2htYXJrX2NtZCkNCiAxMTggew0KIDEzOCAgICAgICAgIHJldCA9IGNoZWNrX3Jlc3VsdHMo
c3Bhbik7DQogMTQyICAgICAgICAgbWJtX3Rlc3RfY2xlYW51cCgpOw0KIDE0NSB9DQogDQogNTAg
c3RhdGljIGludCBjaGVja19yZXN1bHRzKGludCBzcGFuKQ0KIDUxIHsNCiA4MiAgICAgICAgIHJl
dCA9IHNob3dfYndfaW5mbyhid19pbWMsIGJ3X3Jlc2MsIHNwYW4pOw0KIDg3IH0NCiogVGVzdCBy
ZXN1bHRzIHNhdmVkIGluIGZpbGUgUkVTVUxUX0ZJTEVfTkFNRSBhcmUgcHJpbnRlZCBieSBrc2Z0
X3ByaW50X21zZygpIGluIGZ1bmN0aW9uIHNob3dfYndfaW5mbygpLg0KDQpCZXN0IFJlZ2FyZHMs
DQpTaGFvcGVuZw0K
