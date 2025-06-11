Return-Path: <linux-kselftest+bounces-34706-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA43AD55F6
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 14:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D723D16D23C
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 12:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D71283121;
	Wed, 11 Jun 2025 12:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="QcR0AHOm";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="QcR0AHOm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010044.outbound.protection.outlook.com [52.101.84.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319D92E611B
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 12:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.44
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749646329; cv=fail; b=sfWeWkghZIudl0pHWpi26e4Rk8nFdV35N8mD1d9NOOB3EvtqN9erqq9mFI3sJSziQEGICFR9P5OiQrqe6i3yCbu3mZcAa4DvkTUGCBPR+l8mLkAws3irbALfhYMX3n/znwrHFmpZVyToQVXoN+rJr88sv5Gl+2rWwAamwPsJyDc=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749646329; c=relaxed/simple;
	bh=6f6g0/7MW2SuLw4dmDqxTHEOSJoTKADK0/6sZcwn31s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ORqxx4K4zMAxWzWzLPUTmRvmM4GMYNhsiixGByqJGbMqnivRmqHDppdfqeNlsc/r4vh+1vV0KbxWDRB/nhghPgCNwOB01ZopTepWft6SCch22oLBz5ihFUX7B+tcGPVEFrF7a/QsCciVfNlhm8gmH9kQwmfUGz+yZcWhUkgAYe8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=QcR0AHOm; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=QcR0AHOm; arc=fail smtp.client-ip=52.101.84.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=fq54Bk5wVWY/Gu0ZtT1mAQfd1x3giiwNtSFxiTYHJemAXr3fnt3IYkDVkgRBikdzZVwc5e4x9myCcpmzY6V8DZy8KMowmeJhj4twBQ+UFnv9zAP4Of4NFZnFmSkjQWVv5Vvd8J+tWtSKbeTUrJ3UwWJK6qnibN++4rBkWb2ZO7H9/kwj276KOKA60cY//hiNy8UwZwx70Fs8zofC2NMvYHo1B1B9AI0mskBqWv1I6F6Gj+DSSUjqDeYfEjkB8TxGSL51BupAzvD5ibV2ohmhn+sPPLkyqxSPx2D4ldp0vAhfQX9WsuM3Lq85dkuaj4C7mL4ZpYwB0VXxbtudzxXYIQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClqLAl2U4SF5u1Ma5kFwGhztmIb1f5Ta87TBkzNKBlU=;
 b=TMWbv6o3DrYHjFmSiOA8rmbZcMEMMdL5qP2vDWU55GsbpfbqQsbgutpx0QE3HeTz+LWIXlwIfJ1g/RM3D+sscTtjKP7jfjozm3MgmWegGkWtEkvFX5HZXh0UVY1ErVsznXAKp9JASy8BC3rgBqsAyw0tRx8AffwN9b+zTAm6zSLQSfI62w0h3xBwqhYsMrjmnsGM0NQyZFfCRaiffRGf+8v543/dtSHqstyDFHM21Dc4dSxfUbO3kWqQYxZoHEmkiHu/emT1ZlWZ9zLv1EavpDZtxj1U223v5yICTJxxWr8t+zVJ54cJiX82m9HuZiJgySr2MTEUUAlmsKrFuty0+w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=oracle.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClqLAl2U4SF5u1Ma5kFwGhztmIb1f5Ta87TBkzNKBlU=;
 b=QcR0AHOmEuXJAVPjqiR8Sa/1HbbgOldAx4GVJpaY6qglOObLf4hlrw1LOWX0zvGIINEonCZ5d65dSqvzYXY8UViOUyAooloujc641E21liF8d4TfJMiV8E/CDunuzdP8VCUkbcNBws0k22wO/WXg7p0ba126UKTvY9vE4SYrASk=
Received: from AM8P190CA0019.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::24)
 by AM9PR08MB6146.eurprd08.prod.outlook.com (2603:10a6:20b:2db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.27; Wed, 11 Jun
 2025 12:52:01 +0000
Received: from AMS1EPF00000042.eurprd04.prod.outlook.com
 (2603:10a6:20b:219:cafe::3) by AM8P190CA0019.outlook.office365.com
 (2603:10a6:20b:219::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Wed,
 11 Jun 2025 12:52:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF00000042.mail.protection.outlook.com (10.167.16.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15
 via Frontend Transport; Wed, 11 Jun 2025 12:52:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cL2uGA5TP39bVFdTEqjMBp5qXcuzopNz/gmerYGgcv8juIWRJeLK249Q0baHM73LX5xo4pzgfsmYf+Q3OM9VfGZZP//xzHw0gmTb/WZLZZTt6vImSfJ0zDpH4hOeDMdHrJbtVH7S+ppyCYzRqEAlNmcqbjXEEel/yRXsC3C4RcrjJuK8CVV/dmdFApAiC6bsp3+cZ6UK+TEnmNRu7SW8hae0PKuwgzIhxk9CSh0Oj4IK0bIctzotSNR0h0/L+jdMNomhm0yUy0FsiRJbpz6x30GCJSJFb0g394uooX9QlqR4RZ6bxAPFQcplPlWB9Z+o5ZWssTaaf2+GTWitTvGw3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClqLAl2U4SF5u1Ma5kFwGhztmIb1f5Ta87TBkzNKBlU=;
 b=TJrydS/XnRo2vPLGxcKFgRPgeWzV7n+vesYa50aGhh+Y/CkGWVCw79MFtJln64JMdofSivAptVa8DHEo7RCy1c8eRJB6wp64Qck4bklPJ5Hn2WSwXbWzvhQkDqT1KHXc9Y1nO8nAW4mCxxVbLpZdLWOIKmaAN3IZOhsR2MZv+WQubwbi9xBxHdb4VGLdAt1SVHryF13ykagqXHe/ZuazGBaKz6+yE0XVuEgCF4lEVxPQCw7VGu+7Zzb+kpwSaXuhqcIubbJPPWBHjEKZcS1+cXqrxdtmQTrpo/D7zDLRSmS7Kp/Jitiv+M/syQgqlup/DyrTzxB3QEpYirYF4ef/uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClqLAl2U4SF5u1Ma5kFwGhztmIb1f5Ta87TBkzNKBlU=;
 b=QcR0AHOmEuXJAVPjqiR8Sa/1HbbgOldAx4GVJpaY6qglOObLf4hlrw1LOWX0zvGIINEonCZ5d65dSqvzYXY8UViOUyAooloujc641E21liF8d4TfJMiV8E/CDunuzdP8VCUkbcNBws0k22wO/WXg7p0ba126UKTvY9vE4SYrASk=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by AS8PR08MB8394.eurprd08.prod.outlook.com (2603:10a6:20b:568::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.28; Wed, 11 Jun
 2025 12:51:28 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%2]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 12:51:28 +0000
Message-ID: <d38ea060-38a0-4672-a4ea-2a52e1d0fdd7@arm.com>
Date: Wed, 11 Jun 2025 18:21:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: Add CONFIG_FTRACE to config
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, shuah@kernel.org,
 pfalcato@suse.de, vbabka@suse.cz, jannh@google.com, pulehui@huawei.com,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org, aishwarya.tcv@arm.com,
 broonie@kernel.org, ryan.roberts@arm.com
References: <20250611121011.23888-1-dev.jain@arm.com>
 <452f1851-5511-4326-a206-86e119b58841@lucifer.local>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <452f1851-5511-4326-a206-86e119b58841@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MA0PR01CA0104.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::10) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|AS8PR08MB8394:EE_|AMS1EPF00000042:EE_|AM9PR08MB6146:EE_
X-MS-Office365-Filtering-Correlation-Id: 45a0ab47-a8fb-4c87-cca5-08dda8e6c24a
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?bEZtbFd3MUtic1NMT0tuY3drK29vWUhScEhjaG5Sc1VsL3djWHZzajkrdktI?=
 =?utf-8?B?UzRDR213VUNsNzVvSEU3eEtWSFlqMDg0bDJiYk94dHYyUDR5OHMrYTRoMHJ5?=
 =?utf-8?B?Y0JjaHlxeDJaWmloR29MMjZFMnB5RUd3UDJFVXhXZUJjWmhIZHZnMlhuYk9F?=
 =?utf-8?B?QUlhemtUVGEwVGttZUQweGFxNTJlOWliSWs1aGdYRlpaTTVHMDlWVUtvY3dJ?=
 =?utf-8?B?djlwUGdBV2gxRzUxdENsa1liTGt3M291ck1xTVZyR2ZIK2RJM3ZFTThGQWJF?=
 =?utf-8?B?TWhnWVpobmFKWUt1YzBxUVBES3haM0lHdTdWN0h2RVUza3JWSENWaHRtVyts?=
 =?utf-8?B?aDV0cHNqSFNEWTRaOXVqbm15Y0plSGlxM0ZKTWdUVU1DdW5hTE5BTDViWTNK?=
 =?utf-8?B?b3FOZVFEaWRHYnZlS2UyOTRSM0xrSlZwbzdLb3hJd3RyT0tLM0hUL3FMOGE2?=
 =?utf-8?B?RW5PaldMbk90UHVtRzh5dlYwQ2lmQXhOZVRMRWo5ZGRCMHFTT25lZ0o0cWp0?=
 =?utf-8?B?TjdmY01HcURmSXpqdXk2OHNJbWJWK0x5K3RaRmlPVjl4UkhLWGlWaldsVW9F?=
 =?utf-8?B?c0M0R012VEFsOG02c0xVa1FjVHhwcitPMGVRUW1HZWZZRThoOGVlR3hNdW4z?=
 =?utf-8?B?c3d5amJjZkNRK1ZFZ0Y1ZklSZjFRcDJwQUd0OXYvdUxPVVlaT1c3ekozNWto?=
 =?utf-8?B?U1ZyQ3hQMDMwdmdNbnVIK2dmT0V1MER4dk5iWUtteWYvUkIrT2IvVGgyRDBD?=
 =?utf-8?B?VG5ldlQvaHBlUTd0WWJ2UWF5czJ4a2Z1OWg3YjFnRkhwcmkwMVhTaWJSa3lw?=
 =?utf-8?B?S2pDTGZiOVRsRTlaalY2MEZ4MTdTTVZzY0NoWng4enN5VktEYnRjMUlIQTg4?=
 =?utf-8?B?amZGU0RldklDZUh5TEZXY1BCUFlBZm1EcnE1YlJWQ0dtdWxMeWxIak9LNjRG?=
 =?utf-8?B?STFxWUNLN1N2amxyVWtCK2tRcTZmRGpiTE5FeGNCN0QvdWhlREdNVmMxaTcw?=
 =?utf-8?B?RVlOekpYc2Zwak1nSUNmdExzNXczM2x2aGlyU25HbkNSMHRiOHlkRHJtMjFI?=
 =?utf-8?B?QmhHcStDY20wQXNpRlFDWVhndTdtREZnRnBkOVVVL1VrS3FlQThVTHFGOGFG?=
 =?utf-8?B?blNQMVpXS1ovVHhwTElUV0hBZUNaWmswaVYxaVF3RGwyQlZ6TTBVMXI4QzVE?=
 =?utf-8?B?d0d3TytRN0NwMEdMb0M2bXAyT2daK2w5UVEzV2RuaXY0azdjbXRlenI1TnlL?=
 =?utf-8?B?cThaYWRvNHVNUVZtOW4rNDR4ZFFlV1lUcEp3T3BOOWNzWVNSdVVONjNZUyt1?=
 =?utf-8?B?RVp6SFQrYXNJVDdKT2ROamkzRnE3OUJmOFdKVEJoK1B2UTdac0tEMFN4aG02?=
 =?utf-8?B?ZkVPTHZqc25wOW5yT3MwdDVOTEFnWnJtSUpYSElBU3F2aHgwd2ZrTTBQVjBm?=
 =?utf-8?B?SkROK3d3akNaelh5SUZ1cktublFFaVFUZ3IzOUxnNVVZeFFCUFNqMUd2ejFY?=
 =?utf-8?B?UlhxZVhRNTE5Y0poYjgwbEJaTWEzN01Wb2RTZWEwdUJWMFlmRVdsL01XbjFz?=
 =?utf-8?B?UVF4dVYycnhVU2hyTlBabm5kKzJnbytPMHYydTNOakxCcVhDcGd4TmxLN2ph?=
 =?utf-8?B?Ym05SzFtaWZlNy9hSkhva3QzUFlDQlBoNG1MeDZsbHV1YUR0U29maSswWVFr?=
 =?utf-8?B?QTJzR2M2VGJyZFZYSlB0ZEx2ditjMjhVL0JWdmZGUXFVWXlVVndJaU95MlpC?=
 =?utf-8?B?WWFwMHRnTVVTbFpaYkMyejdWWEFia3lqTVduMUZnV05PaXlORENibmhZTlIw?=
 =?utf-8?B?UGtxSGdjUW1JVFFnNnNJU2c5MEo0RVZBeHpvSWxPM2FyakFjcUlKb0FZQ1JB?=
 =?utf-8?B?aVhzdTlPWWZ1amE2Mm9RTDBXN2JvMDA1Wm5neWs1NmR6Si9FTmhZZEFtRzRM?=
 =?utf-8?Q?1HJCG8pElfs=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8394
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000042.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ba775142-1972-401b-b709-08dda8e6aecd
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|82310400026|36860700013|1800799024|7416014|376014|35042699022|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjNLSlpCSGtIZzRJZWJQdGNxVmhCV0RJMHpqUk1HZGsxRVdIQmxyczh4Qmty?=
 =?utf-8?B?M0NSK2NmS2xEMS9HdGdZeitjT1VEVjZROEZLcU5MN1VvV1ZqRnNaWjRWTEsv?=
 =?utf-8?B?Tmo3NWNWSlI4cWZnaEJNS2xsS0RwYm92UitvL29WZUF0cjA1dkJKa2hDbjcr?=
 =?utf-8?B?MzlGMSsxb0xPMGRibVkyK3gyQmhBLzU3OHVOSFF0bUFOTkIrZGxwZ3d0VWpC?=
 =?utf-8?B?dThEZG9GWWZCd2Vqc0F1a21nTGgxQndML3Uxejh3dnkxS3MvWXZ2K0d0dlJo?=
 =?utf-8?B?VDcvTk9OOFU3OGowU01NdHBtVzlUeUxNcGtTUW9lOUFYa1NTUWxKeGpmZzgx?=
 =?utf-8?B?SlVVUFJhZHBYR2oxcG9peW1CcVhZbUZSZEVWckNMY2JPdXhoTVR1VFpnQmZv?=
 =?utf-8?B?K2d3bjNrbzhPc2taN1gzT29jQXlkR0JuQVRpWC9yczRqSVY3VWVyTWx2SnlL?=
 =?utf-8?B?UU14L3gyVXFLNVNrWkNTN0dOVVpFV3Y4UGlIdHJkZ1lFWDNEM2s4RHlIWVBj?=
 =?utf-8?B?NTZCeFl5L3JheC9yc29rVEwzMUI5MHBWcFIwRDc0QVhxdC9MeGJvNElYSVpG?=
 =?utf-8?B?azdsdlIwWUVTczd4am1YSEpRYlQ2bVRYeGxnWVlXcE5HOGlzaXI4ckNaR3FN?=
 =?utf-8?B?cUtaVzZQQm9Jd1BFRk5PVGZPVG9jdzF1WVNObTJ6TklQYWZjeDVDNGtWMlFt?=
 =?utf-8?B?WjdUTTNmSVQrY1EzeDFIWUp0WEtrU2t5RHIwcFhSdmhSWHZCNDcvcnhieTU5?=
 =?utf-8?B?eEE1M1MvZzJqaHFFS0w5QXBhLzFLMHByemlQY2FITzlvRlZVOGMrUERzSHBW?=
 =?utf-8?B?YmJlRzFyb1FUcmtFUTJNeHZxR0o4OERVS3QvMGF0RFFGVk96cjlXcitjUm00?=
 =?utf-8?B?OC9Ca1B3Zkw2Nkh6ZjhkZVhqdjRQMnlVRVRLZUE4TmxiZ0VDalBETWhLOWRo?=
 =?utf-8?B?YVMwSlFucU9VY0QvWmREOVBBTUVkTUtjeHZEeGJ0dmN1U1V6QnFhQk54WXln?=
 =?utf-8?B?b205ejR4QTg5QTBmbzR5ZVo3d244QnpOMEcza0pYek9hNy9vZEZ3cktFRzJ5?=
 =?utf-8?B?WTNqcVRVSDdTcGRlM0tVWFJWaVBZMlBNeTVhWVB1NHhWb01tZ1oyUlBpYWR4?=
 =?utf-8?B?dU95dHErUTRKR292YjdZaEdnSG1UTXlKQWw5VU5pRURNNXgwVWQyeng4d0Rv?=
 =?utf-8?B?V3hUVnZ2YXl6N1ZTR3ZCZkkrb0QvNEF5a2tqVEJGVEhWVUlLSWJEeC8zckh5?=
 =?utf-8?B?YTF1NWQrSnYrU3VyclVQcEJ5VU9NeFVxUDlBZzRlNUd3aEJUblEzUStDUlU0?=
 =?utf-8?B?QUs1TlhCSVoxeXY4SmZ5VzNpWGJlMlVseDJVeHJoQTJWWEg5N2xNNnZwYy90?=
 =?utf-8?B?RDdnblppU0EyeHptdktvZ0RQemd3SmJubjkrTFlwSFNNVFJnWWI2cDBuOStP?=
 =?utf-8?B?c2VQMDczR0Y5YVppd3V5R2lGZzRsWVpBeHBsekE1a2Q4YlRRcGRLdHNib2xK?=
 =?utf-8?B?TE1GM0JwK1ZkRnVVUU51UHNNMGhTRGF5NktlTFpkNStvVTBybXVWMGN0Q3ZL?=
 =?utf-8?B?cW5DSzI4M2gwNXY1NVhETnB6L2ZDSmdTcDBiS2JGR1lVbnFJYmRYbXBmc3pI?=
 =?utf-8?B?U3AvSlZ3alFhUjN4TkFQeU83WHM1WE1UczQvT3ZEQ1VYblBnQXFFR205bFpV?=
 =?utf-8?B?Ui9FOXFDajRMYWF2UHJFSFhWdnFlLzFCUDVOTU5jOEV5eGhucnFKVzdCSi9w?=
 =?utf-8?B?K3dFejNEb29wU2U3NE9HRmNtTmdRVkg4MFV6c2xQZ1REMjF2bVFYWi9xeFU1?=
 =?utf-8?B?VVFha2Y1M3FTbHI0NE5Jd3JrQ21WZDQzNXFZZTAybERTd1c2aDFsNjgvOHYw?=
 =?utf-8?B?cG5aa3ZPNWpzcHpyVXF0cXB2eXRpTFEvMFhXUFJhS3huc3BZc2s1YjNzNmZ3?=
 =?utf-8?B?WWRFdGJjR2lUbzNmMHprM2ZGOXh0eStsNkVHVmN4aTJPMkpHUUJ1K1V3RTli?=
 =?utf-8?B?MnlmRDFCRy9wYnVzVFFYNDBPTGI2cmo0OWNxNlF6VkR5MG44RVpNZTAwc1Za?=
 =?utf-8?B?T05FYW5JaFhSS3VPd1pXQWdqSVRCQ1hCNE9Sdz09?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(82310400026)(36860700013)(1800799024)(7416014)(376014)(35042699022)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 12:52:01.1109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a0ab47-a8fb-4c87-cca5-08dda8e6c24a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000042.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6146


On 11/06/25 6:05 pm, Lorenzo Stoakes wrote:
> Thanks for this!
>
> On Wed, Jun 11, 2025 at 05:40:11PM +0530, Dev Jain wrote:
>> If CONFIG_UPROBES is not set, a merge subtest fails:
>>
>> Failure log:
>>
>>    7151 12:46:54.627936  # # #  RUN           merge.handle_uprobe_upon_m=
erged_vma ...
>>    7152 12:46:54.639014  # # f /sys/bus/event_source/devices/uprobe/type
>>    7153 12:46:54.639306  # # fopen: No such file or directory
>>    7154 12:46:54.650451  # # # merge.c:473:handle_uprobe_upon_merged_vma=
:Expected read_sysfs("/sys/bus/event_source/devices/uprobe/type", &type) (1=
) =3D=3D 0 (0)
>>    7155 12:46:54.650730  # # # handle_uprobe_upon_merged_vma: Test termi=
nated by assertion
>>    7156 12:46:54.661750  # # #          FAIL  merge.handle_uprobe_upon_m=
erged_vma
>>    7157 12:46:54.662030  # # not ok 8 merge.handle_uprobe_upon_merged_vm=
a
>>
>> CONFIG_UPROBES is enabled by CONFIG_UPROBE_EVENTS, which gets enabled by
>> CONFIG_FTRACE. Therefore add this config to selftests/mm/config so that
>> CI systems can include this config in the kernel build.
> OK I see the dependency chain here:
>
> menuconfig FTRACE
>       bool "Tracers"
>       depends on TRACING_SUPPORT
>       default y if DEBUG_KERNEL
>       help
>         Enable the kernel tracing infrastructure.
>
> if FTRACE
>
> ...
>
> endif # FTRACE
>
> ..
>
> config UPROBE_EVENTS
>       bool "Enable uprobes-based dynamic events"
>       depends on ARCH_SUPPORTS_UPROBES
>       depends on MMU
>       depends on PERF_EVENTS
>       select UPROBES
>       select PROBE_EVENTS
>       select DYNAMIC_EVENTS
>       select TRACING
>       default y
>
> ...
>
>
> However we also need PERF_EVENTS w, which is defaulted to y if CONFIG_PRO=
FILING
> is set:
>
> config PERF_EVENTS
>       bool "Kernel performance events and counters"
>       default y if PROFILING
>       depends on HAVE_PERF_EVENTS
>       select IRQ_WORK
>
> ...
>
>
> config PROFILING
>       bool "Profiling support"
>       help
>         Say Y here to enable the extended profiling support mechanisms us=
ed
>         by profilers.
>
> So maybe to be totally and completely pedantic we should add CONFIG_PROFI=
LING
> here too.

I don't totally understand this config stuff but I will trust you and updat=
e
this in v2 : )

>
>> Fixes: efe99fabeb11b ("selftests/mm: add test about uprobe pte be orphan=
 during vma merge")
>> Reported-by: Aishwarya <aishwarya.tcv@arm.com>
>> Closes: https://lore.kernel.org/all/20250610103729.72440-1-aishwarya.tcv=
@arm.com/
> This is already (semi-)addressed by
> https://lore.kernel.org/linux-mm/20250610122209.3177587-1-pfalcato@suse.d=
e/,
> perhaps worth mentioning?
>
> Pedro's patch is still important, as for any system that hasn't happened =
to set
> this up, we get a skip + information rather than a failure.
>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
> This looks correct, see above for nits etc. but:
>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thanks.

>
>> ---
>>   tools/testing/selftests/mm/config | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/tools/testing/selftests/mm/config b/tools/testing/selftests=
/mm/config
>> index a28baa536332..e600b41030c1 100644
>> --- a/tools/testing/selftests/mm/config
>> +++ b/tools/testing/selftests/mm/config
>> @@ -8,3 +8,4 @@ CONFIG_GUP_TEST=3Dy
>>   CONFIG_TRANSPARENT_HUGEPAGE=3Dy
>>   CONFIG_MEM_SOFT_DIRTY=3Dy
>>   CONFIG_ANON_VMA_NAME=3Dy
>> +CONFIG_FTRACE=3Dy
>> --
>> 2.30.2
>>
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.

