Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D5845B8E1
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Nov 2021 12:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbhKXLK6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Nov 2021 06:10:58 -0500
Received: from esa16.fujitsucc.c3s2.iphmx.com ([216.71.158.33]:53683 "EHLO
        esa16.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233494AbhKXLK5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Nov 2021 06:10:57 -0500
X-Greylist: delayed 434 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Nov 2021 06:10:56 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1637752068; x=1669288068;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xDIcarIgYXz52EhwVA4fuGCQZfDHnJ4Lc1BTD9Se6GY=;
  b=WV5g/CxO12dkDnNFuP8ZzivZ+YMVh5jDUp9q9eapnmQjxDZJNtCbzYmA
   mtBS9ZRa7ZTEbMTbg6bid1dUsMatOn3eoZzdVqr7ootR0uBrbkxwl4o8r
   tNPX9FbQCFKgYQloEdSlEv5dKvI81RMIvvT5Repn2STkfIzMsHzKNtoA/
   SUmeml9NFP+2tazJ6VXCCpY40sCMXtSbNtvkADqMADFFFPprL9kiIWj9J
   c7WL8xf35YayTApDO+ZxeXEt14K86PTUKt3el+zWxt1RFAle0x46OI8Dw
   JfThCm7yu6Y1QPtENPJ764qNhFifQsauWchxCV8J6HZDbwsirVlQv1iwB
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10177"; a="44427738"
X-IronPort-AV: E=Sophos;i="5.87,260,1631545200"; 
   d="scan'208";a="44427738"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 20:00:29 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/trdBHFMpTKIBpT9M018f/niP3dn1/UjZuFGFGJSZ5Y+4uYY7RULNriyaw6FNP+fvLAbzcuPHVXnxL16Z3gk6/0p/uUaa7y3iQU7cypGm0pXt/MrCTUpO62YhozwXex33vAAEBJHHmoMjBrDApPj9q60+ZENSyNZeloE5VmiZME05RSDNJqbrQSxETttyoC7cJAXUnYyUJzOx8li1i+J0DF1mR3cD8IsLDyYM6ErzVqRIWj/PelPGshr8epgEMSKHgroUoEhY63q6wrEew04Nd1fTPQzPKd3CfbnIAACVn7dKNL26iL9y/9LK6MAHmLh/HNWQaikAoWTvRctrGPsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0xaycaVWYo0YBMQvBwcYorC7FT3Q9sR6vpwNBLYV1s=;
 b=FapHVU+U38uxRjoZb13ahrRawJ3MvvHCueAfIeJUnvgqaW4o3cne8v7vw9JB0mYdVa7TBkeQufpJ0UMAEdImB/F2QhTuJ1q3WCxUydmuHBXH8RpNrTT+342rciNJrrp66O7W5gT0sK/RrR08F1tAYGurAIKLKt+15uxjAcS/thP0FLBxM2lPLiG2Rb68dH2xNa4heJmXUe86URm5NGpkhFyWpRGWO6wlxOjZz1/TswezER0nkbsu0YSYLkOys2jKqJkw1FkRR6jOCs2DDFsQUe0Dp/LH0HV0aEvS5rYveoy3V0gnkN839OTvqC7EORFlxfQ4JazBQtvc9QfVBFPwQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0xaycaVWYo0YBMQvBwcYorC7FT3Q9sR6vpwNBLYV1s=;
 b=CuH10KQyPJWreG0yfM0PEz3RRsIwaSBnGFAmghIaYx1BkzZ9h32HcwDwgN+M3HFRknQskvqW2XyIEiBHdkK5fhKRa41vpAAe55H7ZcVV71EXCz36CARsRk/BLdRpUmo5txhylOylRJ3Us8gFNBGvHctVIZeByZpadDejZm/aYsk=
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYAPR01MB2351.jpnprd01.prod.outlook.com (2603:1096:404:8e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Wed, 24 Nov
 2021 11:00:27 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::b839:7029:4084:48dd]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::b839:7029:4084:48dd%6]) with mapi id 15.20.4713.025; Wed, 24 Nov 2021
 11:00:27 +0000
From:   "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>
To:     Shuah Khan <shuah@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>
CC:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/3] selftests/resctrl: Add resctrl_tests into kselftest
 set
Thread-Topic: [PATCH 0/3] selftests/resctrl: Add resctrl_tests into kselftest
 set
Thread-Index: AQHX1hYLoIXWYBiglkum9748iqCiF6wSl40w
Date:   Wed, 24 Nov 2021 11:00:27 +0000
Message-ID: <TYAPR01MB633085FC70B0B6676D4466198B619@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20211110093315.3219191-1-tan.shaopeng@jp.fujitsu.com>
In-Reply-To: <20211110093315.3219191-1-tan.shaopeng@jp.fujitsu.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?iso-2022-jp?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZl?=
 =?iso-2022-jp?B?Y2UwNTBfQWN0aW9uSWQ9Y2ZkMjUxY2ItNTk4OC00YTNkLTk1NTctZWUy?=
 =?iso-2022-jp?B?ZTE3M2IzMmEwO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFi?=
 =?iso-2022-jp?B?NGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9h?=
 =?iso-2022-jp?B?NzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxl?=
 =?iso-2022-jp?B?ZD10cnVlO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQt?=
 =?iso-2022-jp?B?M2IwZjRmZWNlMDUwX01ldGhvZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9OYW1lPUZV?=
 =?iso-2022-jp?B?SklUU1UtUkVTVFJJQ1RFRBskQiJMJT8lUhsoQjtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRl?=
 =?iso-2022-jp?B?PTIwMjEtMTEtMjRUMTA6NTU6NThaO01TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?iso-2022-jp?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?iso-2022-jp?B?ZC04MWUxLTQ4NTgtYTlkOC03MzZlMjY3ZmQ0Yzc7?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3af59fb2-1682-4ae3-a6aa-08d9af399f75
x-ms-traffictypediagnostic: TYAPR01MB2351:
x-microsoft-antispam-prvs: <TYAPR01MB23513820DD0EEC0738953B368B619@TYAPR01MB2351.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 67spHt3oVU2WevC4sxEvJw82hjWfNtbNqAw/I+UYXv1B9iQwEuYw7fC8Wn0dZHCah12tgehVNfVtWCsDuKAvbz2UhH6es9HX4drWTu9jDUXzH3qWtcbezJxRelYnLUiF97N5q+7MqhQXih/mKOY06H/ZbsRF/8+0/zwFOqijw7hz962Uj+LyBtPWN+W2On9QuyUd4VGbS62sQVASaDuYwpjaL+wECaobmEV/hotSc0G04y0wXJP7njMWsIBGaysfWfsUXRm0t2yOi5wFSFPcmUJP9VGX5bDMbywAyTzKGPv7AKKS/ZIeZbuK9ulkPuuyatugs3fbu4ixLqr3sj1OAh7JiMsiN7IaFR8AznSivxnP6kWqw94PA36hfgDQ4AWLLmEQUrd0mQ8AmRoBDRJOOylZjPtvFqaSOuc+K3wCzwyQWZnho+pnTWBaskFaWcT5mnOALcjopWwkMVvtiGhhpLtbGA8yAplu2PDjs3fOVNnLEHQXePUIgjPxgxdfmjNuuVOO7xas+4c1jX5GN8SQwG04w4C/9pdm5sOhphZ5STlb0ewhfFI41R6/5oVE9KVkUP1lPTYvkZoN+HSGdeepsh2lOQR9oh5AHfVsC7mQg2UYULsw2ZI6U2tTt9ahNuCUfgRmlndIY4WiOTsnv5TjCg2Bhy5AsCYzb4vobpXEbQIxHADnvTouHpNSLEabV17zeURbsW2eA27cLYPGIr8MeA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(508600001)(8936002)(76116006)(122000001)(33656002)(7696005)(4326008)(38070700005)(186003)(83380400001)(26005)(82960400001)(66946007)(110136005)(86362001)(71200400001)(8676002)(66556008)(64756008)(66476007)(52536014)(66446008)(54906003)(85182001)(2906002)(38100700002)(55016003)(9686003)(5660300002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?clBTWFZqcDdXTlE0VktJMFJDTE9oWmtJUnVrR1VBV3l6ZTVrY1hSRDJQ?=
 =?iso-2022-jp?B?VXpkRHBrZXh3aDNqVVVVUzhReFBUZHB5N1A4RzU0RFIrNUZPYU43emw4?=
 =?iso-2022-jp?B?R2M1eUNKRHRXaWNVZ1BBcm5nZHVGcWtyZTRRZTJlbWxWa2ZkRGNNaVhs?=
 =?iso-2022-jp?B?ZDFZM0I5L3NyanFxbzQzVVhnK3E4UUxiRVp4eEYycFVQVmVGR1IwVTQy?=
 =?iso-2022-jp?B?QmU1L2EwVmU3SjJHWTJtN2dRTHJtZld2R1lBWjJ5Y2N3RmJlaVlHdTBs?=
 =?iso-2022-jp?B?d1JrQ1BPcTN5SGpwM0V3d29ubEtuREl5a1BzN3I3MUg4c0M0dDFvRmRW?=
 =?iso-2022-jp?B?U2cxY3FRTFBzOUJjZTJBN0l2dC9RYWxkSFhlb0F0aGtxSkJ3TTc4clRk?=
 =?iso-2022-jp?B?MWhIcEt2T2JZcW9NL3ROaENxb0VBdG1nTTN3UDF0ZFVocC9jOEc0Smha?=
 =?iso-2022-jp?B?Q1lINlZHYlkyUDdZUFVZMlR1VTFOQnJ5TXpWYm8yY1dlWUN5TndaM0NS?=
 =?iso-2022-jp?B?ZW1EdWZ4dkJwcEZremp6RGFBbW5xYWVySHo0WUZFZ0IyUmZBR0ZFN1dw?=
 =?iso-2022-jp?B?OVRBQXcxcUVrM0VVNmExUFAveGgrdGEyMXVMWDMvSm1pR0J4MStaTysx?=
 =?iso-2022-jp?B?K1BvcHFVMUxPcFpTR0w2eFh2L2Nsb0tuY2FVdmxOSUdwNERJOW5ocGdx?=
 =?iso-2022-jp?B?Tzh4SXZMa2VUOGpvbkJnYlpmR1FBMnBPditKRFp3dkVHUWc1M3ZCL0Yw?=
 =?iso-2022-jp?B?TWtmaVMrejNwcXdRaXl1OFR1ZktWSnhQMTN5WWRaY3NuZDBJZVpYUHdy?=
 =?iso-2022-jp?B?RFptSkRFMjMwMHk1ak1rNzZReDZDbE8ra2lPOFhtTEFtZzFCOWZucjIr?=
 =?iso-2022-jp?B?K3ZpQjVzckh4NzFmbUd3N2ErLzVOV0txeG4vaXRWek9JNHlzVnA3NG9Y?=
 =?iso-2022-jp?B?YW9vb2l0NlVvbktCZVpBZXNoem5zY3hvV0taRmZOVkJ1YWFXYWhnRW9r?=
 =?iso-2022-jp?B?WVgxSnRrVGM0ejhRTDVUNzNKK0RiZnQ3a1E3QVU5MGZGTk5icktHVzFt?=
 =?iso-2022-jp?B?UXU5TmJMQWdGQkx0Slg2aXZkNmpTQmRodGRUYWJ4S3hZMWxuU01MdUl1?=
 =?iso-2022-jp?B?YnBxRkltWHdsTklyOGRjRTllNjAzLzE2UnhSZllJdldmOVZjcEVVYWtu?=
 =?iso-2022-jp?B?VFVCaXY0MHJ2V1Arckl3SGtZQW1aSExnZ1k2UTFmVHRPZC9TMDBhZG1I?=
 =?iso-2022-jp?B?MUpoZG5Vc0lPMklCR20yYkR0ell0Szl2M3J2QmtDY0tURVFkWmFlUnd6?=
 =?iso-2022-jp?B?Wlo4S1gyUU11NU1LNjRiNHI4b0ZJcTZXRjBnNzNPV1VLejllekRNbUgv?=
 =?iso-2022-jp?B?SGhrbDZBTlB2Y3dJejZJU3NNNk1yQStlRGxGbFp3N1pkZ3BXUXM4RENj?=
 =?iso-2022-jp?B?anJqQlZjOG1XYU1JQW1zUzA2bGkxdms3UHpvbkU5Z1g0SEJZeFVDQ2VT?=
 =?iso-2022-jp?B?cDNHdTF0S3NvajB5NjJOOFNQWjNqeDQ4TXYzOSswZWFCVTJBZWZPRWFm?=
 =?iso-2022-jp?B?bG05VG95RHhUcWt0NE5nN05IUHRrVkIwY0NMZjhCOEswWTFZN2dRSXU5?=
 =?iso-2022-jp?B?NzVEWFB4azVkVFQ1RW9DeDFDNGQ3cklBMEk0UVJ6NWVVZno5R0EyTDVG?=
 =?iso-2022-jp?B?NzR1dTZNcnFxQ0V6T1l5S2RtYitGK3JYbG9SUjlmWFl4eDkyMkZ2MXkv?=
 =?iso-2022-jp?B?b09VYTl5aXVZS09aaWZRT29ncy9HOEw5T0llSFlRWlFEZnFKemVoTG1i?=
 =?iso-2022-jp?B?RzdFZFBSQkN4U09uMy9UWG8rTlIyYlByejAxazMyanFrZVZqRWNnS0hx?=
 =?iso-2022-jp?B?WUNxWVdTZlFYYzFpemNGcXc5OTJLVm1qNGp0dkFJa0drcUIraXhBWm9L?=
 =?iso-2022-jp?B?cU9qcnNPNm5OS0hiLy9WbUtMbDdNYkRVZzY3WnpBdHBWYzljdlpVd1p6?=
 =?iso-2022-jp?B?bTJ5U3pmbXhxVTltU0hLdFhNZUwyKytaTjVPckRERWsxRTJlZ1oyWXRp?=
 =?iso-2022-jp?B?dlRDeEtiZkpOa0dRQ29SdXkyTEF6YmZoanpCR3J3Tk5CZkVHQzFZN2pz?=
 =?iso-2022-jp?B?ZlUyUEhRc1RSakc5UW5Mb3RtVG12VDZOVkMzOUd6QmNXNmdBbjN4ODhu?=
 =?iso-2022-jp?B?TkY3MThrQXpWQm0xT1hod2ZiRC9ML0gzMHMydXJLS2NjVklZSkVKNlAv?=
 =?iso-2022-jp?B?S0pwOEh5R1hCOWoxZUgwV2FYMXNFM2hvY21MWnZYZXJIYWZxWmRocUhB?=
 =?iso-2022-jp?B?OXlDS1lzUityM3JKV3RIMEo1VFhGRVIrYkptMHI1dDFkUEozVmVQVjRl?=
 =?iso-2022-jp?B?d0RnSXhrTG9obGlCK0tZbnJ4ZGlQL3J2Y0FEaE11Tk44akxSSHU0aTJB?=
 =?iso-2022-jp?B?ZUpEUC9RPT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af59fb2-1682-4ae3-a6aa-08d9af399f75
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2021 11:00:27.1864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uZido3PVTkZOnr3sWKzTMcH8zsbmXH8N8OrwXeWaXk8TuhO9l7k50zMXof8NvbPIoKMW8dxN8mFBl8PG/kAJ+KDlmDvTYdATojfUwqNg29U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2351
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

Ping... any comments&advice about adding resctrl_tests into kselftest set?

Best regards
Tan Shaopeng
=20
> Hello,
>=20
> Resctrl_tests is in the kselftest directory, but it cannot use kselftest =
framework.
> The aim of this series is to make resctrl_tests run by using kselftest fr=
amework
> and to fix some bug/setting of resctrl_tests when use kselftest framework=
.
>=20
> In kselftest framework, we can build/run resctrl_tests by build/run all t=
ests of
> kselftest, and we also can use the "TARGETS" variable on the make command
> line to specify resctrl_tests to build/run.
>=20
> To ensure the resctrl_tests finish in limited time(which is specified by =
timeout
> command), set the limited time for resctrl_tests to 120 seconds.
> When resctrl filesystem is not supported or resctrl_tests is not run as r=
oot,
> return skip code of kselftest.  If it is not finish in limited time, term=
inate
> resctrl_tests same as when executing ctrl+c.
>=20
> Thanks,
>=20
> Tan, Shaopeng (3):
>   selftests/resctrl: Make resctrl_tests run using kselftest framework
>   selftests/resctrl: Return KSFT_SKIP(4) if resctrl filessystem is not
>     supported or resctrl is not run as root
>   selftests/resctrl: Kill the child process created by fork() when the
>     SIGTERM signal comes
>=20
>  tools/testing/selftests/Makefile                |  1 +
>  tools/testing/selftests/resctrl/Makefile        | 21
> +++++++++------------
>  tools/testing/selftests/resctrl/resctrl_tests.c |  4 ++--
>  tools/testing/selftests/resctrl/resctrl_val.c   |  1 +
>  tools/testing/selftests/resctrl/settings        |  1 +
>  5 files changed, 14 insertions(+), 14 deletions(-)  create mode 100644
> tools/testing/selftests/resctrl/settings
>=20
> --
> 1.8.3.1

