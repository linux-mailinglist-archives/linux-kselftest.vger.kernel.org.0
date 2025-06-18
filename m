Return-Path: <linux-kselftest+bounces-35294-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3E4ADEF07
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 16:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 359033A52A4
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 14:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B7C2E3AF1;
	Wed, 18 Jun 2025 14:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ojVeQmiK";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ojVeQmiK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010071.outbound.protection.outlook.com [52.101.84.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4D42E06FC;
	Wed, 18 Jun 2025 14:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.71
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750256282; cv=fail; b=hkMX8DwAuCEOPXut984npBpflo0kCHw4vriRpWeNEPQlUpKZslobvQ+JryPBOraeDsL7p2nIR7rA/E+yDiG4sn5uDQkzD+yoFQGZ1sSIMa2xE2XoC9x6YPoHh6IjxWCfSbCLQ1gakmnZR4TeDtvYfasQD9zV6QNJYScb98gfxgc=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750256282; c=relaxed/simple;
	bh=BFEdk/tuSY53Bxn5H9TCH2UGG3jogSxSgABV6PEwpdM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DRDMDe+ZoQ3GVQKUMbTVkLDakbHsZjunPF9h224CQTazOiTpxIvykx4ZlelBFnpwBDSB2+JhGGBvjaL3BpQudYZMcLA7BJuRkSW4F5UFQtwVO+AOBzDGn1gevEaqZrbmM3NQ63y6RWUaPuCFSmOtEupboeQU9Y45OG02xH+ERHI=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ojVeQmiK; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ojVeQmiK; arc=fail smtp.client-ip=52.101.84.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=GbupRmnE1urI3JJrOru9qDEVG3tPSNSSqXEV+WEpDVXg7+V7+OTFWNrM5ZxdNN4MvxOBzc5lninuoQ4hVYEatj0x1VnAiFoh9H9b3JYObg0Ixbt2WYwFzje2Ibcz9/mVwQPW1vS8zr2zKesMlqAy9qnZbVRYwha2CByhIdUefz8FdbLEmqIxAYnFYqpmJbTK8vI0c6jBvCsjRwO8Gf33HBSTHWpYFPB0fj/lhg3uipAWOkdpyJuo1TiqtmwUWq6qOjbVAcHKZAmcQp9I9fHY6HF62SYlIfXISOUg+worgpgwLvH3Tbx9fumINCGeXwR5qZ/QzoJEXXnmWRoBYLiwRQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hV5JMlm9+zFFi8fwy2C5DOT0Y+bXLVHJGVMc8z/3GHc=;
 b=SJG2Pl/hBmjyl9r9KBbMslJd0MWMXPXwmAUXbFGhWT1f7pK7Y5SHwHS1ZyvL+wwr3Q8WODWaVwGvMXA491RgHkNJ1DnUi7XzPEftRt6VHXoY46oGjORzuqKM4q0CpUR3xK6T0sSrepA/cbbJiA/id65v80IHihljUWfDZ9xtNX46WKMGuqd+8eB/r06sw3Bb8ANWqMZxykIRQyHcCcly/xy/V+/pI3KSb/mROs2ddF2OZ7CX8FR77i9m4oXIGs53vxtEUAaTuH7Rs5yBRS+OcOmO/Td0gGXRxrBa7HDUSIN6wfMuraTg8ET9ZSZmfBpctNVJWUGV56Y92EZwnrZIJw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=oracle.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hV5JMlm9+zFFi8fwy2C5DOT0Y+bXLVHJGVMc8z/3GHc=;
 b=ojVeQmiK+oumRAiVM3d9453uyD+lE88c0GV55T/pur2V+CKBHvMY65ycgKiHRkrFpv6f183K7xjAHmfmc8qqB46wMhnEqBYru+eza3Iv1ww4YNbjb48NPOCIvgn8yCxPI+UROoGC1u0Y3zteR3LwC12P+DhED5dFDpOlamMXU9I=
Received: from DU7P250CA0023.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::11)
 by DU0PR08MB7996.eurprd08.prod.outlook.com (2603:10a6:10:3e3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 14:17:57 +0000
Received: from DU6PEPF0000B622.eurprd02.prod.outlook.com
 (2603:10a6:10:54f:cafe::a2) by DU7P250CA0023.outlook.office365.com
 (2603:10a6:10:54f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.32 via Frontend Transport; Wed,
 18 Jun 2025 14:17:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000B622.mail.protection.outlook.com (10.167.8.139) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.21
 via Frontend Transport; Wed, 18 Jun 2025 14:17:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kw6M9DViCcxPzco/vS/hR0qk0RrfAqvtnZAHXe6NKeSI+tFgRwPQW00gWLIVmmy+8H/UMFR8BK9f20P+k2OCDjwwgPM+UJhxTSTc8U3rj9y8RNCCmrCE91e4nehMpSNYhb2qQ+nPDc0dSC8JAKNG953wtdUi4BEXvyM+z1HRVUxeUyjDxDJ4chDlMmHvH27nlgpaRMd9euVrK4v5ho75N6cyEcWqS+M8W09/s1bt7c0lab9XfYgy6fW3TxbguUjpajuZetcqJ4115dloV4Hakim0ReBs4rmbAPZJKTK7uykB+lnPXfpLxO3HDNFTyS37ImYBM9KEv3nTz1w/tdBB7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hV5JMlm9+zFFi8fwy2C5DOT0Y+bXLVHJGVMc8z/3GHc=;
 b=ecHmWcztBFlgG3+hWIZEAtUmprcwhwj4I88hNH9PZZh00f13XdJxek3d6x9bdI9SlMgBkwZBiSBopfAs1JSeY9E1T048g20IlcA0Ch/PjbwtQ7m4brjDp262ATeyRXFbxGW1KdnFJPKmTXDjbyfVXOAL8VRyL6GzfllaxBtra/noSfY9yZ0eTQJ43x3A5/Rc1Vh+50m3/HMpeS7P2q2vgMt1i/H845+ND+8nj9BRkOSxMN3uYoH0QihXCrsnxNQ7OaeLEvwrzbFh2iXhY0/n0D5RyL81OxLt8vtxegNb2XalbrQxt2WLCEUB/RSPisdwXJ6+Pe5e27J6NCmtJ1U6CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hV5JMlm9+zFFi8fwy2C5DOT0Y+bXLVHJGVMc8z/3GHc=;
 b=ojVeQmiK+oumRAiVM3d9453uyD+lE88c0GV55T/pur2V+CKBHvMY65ycgKiHRkrFpv6f183K7xjAHmfmc8qqB46wMhnEqBYru+eza3Iv1ww4YNbjb48NPOCIvgn8yCxPI+UROoGC1u0Y3zteR3LwC12P+DhED5dFDpOlamMXU9I=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by PAWPR08MB8984.eurprd08.prod.outlook.com (2603:10a6:102:341::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Wed, 18 Jun
 2025 14:17:25 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%4]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 14:17:24 +0000
Message-ID: <815793f1-6800-4b9a-852e-f13d6308f50f@arm.com>
Date: Wed, 18 Jun 2025 19:47:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] mm/selftests: Fix virtual_address_range test issues.
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Aboorva Devarajan <aboorvad@linux.ibm.com>, akpm@linux-foundation.org,
 Liam.Howlett@oracle.com, shuah@kernel.org, pfalcato@suse.de,
 david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, donettom@linux.ibm.com, ritesh.list@gmail.com
References: <20250616160632.35250-1-aboorvad@linux.ibm.com>
 <20250616160632.35250-2-aboorvad@linux.ibm.com>
 <0665a8d3-7094-4732-9518-01ac313959e1@arm.com>
 <159f6939-e7c8-492c-8195-b7e8787a08f1@lucifer.local>
 <f8730d2d-41bf-407a-b44b-6cb9c1e5d4b3@arm.com>
 <79bdd993-0e9c-4d7d-b42c-4b5750eff140@lucifer.local>
 <aaddfd0b-216e-48fe-b48f-35c78eabcf9a@arm.com>
 <8e23c5d3-6ce3-4fe8-b6fe-69658d5d0727@lucifer.local>
 <fc5c8193-2642-49f7-9f2a-00ad33353773@arm.com>
 <c93110a4-19e4-4a1d-b044-6b7f521eaa0d@lucifer.local>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <c93110a4-19e4-4a1d-b044-6b7f521eaa0d@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0005.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::16) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|PAWPR08MB8984:EE_|DU6PEPF0000B622:EE_|DU0PR08MB7996:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c197324-1dfd-4ad7-d52b-08ddae72ec57
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?YlJSVmNscXhlSGZlbGVWYk5MN2tRcjBuT2dBMHZDWjB3MzRsM0pzS0ZlUncw?=
 =?utf-8?B?WWF4M3VJMnZKSit3bnNYV1JNa2NEYUoxWmhiSG9sN0JBeWxsVll1YXJJaG9B?=
 =?utf-8?B?dEgydE02d2U3ZWNzOVgxVzJXNWlOY3YzeWxKcmpySFpGV2VqL0tZRmNZRmFa?=
 =?utf-8?B?czBsdFptL0JNSVZ5dkh0aDJKMnFURzRsRyt1WjllNmRaLzNMNzRDdXRYeWxQ?=
 =?utf-8?B?Z0hzSGhFUmR2R1BkWjFSUU1WQThuYm0xWTloUElGQUcvYUVOcTV1S0prQ3Bn?=
 =?utf-8?B?YlJ4cWRJZWE1QU5OaEZWdnFNTmcwUmVzYXZma3ZaRVJRaERWYXJNckNwVHpy?=
 =?utf-8?B?dFBUWVZEakIzQzRreFV5cWwxaEl2T1hvMnJHUGpNYzY1dDhnZmkvY2Z5b2Qx?=
 =?utf-8?B?U3pXeUphWUtlN2wzREx6anpjQ2ZraEdsWlNoWi93MHZibmh4dXBWdHN3TElj?=
 =?utf-8?B?Qzkvd1dabVhxOGVuOGJpZW05ZHc3N1hHK2VRK3ZtQTVwZmt1TnVmMjNSekFP?=
 =?utf-8?B?TjlzakxsWENZM3dWTURoeFQ5akpQRzY5UWVsMVVHektYMmc2eHNpNHoxOEcz?=
 =?utf-8?B?ajhMNjVENytRdlh3NGx2TzlzWEdjMnNsMmdlaW5URzJCTzZBWi9kUGhjRkVp?=
 =?utf-8?B?bGlUN1BDczl5ZG1oY0VxVm1OaTFCdFFGZ2VVVk5RUElLOTFtV2I5QjNGTVlX?=
 =?utf-8?B?aEV3SVR6S2xFV2FuQzBxcGovOWFyY29YRWZKMitzczkycmdXeFhEOWpabEll?=
 =?utf-8?B?RGY0dkVQeDRkZUFEcjBFL2YwZXBxVmNtclpEK0xTRTRPUHZ0L0JSU25sWklL?=
 =?utf-8?B?elZqblU3WWJ0RGcrbWp4K2ttVk1TYTB2NWVFUExNcFFPU0NmWVBHL0FCaHJN?=
 =?utf-8?B?dFBPYmE3ZlZ0UVhzR1NCeGN1K1VFTFJnZ1U1OVQ2RVhnZ1VrOWE2QmlHSmFX?=
 =?utf-8?B?TW1Oai9UQnhJNVZiY0VUNkpIQ1dtWVdmMGV0MlJLanZ3TmlOaVVXdXFqK2Yy?=
 =?utf-8?B?dzA4MWlESHpUenhlKy9mc3o0WkRoSU9qbmlLNDFDZ1lFUFczL1V5N2hFTG5V?=
 =?utf-8?B?RUJ1Qi90NG9lMlErQmZzakFzOTR5R3FRQXZFZ1BiUjV1ekEwUm5uK1ltUCtr?=
 =?utf-8?B?OENVVm1FcU5keHVmQlhUdFJHNzNOY3V4VDdaWkVkQ3g1TEthUndnMHJxeHdv?=
 =?utf-8?B?S21SdG9UMjZ1ak04OFdOQ2V6MTBqT3gydU9ETzdaSGNnQ2grb05YU3BUN3ZS?=
 =?utf-8?B?eURtWEpFUUpsK2orRUd5OXFaNWk1M0RRcXlvaDVxdms0UDFJR0o3OGtkQXo3?=
 =?utf-8?B?dVdORURycWh5ZmxRbHF3Qkl4SC9oNnZxMkJETnEreE9CbmFvZWFUN3N6NW9V?=
 =?utf-8?B?bDFkbzlzcVZSUkJKaUV4bTEvSU9GMWorTWoraUdjYWFtaFJTUnNndmhUNjJt?=
 =?utf-8?B?WjN4ZUpLeUpZNld3aFA5eUxHRVRMbHNQc3hvZnRGU3VYeVh0WjFYbHFMbkN4?=
 =?utf-8?B?aVFqVEhVamY5bzRJdjVLUnlGSThheFZ5TDZOVXAyVFpmbDU1bE03MFlZM2d1?=
 =?utf-8?B?L2NTUTRiNUNDbXRoK0czRjAralhIRlNzSTExYWpITFBySkM0SDRZRnBoVy9H?=
 =?utf-8?B?eEhUTG91OHRFRW9nMXhrSGhyUnBteXcxMWNFVjFjT29pempVUnNsckpuU05J?=
 =?utf-8?B?NGZOQ04xZWVHOTNnWktZTUw4b1EzZnlEOVg4VFN4ak9BUDhKcnFkN3pDTWIw?=
 =?utf-8?B?dEc0aURxbG5kV1ByK0s3WEJ4S3MxcUR6WStyblJGRmVROXk3R2krMkZId202?=
 =?utf-8?B?YXRZUzhWRVpNaGVpd3luUEcwenNxTkxQV0d6MlBmZUw5TWZMemtsUUdvVEpQ?=
 =?utf-8?B?YVZLUVlDYTdPY0VmeUFqVHpHNHFTNGFhZXlMSXNIR0NaMUY1MjJ5UzEzaHkw?=
 =?utf-8?Q?YbOzi1jSxjE=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB8984
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000B622.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	79578197-f8c8-48b6-8c08-08ddae72d8fb
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|35042699022|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUZlR2pjMWVXaUp3MGtpc21HRUJMaE0wbFI4QU5mNFZyUnhDNDJnOGUzKzQ5?=
 =?utf-8?B?VUJDbEloY0ROWm1ldEkvcllWeU1SWFJPa28zckszR21CWXRBRGxjU2tHZlk0?=
 =?utf-8?B?V3YwNlBidXpOcnJ0bGRWVm4rak92dzlCWS9GVkdvY0dIS2NPWXgrNTdob1dv?=
 =?utf-8?B?UG5aUzlSSGNHZUdVc3lnWWg0Y2c0cHJXSVFhdjlXVDE4dk9JQVJ5U0Y1am1P?=
 =?utf-8?B?aTdwZDE0SllocUFLTU8zTlhkWS9Jc3FuMm80bDhWZUQvRDdLdGdBLzZHL2JK?=
 =?utf-8?B?cVgzNHl6elZiN0ZLWU44WXlUR3djWmRkVUpEZDY3K0NGRTNmeDVPKzV6a1Np?=
 =?utf-8?B?Q1lyMXR4akRBOW9tUjI4VmgrQ2dWcTZPbGQzNWRZKytJUjl1RDZYSWFkYUdP?=
 =?utf-8?B?RDc2ZzNMUUpKRUV3SGpMR25sci9nZFdkYmNSRldkV2Z6UEs4N24xMEQyVCsw?=
 =?utf-8?B?aDFSV0Jrc0VWSHFSRU1DTkRYTHFuZHQ1bnYyVGVqbDRLVjllM0dSU1ZsQWRR?=
 =?utf-8?B?dmZWdzNsWjA1VmMxRUNIbUpsamFRT2RKWmdmR1JHZDNvemdPbHlkc1Z1aHJL?=
 =?utf-8?B?OFB0RWlzSGVrWnYvV3FCckhnRDlmWjhjZ3R4bHhSaUFtcThKZnNZeWFFZEw5?=
 =?utf-8?B?WVlXMmsxV0pKQjZIYWZsOVRPemM4VS83MWVsQWlUMDJJUVRZT2c4eTVvdEZ0?=
 =?utf-8?B?OFJmcjVaQTZqT1V3RGRUdU91aFREejFpcUh5VlFpa1p2OTZkL0ZzNEY3YlJp?=
 =?utf-8?B?SHBSUTFxMEdlRVRSZmtPc0NBV0FSQmNXUXc1T2VUZStZZzZGbVRxUklFWGZH?=
 =?utf-8?B?NE5PMDFrQVNNQVVRTE9KVjkzbThGMjdSTkZIMHNndi9HY2J4WFFvZXRsOFV1?=
 =?utf-8?B?aytZM1psTHlLMkVLNWRMNTNxcER4UWVpTVMzT0pmaG0zVUlVbms5ZjcwVzJr?=
 =?utf-8?B?Z0cyUHhWblF6c0h1MkUySjZUSDRoOHh3azZKakpXTlh2QVZIME1zN1lWMThK?=
 =?utf-8?B?bmN2N25oK3VycGtPMGVpcWRCSnRvcjlGZ291Qk5DTVF6QmszcnZIeTVqSWha?=
 =?utf-8?B?TFdFUTMyQllhOXJ0M2RzclVNTklQbTFjcXNuVjRaVGJ1RHNnVVg3RFg4QTlL?=
 =?utf-8?B?aHNFWis3V0tHcHVIYnVna2lFdllYMVdMSWtqVnNBenhkVkd1c3o1YWQ2OFJ0?=
 =?utf-8?B?OHFwTXl1UUpQSFZucDVHSm1pRGphc0V2L3IydWhNMEovV1o0cGtRbU1kUVFa?=
 =?utf-8?B?MUZld21pQVh6UFVvaCt5UFpZb002eFlEZ0JZRHhDYnVxSmIyZHc1Mm9ZbWpM?=
 =?utf-8?B?S0hFR3lwNkFDdXRwUDh2Z293VkNPdWNBYTNhbW9wZ1IwTllOU3FNeVpNWmF3?=
 =?utf-8?B?djY5VkwwNnlKbUZ0TGcxV2luU1NwNkRUWVpKQnYxU2pCYkptTGplem5RRFZZ?=
 =?utf-8?B?WUVIdGtRS05vVHcwZUZ2LzNjSlJsRlA3U0U3LzhUYjRmWmFIWXNoa2lSUmlx?=
 =?utf-8?B?aXErcGZ2Mm8rYkV6QTFvOTN6M3hORXNIc0FxVzk4S1I2MkMzemlUVDdMV3R3?=
 =?utf-8?B?anhLVG1yZXlRL3dTQmVoYzZoRXplQnhrWXNJVE9lanc5YVlNbmNmcmlnaDVP?=
 =?utf-8?B?SGRWQWtIVnpwR1hLNWlKVkN0RlFxaFlYcFQrSm44dVJLdmxTMHhLVEhOb2dI?=
 =?utf-8?B?S2UwN1BHaGhzU2pZNzhPMHdrcnoycEZDVTBTOW5pSHVJQWpVN2hhcEdKVC80?=
 =?utf-8?B?Um1WYUlXZ01OM1Vua255VTdBdTNZOWV1c3Q0anU3eGN2UjhYSEVnUzhoL2hN?=
 =?utf-8?B?TnlUd2tkSGFzMTBNck9YT0pIZldjUkJWMDJJT0VMditqYVdQVStYSElLekJh?=
 =?utf-8?B?M2NMTWpGNXFYQ1RuQjZleEliV2drNHBwWk5nalM1WXJvZWlzU0ZYeFFJblBr?=
 =?utf-8?B?RlREVVA1ckI5VVBkK0RveW1uY3pRVkM2YlVnSEsrNFZ4TzZzNmh6NWt4enY1?=
 =?utf-8?B?Um1QdWE1R0FwY2JLd0NZeCtuM2t4dDV1WkdTZ3BXOEdDaDhzZWpzdm5OR0hx?=
 =?utf-8?Q?cNYu89?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(35042699022)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 14:17:57.0167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c197324-1dfd-4ad7-d52b-08ddae72ec57
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B622.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7996


On 18/06/25 7:37 pm, Lorenzo Stoakes wrote:
> On Wed, Jun 18, 2025 at 07:28:16PM +0530, Dev Jain wrote:
>> On 18/06/25 5:27 pm, Lorenzo Stoakes wrote:
>>> On Wed, Jun 18, 2025 at 05:15:50PM +0530, Dev Jain wrote:
>>> Are you accounting for sys.max_map_count? If not, then you'll be hitting that
>>> first.
>> run_vmtests.sh will run the test in overcommit mode so that won't be an issue.
> Umm, what? You mean overcommit all mode, and that has no bearing on the max
> mapping count check.
>
> In do_mmap():
>
> 	/* Too many mappings? */
> 	if (mm->map_count > sysctl_max_map_count)
> 		return -ENOMEM;
>
>
> As well as numerous other checks in mm/vma.c.

Ah sorry, didn't look at the code properly just assumed that overcommit_always meant overriding
this.

>
> I'm not sure why an overcommit toggle is even necessary when you could use
> MAP_NORESERVE or simply map PROT_NONE to avoid the OVERCOMMIT_GUESS limits?
>
> I'm pretty confused as to what this test is really achieving honestly. This
> isn't a useful way of asserting mmap() behaviour as far as I can tell.

Well, seems like a useful way to me at least : ) Not sure if you are in the mood
to discuss that but if you'd like me to explain from start to end what the test
is doing, I can do that : )


