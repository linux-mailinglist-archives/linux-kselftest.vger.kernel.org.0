Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1919572B7DB
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jun 2023 08:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbjFLGCS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Jun 2023 02:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbjFLGCR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Jun 2023 02:02:17 -0400
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com [216.71.156.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7409B107;
        Sun, 11 Jun 2023 23:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1686549736; x=1718085736;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CYSCTV4/3l3YulIDp7ciUb2qDWlMOpWdySymCsuWd5E=;
  b=N0Ln9LUQ4mHGPGD2sRDhcd9YCJsk1isdW3Bdymg43TgZJgGfvaeYtWvn
   kQuVr6M7MkyrQsg5knB3T6JhLRgEaDLXn36XVQU/kxXgtJrjvX+j/gLJF
   PiR6iCLlPEvufrEHifOzNkHIkMbSkMtZdn2yX1LAw9GioJ8E9ilvdKOrW
   yCOrtYQY5JuvCeCoUa2qeSOURDxCAq7lvzkqFXMfJrQKzPJm/cyie3B4J
   UTbHojsfCf8yDyFKLrnB2aXb36BiJ2xyJyy9Zp+hI7CB4bPknVSnMGkjQ
   JQjCM0M7an7bTpxqsUEXw1WO7tKGeVdUtJ82ciRwbAxe/j+ozAraF2drY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="87342185"
X-IronPort-AV: E=Sophos;i="6.00,236,1681138800"; 
   d="scan'208";a="87342185"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 15:02:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z30GFBEVP+0fNxVZvQ/g7Q/bWr0HoVuIX2OxcYreEsPVcQp0XqY3/HqybyxrIhaHHLhcqEJnbGLytbIvXP3/Bw1CnvoWCUvfRgvEoP/7L1U6mhLQaIjzSvcSWgNQ0n4+N6vxNaI6IbFLGWBSufZfhlo8XhE8HgcuDXhv0LWBx1qKVAKxgC1e8LjAPJ8A0sXE/PK6iNgsw02z9rO4ACX3C9T/9t2NUtduW8ajyv91ksx98bmOpXXaX2XCOABIA72ULjqr5hKFYpyB91/3NFc25MkW4KlRvdtRDdEU7S1VeNdrYLNRPpc3PhfK35sg4m59VhBRbgw628lkGhtQ7sCiqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYSCTV4/3l3YulIDp7ciUb2qDWlMOpWdySymCsuWd5E=;
 b=df8WUbVmQcpA/YYl3omW/4xEqoTd7JgO7BhZkZYbSEQ1x3qZ62QdEDYWSbfnnqr3IisAqv09Ko+1BAkPAc9Rg4WWeysVSA1Bi7DfDyq+dTpj9rmdx+0y1QwvmFFTQtmjHNqmihyOqDVSHsQLVErnbF1JXDcceDJuHnRuXARR3al1eKJw4hoS0R6h2U6d0zk5HYv0es06Rg6Zh9+p8n74P6npX3I92TASxj+JCmmLeXbV6VUFJWx8uxaZ83jN93p06oOzJclOcExlM72exAsLgCZO+d06tBEqNZe9U5m7y2ieOzAmVGwg7CfxV5RLnI9yTaVXIpxrxjZTbe1aXafcHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by OS0PR01MB5970.jpnprd01.prod.outlook.com (2603:1096:604:c9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.42; Mon, 12 Jun
 2023 06:02:10 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::8fa6:7b20:a48:5400]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::8fa6:7b20:a48:5400%4]) with mapi id 15.20.6455.043; Mon, 12 Jun 2023
 06:02:10 +0000
From:   "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To:     =?utf-8?B?J0lscG8gSsOkcnZpbmVuJw==?= 
        <ilpo.jarvinen@linux.intel.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 00/19] selftests/resctrl: Fixes and cleanups
Thread-Topic: [PATCH v3 00/19] selftests/resctrl: Fixes and cleanups
Thread-Index: AQHZl9foNAO0MSBDF0CpOlcdC7GWP6+GtpQQ
Date:   Mon, 12 Jun 2023 06:02:09 +0000
Message-ID: <TYAPR01MB633029B8CEAEEFE28197A2458B54A@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20230605180145.112924-1-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20230605180145.112924-1-ilpo.jarvinen@linux.intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjMtMDYtMTJUMDY6MDA6?=
 =?utf-8?B?MDVaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD0wYzUwNWU0Yy0xMjQ4LTQ3YjIt?=
 =?utf-8?B?OTI1NS0yYjA1OWE1MzFiZDc7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 4df054b20cc54d68b6aa02e6dee62d58
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|OS0PR01MB5970:EE_
x-ms-office365-filtering-correlation-id: e04c771e-fc4c-4e9d-eb92-08db6b0a8f34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qDt/mm9H8h4kAm64jPAL9zvO9/d5d+yc8Z0XWDvs3k8Onu/IOzOzX0oB0A9hlbcx2WW5nF6+fogwbBouwiigxYbatXvA3v7HAXLW7p/qmF+lo+YBhEU04BC/zrOv11Q/6YpvIELmJ5wZ6fRrawkY7B7tjnv7UwGZ+/yacMaxZdxNYLkauNhm6zmJU4YyycEyFMo9SBuZz8ZoR62mZ3sL1Fid36+Y8VPWkw5YNVXAV9yQX1QPbQnT/xpinmBNYUHG814+iyLrH4jsDGEwDa/IA1C9EUeD2XbaogEHUrAcjsbOhLgZqVc1Z46Z0EYi22L/yvqtXYviA8HrrTKayzep9tFMD35sIch+5CmiJhWdcw2bmR5MC/BBqE6Tb5S/tq4Y+/8/AR4q2L462TinyGi54VkU7pqS7FFZrdeTV6A9XudtO7BGR9D552/ydGWvjqRMC6Ji+Vcnvo8HvSCWuK9t0QYvxQFrsFb2+99hRNEYu1lwOAQFxPBGzw0j2eDNE2foiGpda9KFK8sfuQJjryLJSWUJbseO06poueIm52VdbBxSLF14nAagDZT3yx1VfVuGJP7M96pkj+esMeN7M+KvtNV3HMRI0Gykxdx7uIG0BHhIvOE4QL9lkUnRSlpbCuhbEkT2iOm8xaUF4tLqKexW2A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199021)(1590799018)(55016003)(1580799015)(122000001)(64756008)(110136005)(478600001)(82960400001)(76116006)(8676002)(8936002)(316002)(38100700002)(66556008)(66446008)(66476007)(66946007)(41300700001)(4326008)(186003)(71200400001)(7696005)(6506007)(26005)(9686003)(33656002)(86362001)(52536014)(5660300002)(4744005)(2906002)(38070700005)(85182001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?REgreEhpVE82Z0JZT2xCcjAvdm1jMFdKa2R4cngzNzFMTWdjVlBnSGdvOTlP?=
 =?utf-8?B?OHV2VENuTTJZOHkyaXMyL3I4RzBtUUhqTjJ1NGFlcXRxYkIrdm1zT2Zubm80?=
 =?utf-8?B?dVYzcy81RjFwSlk2VEIwaXU0blR3OGNlRWZPVm9na0V6QmpQek1VSnRLT1d1?=
 =?utf-8?B?SC9QWEVnZmQ4VFh2WmxRajhWK2pGME9XanNldU5TNi8yWXdGaVZqZ1ZsSHEr?=
 =?utf-8?B?enM3Y0RGRUNtK1dNTHozN2xhWGxlaThDV0hVMzduM3RLbTQ4VUY2VlZsZ1Uy?=
 =?utf-8?B?eGYzZGwvNlYvWEZPakZ5NW1jRzI2cHJNZCtyTDNlcy9FNlRYVkZsK3B1ejlP?=
 =?utf-8?B?alJsNkZkaXBDZ3EzcDhkdEFPa0I4WXFDY3ZnK0dsajJDaWlNVzNUUlFYQ0o2?=
 =?utf-8?B?VGVTL25KUm5yaEQvaFR3Zk5rb1J4S3ZTSmczaTJTd1k1NWFPNTdoRVBRK0xL?=
 =?utf-8?B?VndtaENuTHI1ZElteVNZd3k3UTlScDdIbzJsVFNrNkp1TW91d085YVVnR01B?=
 =?utf-8?B?Ung0dXhvU1JWNWt3RGNVMHBVeElKZUQvQWpTNm9UOEdaZjdmcXhseDF3TjZ0?=
 =?utf-8?B?QzNqSkRRV3JBekJoUnpkWVo4ZW9BK2xIVzZGZm05M3NIaWkyVTE2WjRudW1U?=
 =?utf-8?B?VTZMeS9hMmxsZlkvM3preWgyR0FhSDMwTHJHK0FSZ0I5NDJKWWNDSUlzWGRR?=
 =?utf-8?B?OWQ4RjFiRUtCUU5JSE5odm9iaUd1Q3Jycmw2OUlnVExqU1RMaXl3NWdvMllI?=
 =?utf-8?B?cDhzVlpTVXQ0MXJhRno1QXp3cTRuaFdKRWdwMWZiSTlSdGo4TlhYY2tKdTJ3?=
 =?utf-8?B?cTRIL1VZM1NqTkp4NFlmU0hiKzBSbEFzQjFraDh1QnVkKzB6blQzMXg3Y2w0?=
 =?utf-8?B?NUllYWovc1UvVVl1Wk1odS9zMzdzc2VhTEV3QytzbFA0VTByZFZkTUJnTEsv?=
 =?utf-8?B?MkpFT2RXTGs0SzYvaFNHZWdyMHM1VVJtaklGYjFmdkhLVGlKRk9aRzN2cDli?=
 =?utf-8?B?M1NmZ0s0YzducUhJbWNML1ZXUzVkVno1SmpoQlcxUDdPWjJkRXdzU3lVZlhL?=
 =?utf-8?B?OWl5VlpqQXBOWURzc2pTeGRmUkFFdXFpeGljbk5DL1hKVmNRK3E3YTQ3NkZY?=
 =?utf-8?B?VTZKcWdsOGttMHdNZ0xJbmxiRk15OWl5YzBBcU1oSDd1TXpaTXFycnBrUVBv?=
 =?utf-8?B?Z3ErcXBITDRKTEtsOEVxNGN3MSs5ZnlWdXZ0QkJaVVdHN2F5RC9vamxqWkxD?=
 =?utf-8?B?Kys0WlRjOEpwWVdnOHcrWmRwWUVIZFpVVjBQYzY0Y1hGRUROVlE4S21la1hJ?=
 =?utf-8?B?TWcrZllFUTNDUGc0aC9XRXN1bWlMMFlJKzA4RnBGbTBpZjVVdVNza1VHTm9T?=
 =?utf-8?B?MXU1QjJuUXVHcTcyVnhsUkdkU2xiU3RMd0oyOTFXb2hPQVVMeVkvcHdIb1VE?=
 =?utf-8?B?dmF3TGw2cFU3b2owbEp4Q3I3clM2Ui9xa09BNmkvc2Q2Q0pGRTE2ZFdrRzJ5?=
 =?utf-8?B?MDhndmRXcjEycVJ0NVZ2cVU0enlFVkhmdmVXOVpXODV6TDRGamhuVm9Td1cz?=
 =?utf-8?B?dFBzK3I3VlRxZFM4ZlozdThXRXJocUNaTU9Md3JnUUJBU3ptSXRVUGV4bGsv?=
 =?utf-8?B?RFZnU2hKMzIzL3YvcDhTR2RVMUhUUm5xbWEzcEVUcnUwNkxERWM2TGJQZlcz?=
 =?utf-8?B?ZFlXbk40cm9HbVdRVzRFVDE3RkxWNm5PdlQ5NU12ZFhQbXIxblJ0M0VoZm1C?=
 =?utf-8?B?STIyVlpDMVRZU3ozblQxa0xHSWhkeFBzZllxbngzS3RrR0hOZnFUNSsxQWp6?=
 =?utf-8?B?UHhoNDVGcm1uWG01dWdIakREUEt6T0d0TVlRYWFINm1ia0RXSmx3bEZsclh6?=
 =?utf-8?B?ZUUzaDVwNlU4bXRtdnZza0NhY29KMHh3QTc2V1UrVUk5elNDaEZ4b2ZYQUlR?=
 =?utf-8?B?ZlFFdUhRUVZOQ0libDd2VmRVbWJNUnBkSXRhR2s1Q05EVVBwYlIycVlQQmZ4?=
 =?utf-8?B?cUhPWDh2SnlvVE9HRHRpV3MvSlZpM3VEdUVOTkRWNitGdHJsdjhhM0ZjZmxE?=
 =?utf-8?B?VGpnTExUcVprc1lkY25ZSjhDVitXTTltMGc4a1lPZ1dveFFqaE1pNjlEc2ZO?=
 =?utf-8?B?NVI3blZrdUswU002N1lZaXpKK1Izd2NselpOQzAybWpyUGI3OXVBTnZMVjg2?=
 =?utf-8?B?aGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XzwjTTmEX/c85YqMORIbARYC9mXo6zBeh2lkVzR0/vkwKwoBGSddF12uXXBmbQPHpx+S4wM5ON7i4IDd6/etGPiIKo6oJo6VGqOwxsXNaA0q248LkSh5GTx/G5l7uH9iGZTm9BLjeWerprXt6wFMA1wrsHHM1i4xGIrrkWycptQXtSRNB7VlIlNqV3N0+sdblJKuVsvqgwgoJBQ3ZTm+0A495quufI5wpN4uZnUKeZYxMW+UszqOZVP2ygPUhSsE/eVpTcSm27CFivqWnIJ6U8Xv/O9v/HDHzKRYVknJc0rw+X6hwJMoek9UMTP8kPdJLQSHhtVdElICCAECMlUsKcbSzyxB2MKyj7QpWhcRYbOVpQXU/Rfsd9RaiK14LuDmMract3i7PiH6RoiJaWfb1wvdQ0SGaZhoXjKXlSf6M1L+JE7GS+J/+/9gd3tUMHnVP+tZjMjpAls598z+A/Ng7jbfj/p6PR2neVx6GtP3jM2ZtxzCtUeWbEqrFeecyWCcqHxcuYVudZ4iAoqRjju6kEqHw+sljSMumwhdDJMjXL+/iJbJ1sP3SmyOl8Hl8ST/rcbWhqCbKPRAexONBG5AGhdldqRae50f4/DxNYs0e12jSPiq9VcNLGrR7pDBUIm3oly470hycIx64VHWrmc0oOdlGV4K6RnCONnpinfN4055g3eu80Ojlfs8Yv+NkbXU9d2fBRmamEHoZgOxGCLYvn3bZ+HWBtCKLJpDSs+yFBUBkuq//w0X+Gdc/Bf0kXXoySbzSgQMww2dNMRWgeacflUFH719Zi1QNy1IXfa5Q8dnmL5RbH3Xaxf5Eb0KJoosgFp5AQ+UmS+ZlXKgag1akOu+ItWSfln/p+W6qiTDo0EY2lJbn91CqEnRJ2vFyICj
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e04c771e-fc4c-4e9d-eb92-08db6b0a8f34
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 06:02:09.9257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8N9pmeWpPAZXdsVeoySmcIDa6/A8uvJ8V+zxenVRl2+7oVbgVBFmrLFHYUVgTIrk5km6k/7mWiY6k0GImIlCUucYrLa8tcSEkcnj7UMXQC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5970
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGkgSWxwbywNCg0KPiBIZXJlIGlzIGEgc2VyaWVzIHdpdGggc29tZSBmaXhlcyBhbmQgY2xlYW51
cHMgdG8gcmVzY3RybCBzZWxmdGVzdHMuIEluIHYzLCB0aGUNCj4gcmV3cml0dGVuIENBVCB0ZXN0
IGlzIG5vdCBpbmNsdWRlZCBhcyBhbiBpc3N1ZSB3YXMgZGlzY292ZXJlZCBpbiBvbmUgb2YgaXRz
DQo+IGNvbXBvbmVudHMgcmVxdWlyaW5nIGZ1cnRoZXIgd29yayBiZWZvcmUgaXQgY2FuIGJlIGlu
Y2x1ZGVkIHRvIG1haW5saW5lLg0KPiANCj4gdjM6DQo+IC0gRG9uJ3QgaW5jbHVkZSByZXdyaXR0
ZW4gQ0FUIHRlc3QgaW50byB0aGlzIHNlcmllcyENCj4gLSBUd2VhayB3aWxkY2FyZCBzdHlsZSBp
biBNYWtlZmlsZQ0KPiAtIEZpeCBtYW55IGNoYW5nZWxvZyB0eXBvcywgcmVtb3ZlIHNvbWUgd3Jv
bmcgY2xhaW1zLCBhbmQgZ2VuZXJhbGx5DQo+ICAgaW1wcm92ZSB0aGVtLg0KPiAtIEFkZCBmaXgg
dG8gUEFSRU5UX0VYSVQoKSB0byB1bm1vdW50IHJlc2N0cmwgRlMNCj4gLSBBZGQgdW5tb3VudGlu
ZyByZXNjdHJsIEZTIGJlZm9yZSBzdGFydGluZyBhbnkgdGVzdHMNCj4gLSBBZGQgZml4IGZvciBi
dWYgbGVhaw0KPiAtIEFkZCBmaXggZm9yIHBlcmYgZmQgY2xvc2luZw0KPiAtIFNwbGl0IG1vdW50
L3JlbW91bnQvdW1vdW50IHBhdGNoZXMgZGlmZmVyZW50bHkNCj4gLSBVc2Ugc2l6ZV90IGFuZCAl
enUgZm9yIHNwYW4NCj4gLSBLZWVwIE1CTSBwcmludCBhcyBNQiwgb25seSBpbnRlcm5hbGx5IHVz
ZSBzcGFuIGluIGJ5dGVzDQo+IC0gRHJvcCBzdGFydF9idWYgZ2xvYmFsIGZyb20gZmlsbF9idWYN
Cg0KSSByZXZpZXdlZCB0aGlzIHBhdGNoIHNlcmllcywNCmFuZCByYW4gcmVzY3RybCBzZWxmdGVz
dCBvbiBJbnRlbChSKSBYZW9uKFIpIEdvbGQgNjI1NCBDUFUsDQppdCBzZWVtcyB0aGVyZSBpcyBu
byBwcm9ibGVtLg0KDQo8VGVzdGVkLWJ5OnRhbi5zaGFvcGVuZ0BqcC5mdWppdHN1LmNvbT4NCjxS
ZXZpZXdlZC1ieTp0YW4uc2hhb3BlbmdAanAuZnVqaXRzdS5jb20+DQo=
