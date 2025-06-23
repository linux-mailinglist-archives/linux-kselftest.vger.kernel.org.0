Return-Path: <linux-kselftest+bounces-35593-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C758AE348C
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 06:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7B963B04FC
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 04:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74DD1BFE00;
	Mon, 23 Jun 2025 04:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="BUvX6Yy1";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="BUvX6Yy1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010068.outbound.protection.outlook.com [52.101.84.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DF218DF6D;
	Mon, 23 Jun 2025 04:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.68
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750654553; cv=fail; b=KUYHIpHS8ZrMCaY6nIHIk/OZAO7ZlUJZGhZZ1Duls58tRLDseKWuKtXZcqedCFxcHCojY/T1Py0Nj4q4imOKzHExpgBmeD7vZiFcgk3MLbP19VMlbZL6Z1lqHNfS9t/i3N6erw27Zt20TZYo/vjRM8LEJUff9QA5FuVLS6bAxoA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750654553; c=relaxed/simple;
	bh=OO6rr14oyCRbYEgydOGPFVewLz4X6rcXwG/WLu2p2r8=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r+W8uiJooKqCGsUYyLbQ5M+B93RILmlBpmIDQzGK5kB+1UM6eIaDFvRjJOPhHKtrCzVL7Xu1D77ITWpploKFv8tHYfdu98iSa6oFph0I2Ql5a6t/7VXFZso84YdNW8v15p+ziG2jWoGlV6RMlkJEmfsu+l0bOozC/ZspYClF2u4=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=BUvX6Yy1; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=BUvX6Yy1; arc=fail smtp.client-ip=52.101.84.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=a54U2VaBDoIO5gtMePJx8TnJlnrEHfCZmn+6hm9uaJvc/HeroU4uDGIlmj/g8pMLY9ayWlfqT3rix0WQUWKQJyG5rwnfWjLDFiL9tx16CRxTnRBWveShTzEyNBwjCdNQ4bIAQBb8YKvqZTP4IW3Ifyu2R19Zc5F/Xw3BDKNTo1h/F2j0apxly9qtA5DIVUisbdSxqq4QqM86PZF3C4YUIOJsvCRVq6O3wHiuRNHP+8QgLNjtpj8fXaztWiLzH2HkgDTu/XYa4xaDIosvuS1CaayJ3rCZwW3kIHfl9jl+N7ZCcoNB18nZoppTqIkz9MjT4jJhLW4SMYWFtbIQlWzqBg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zg26MD/lcqsKsXQNlssvK6+7Wjl+9y73hP/ZRXYcF9s=;
 b=QTgLFk5mWbIL42lzDQPMafDJ/r8gr3Ockznuy0MpTFDjyUQeIkLzcEIjV7/GS1ynY1yQ5HXgXBzXN6QDu0qd/V+dF67dlnRboBokdTsvJtnpKfoQImrKnKSwuOnKd7WYvn7+iADbYMOI4MilSRIaKuNDnL+I94713fgw5U2wBpzdsjOVnZqrDt7drHXjCazLzKEy8JqYDysHvudPoObycmRMN6Ppc6xVydGe/DDt6bn6/Agn9uSMwqOnoyA7u4EZKDhE2UytyNw2zTPadfhZCBh/bGw7FWJhfS7EfTgc9JLl9MtzJALqIkXa9W9DHOAMANduyohrrbzMpd8qIcfSGw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zg26MD/lcqsKsXQNlssvK6+7Wjl+9y73hP/ZRXYcF9s=;
 b=BUvX6Yy1e8ZmKiNslqMEXTfT746odWESF/r4WQ1xSxvrThy7Gpns5mxhWnvFdPCyRiLRy8Zr7FgTaOZOi0pkHt1dyOWwWo+ez2dTJRh4FpF2lZslqjyFyleYHjWcFjIPpxzx/82aSYdl0Jr/KwWrxcI7pjdEUT/TRb6SsDcJDS0=
Received: from AS4P192CA0047.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:658::19)
 by DU0PR08MB9584.eurprd08.prod.outlook.com (2603:10a6:10:448::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 04:55:44 +0000
Received: from AMS1EPF00000048.eurprd04.prod.outlook.com
 (2603:10a6:20b:658:cafe::af) by AS4P192CA0047.outlook.office365.com
 (2603:10a6:20b:658::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.29 via Frontend Transport; Mon,
 23 Jun 2025 04:55:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF00000048.mail.protection.outlook.com (10.167.16.132) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.14
 via Frontend Transport; Mon, 23 Jun 2025 04:55:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wgr0bdoCG/8iWqMjoezyTO0EZ3wTZHdF0zNSRrBu0E4E32nv7ygH6lOebC203lsQKvGV8qp3ddruieWDNc40NrSaCyfzIJDb8gynZjEz6uEq/u+R1BdCsvY4ibFiyFw2asGnSuzKIKKuOGK3VpfEwPkQ7XREjPu3GQOyI7G091wpQ0mX8NzjS0WjYo6wRunftqyEc8YCEh2QTIHmdU5YDPrDutrBbSRIJj+IwCl/3eXhRKrbMvLkIK9jlWdExKWZrvlKr7HgB3thdKsd57Ef+CeVxv/nXxLiXG0wCHCkWzErH4QH6NADzdI8mbrYysQb78g/l1O3XWSJEh0KlUIcUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zg26MD/lcqsKsXQNlssvK6+7Wjl+9y73hP/ZRXYcF9s=;
 b=W1ulAVUEOAhg4NaElJ7zNTezm8TV9MqgxOI9EyonRRRbg5aXhMO6739LaT5E3KTm0gXIb199ytH2c/a9oK0LBdJcpTyzNT1UOHPcT4O3pi+fYDuiYKzevIHWDtf4Ewb472Xc9tsYoKo18wvt0NqE2pa9m8m0WX3Kg5MpvrPu14wIuAMGo3mnN5NYsr2Zu2f9E1pqKLHuXzLPZZWTRrk8HpIdpohWm6Wds2u2Sfsc7lQei8uXxyyyT+d3UINbjSfnlvq4heSRtfUYSlhJTD239jiAFbtp6LGSCMb6CXl/JvgYlCSWk17++d19qyLd3izJoWxCCRfoi7eh2XtpUaQkmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zg26MD/lcqsKsXQNlssvK6+7Wjl+9y73hP/ZRXYcF9s=;
 b=BUvX6Yy1e8ZmKiNslqMEXTfT746odWESF/r4WQ1xSxvrThy7Gpns5mxhWnvFdPCyRiLRy8Zr7FgTaOZOi0pkHt1dyOWwWo+ez2dTJRh4FpF2lZslqjyFyleYHjWcFjIPpxzx/82aSYdl0Jr/KwWrxcI7pjdEUT/TRb6SsDcJDS0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS8PR08MB7111.eurprd08.prod.outlook.com (2603:10a6:20b:402::22)
 by AS8PR08MB6727.eurprd08.prod.outlook.com (2603:10a6:20b:393::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Mon, 23 Jun
 2025 04:55:11 +0000
Received: from AS8PR08MB7111.eurprd08.prod.outlook.com
 ([fe80::4ea7:7e71:7dd3:3b45]) by AS8PR08MB7111.eurprd08.prod.outlook.com
 ([fe80::4ea7:7e71:7dd3:3b45%5]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 04:55:11 +0000
Message-ID: <4585175b-303c-476e-ad3f-09838383364e@arm.com>
Date: Mon, 23 Jun 2025 10:25:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] mm/selftests: Fix virtual_address_range test issues.
From: Dev Jain <dev.jain@arm.com>
To: Donet Tom <donettom@linux.ibm.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>, akpm@linux-foundation.org,
 Liam.Howlett@oracle.com, shuah@kernel.org, pfalcato@suse.de,
 david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, ritesh.list@gmail.com
References: <79bdd993-0e9c-4d7d-b42c-4b5750eff140@lucifer.local>
 <aaddfd0b-216e-48fe-b48f-35c78eabcf9a@arm.com>
 <8e23c5d3-6ce3-4fe8-b6fe-69658d5d0727@lucifer.local>
 <fc5c8193-2642-49f7-9f2a-00ad33353773@arm.com>
 <c93110a4-19e4-4a1d-b044-6b7f521eaa0d@lucifer.local>
 <815793f1-6800-4b9a-852e-f13d6308f50f@arm.com>
 <2756fa2b-e8bf-4c66-bf9b-c85dc63dfc33@lucifer.local>
 <41d9a70d-9791-4212-af23-5b13d8e4a47d@arm.com>
 <aFPI_blZGhvKSbNJ@li-06431bcc-2712-11b2-a85c-a6fe68df28f9.ibm.com>
 <546d7aa5-9ea3-4fce-a604-b1676a61d6cd@arm.com>
 <aFbyFMjVs9F3KMex@li-06431bcc-2712-11b2-a85c-a6fe68df28f9.ibm.com>
 <2fc32719-1e38-4bf0-8ec5-5bcb452d939f@arm.com>
Content-Language: en-US
In-Reply-To: <2fc32719-1e38-4bf0-8ec5-5bcb452d939f@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::7) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR08MB7111:EE_|AS8PR08MB6727:EE_|AMS1EPF00000048:EE_|DU0PR08MB9584:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eae2aaf-f17f-4173-d54e-08ddb21235b2
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?am5sQ3BTVk1jZExYMHJBZG1maHBVaGR0RHFmVTRQM2x6dG4ySEI2b1gyQjI0?=
 =?utf-8?B?d1F1RTY0LzMwOXFnc1J4N3MvMGk0SU8yS2I1aW5ZZnZDYlBjSjFwTElJM2M3?=
 =?utf-8?B?QTNNZWljOTBEVHpkTUY5THNYaVN6bjdrM1dEcHZlN0pVS1Vyc20wcFJYS3lR?=
 =?utf-8?B?MlVHSG8vSXFNZENDK2I5UTBoaFBCdWJRK2FvVnZjeFgxbVV4TzE5QnNFN0Z3?=
 =?utf-8?B?SVBCYWRFcEhINlowZk9vRDQrN3d2b25WNVZ4T0xSNlRQZUVIMllCdFBMaHNT?=
 =?utf-8?B?cVQ1N081WnBjdkJvcEdMVzdCRk9uT2VoL05KZ0J3YXNKcUhKclFWKzczdFRw?=
 =?utf-8?B?N2dUQ05yejdMYmZoSkVpenZnSXNYbzZPeHpSQUVxamxkdlg3RHdFa1lBZWN6?=
 =?utf-8?B?RmNGdVJKSk52UnpVcW1WZUF6cnBGS0k2MEZORTdLaFNMZzlTUzlrSjRoVnhk?=
 =?utf-8?B?SktYUzlqWmp5SFMxYlA0MVVJMjZFSklJTkVyKzNZWlBtVTZuSDNWV0VTb1Jw?=
 =?utf-8?B?Q2NHVHZtK2dHQVJBZ2xxNVcyWEEzbjFCM09wVjdVdHJFL0pjUjZGZ0o0V2d5?=
 =?utf-8?B?UXg0SzdQcHlhTEV3dWVzWjI5SGhIVmlsbjNaSURPc2FEQ0JNWEU2NHA0RjBB?=
 =?utf-8?B?R1Y5Vk5LYmswSzdreFk5MzBSUGFHcjBwdklnQVhZMWhDVXlrMVdLY0RpNlVW?=
 =?utf-8?B?ZDNydVJWQW43aXJpRlVlMnhQRVZMc0dycmxhZExYK01tN1BleHIrTzQ0amtx?=
 =?utf-8?B?ek9pNGZmQ2xFUXROd0RtbWZHQU9PVWZWM0VsSHBKOHJlRjVDOUJVTUVia2dG?=
 =?utf-8?B?TVJTWTUrVFlDdkdGd0Mwek96UFplNUduUmw2S1F0K2dndFdiT0ZtMzZJMkdi?=
 =?utf-8?B?MjdnRVVzMXBCbVRaN0V3RkVvcXhzK00xV241cTQ2OWlJUWxnbWRyN2NZYzJT?=
 =?utf-8?B?K2x0aXZydG9KYjRHaGZ1Wlo0Yk44NXlZdWxWSkM0dGJRbTl5WXRnMXVKRXZh?=
 =?utf-8?B?QUZ3UjdoRlRVeGxqVXBONG5KMmFERFdESVg0VG96QzFrWmU5SHhTOGxnL1Z6?=
 =?utf-8?B?NmlNWjczaDExcGJxdi9hazVhelZ3QmN5eTVGY0dhZ0tCZmdqQS9va2twdm9Z?=
 =?utf-8?B?Vkt1OHhHZWN2R0pRcXJSWkZYRTBVczhWcUZkL0pJMGYrUGZ3eXcxVVFCVFk1?=
 =?utf-8?B?OWF2eGV6Qk1QZE9wa0svS0ZzUDQySUNTQzJTS0w3b1lMTkpVRWx6a2oycFlR?=
 =?utf-8?B?dit3ejlFRGRmR3lBU1BDUktDaTNzdHNpb0FOdklVRVVUYlJmNlpMWmt2dlFo?=
 =?utf-8?B?L3F5VGZ5a2dlVGJUMy90YzF3NVNOM0U2ZytZRFJzQUpHV3g5dnFmYW1iZXZY?=
 =?utf-8?B?SGtRejJmM1FHcmtidmJZckRlTjlsQ2p3V09wbGtVL0xHQ3g2Yk05cDUrUGta?=
 =?utf-8?B?bVViT3dod0UyNnVQS004Q2twbWI3ZmR0ZmxpZDM5aklRQTBYbFVFdXBFaHhC?=
 =?utf-8?B?a3RXVnQ3QUNFVEwzdEFLTkdXY3RJR1pCV1RiVzhjb3c0UzExcXNtVTM0RFR6?=
 =?utf-8?B?V3lOWnhqS3hzS0NBazdNTzM5UUZLcmJpTWlsNDkvQ1NsMzNpNjhSd283dGkr?=
 =?utf-8?B?SVg1YTFhaERlSDZlbmQxUXlYUy80bHMwdDNlZ1JFZjZVc3RGeDMxSlhORUNQ?=
 =?utf-8?B?Q0ttdndmdEJtVHFUa0x6ekxNY2Q0d3NtTzVEQk15RVZFYXRHcVJiYVdVbUVU?=
 =?utf-8?B?VzhINTE5Nnkra2NHTWt2YzhydVByWUFPMUV6N0YwRDRYMkFRSGtBeWtPRFFF?=
 =?utf-8?B?MUtqYTRrV3JIR3VNL0pDaVdTMjJDaFF4cEVJeHNTMm16SnNzSG1wRExxNExR?=
 =?utf-8?B?ZVBjWVVZOGZ1YWw4VXpPdnlHSHJzZmkzUjlaU3pnWXltUkhKWFNJK2lrTWk5?=
 =?utf-8?Q?1PzJUIPFQRg=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB7111.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6727
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000048.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	59143836-fe9b-4c7e-e860-08ddb2122222
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|14060799003|35042699022|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cnFINkd1NmI3bDJOUlVKSjE5emNCY3RBejJRYStKTUxOLzNpSEhRTkU3aExE?=
 =?utf-8?B?bVFVMHFUY0w1d0FIc1JJZ0d3d3Y3UXpBK3dtcGlNdm41L1Iyczh1OWhJbTZV?=
 =?utf-8?B?eWZxMkVaM2JycU9VaGczQ0NYbHB5anVSSlFKdHFPVFBaUmRYd3FnbkVkdVFk?=
 =?utf-8?B?RTdjRTdYcGIvSzRnSjI1KzVkd0ZWc210eC9vc0dwYU1RRkNPbHVPOWRBdE96?=
 =?utf-8?B?NUI1ZnR2WHgwVE1va1Z0Um1idnJLVGxScS90VGgxZ0xBQTR0S0ZxOGc1NkFI?=
 =?utf-8?B?dmJ2WGtCVHVqVWs5dmJlU2MrMGZ1ektwWlBtWVZ4bzdsMmRpRlpmYlR3WDU5?=
 =?utf-8?B?c1dLNUtGVENNUE5PZUZhRXUreXFDaHNvMDY2czh3YlU2anV5MG5tTit4QVlk?=
 =?utf-8?B?VDVOUlo5REVDbFNHWEh0NnZBYVQ3Z0k2M2w5S0VBOHNrb1lVL2VrWVVrNVpZ?=
 =?utf-8?B?bFNucDYrckNzemVWdGdVcnFkd1J2dW9yODhxZDRZWkxXWjJVUGJOei9xdDY5?=
 =?utf-8?B?SHhMRmhyR2RVckx2SG5zRkVhWlBuNS9rYnFYK3pmMW5OSk1JR2lQd2p2cjdY?=
 =?utf-8?B?VVB3c2NTckZON2ZPMnR0MlpxelZvL2E0N1UvWTNDYlN3WHVPMUtqbWVFOTkv?=
 =?utf-8?B?R1g2UVczMGo4OHRDOFQxUTdFM3JacTNZa1gxdE80NksvUUdIVGZvSHRNUTlz?=
 =?utf-8?B?VFJaRlZkNzMxOVhFeEJVbnI4U282NUM0NnRobVYvQXQyYlBCejVqN1RRZ2Uy?=
 =?utf-8?B?MkUyWEZLRHdWZVgxM3I3WmRQL3B4SDdpWUxvRG9aazk3RFVPZGxoQUpyeU9C?=
 =?utf-8?B?Q0hJY01HTzM0VVRmcXczTjB6NUdPY0pndzRoQ2hrdDFZTW03YnhPNUNQNjB0?=
 =?utf-8?B?dVkwMnZoSHFJNUE1ZmlLZW1CTlY3UVc5MmVxT3ZUVFRnS3M4QTV1dit0ZVNu?=
 =?utf-8?B?cmZCNlZjZGd6OUpkWWhjZWI5Q2dxQVQ3VUZwaWJ3SjJxNXhqdXNuS3I2OHFC?=
 =?utf-8?B?aWJzajI2ZnZ5dVB2RDE0R0RpNlZDc3dlSUVGYUtRYkxmVXBSQW5ZSHlnSmNZ?=
 =?utf-8?B?QXVqcjZMNVpQQ1hlOXhjc2k0emZTUm5WMDY4NWx6UFhXc3V6VEJ3TWk3c29t?=
 =?utf-8?B?WURLWkM2dk9NWTN2V05NMU5XSHloNko3bWJZbkpYMzB1TnVPdlFZMnluejlN?=
 =?utf-8?B?Nml2cUZEZ0piU1NUNnZ2cFU3ckJXTnNzSzFPc0drZFZrVHQzQ1RmakVkYnMv?=
 =?utf-8?B?OGFiYWhISzdqVE5udEMrTGl1QXFSaGZHRUQ0eFlyWGFDeC9DV0RkWmRzaCtL?=
 =?utf-8?B?NTJ0UXJ0Z1N3Q2ZTbnJuT3NXYmFYUnZzNW5Ic3EvU21PMFFhS3NKTmRxRFBG?=
 =?utf-8?B?QmQ4R0IrOW1TV0tQRkVlVm1pYnBxb0oyWFV3TXI0VFU5UVpqUHhMeE4rNFU4?=
 =?utf-8?B?U2xnbXpDYmJlS0xocElJeDVYMmtULzdBeVJBTEtIcVV6TVdCbzNiNnVhM1ZO?=
 =?utf-8?B?SXpZMzU0dUwwZG1LVHQxRW0wNUpiKzBna1k4eHdXaE5UZVhLTXlTODF6NUdZ?=
 =?utf-8?B?blcrSFBNSHhzVmVnVlFNT2hwRkI5ZHBiUnRWODRoTTloVHpqbmI3a3R5L2dR?=
 =?utf-8?B?NnZ1OGxlTnJIWm1LSUt1MTQ4RURqNUxGcVBLdnlYU1p4ZklKZUFsWVE2aUw4?=
 =?utf-8?B?SXpvMUxzRkYvTGI2Mlo4cjZxVS93bVNtNksvMFQ4dktkWXFrOEhtL3Y2Z1dy?=
 =?utf-8?B?a2o3T0ptc29CaFJIUEJTWWlPaTdCdDlXMUI0SmxQbUZRVllON0J3NlUrTkFW?=
 =?utf-8?B?aHlzU1hoZnJTOE0zUzZaRlUwWnpSMmQyTnpyYWN3c3NoMjhGa2hZckkzVGZH?=
 =?utf-8?B?cW1Md3ZWNjRWZitnYm1wbVpxL051YnFHRS9CZHJodzJjMmVGMFUzYW50STk3?=
 =?utf-8?B?ajk0UUdmd1BoVGltM1k3MDlRZURMamdWbjlGNWVQck1wSFBYVnlveTd4VHdE?=
 =?utf-8?B?aGtDSVQrZlp6SUhQWDczZVFkeVorY3NtNXFKZkFMa2VIMmgvdWhid01CdmI0?=
 =?utf-8?Q?FCn/QO?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(14060799003)(35042699022)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 04:55:43.5544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eae2aaf-f17f-4173-d54e-08ddb21235b2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000048.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9584


On 23/06/25 10:23 am, Dev Jain wrote:
>
> On 21/06/25 11:25 pm, Donet Tom wrote:
>> On Fri, Jun 20, 2025 at 08:15:25PM +0530, Dev Jain wrote:
>>> On 19/06/25 1:53 pm, Donet Tom wrote:
>>>> On Wed, Jun 18, 2025 at 08:13:54PM +0530, Dev Jain wrote:
>>>>> On 18/06/25 8:05 pm, Lorenzo Stoakes wrote:
>>>>>> On Wed, Jun 18, 2025 at 07:47:18PM +0530, Dev Jain wrote:
>>>>>>> On 18/06/25 7:37 pm, Lorenzo Stoakes wrote:
>>>>>>>> On Wed, Jun 18, 2025 at 07:28:16PM +0530, Dev Jain wrote:
>>>>>>>>> On 18/06/25 5:27 pm, Lorenzo Stoakes wrote:
>>>>>>>>>> On Wed, Jun 18, 2025 at 05:15:50PM +0530, Dev Jain wrote:
>>>>>>>>>> Are you accounting for sys.max_map_count? If not, then you'll 
>>>>>>>>>> be hitting that
>>>>>>>>>> first.
>>>>>>>>> run_vmtests.sh will run the test in overcommit mode so that 
>>>>>>>>> won't be an issue.
>>>>>>>> Umm, what? You mean overcommit all mode, and that has no 
>>>>>>>> bearing on the max
>>>>>>>> mapping count check.
>>>>>>>>
>>>>>>>> In do_mmap():
>>>>>>>>
>>>>>>>>     /* Too many mappings? */
>>>>>>>>     if (mm->map_count > sysctl_max_map_count)
>>>>>>>>         return -ENOMEM;
>>>>>>>>
>>>>>>>>
>>>>>>>> As well as numerous other checks in mm/vma.c.
>>>>>>> Ah sorry, didn't look at the code properly just assumed that 
>>>>>>> overcommit_always meant overriding
>>>>>>> this.
>>>>>> No problem! It's hard to be aware of everything in mm :)
>>>>>>
>>>>>>>> I'm not sure why an overcommit toggle is even necessary when 
>>>>>>>> you could use
>>>>>>>> MAP_NORESERVE or simply map PROT_NONE to avoid the 
>>>>>>>> OVERCOMMIT_GUESS limits?
>>>>>>>>
>>>>>>>> I'm pretty confused as to what this test is really achieving 
>>>>>>>> honestly. This
>>>>>>>> isn't a useful way of asserting mmap() behaviour as far as I 
>>>>>>>> can tell.
>>>>>>> Well, seems like a useful way to me at least : ) Not sure if you 
>>>>>>> are in the mood
>>>>>>> to discuss that but if you'd like me to explain from start to 
>>>>>>> end what the test
>>>>>>> is doing, I can do that : )
>>>>>>>
>>>>>> I just don't have time right now, I guess I'll have to come back 
>>>>>> to it
>>>>>> later... it's not the end of the world for it to be iffy in my 
>>>>>> view as long as
>>>>>> it passes, but it might just not be of great value.
>>>>>>
>>>>>> Philosophically I'd rather we didn't assert internal 
>>>>>> implementation details like
>>>>>> where we place mappings in userland memory. At no point do we 
>>>>>> promise to not
>>>>>> leave larger gaps if we feel like it :)
>>>>> You have a fair point. Anyhow a debate for another day.
>>>>>
>>>>>> I'm guessing, reading more, the _real_ test here is some 
>>>>>> mathematical assertion
>>>>>> about layout from HIGH_ADDR_SHIFT -> end of address space when 
>>>>>> using hints.
>>>>>>
>>>>>> But again I'm not sure that achieves much and again also is 
>>>>>> asserting internal
>>>>>> implementation details.
>>>>>>
>>>>>> Correct behaviour of this kind of thing probably better belongs 
>>>>>> to tests in the
>>>>>> userland VMA testing I'd say.
>>>>>>
>>>>>> Sorry I don't mean to do down work you've done before, just 
>>>>>> giving an honest
>>>>>> technical appraisal!
>>>>> Nah, it will be rather hilarious to see it all go down the drain xD
>>>>>
>>>>>> Anyway don't let this block work to fix the test if it's failing. 
>>>>>> We can revisit
>>>>>> this later.
>>>>> Sure. @Aboorva and Donet, I still believe that the correct 
>>>>> approach is to elide
>>>>> the gap check at the crossing boundary. What do you think?
>>>>>
>>>> One problem I am seeing with this approach is that, since the hint 
>>>> address
>>>> is generated randomly, the VMAs are also being created at randomly 
>>>> based on
>>>> the hint address.So, for the VMAs created at high addresses, we 
>>>> cannot guarantee
>>>> that the gaps between them will be aligned to MAP_CHUNK_SIZE.
>>>>
>>>> High address VMAs
>>>> -----------------
>>>> 1000000000000-1000040000000 r--p 00000000 00:00 0
>>>> 2000000000000-2000040000000 r--p 00000000 00:00 0
>>>> 4000000000000-4000040000000 r--p 00000000 00:00 0
>>>> 8000000000000-8000040000000 r--p 00000000 00:00 0
>>>> e80009d260000-fffff9d260000 r--p 00000000 00:00 0
>>>>
>>>> I have a different approach to solve this issue.
>>> It is really weird that such a large amount of VA space
>>> is left between the two VMAs yet mmap is failing.
>>>
>>>
>>>
>>> Can you please do the following:
>>> set /proc/sys/vm/max_map_count to the highest value possible.
>>> If running without run_vmtests.sh, set 
>>> /proc/sys/vm/overcommit_memory to 1.
>>> In validate_complete_va_space:
>>>
>>> if (start_addr >= HIGH_ADDR_MARK && found == false) {
>>>     found = true;
>>>     continue;
>>> }
>>
>> Thanks Dev for the suggestion. I set max_map_count and set overcommit
>> memory to 1, added this code change as well, and then tried. Still, the
>> test is failing
>>
>>> where found is initialized to false. This will skip the check
>>> for the boundary.
>>>
>>> After this can you tell whether the test is still failing.
>>>
>>> Also can you give me the complete output of proc/pid/maps
>>> after putting a sleep at the end of the test.
>>>
>>
>> on powerpc support DEFAULT_MAP_WINDOW is 128TB and with
>> total address space size is 4PB With hint it can map upto
>> 4PB. Since the hint addres is random in this test random hing VMAs
>> are getting created. IIUC this is expected only.
>>
>>
>> 10000000-10010000 r-xp 00000000 fd:05 134226638 
>> /home/donet/linux/tools/testing/selftests/mm/virtual_address_range
>> 10010000-10020000 r--p 00000000 fd:05 134226638 
>> /home/donet/linux/tools/testing/selftests/mm/virtual_address_range
>> 10020000-10030000 rw-p 00010000 fd:05 134226638 
>> /home/donet/linux/tools/testing/selftests/mm/virtual_address_range
>> 30000000-10030000000 r--p 00000000 00:00 
>> 0                               [anon:virtual_address_range]
>> 10030770000-100307a0000 rw-p 00000000 00:00 
>> 0                            [heap]
>> 1004f000000-7fff8f000000 r--p 00000000 00:00 
>> 0                           [anon:virtual_address_range]
>> 7fff8faf0000-7fff8fe00000 rw-p 00000000 00:00 0
>> 7fff8fe00000-7fff90030000 r-xp 00000000 fd:00 
>> 792355                     /usr/lib64/libc.so.6
>> 7fff90030000-7fff90040000 r--p 00230000 fd:00 
>> 792355                     /usr/lib64/libc.so.6
>> 7fff90040000-7fff90050000 rw-p 00240000 fd:00 
>> 792355                     /usr/lib64/libc.so.6
>> 7fff90050000-7fff90130000 r-xp 00000000 fd:00 
>> 792358                     /usr/lib64/libm.so.6
>> 7fff90130000-7fff90140000 r--p 000d0000 fd:00 
>> 792358                     /usr/lib64/libm.so.6
>> 7fff90140000-7fff90150000 rw-p 000e0000 fd:00 
>> 792358                     /usr/lib64/libm.so.6
>> 7fff90160000-7fff901a0000 r--p 00000000 00:00 
>> 0                          [vvar]
>> 7fff901a0000-7fff901b0000 r-xp 00000000 00:00 
>> 0                          [vdso]
>> 7fff901b0000-7fff90200000 r-xp 00000000 fd:00 
>> 792351                     /usr/lib64/ld64.so.2
>> 7fff90200000-7fff90210000 r--p 00040000 fd:00 
>> 792351                     /usr/lib64/ld64.so.2
>> 7fff90210000-7fff90220000 rw-p 00050000 fd:00 
>> 792351                     /usr/lib64/ld64.so.2
>> 7fffc9770000-7fffc9880000 rw-p 00000000 00:00 
>> 0                          [stack]
>> 1000000000000-1000040000000 r--p 00000000 00:00 
>> 0                        [anon:virtual_address_range]
>> 2000000000000-2000040000000 r--p 00000000 00:00 
>> 0                        [anon:virtual_address_range]
>> 4000000000000-4000040000000 r--p 00000000 00:00 
>> 0                        [anon:virtual_address_range]
>> 8000000000000-8000040000000 r--p 00000000 00:00 
>> 0                        [anon:virtual_address_range]
>> eb95410220000-fffff90220000 r--p 00000000 00:00 
>> 0                        [anon:virtual_address_range]
>>
>>
>>
>>
>> If I give the hint address serially from 128TB then the address
>> space is contigous and gap is also MAP_SIZE, the test is passing.
>>
>> 10000000-10010000 r-xp 00000000 fd:05 134226638 
>> /home/donet/linux/tools/testing/selftests/mm/virtual_address_range
>> 10010000-10020000 r--p 00000000 fd:05 134226638 
>> /home/donet/linux/tools/testing/selftests/mm/virtual_address_range
>> 10020000-10030000 rw-p 00010000 fd:05 134226638 
>> /home/donet/linux/tools/testing/selftests/mm/virtual_address_range
>> 33000000-10033000000 r--p 00000000 00:00 
>> 0                               [anon:virtual_address_range]
>> 10033380000-100333b0000 rw-p 00000000 00:00 
>> 0                            [heap]
>> 1006f0f0000-10071000000 rw-p 00000000 00:00 0
>> 10071000000-7fffb1000000 r--p 00000000 00:00 
>> 0                           [anon:virtual_address_range]
>> 7fffb15d0000-7fffb1800000 r-xp 00000000 fd:00 
>> 792355                     /usr/lib64/libc.so.6
>> 7fffb1800000-7fffb1810000 r--p 00230000 fd:00 
>> 792355                     /usr/lib64/libc.so.6
>> 7fffb1810000-7fffb1820000 rw-p 00240000 fd:00 
>> 792355                     /usr/lib64/libc.so.6
>> 7fffb1820000-7fffb1900000 r-xp 00000000 fd:00 
>> 792358                     /usr/lib64/libm.so.6
>> 7fffb1900000-7fffb1910000 r--p 000d0000 fd:00 
>> 792358                     /usr/lib64/libm.so.6
>> 7fffb1910000-7fffb1920000 rw-p 000e0000 fd:00 
>> 792358                     /usr/lib64/libm.so.6
>> 7fffb1930000-7fffb1970000 r--p 00000000 00:00 
>> 0                          [vvar]
>> 7fffb1970000-7fffb1980000 r-xp 00000000 00:00 
>> 0                          [vdso]
>> 7fffb1980000-7fffb19d0000 r-xp 00000000 fd:00 
>> 792351                     /usr/lib64/ld64.so.2
>> 7fffb19d0000-7fffb19e0000 r--p 00040000 fd:00 
>> 792351                     /usr/lib64/ld64.so.2
>> 7fffb19e0000-7fffb19f0000 rw-p 00050000 fd:00 
>> 792351                     /usr/lib64/ld64.so.2
>> 7fffc5470000-7fffc5580000 rw-p 00000000 00:00 
>> 0                          [stack]
>> 800000000000-2aab000000000 r--p 00000000 00:00 
>> 0                         [anon:virtual_address_range]
>>
>>
>
> Thank you for this output. I can't wrap my head around why this 
> behaviour changes
> when you generate the hint sequentially. The mmap() syscall is 
> supposed to do the
> following (irrespective of high VA space or not) - if the allocation 
> at the hint
> addr succeeds, then all is well, otherwise, do a top-down search for a 
> large
> enough gap. I am not aware of the nuances in powerpc but I really am 
> suspecting
> a bug in powerpc mmap code. Can you try to do some tracing - which 
> function
> eventually fails to find the empty gap?
>
> Through my limited code tracing - we should end up in 
> slice_find_area_topdown,
> then we ask the generic code to find the gap using vm_unmapped_area. So I
> suspect something is happening between this, probably 
> slice_scan_available().


Also, is the memory system you are testing on radix or hash?


>
>>
>>>>   From 0 to 128TB, we map memory directly without using any hint. 
>>>> For the range above
>>>> 256TB up to 512TB, we perform the mapping using hint addresses. In 
>>>> the current test,
>>>> we use random hint addresses, but I have modified it to generate 
>>>> hint addresses linearly
>>>> starting from 128TB.
>>>>
>>>> With this change:
>>>>
>>>> The 0–128TB range is mapped without hints and verified accordingly.
>>>>
>>>> The 128TB–512TB range is mapped using linear hint addresses and 
>>>> then verified.
>>>>
>>>> Below are the VMAs obtained with this approach:
>>>>
>>>> 10000000-10010000 r-xp 00000000 fd:05 135019531
>>>> 10010000-10020000 r--p 00000000 fd:05 135019531
>>>> 10020000-10030000 rw-p 00010000 fd:05 135019531
>>>> 20000000-10020000000 r--p 00000000 00:00 0
>>>> 10020800000-10020830000 rw-p 00000000 00:00 0
>>>> 1004bcf0000-1004c000000 rw-p 00000000 00:00 0
>>>> 1004c000000-7fff8c000000 r--p 00000000 00:00 0
>>>> 7fff8c130000-7fff8c360000 r-xp 00000000 fd:00 792355
>>>> 7fff8c360000-7fff8c370000 r--p 00230000 fd:00 792355
>>>> 7fff8c370000-7fff8c380000 rw-p 00240000 fd:00 792355
>>>> 7fff8c380000-7fff8c460000 r-xp 00000000 fd:00 792358
>>>> 7fff8c460000-7fff8c470000 r--p 000d0000 fd:00 792358
>>>> 7fff8c470000-7fff8c480000 rw-p 000e0000 fd:00 792358
>>>> 7fff8c490000-7fff8c4d0000 r--p 00000000 00:00 0
>>>> 7fff8c4d0000-7fff8c4e0000 r-xp 00000000 00:00 0
>>>> 7fff8c4e0000-7fff8c530000 r-xp 00000000 fd:00 792351
>>>> 7fff8c530000-7fff8c540000 r--p 00040000 fd:00 792351
>>>> 7fff8c540000-7fff8c550000 rw-p 00050000 fd:00 792351
>>>> 7fff8d000000-7fffcd000000 r--p 00000000 00:00 0
>>>> 7fffe9c80000-7fffe9d90000 rw-p 00000000 00:00 0
>>>> 800000000000-2000000000000 r--p 00000000 00:00 0    -> High Address 
>>>> (128TB to 512TB)
>>>>
>>>> diff --git a/tools/testing/selftests/mm/virtual_address_range.c 
>>>> b/tools/testing/selftests/mm/virtual_address_range.c
>>>> index 4c4c35eac15e..0be008cba4b0 100644
>>>> --- a/tools/testing/selftests/mm/virtual_address_range.c
>>>> +++ b/tools/testing/selftests/mm/virtual_address_range.c
>>>> @@ -56,21 +56,21 @@
>>>>    #ifdef __aarch64__
>>>>    #define HIGH_ADDR_MARK  ADDR_MARK_256TB
>>>> -#define HIGH_ADDR_SHIFT 49
>>>> +#define HIGH_ADDR_SHIFT 48
>>>>    #define NR_CHUNKS_LOW   NR_CHUNKS_256TB
>>>>    #define NR_CHUNKS_HIGH  NR_CHUNKS_3840TB
>>>>    #else
>>>>    #define HIGH_ADDR_MARK  ADDR_MARK_128TB
>>>> -#define HIGH_ADDR_SHIFT 48
>>>> +#define HIGH_ADDR_SHIFT 47
>>>>    #define NR_CHUNKS_LOW   NR_CHUNKS_128TB
>>>>    #define NR_CHUNKS_HIGH  NR_CHUNKS_384TB
>>>>    #endif
>>>> -static char *hint_addr(void)
>>>> +static char *hint_addr(int hint)
>>>>    {
>>>> -       int bits = HIGH_ADDR_SHIFT + rand() % (63 - HIGH_ADDR_SHIFT);
>>>> +       unsigned long addr = ((1UL << HIGH_ADDR_SHIFT) + (hint * 
>>>> MAP_CHUNK_SIZE));
>>>> -       return (char *) (1UL << bits);
>>>> +       return (char *) (addr);
>>>>    }
>>>>    static void validate_addr(char *ptr, int high_addr)
>>>> @@ -217,7 +217,7 @@ int main(int argc, char *argv[])
>>>>           }
>>>>           for (i = 0; i < NR_CHUNKS_HIGH; i++) {
>>>> -               hint = hint_addr();
>>>> +               hint = hint_addr(i);
>>>>                   hptr[i] = mmap(hint, MAP_CHUNK_SIZE, PROT_READ,
>>>>                                  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>>>>
>>>>
>>>>
>>>> Can we fix it this way?
>

