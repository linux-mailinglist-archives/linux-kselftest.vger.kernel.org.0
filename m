Return-Path: <linux-kselftest+bounces-34788-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96098AD6717
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 07:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58FB01BC07B2
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 05:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D9C1CD215;
	Thu, 12 Jun 2025 05:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="IP3+Y77V";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="IP3+Y77V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011013.outbound.protection.outlook.com [52.101.70.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3827A8F40;
	Thu, 12 Jun 2025 05:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.13
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749705086; cv=fail; b=EVFd86Q3UxNQNgUt7TFv/03+JZPIaPnlpe7ePLHSuC5RZdqCDpqwbsIsGcp8M82pOs5eFFRxOSZOSw/eOJMCT5BqFnloe4R8d0cTpYAN8pvO4lsimUJiNojvmwX5U9SZNpfUnjjAMq8XEWrEp5dpdoXemJRs1lSxxiXch9yHWJI=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749705086; c=relaxed/simple;
	bh=GC49BFb4awGTflb1msU0cf+mdEKP4jGIh544L/1wiCE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O3/YGIxrcwi+5+V4c1PPxVb8IpkJKmFJV3UsPrignOwCFylrPilhdzwEliX9J7O7J6ful6wBC6170RfsGrrxj6vMRaDBiIN1LqDGGlmrRpSFId5r+ldYMhtw2l2/ETwm6PVot4ldvLAOz/Lvkur49+e+AuyzDH5QhccBl0hwpoc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=IP3+Y77V; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=IP3+Y77V; arc=fail smtp.client-ip=52.101.70.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=B1gWT135zj7oi6MsrjE5UXRX8X3kcHKJmY+OF+Y1YW35QQD6tP+18wOgCgTo8ftCR82Wck8AYC0S4D0R54iMd6SS4zvSvJyce54Lei97zpznEdJyd3WEcqYbYht4+Jg7ZWZe4geJu/GaKBGmSkaGwgdYTiGA8BS+aiLnKtkotfKbcyV9CMmmeMoSfm5i+kf1O0fdGSSTpxXJmbvdBaj80VtXxeVlQzhpO2qui/VSBGyiEpG7r3CvK6aKlxi0m2MxaCIodjOtGuLpFTx0r/zMgj1U+zOrHYtqIUwhHBAv2PeWvXLo8XCgI0Of3K6BgE3lOy8S8S7Eib6YgqobbiFEJg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTq8zY8hQHHxM7jkMWynxGi/ywTJXV4gBkr4+F5MCjU=;
 b=UNB7mJ/ti0MtZm4OMftX8NA64si4QV0aT1dr3Y718z5CJCemULEsU66usn9K6ViCTndzO86eDY7SGYbHQwkxV3R+NhPC6ExyqF94fvjffQpwr7tMtZmxqDsRRWuDYweYZLb7YRRKDDadwxqz69m/bXUxFM8jwrfr9VUwWxBMAKE+lTu3G+T0J6hN89bULPbN2pwgFFpVOj7yMcPnabSzsdOtcX3U2tSB45h3fA1BlGLSnmt0v9W5nsXF9ax7u7azqQkfY6yE/d52HGS/eDai9YSqXo0UPtMdxZ67OVswOfNJ70iv9bCEQXpB4planKlBkw6Q7cvC4k7qx9CxxPnxnA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux.alibaba.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTq8zY8hQHHxM7jkMWynxGi/ywTJXV4gBkr4+F5MCjU=;
 b=IP3+Y77VFDwC0jeQmr/4nVlpGeGxXHXI6F0pJF2bykYqTrhbWD6oqKq0unYnQwAeYPkicLwW8S3DAkNU01t367RdDBAqGe9TxdmQaLUJR+XEAMRyGsOgcq8pZEQ0zAPRj+CVt2GKI1scTRMPfp62wSIPYInkXD91HM3DMBobIP4=
Received: from DUZPR01CA0125.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::17) by PAXPR08MB6349.eurprd08.prod.outlook.com
 (2603:10a6:102:15b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Thu, 12 Jun
 2025 05:11:18 +0000
Received: from DU6PEPF0000A7E2.eurprd02.prod.outlook.com
 (2603:10a6:10:4bc:cafe::3f) by DUZPR01CA0125.outlook.office365.com
 (2603:10a6:10:4bc::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Thu,
 12 Jun 2025 05:11:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000A7E2.mail.protection.outlook.com (10.167.8.42) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15 via
 Frontend Transport; Thu, 12 Jun 2025 05:11:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QTQsGlLz1ltGE6mRilHFMhuCEwdac7V9Qh5F/0zFSWD1+xCpp15W4lFMhe7Iw/RpUMmnGfBNeUMJOsoaz9gjFBrGDNYKWvfNPGYYg8bCcmMMEDMurLsF3E4B0OChodphIyxvayY/mbtU2h+IUIlcd5sfHdqJYkVNiH7n/xrsU1XeY60vW1fGYHN1RlkMYwsEfV4OhzyEjbuMvTKTxWJmCmw3pRmoUAe3lSKbziVWS3Vm7maP3TfyQsZLbxzmiFz2D4yhk8OIEXiZssfCHqO4dyEswtsak0+KVL4DW90nO/2h7kb9D3gmTwMkD4wu5PsvJS8BsLj67H4qIMk9NVUwRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTq8zY8hQHHxM7jkMWynxGi/ywTJXV4gBkr4+F5MCjU=;
 b=H+bZNp98I9Sy0+vvEbKE5fJVbg44VWXt10j4QkUaeQjPYV+s9OorRIE65/K+5rSnj0VZpoAYB8w3IZXgB9QvRbm7y7uRUOnoFi/sstXorfbWgbqFnkH9X/zDka/Nw+GQLrpKJpuNU4uluDqNamxnH+W8xx5VMR3nx4t7CMJyelg6psKsLvUms6R6nbYWTwsyuxiG2BqftIZ8juGEmZnZb8q0EVcTKMzeO2Gr2m/ekbH5QTIAL87h9SXLYy1uLWuD9yx5unO2Tkve9RYNP+VoLSD7a3XVvmu9X5IhNaEf8EyrkRpU0gd1BH5cyX64j5/2tUxmFx0cGfiozhwVpA6PwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTq8zY8hQHHxM7jkMWynxGi/ywTJXV4gBkr4+F5MCjU=;
 b=IP3+Y77VFDwC0jeQmr/4nVlpGeGxXHXI6F0pJF2bykYqTrhbWD6oqKq0unYnQwAeYPkicLwW8S3DAkNU01t367RdDBAqGe9TxdmQaLUJR+XEAMRyGsOgcq8pZEQ0zAPRj+CVt2GKI1scTRMPfp62wSIPYInkXD91HM3DMBobIP4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by AS2PR08MB9524.eurprd08.prod.outlook.com (2603:10a6:20b:60c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.26; Thu, 12 Jun
 2025 05:10:44 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%2]) with mapi id 15.20.8835.023; Thu, 12 Jun 2025
 05:10:44 +0000
Message-ID: <80218cc2-de6f-49dc-bdee-4b2560c619b5@arm.com>
Date: Thu, 12 Jun 2025 10:40:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftests: khugepaged: fix the shmem collapse failure
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 david@redhat.com
Cc: lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, baohua@kernel.org, shuah@kernel.org, ziy@nvidia.com,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <c16d1d452aa876b449324d12df6465677158a711.1749697399.git.baolin.wang@linux.alibaba.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <c16d1d452aa876b449324d12df6465677158a711.1749697399.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0012.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::11) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|AS2PR08MB9524:EE_|DU6PEPF0000A7E2:EE_|PAXPR08MB6349:EE_
X-MS-Office365-Filtering-Correlation-Id: e52fc382-05d8-4008-18cc-08dda96f8fda
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?OGJPYUJLbU9lSHkyb2FYVm1oczN3WmtsSDVvb2lRdlNjZ1gwNFVXSWdVWXNp?=
 =?utf-8?B?TFczSWlkUXpsWXo4ZlFURDhZcHhKMWFBVDJVSGJoN0NYRzdSR3JrZTRvMjFH?=
 =?utf-8?B?UExkdnl0T2NvZnM4YmVHYkpDVFBPeDZjNGJpR2RDT3dSVTczM3dQUTdqSm9o?=
 =?utf-8?B?cUJxMUs1dVZIRkpCR1J0NFRMb05jY1F2TGRySXJCYUxkVVI0VFlEN2dQK1Zp?=
 =?utf-8?B?eGRKaGlXNVZzY0FvQ2J1ZDZxTTNRWjY3UlRCMjhjcENKY3daU3JpNlpXdmVD?=
 =?utf-8?B?akFhWXJ0V1lJQm5PZzZWZ2p2am15VDU2SVFLNjlaM0xoTTFPVG1wYXV2aExP?=
 =?utf-8?B?ck1pa1o5eWJKcEFYYWJrUXNiVFpHY0dLZzN1THM1eU43L1ErcWFncTlkNGJt?=
 =?utf-8?B?RlR0SlNWTHdObmRWRHVPWXZwTWdFK2pKdVdiVzRMWmNGZURWUjliWjFRcVM5?=
 =?utf-8?B?QXpZQkJuT1ZIOE9SR09DclNvOTd0UWVRUWg4UFRaRjQvd3NBbFNkbFUweWtX?=
 =?utf-8?B?YzdVS2czUkFyNTNPSXRuMUxJaUJxMHVDY1dVTStkcVd4Z00yMkVYUlg1UjdX?=
 =?utf-8?B?OC8wOXdLOG5BV3FSYU9zRm9YekI3RHhJWE9aZkZXY2FhVTlmeHpzTDd2MXo3?=
 =?utf-8?B?OWpTbWo1NFN4SFpPczNJeDd5OXNVSkNxeXhwSXVwQ3hNR2VUVitYVWtqTFRN?=
 =?utf-8?B?S3NxbVVPNnV6alZuSUZReTFjUWZtQi9tMS92YTJUS0NQUCtaaGs3cWRtL1Q2?=
 =?utf-8?B?YUowWHVBemdhMnkrNnJJSW0ydzJTZ0lGZGVyRFBsQnBuSEt1VU9HRkpFS1Fn?=
 =?utf-8?B?MC93dHdacVh2dGw3OCtTaExONlBXOGpicWlCeWdhcTVaWmsyZ1hQaVdYWktY?=
 =?utf-8?B?WTl1dVlxZHpERFd1MUkxUTQ1M3ZXSjRFZjkxU1luSXAzYm9oNWFJSzJ1SU5J?=
 =?utf-8?B?cDV6WHFPa3ZUUlNCd0pFQnYwSGhSODgySVZDK000UzdDTWM4U0V3MmpFcGFR?=
 =?utf-8?B?aUw0U012aktXNmNTdnVxeGZiR2hJNUZ3bWtGdlV5RG5uSDY3N2RYY2hyN25o?=
 =?utf-8?B?QnpPODllVkRidS84akp2RFdxSTVpQU45ZjVYWUliRzRhWTJRVzhPdVBuOTBs?=
 =?utf-8?B?QlJvcDlINnM0dWYyZHMwZ1htQTFLSGVpVlZXYmNNVzRucUUybEM0bWFTV080?=
 =?utf-8?B?Mm5XcUhIczFKdnFlVDFEbEFrVDN5OEhYbkh2elhTVHB5ZlQ0M1drdG5BZmtY?=
 =?utf-8?B?QkQxUjJ0M1I0Uk55WFNWMHVZNlF2R2FXQnh6aHhRTmR4YVFyb3NPY2xxUHFs?=
 =?utf-8?B?WlBoOFNtRi80a2RCeWtwQUFiSHJMSE5HdjhDMHIrZWt3V3VRcGQwMWFWZW92?=
 =?utf-8?B?NG1LUHk2eXFNS3VCMXVkbzdqcFY3MDBnZ2V3WS9LVkFOS2NQbW45eWduZHMr?=
 =?utf-8?B?bVdYalE5RmErTitONnlJUzMyMlhzQklMNmM3MXljdUN6VVg2MzdUZ0xxM1A3?=
 =?utf-8?B?a0VReER1TTFLdThWMVJ1KzJQQXUwY3NteWNWN0RRdXBUdkFoSld4SStDb0N5?=
 =?utf-8?B?WWpMbGJOQ29XYk10UXkrU3I3MXJuT2w3V2NnajBYU3ptcWxYNWNrWWxIdUNM?=
 =?utf-8?B?Q1JJQXR3MGdkY2w1V3p6VHVTM2k2ckNEWnhIZjBFZ0tGZGMzSFhIVjNRbG5V?=
 =?utf-8?B?anMvcWNiOHlaVUlCN3JWMjZkbEVhQ1hveXpBL3VpR1RndFpuZkF6OE5yUVdN?=
 =?utf-8?B?aHFhdFVzRndKY0tvdklFd1JuVGFwTjhIMW4zb0ZIb1lZaHdLdXBGL05ZcjlK?=
 =?utf-8?B?VlM0TU5kN0ZhaUZ6MklmYmpaUDVSVUo1SUVWWnE0eThXajZBYW02WWJyT1hk?=
 =?utf-8?B?UGJEbGtjbDRsUUlHMjFRT1V2djJ3VG1hakNScUJ3NzM4UWZNS0p2a3h2ZHB0?=
 =?utf-8?Q?5r2qUjVAgiQ=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9524
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000A7E2.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	aeeeffdf-17b2-47eb-8f7c-08dda96f7bb4
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|35042699022|376014|14060799003|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NjFVQVhRM2R5by9HN3AzZGJzcDNQVXJZRXBhb0lmanJuaU5RL25CQTFOaEYw?=
 =?utf-8?B?Tis3elNVbHNOVEJGbS9GV1ZybHgybGtMcnliNmtENEZTeFhZN2wyUzNvdzFD?=
 =?utf-8?B?RjNSOU9uSmFQZVRBOW80akNiRmlmUXFkVXBCYU4rTmdFTStaM1M5VEJlWjVT?=
 =?utf-8?B?WmxWdVZ6NGZ1aEw0dlVlKzVSd1FYbUpqdTYrczVUcDhmQmsvL3FRWlRLeHJh?=
 =?utf-8?B?VTlOTno4Y3E0MDhxekxPU3VVQStrK0xFMmVMUGdHVEJMelZ6UFBsR2lCUWdC?=
 =?utf-8?B?WlhwTmY2ZGNGOGE2MGdFNjFxb21lT1JVN0pDQnNTWkVocWJvWXJZOHpKNnRG?=
 =?utf-8?B?N255eGliQXhLSFlLTGtDemdZR3NGc3NiZjZEVGZQRzBCWCtZY0RBU1hJYW5H?=
 =?utf-8?B?SXF4dzFldlZNcTAxa0xxRWd6TXYrY3hwYXVmUHBHZytMZCtWRUNuNGt4eDNM?=
 =?utf-8?B?VUlKdzN1Mk85NXFtUzBqMVE2NzNTNkJSRHZodHZXRFRJaUZORFFHM3grTzVk?=
 =?utf-8?B?SVZjd3IxOTc4SXM1Vkt3WndhUis1NFlNNlV0cG1SNTlIRTU3bXNwckhWMDdG?=
 =?utf-8?B?S0ZQWSs1N0JmQWJWbVcydUd1NXBZaXBYTEZSQ2NBcEd0bjIwTmdVbnJTa3ZT?=
 =?utf-8?B?bGNBQTVVekZHemlZOUJsTTdwUU1SbGRTbDA3MGh5amZyYVIyZzFoTWttMGV3?=
 =?utf-8?B?L2FEZFRWNVZaUDJRMlNvWkZ4WWcxbDNac0h1amgzeDNwM3F6dWhGQmMxOWln?=
 =?utf-8?B?YmNaZW9Qc2VnSW9rQXQxL2lWQVlDTEpETkJrR1p4RlVuYURlWnphUkpLRU5X?=
 =?utf-8?B?V2w4anFaOUtaMStCaTZXcStrSmhCWXRxK1R4bVZtd05lVWtLdTBCaTRHSG5p?=
 =?utf-8?B?UXFhV3o5UmkvcFI3bHloYVhWbXNEdElwcHU3Y3ovS29iVThuN04zK25jVUFj?=
 =?utf-8?B?aVVvYjN6N21SYkJZZXZES0lSTWhuRFphVmxaNUFFSUJ5Z2tna3oxQk1GTTMy?=
 =?utf-8?B?bVk1cldhVThPS1pUNkxXeVAvMTlZY25oTU9PSDNFeW54SERMWWhVa1JEUGtF?=
 =?utf-8?B?L2lUaGxsT2pDY01qRjBRVG1GZXZleTQxczhIRnp5T2tkUC9JUGhzN1M2S2lY?=
 =?utf-8?B?cHFkQVNjUzFKLzJ0TU5TK0xNRC9UVXZGY2xPNDBJbzdrdVlweGpubDJWS1U1?=
 =?utf-8?B?WDdNaFd5SHQ3enRUSGdYMGFtdXFaMXFYdVF3ZjRyTWhLdlBUcVZncStUWnNr?=
 =?utf-8?B?VzVJcVZ1Y1RCcTRva3BhaXFTa1FkREdDM1FCV1NHWlhxQ3pjMlpoRFVkeW1i?=
 =?utf-8?B?THdsS0h5TjBTOElqcDdSTlFmZ3ZnQTBjY3o0a2QxRTRjNkhBVFpCRTkvSlJn?=
 =?utf-8?B?TDNKRldBTFhlQVJZcG5LN1lhUlNmdkNGYU8vcFBSK0ZFN3RiRkorcWxQNm1I?=
 =?utf-8?B?RXEwR0Y2TlVWOUtSRnZ0aUV3MHNCbnFRcWhORURBemtxWnNFZEVBQnU0OUhL?=
 =?utf-8?B?YmFOWWhHN1FrTERyNnl4bkJ5V1FkYlRjZlU1S1dUZkVrVHFuWjVJWG00Z0xE?=
 =?utf-8?B?NlZZTk9VQmc1NnNMay9sUk1ldjVBNG9EMEdoWmdFRWhsc3dGS1dvcmx6dllN?=
 =?utf-8?B?Q1NnbzVnNHR4eWVuNGp3TW5zcDUralRWZyt1Y0ZHNHBoZTNBQldKY3E1RXpG?=
 =?utf-8?B?ZEhqb0M5bElHNzJNV0VlQTBicjh6RUl6VXYxL3BvK2x6elFBeHd0TUZJSHE5?=
 =?utf-8?B?SXJuOFNwQVFIeDliWFlCLzJVVk5YT3EvN0ZMVTVwTzhtYzRlWXhsdXdEVGF1?=
 =?utf-8?B?cVdvclEvRzZJaGUvTzVGM09sM1cxNjdEU2szRTdWc3lhTFpGWVRGMWhiNW5n?=
 =?utf-8?B?QXdMTW0zVzN6Tytac3gyZXFFWXBKNUpSdk44UlpRL0VPTk5WVU1uc2xjbWVW?=
 =?utf-8?B?U3pweHYydlZ3dVRiMWF4ZnNVcys0eGR3ZE5PVDRUVmV4SEpVUFpQRmR4UUJy?=
 =?utf-8?B?TUxNODlJRjVUcHp6NjlrNUh4dDBxR0Z2QzdudkpnclNIelFVeWZOZklNUExG?=
 =?utf-8?Q?uu1FQA?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(35042699022)(376014)(14060799003)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 05:11:17.5337
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e52fc382-05d8-4008-18cc-08dda96f8fda
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E2.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6349


On 12/06/25 9:24 am, Baolin Wang wrote:
> When running the khugepaged selftest for shmem (./khugepaged all:shmem),
> I encountered the following test failures:
> "
> Run test: collapse_full (khugepaged:shmem)
> Collapse multiple fully populated PTE table.... Fail
> ...
> Run test: collapse_single_pte_entry (khugepaged:shmem)
> Collapse PTE table with single PTE entry present.... Fail
> ...
> Run test: collapse_full_of_compound (khugepaged:shmem)
> Allocate huge page... OK
> Split huge page leaving single PTE page table full of compound pages... OK
> Collapse PTE table full of compound pages.... Fail
> "
>
> The reason for the failure is that, it will set MADV_NOHUGEPAGE to prevent
> khugepaged from continuing to scan shmem VMA after khugepaged finishes
> scanning in the wait_for_scan() function. Moreover, shmem requires a refault
> to establish PMD mappings.
>
> However, after commit 2b0f922323cc, PMD mappings are prevented if the VMA is
> set with MADV_NOHUGEPAGE flag, so shmem cannot establish PMD mappings during
> refault.
>
> To fix this issue, we can set the MADV_NOHUGEPAGE flag after the shmem refault.
> With this fix, the shmem test case passes.
>
> Fixes: 2b0f922323cc ("mm: don't install PMD mappings when THPs are disabled by the hw/process/vma")
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>   tools/testing/selftests/mm/khugepaged.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/khugepaged.c b/tools/testing/selftests/mm/khugepaged.c
> index 8a4d34cce36b..d462f62d8116 100644
> --- a/tools/testing/selftests/mm/khugepaged.c
> +++ b/tools/testing/selftests/mm/khugepaged.c
> @@ -561,8 +561,6 @@ static bool wait_for_scan(const char *msg, char *p, int nr_hpages,
>   		usleep(TICK);
>   	}
>   
> -	madvise(p, nr_hpages * hpage_pmd_size, MADV_NOHUGEPAGE);
> -
>   	return timeout == -1;
>   }
>   
> @@ -585,6 +583,7 @@ static void khugepaged_collapse(const char *msg, char *p, int nr_hpages,
>   	if (ops != &__anon_ops)
>   		ops->fault(p, 0, nr_hpages * hpage_pmd_size);
>   
> +	madvise(p, nr_hpages * hpage_pmd_size, MADV_NOHUGEPAGE);
>   	if (ops->check_huge(p, expect ? nr_hpages : 0))
>   		success("OK");
>   	else

The idea looks sane to me, but do we need to add the madvise call to
madvise_retracted_page_tables() too, since that also calls wait_for_scan()?


