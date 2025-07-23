Return-Path: <linux-kselftest+bounces-37871-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B458B0F00C
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 12:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B5F63B1DC9
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 10:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE21A28CF47;
	Wed, 23 Jul 2025 10:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rvB1HT4B";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rvB1HT4B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013033.outbound.protection.outlook.com [40.107.159.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781BA28A73C;
	Wed, 23 Jul 2025 10:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.33
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753267109; cv=fail; b=rp7rR72dtxumJeFjAov6poc/TFygjrlYebZWBxRRvSLleLmOdmWmLw63yrU4gsmf40wSMy9yFzir1xRF4q2jaXTgbc1eWsHHu2YWYMi3M3uCGm53yeYDCbe7EMqcJHWXha8QsxmvFE1qCF3Ckiex/85Gt/ethBw7/FiFlbHLCpQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753267109; c=relaxed/simple;
	bh=LIF3okMbzddOSUvtPmZT5VOIDzpAL7iAxrS28nUgsWo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bp1rRrmT6L0K2YPPFS5fx8bWHod0TYA6SShDQcIFVuJjzoJEN426ioq45qgqyp+cwpLQjUN/NzE4eMPaNdSPAf0zhON5ItUK5ukMqD8soGw28LQwo2yeA0xtSKcsrFyCCGEjUdKtC8sWNmwvRnjm9CAY4Q1aVP+qBkBeMac+Nz4=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rvB1HT4B; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rvB1HT4B; arc=fail smtp.client-ip=40.107.159.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=iv/TuXM2HOnZAmDXY0SQcCewrelhnfslwCxHJc25kRpZQRZjnzIMHpbvyVvYtanXo3D+Lm9/+5bvjRXhuVLT+h8uzoDK5fJ6glZPLzGL/JY4BAiijGEQVd+MBsgUBsUHXKAT2rgWrJ0Q07t7cYb5r+pL06S820z4EGTQneidF+ZjwBJJqIW++uIwUBxod8SkK1NK9GDS1QHWVMkLxYZ5ocvZI2p3XmmS1CS/wpKUKjzsHrxRe1Xtge7pHTspe1iE59mdIGPY+dNX6+D/MtjcmCkALHirD2l9G0o21ANFNq/s/DmzAj7GZjoVRciFhAPeaWp6DykXH4xpAw++JSreyQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vo0pWag35H28imTY8kbJOO5isbJbCghSOn6U9yTQvWM=;
 b=tbYFS7yk9D8D73CiO2CPhZnJmk00hig2gnBY9wfHF12uXtIJBs9D6UyP4TiyZ8o3KXhDXhxBu/fmFKERaSA+k7a0PxXPDmi0i1KfepTJadneCWvoU3t5xk5EGubOCB04X0hjga63A3wSYohumoFTsdVx59gLTwUsIrd6jloHJLUlC6htqkElgS1mfhynsNPZ2mYxXn/q2X7DNXu/vVX69QmE962fFK5GVsQqMvZFctVGBxlu+K2rACDVmGW+aJS5Eqm5p8n/CbWgd0R6Lp2K+mkRSNxIJelG0iyD3LixI4ZbC+IgWK/TyA+bBjTm21fKig8sbjpoT2tUQLblDtQpmA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vo0pWag35H28imTY8kbJOO5isbJbCghSOn6U9yTQvWM=;
 b=rvB1HT4BlQTY3N0KPsh239tBwuqHcbD44nxwltEpMYHhkr2kHd1kw09rWzOTchWgwmvEpqoMcxkoLzaRtO8kjAI8FBrCRWLDC+546IKnT1XeBldlF2LTdgmccLi05miZc8JJiekMKzRMiX9KVNM7TVBOIxbWS/0LBvt6lfevmy0=
Received: from DUZPR01CA0278.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::23) by AS2PR08MB8454.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 10:38:22 +0000
Received: from DB1PEPF000509E8.eurprd03.prod.outlook.com
 (2603:10a6:10:4b9:cafe::e2) by DUZPR01CA0278.outlook.office365.com
 (2603:10a6:10:4b9::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Wed,
 23 Jul 2025 10:38:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509E8.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.20
 via Frontend Transport; Wed, 23 Jul 2025 10:38:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U9GKRmMgkTqjm6/0CdienJ2OyF1CclYBwGIBYde/4og1yV+5FdTKmTnGz/pOcgrtx+L8EPr0DbZHi6waJVGjSKmc+Hs56rbossBff24Th1r+JpRSkhSJdV69kMU5gFtOB/MVOooX6r5mkR+5xjPrmtSOyoqFwsQLak/v81XF4Y9kNKZHVqvQsKV3+f/pGn384rywHPTU9tx3Pr/SZf4LCtusf8kxvluTyI6pSoCys+e5++wt+OfqEdx7+PLlTV95w1sm7IwkzGPFkZ4zkC5ecsWFuGy1mm3IgNHIql75uTj8LbMR1yVonU8JXvFvlSFwoUr3T5B3D2/3AcCBISzfCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vo0pWag35H28imTY8kbJOO5isbJbCghSOn6U9yTQvWM=;
 b=KsYtu6AQtIuZ5QTlPFArL3g0vKV8J7j4PIWYjFk2XdhZ69BVvTURs1Q2QpFdNPWwv96uEoM5zCcknxRWyS4zhbW8tjmkPc6H5vhKmrTfkupBws0Cf8QojCFh3kDYyRufIS1pETGqp/Fi/RKqc8YR0umK6dx6OcwxA7pDYyPa1UbBxD2vJ6GFnXU6RMk3jtUbvuYnHjizqM/cedGldICbAA1iO537DPh3CQwxMCtUYFijKtQ9dghLptoUgqPMU9fG6wlzMqQ4OigKUh3HyU0SNfioFRzqBit+U6hmMdMb9nGTs9Vj2Lb5TXZtAJgpAn9vNkqwhbABz7TJ5dWrATNnpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vo0pWag35H28imTY8kbJOO5isbJbCghSOn6U9yTQvWM=;
 b=rvB1HT4BlQTY3N0KPsh239tBwuqHcbD44nxwltEpMYHhkr2kHd1kw09rWzOTchWgwmvEpqoMcxkoLzaRtO8kjAI8FBrCRWLDC+546IKnT1XeBldlF2LTdgmccLi05miZc8JJiekMKzRMiX9KVNM7TVBOIxbWS/0LBvt6lfevmy0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by AS2PR08MB8334.eurprd08.prod.outlook.com (2603:10a6:20b:556::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 10:37:46 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 10:37:46 +0000
Message-ID: <53441c33-ac45-443a-a16e-f484347a2525@arm.com>
Date: Wed, 23 Jul 2025 16:07:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] tools/testing/selftests: Fix spelling mistake
 "unnmap" -> "unmap"
To: Colin Ian King <colin.i.king@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250723095027.3999094-1-colin.i.king@gmail.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250723095027.3999094-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0069.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::10) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|AS2PR08MB8334:EE_|DB1PEPF000509E8:EE_|AS2PR08MB8454:EE_
X-MS-Office365-Filtering-Correlation-Id: 4177a55e-337f-4574-3451-08ddc9d50b46
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?b1FHeEhRTUZTdmg2Y0JpU0ZNMHQ1SUNpbndnOURuRHBuVmVmR2RybUdONE91?=
 =?utf-8?B?Q3BrcTVOQ3dsRk5iUDBVQmxIQ1VVK251cW9jdjkvZ0UyZHRqaFE0c3l3c1M1?=
 =?utf-8?B?RFovaGgyNGpUK2tqUjZIVmNxMElBMlJyMytkT2YwUjUwZXJEejFJQlNYbnlm?=
 =?utf-8?B?c0pJZnNkck04dWpEOXVPaHB1RUhsQ0ZIZ3JzMlFiNllwY0Z3bTlNeG91V2ho?=
 =?utf-8?B?dVVJTEtaNnBZTnZPdGVkSkFzcnpqeXZYczAzUnY4eHE0dldEc0FxaU5ybFZi?=
 =?utf-8?B?N3pkVTR5MXExbk5IZ211eWFCTllScytnSnNJQmhDTGx2QjdNNjI0WkZvaDZN?=
 =?utf-8?B?bTJESU9vbDVkSUMyRUxiTU9GR2s5M0VCZ0licldwTXI3enV4ek1xNlpWQUR6?=
 =?utf-8?B?UFNBL2I0aG9sOU1kYmlzTnFrMkJzM01yWXJxSGlDdG0yVkpHL2JDNmRaTXlw?=
 =?utf-8?B?M0VzWmljYzFWSDZTSm5zMXQ1WHFNNXF2T1BkVDEyaEx2YnpHSWhUaVZJTWow?=
 =?utf-8?B?cE92UFZSUnNoZHNvQ29xVTZSRUFiWS90a1M1R1dBS2c5WFJpY09JWVRLNFI4?=
 =?utf-8?B?SFUvcG1qM3RIT3U3SW4yck1UQkhubVkzMXp1QXVxQXJUeWUwTkJON1pvTlk5?=
 =?utf-8?B?YytZRkhyaGJOQXorS1BHaG9RaHJuaDJ3WGx1VUFNTE5oc1EzYkFKb3o5eU9U?=
 =?utf-8?B?TGM4MUQvMTI0Y0hsaTZMM2xYY2t2RVFlZWo4VnppZGxhbWZMSHhyQzZoVGdv?=
 =?utf-8?B?VmtBTllkZmJSelliUDdpd09iM215bnlTYmJwUWJSYm1yeUN6V1FqSFZRa2Fa?=
 =?utf-8?B?dXJvMkNaMWNnOXBCVnUvemFZMmN1NFFKajBWSUxXbnNhZlRMZEMxMy9PSElt?=
 =?utf-8?B?WGFrUkZjOHhOdkFQSWsvdm91L24vVERudDAraHRhMnNpcmVKYzNwN3ZOTytY?=
 =?utf-8?B?TmRjaTlLaXBvVDE4TTRZQUY5M2RhdGlFcXFERWVMK2sxR1pzQktrL2dGNkUw?=
 =?utf-8?B?ODNCaVlld3l6QklLY0JGZnBtMjJjRzJQNkY3TEpvYnpZSGFPakltUDV2RmJy?=
 =?utf-8?B?Z0Z4TEdnYXAySDcvTE9EYWtuOWdVR3ZCNy93MFQxZHQ0WFJnNTZkK2MzeURl?=
 =?utf-8?B?dDVmdk1lZGo5OWthT3ovSXk3N1RzcWl0U3pOUmY3a0s1ZHU3cVNKcCtDUm90?=
 =?utf-8?B?WEczK3JpODQ1RnR4RjYrODlSMTVPOXRuZnUxOWc3d0trVXVqSG5EbjkrelJK?=
 =?utf-8?B?aU1aOUV1bm51TnZaSkRoZUt1aXhkNU41cCtnTnJCT01pcGJaWDlhRStuSmRl?=
 =?utf-8?B?NENPdTRhMVV5MGFRRmk1azA1WHhTanFqSDBuaU9DVTVxcS9aT3BpdzFNOVZz?=
 =?utf-8?B?aHQ2M1EySlA5T2FSeXZ1d0xLV2w4MDd4K2Z2VmtUMW55SVBVT1pjVUZrcXFJ?=
 =?utf-8?B?eld3QkZuK2Z6Y1Qwd3ptZFdkSmc2THdGK013bzlIY1gxVGNha0JGU0RESjZQ?=
 =?utf-8?B?MU5VcnJDSlJzZG9LSk9iTUdnUXRCcmx3Tkx5dDNFcGU4SEgySmF2a1hsVW9m?=
 =?utf-8?B?MEhZdVh4RzFDeTVNWGVYT3ZBNVlYbyswcEYzSkNEZkhNSjdSdEpiaXBrOWhi?=
 =?utf-8?B?S2RnRWxHaGJTMEJBZDlUUERYMmt0WnNCZDZJZ05wRERiZjFEWC9LRk0yNFQ2?=
 =?utf-8?B?SVN2MWgrVHBLanU5ejVpa2dxUFpXNmh3Qy9kR3Z4ajcvRGhtV3Mvcml5QmY3?=
 =?utf-8?B?Wm5mbjF3ZlNhYWR6YVFjbVJSUjhZZWdoU2RnVVdNdmllVCt5Q2hZeFZRR3VI?=
 =?utf-8?B?aXNxVzBIYSt3VXJmcExWUDdFUEJCdnYrSjQ4NjlMUTQraHpUZ2pGWEJXSnVk?=
 =?utf-8?B?OW81VjdNUDFkd1N3ekcwU21BY1c5OGdDZTMvVDlMQ3RaMUE9PQ==?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8334
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509E8.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	3f0005ab-e040-4752-c851-08ddc9d4f65e
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|35042699022|82310400026|1800799024|14060799003|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REI3MWxZMElmUk1VVlgycURoUE9UWXl3eUdpUnpKMS8rNC9yaXpJYzd2VUQw?=
 =?utf-8?B?VC8ybGRrU1ppSlF1V3hqaS9TZGFyWmpQdW5sUGVvczUxbTN6MWhoUXNCeFp2?=
 =?utf-8?B?cHRram9aaTBUOHE1LzJUcVFEZzhrc1BOVDM4eGp5c3RTUlcySHUwcGdPbHR3?=
 =?utf-8?B?a0JOWEd2VGZ3ZUpISU9SUEZvZ2xYek9CRXFyWmRrd0lmYVJJOGJIOFlJWmZ3?=
 =?utf-8?B?ZDB2MXZqQVc4RGJ0RUZocUpPaEtZd0tETGFJUkZ1cVdtcnN5RkM1WjlEVG43?=
 =?utf-8?B?bFdoVjEvTmhRV0ppUVh3ZDB5VFFzY3k5c0hiU01hZEU5MnVTVExBcVZ6cHlN?=
 =?utf-8?B?S1ZvRUZOKytFbGJ4dlhQMUhSL3FMUTZ1U2xWOGRkVlV6RE5UYWNrVGVSNU5j?=
 =?utf-8?B?eFVnL1pBd0R1SlE0SVlIWFNidWxmb2liTFN5RFVua3pFaG1SOUQ0bXVGQW5h?=
 =?utf-8?B?R3VaN3VCSnpSMFVVdUFDWkpPMngyOTBUSDJ5eVg0RFEzaHNxTVpKWWVGRzFQ?=
 =?utf-8?B?VDNOTkRUc0gzZlluRVdlMW80WE9QMElsdWV5b2RJNGh1NElDY3U3U2pQSThl?=
 =?utf-8?B?bjNpWkJDT0lRVUFMdDJTblpSdU5KTC9Sb1lmWFdRUDJLM2s0NHJUcEhlWXll?=
 =?utf-8?B?c0szSXc2VzUxc3QwSkxCZW1ZUnlXMFM1TzBaQVV2Q2FBSVAxckFTbjZoMXdk?=
 =?utf-8?B?WW9ZWFMyYXlocGxmNkcyVDVEa2N2d1pvYitYY3B6eWp4MTN4Uk9qZHEwU3Rs?=
 =?utf-8?B?bkZQeFRCNzJKalM2S2RjeXZGeWg4eUM4VmQrYUZ2OE9ZSHNvc3hob3RkUXpv?=
 =?utf-8?B?dmhxdXFuMHVZU3YyMHhqVHp0eWkzczZ1dWFXWndjSGtXVTY1a2E2N1NPZjNR?=
 =?utf-8?B?dXgwQ0Y0QThDUEE1aWJwMnBJa09VVXhiSUJYS1lQMEFaZVVaUElJUDFkWm9H?=
 =?utf-8?B?T0VXaHpIOHdCOGZaeWVIdVBlbXFGeDhULy9xTWc1VmdDR0M2akY4aHRGK2t5?=
 =?utf-8?B?T0hRQUV5ajJac29IV0EzSGswUjgrV0dlMUdiOG5DMERKWWM1R0RkUXRCQjRt?=
 =?utf-8?B?cit1R2I1QU01aTV1a1lnNGFaYkdJc1orK25FNW1JQjdMYkVNQnJXRGsyS2F2?=
 =?utf-8?B?ZGdVREpLZEdkVXcwNHFGOWJzSURaazlXaEtNalNaRWNXNlBVYlVmQ281L1ps?=
 =?utf-8?B?ZUl3UlJRdnVMdHh3dnYwUEJESXhiVTNsZkJSTk5tYml0QlN5ckxEMnRVVHFx?=
 =?utf-8?B?MXNNSEZrYXA3Zk0ydXBSYWt0Q2U5cVh2dHZxZDU4bnVnNTFXWWVNOVAyTmtv?=
 =?utf-8?B?Z2xsdGl2VUlJbm14V0x1Y3BaL0RGU2wyTk5nbEJuOHpZbTAyaXNzTnhTcUpl?=
 =?utf-8?B?QmVJR2F0aXYvSUkrZ3A5VWltQlduTGJkMndGSUVMRW0zRU5ybWVKUEdDcC9W?=
 =?utf-8?B?eGFCLzd3QmcvVVZSU2E2dGtvVFB1OHVrZ2ZGVm5sS1cyMkRXSlg4cTVBa2V2?=
 =?utf-8?B?WHgrdjFkdlNiVlY4Um9TcU0vMXNKMFYvMGFCcCtoUW5Xa0s0ZXFELzF3U2sz?=
 =?utf-8?B?ODBwTjFEdktWazRjTXFZR3JHRzNOdDVKeXBwWVZ3QU1pMGdLY3FmK2o1SmxF?=
 =?utf-8?B?T0t6T1Z0Z3pFeTdWTUxMU0lUa1JsaUY0UDdpTGJzVDNZbHMrVlRFaU9saE1t?=
 =?utf-8?B?a2tpbkVpRWdDZHlkOXMrZExLU0Rxb2dyRk9rSFY1Vkx4Nk5IVURBbXFOSUIx?=
 =?utf-8?B?a2JGM0ZKNlNrb0xna2JqT3gxTFIvMlgrcW02SVFraVNpOU9UQU9FUXBiUHZQ?=
 =?utf-8?B?a25ydGd5TldqN1piZUZTQkM4NEZpVkRyUHhXQm5hUG9WWThDb3ovd1AzZ2t4?=
 =?utf-8?B?SnVIMXZOQ05nNEY1d2l0ZExMVjJPeTBOL1p2aDM4aUFTZHNnNVZzZjZCNGF3?=
 =?utf-8?B?MTNwWlFYeHljSVRpQ3VCeEdBc2RMVlNzQjVWWFpJdm1PR2lRTEptNGVubXFw?=
 =?utf-8?B?TjhMSUl5Q3A0b1R1Zi9YWDRMU2tJdU43a3FjSEEzVklSSjhUYU5od2M0ZTE3?=
 =?utf-8?Q?+6N/Ju?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(35042699022)(82310400026)(1800799024)(14060799003)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 10:38:20.9807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4177a55e-337f-4574-3451-08ddc9d50b46
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E8.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8454


On 23/07/25 3:20 pm, Colin Ian King wrote:
> There is a spelling mistake in ksft_test_result_fail messages. Fix them.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   


Reviewed-by: Dev Jain <dev.jain@arm.com>



