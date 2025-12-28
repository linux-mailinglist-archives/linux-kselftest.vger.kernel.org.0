Return-Path: <linux-kselftest+bounces-47986-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 09ECDCE5818
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Dec 2025 23:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1DDE3002A4C
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Dec 2025 22:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BB228B4E2;
	Sun, 28 Dec 2025 22:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yv/pnFcx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012045.outbound.protection.outlook.com [40.107.200.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F98194098;
	Sun, 28 Dec 2025 22:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766961458; cv=fail; b=aABzDGHKzeZ3SWbrH+iInm41AJVjWLV9OERaW63/VDX6lsxu67pwnjSSLLcJK52whYH6Z30lVZlRPaqwYsuamfCj/AYO2RLcvjTC5vlHtKp8n+UgtLhsoucKX1Uq1uBs4G12/LsJSUbbP8Gtl0fkAAFPwnujt+mYjIvKJuCObVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766961458; c=relaxed/simple;
	bh=bupBAHl1v/DGVOxVnpgYAeLq1q/tbWkvNmNpsvuwSp4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G5oH2Q0BDoqwp9xAr+sxoEn612CmeQMmBhUgnbdatVmv1fpM/8q5lHY8mMu+5IYLImwoEY89M8XMxMVrSe65+5RM88zQwrBSRAZkYWto8q+BI4RXA9/NTOb6OwTsfpoA8XuyHWoMj65ITVUlFBOXsQzNK4A2r0VtRKMcpyTKZTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Yv/pnFcx; arc=fail smtp.client-ip=40.107.200.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xyHEgqIcHEsW54bec+NhTVfms2eteezw7c5bkUUt0+A1CcLRJLGbUB5rzq10HOkDmvEDFvFHZ7pyIRq+ojrKxKylHyTzvW74wZG3wlVfUYnlNZfSChpIAlovEzonVvHi1yjZuTz+uWBe39fgcMf8D1ZSCaHcHiwM0FceprF3sTDXPWSjFRw80ED6IaXKqfO57VHUVtIZ6YdG3dT4Ms9HdgggjPsGuxVZHRHDzVweE6FLVfodv6RwU3s0zHGeVI/UXI/1F/RYZGCk5d6V6cAjo9JXkaklTYz/R5ZwI+BLIsqa9ZhHdqaMZzojxVltpsvnL3GBZGc8pcXaTKkMiqTZWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CoSD9hCxkTBtlbcPpOU4SAO6N0H6PKsSvz64CR57a00=;
 b=FKHkd7m6YardbctGxtNq9dOTZV2d8qnxVx72cNAwsYMmvfma4zyGSDOExVcbApWZKyUEhWRDhp907JKtFZmNXIUhPpLUDQQ4zfQGSs0YFq47C7Ykh7baCg5FXYr5+rH+Zoy1BIV2hO4/NSxcOX+ZaCS7hX8HEuMooI90BH9vGSX0FC4Cj6zW0iRgKsSnXc3FGEXSwS8eVfAItPDyHFzJsyA1UD4ngvPMNdTms9T+/EsBpa+JOaNjaMNrEYtLBbrPVt6J+FP+nJIjr5l0fGMSKaHVTq88fsM08To26phefNJzmc8wb0BEgUtgOh4MpPPhnfgGi9UqY5FQXFA0fN1meg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CoSD9hCxkTBtlbcPpOU4SAO6N0H6PKsSvz64CR57a00=;
 b=Yv/pnFcx5qiOuf3PIlwEYxG+iKQ3LtZITTGqX2V8OGrtkmVnpZpulZKp4bYU0ZVpjFj92e4tXv7G/DJ2QNkOKHTWm4SJzJqss9djF7T8UdQOHck0IqaPg5GmVmARLqFh7GZ5iKOtzxHlcr3BBXX1AS9V/7y59DW16TVOw4PHGsAkbmirVBwQejpW9IkeWpmU8KKLfP6ghHXZM1SV7950DmE5zg5xZJRz9ocrGFxcC4PTqNf++kWyhYKCghOC1Sp5EAxpGcJHoLs4xl02qGzIqg+qO1JqCgdh2hki582c+0isH/58skJGQy6aVQ3ITBggOWHKbnUVE0KHO9ppH0KC0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH0PR12MB999113.namprd12.prod.outlook.com (2603:10b6:510:38f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Sun, 28 Dec
 2025 22:37:35 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9456.008; Sun, 28 Dec 2025
 22:37:35 +0000
Message-ID: <3a6bfd87-570d-49fa-854f-8d5802549f6a@nvidia.com>
Date: Sun, 28 Dec 2025 17:37:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/2] rcutorture: Prevent concurrent kvm.sh runs on
 same source tree
To: Randy Dunlap <rdunlap@infradead.org>,
 "Paul E . McKenney" <paulmck@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Shuah Khan <shuah@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20251228220519.150179-1-joelagnelf@nvidia.com>
 <24f4df13-0875-49bd-95d1-4bf1a400ff15@infradead.org>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <24f4df13-0875-49bd-95d1-4bf1a400ff15@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0077.namprd03.prod.outlook.com
 (2603:10b6:208:329::22) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH0PR12MB999113:EE_
X-MS-Office365-Filtering-Correlation-Id: aa9fca5c-2ded-4ad0-e65b-08de4661b23e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emRVTVphUEt1Q0M3N2JkTERmV2FISHh3d2pENThMVXNNbjJYdFRUWEQ1R0RI?=
 =?utf-8?B?UVRQVTd0WlhGbUdaTnNMcTA5ZXNHYkRNOTlHRUFPOVhzNEtKWVNFbVNtR0pn?=
 =?utf-8?B?N1BxaDBEN2M4SE5ZT1g3dmMvRCsyYmR1VlUwbVlQNXhrbkFOSlBUUlprOGc3?=
 =?utf-8?B?T0lnUzFwY29FeFVxQ1V1aFl3WHZPUGNqRG5rN01hQmlUQlc5R3VpVzc5ZzhI?=
 =?utf-8?B?elRudFluc2h2YlJoT25JMzR4NmduTlRid2ZINVlRUFEzY1gyV3Q5RkVqMkEr?=
 =?utf-8?B?OFFLTDFTN3U4dmdMN0ZSMXhIcGMxZGxEbUE5ZFgzTHlNS1ZnZ1BYVWV5cDN3?=
 =?utf-8?B?R05KNXZtak5idzVwOU1MNk9Qa3JYR01ZYmQ0d1BhakhmTGtJdUFUNU5KQzVu?=
 =?utf-8?B?dHczZXUyYnRKQWdTRE1UNHpEeXppbHE0Rm9QTmhXNlVSZHNNM2lJNzN3c1hw?=
 =?utf-8?B?VGhZNnZtV0Zib1JmaWswY0xXdW8vd205WFlpZ013aEZIYUgrZTQzTFdOVGpt?=
 =?utf-8?B?RWtwZVYwYzR6VUJKSkJpUGJQMm5yaTVzanVyT01JNmZndUl2ZHJWWlZONC8v?=
 =?utf-8?B?aGxzQVpIVUNobk5xZ3pXZTVoalNXOWVaRUVaR1ljNzhhVXVFLzc1QWVXUXBU?=
 =?utf-8?B?ZkZDMzdYWVgvc0RiVVNJTXk1Yk1UTk80cFJEeW5nd1NUUFJkdC9LUzlHSWZp?=
 =?utf-8?B?SndVQnpBeWEwa0xsYmFwcU5qTHJWUGNVUjBwcGdWMlUwREs5UTR0b1BNekZY?=
 =?utf-8?B?anNiUDlocHFab1JqSHlQajd2bWpiRUczdkJ5VTZFbllsZFdvVHMwaHVRS0NQ?=
 =?utf-8?B?TllsWTFOaS8zdnkyWVp0cTVnbVp2bzJvaXR1ZkJVTU9NakM2SDJSYnRoRy96?=
 =?utf-8?B?TlFLQXlTQWpmOWVGY2V6NC95cXpXcHMxL2VPL2VSaC9DaDBZQWIwOXVudVJ3?=
 =?utf-8?B?UUpUbWZ5ZVc1ZERFTlUvSTJwanV0YytKcjNSeGtYd3lXMFNkcldsYU1oUXJy?=
 =?utf-8?B?QURvRG1FN2pjR1JJSXZIeC9OTWthOGVSY0ZGamZaMm5oenJwVGhWbmtWclNJ?=
 =?utf-8?B?UloyOUl6bnFMN2ZpT01VY1BUN2VWdEZkRVBjWi9RTHdvTHRHMHlyM3VHKzFt?=
 =?utf-8?B?czNEWHdvZWVHZjdUQWl3Q2xSb0h2QldtYzhHY2dHTVFINHB0TkhnQUdMTnBR?=
 =?utf-8?B?N05lZ1VuMTljeGoyZUg4REsrMnltQzZqajBPVHA2OWlKeWNIcStGN3YyaUJ6?=
 =?utf-8?B?QjRiOERSeEFpdmpJclI0Zi9LamRCamNhV1owRUQxYnVQWGpLN2h1NnJVdmVZ?=
 =?utf-8?B?Sk56dGo4a2hjaEJoM0RGbDh1bVphWU5heGdIZjg3SEs4WFN1MTh6dEVRVnp3?=
 =?utf-8?B?WWoxNjdYZE1GT1N0bXJYYWFDdkg2MDU5V2o1ekxnU1dtYWZXYlJVdlBDYnFU?=
 =?utf-8?B?em1lTW1rSnUyRjRtRXpVUmxJWXJoSTM0b1QzVStDNWhiUFgzS2taQnhvbHVH?=
 =?utf-8?B?Y1hNTCt0T1J5djVteTlLekZnSXduc0k3TDlmQ2tBS2hlaThYVjNma0tScnpH?=
 =?utf-8?B?VjlFVCtDUGZDc0lvQTBSUEtqd0JGSDA2akM3RzJJWTluRC9kd01paGthY3V3?=
 =?utf-8?B?aWkrd3NTVXhTcENxbHFLMDRUQkpyc0ZDVXlZSGMydzIzc0xwVEl0OHJWUTJh?=
 =?utf-8?B?ejJ4dVJTbWJicUNURVVlQkVoRDhEbm1ibkM5NVZpSzBTWlNmYVpTcTVoblpP?=
 =?utf-8?B?cWVrS3dLRCswM3NRcXRSbkgvSjlCZzBFd1VjSmw1dFlRc2Y0bE5oV3JPZndu?=
 =?utf-8?B?TjhVR0tHQ2hsdTZYNVZEVkVVMkl1eWxxTUVrWVQ3YUprQng2VVc1UE9CbmtV?=
 =?utf-8?B?K1hEVWxuVWhqYS9VYmFocTV2YmRCUko0NFd4cU9vdERsMTJ4RlprUkhRRUxX?=
 =?utf-8?Q?kS5PEGPtkXjBKw21fi1Y5pq503y3qbeo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHlWbjFwZFhROG5LQVBjZ1RvbGNnK3VUb1l5aHNrNFBCd2hVOEhBeWFzVGQ4?=
 =?utf-8?B?U0Y0QXhPelJOVjBQSisyM1MvcTMwVXphWUlzK280cWYyUHA3MThuUThrUHpY?=
 =?utf-8?B?MWJLeFFKUVdJVWhIdUE2eE9ocVpJdTNySGtnWnpMaUFRdDJJWXN1ZUVBWFN1?=
 =?utf-8?B?TllHQ0dCcUM4ZE04MVR6QU1naEtvTEZ5N3F0bVpqdUt2Z1hqL2ovdmxGMUxt?=
 =?utf-8?B?Z2R6TzFMaFZMTmNENHBDSDNmM3NTZWZSR0pib0c2T1luTkpmME9iVUp1b1dV?=
 =?utf-8?B?bnRXNy9LQjJrVUUrSk9lNm5ZTzI2THNOYVY0aDhmaWhFdXg1QWtGZzZFSEpo?=
 =?utf-8?B?ZHhRYlNGWVhNdUtGVi96MEdVSjBqZld5TTZ0VlR4WWxrcVVLNE9aVXV0T1Zm?=
 =?utf-8?B?aVp2QTFIUXhxWXBuQ2oyN1NBem9IWm8yL3JrWXkzb3Qvc0RhQmREVEE5THk4?=
 =?utf-8?B?eTBscmJpM1QvRHVRcFQxeWVvYkk4Z2ROdlNoU09ERmhWZmdRbzBGcmsvL0xG?=
 =?utf-8?B?R3JPTjZ1OTEyU1lzUDZNS2JWRUQvRXRyN2F5MnFldkM2WnZQY0YrVW1QVzlT?=
 =?utf-8?B?eGhaTis5aFhrQ0c1TDJMUFJBVFlRY3F0VHdHUUJQZXZuVTRqcDdYYXpiQTQw?=
 =?utf-8?B?L1RTWTZnZGNjSDZ6dWFaeDE3SUt4K1AzY216YnVFZmJRM2FMeTJUZzZma21E?=
 =?utf-8?B?dndsTFp6cHN2WlJvMU5taHRmM2lla2F5M3M0VXJ4eUtTdFRFaTMvMGt0UWU3?=
 =?utf-8?B?bjRqcVRJbVE1MlB0Y0VjM3NTZ2lGbVZpNWNPK3lQNUl6eTdObzN4ajVPSHdC?=
 =?utf-8?B?dk5IMFYxOXVvMkR5RUh3bmI0UDB5ZFQvV2thVE1uQ0FPQTRmY2lmbmNwVkVs?=
 =?utf-8?B?NllHeUZwNFZlSXI1Rk1VOWVCS1A2Qy9nMkZwaStjbE9jazMzaWdGTE05NE90?=
 =?utf-8?B?QUh0dHE0cnFjeHo5TmN4ZFIyZlIzQkRlWE1LbFpqL29LYmJNOHp5VVJZL0xH?=
 =?utf-8?B?eW00RCttMWg0dllOZk9nM29ueEZOVGxnWmliTjhMZy9rRm5hc2FrL1ljcExj?=
 =?utf-8?B?QnB6ZzQ5bGJKZ2MxR1pzRWExT3FiLzZiamJjblRha3RrV0Q1ODliY29mUDg4?=
 =?utf-8?B?d0VtMGEya0N3dllTN2l3d0VLdmJxaDRJRXRQSWZKOVZ5RUduQWMyZVVaWXUx?=
 =?utf-8?B?cTU0ODdBU1E4TlBjZklROWMvVWhELzN2REFZeHVoRlNWa0ozSlYxbk5hZkJK?=
 =?utf-8?B?SDF1U1I3Rkh0bU1CTXV5dmFZVGJZOUE0eTFWSWJZR2VBYi9yNFBmV3lqVGU5?=
 =?utf-8?B?UnN6SjQ0clgxV2ZQRExETTJkLy9UVlcyMTA3VWdEeHFraDZRYW5YZ0lmNFJE?=
 =?utf-8?B?Q1VMKzBVL1FBS1hEY21uRXcydVQwbUZkbEQvOUFUM01qMHVpZHV0YVdnMVk4?=
 =?utf-8?B?a0xwZmhWWHBzVDRKYklUbHFuTXVSQXVTbzVmZTgremxkZ0tHaTNHL3NadU9C?=
 =?utf-8?B?L3ZVcDVBT0tENE5CTHo1MUNuVW1VbWdjL3IxVXRmRE5lTzFSVk9NOWVQS0pl?=
 =?utf-8?B?WnUrVmdua05wWm1kM3lFNWxSRE0xeXU3VXozWnhXQVo4NkFEY1pRNCtPb1J3?=
 =?utf-8?B?WWtCL25rVCtsNHh2TXJrZXc1THJBektIei9uK1FBTW9wVys5R04wWDAwWVVP?=
 =?utf-8?B?Q1Z2UnlKbUQzRHMzQkd1VTV1WmowK0x5bVA1NTVPY2ozMWU3U1g4NjZwRWpP?=
 =?utf-8?B?UGx2QXFmOXBob1hQSEJQUVhTdzFVc25PVWRrTEVURGY0RDNxOThGeEVPY3hE?=
 =?utf-8?B?M1VPeGRlL3pDMWFTSDdWNElNK0xmTVE1anJXTHhKY3pBREpWZ0hWV25WS05o?=
 =?utf-8?B?TzlZUE1xT0l6eTgwWjk2d2lWK1dIVCs1WkU4cW9rNlZQTW9BQXNIUVFvdm1K?=
 =?utf-8?B?dW0ydXhjNjVLTHlWcDY0N3U5b0dLV1B5aVdjK0hrcUFJKzM5SGl6bGpzcnpF?=
 =?utf-8?B?QmNxSjNzdDBlOTJ1T2htdVQvcXBhaHR2STQvRVpEdTNLUk1MRkdpcmZFSDda?=
 =?utf-8?B?bXFzWVQrRXpEcDJQbjN3cnBJQXFWcTVkLzFRa1pPcWtaN0xVd1k2OUhRd2Er?=
 =?utf-8?B?NWovenp5UlNjNkVNdmlBRlluNkVadmQrTjVzL0NFR3cyQU45WmFNL1BNRjNC?=
 =?utf-8?B?ZlJXNzJSaDZKamR1V0xpZUtpbWU2dUxlVm1DRXlXSDdKK0ZVbGNIOG9qWldQ?=
 =?utf-8?B?dWphNHhzZnRjZmZjMzVCOFNrcnMrQ09Yd3NDek5Ya0dqWXhtMitHVWNkQzNw?=
 =?utf-8?B?OU1lVFZPZVRQM05Lb1BKTjNXQWZKbVRoT05BbGVmcVZiUStCSUowdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa9fca5c-2ded-4ad0-e65b-08de4661b23e
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2025 22:37:35.0600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M6oQW1ykuWrtb43O2dPZopEuQoBfv3vI04nZoc7kqXfsJbnq8hLiSJKHgmTCezetwGVjX6LI+sh49GClyeGsHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB999113



On 12/28/2025 5:34 PM, Randy Dunlap wrote:
> 
> 
> On 12/28/25 2:05 PM, Joel Fernandes wrote:
>> Add flock-based locking to kvm.sh to prevent multiple instances from
>> running concurrently on the same source tree. This prevents build
>> failures caused by one instance's "make clean" deleting generated files
>> while another instance is building causing build failures.
>>
>> The lock file is placed in the rcutorture directory and added to
>> .gitignore.
>>
>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>> ---
>>  tools/testing/selftests/rcutorture/.gitignore |  1 +
>>  tools/testing/selftests/rcutorture/bin/kvm.sh | 17 +++++++++++++++++
>>  2 files changed, 18 insertions(+)
>>
>> diff --git a/tools/testing/selftests/rcutorture/.gitignore b/tools/testing/selftests/rcutorture/.gitignore
>> index f6cbce77460b..b8fd42547a6e 100644
>> --- a/tools/testing/selftests/rcutorture/.gitignore
>> +++ b/tools/testing/selftests/rcutorture/.gitignore
>> @@ -3,3 +3,4 @@ initrd
>>  b[0-9]*
>>  res
>>  *.swp
>> +.kvm.sh.lock
>> diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
>> index fff15821c44c..d1fbd092e22a 100755
>> --- a/tools/testing/selftests/rcutorture/bin/kvm.sh
>> +++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
>> @@ -275,6 +275,23 @@ do
>>  	shift
>>  done
>>  
>> +# Prevent concurrent kvm.sh runs on the same source tree.  The flock
>> +# is automatically released when the script exits, even if killed.
>> +TORTURE_LOCK="$RCUTORTURE/.kvm.sh.lock"
>> +if test -z "$dryrun"
>> +then
>> +	# Create a file descriptor and flock it, so that when kvm.sh (and its
>> +	# children) exit, the flock is released by the kernel automatically.
>> +	exec 9>"$TORTURE_LOCK"
>> +	if ! flock -n 9
>> +	then
>> +		echo "ERROR: Another kvm.sh instance is already running on this tree."
>> +		echo "       Lock file: $TORTURE_LOCK"
>> +		echo "       To run kvm.sh, kill all existing kvm.sh runs first."
>> +		exit 1
>> +	fi
>> +fi
>> +
>>  if test -n "$dryrun" || test -z "$TORTURE_INITRD" || tools/testing/selftests/rcutorture/bin/mkinitrd.sh
>>  then
>>  	:
>>
>> base-commit: 0ff41df1cb268fc69e703a08a57ee14ae967d0ca
>> prerequisite-patch-id: 912adecf969d167ddd35b26844249c809a2d4664
>> prerequisite-patch-id: 95ca224b0870cebb545ddaf313691fd18dfd04e1
>> prerequisite-patch-id: 68a218b9aaada53aa85cf33fcf4afe1592fe160f
>> prerequisite-patch-id: e40912ee9655a8abef17413a1bb9b05d2d4520de
>> prerequisite-patch-id: c0511755626728abcbed2f76e9a0b1d2f15e7c9e
>> prerequisite-patch-id: 0a8814cf3965ce3d5fb30d18db3daf2b96c3db74
>> prerequisite-patch-id: 450827b1f88e4ab714a63a24a66bd209f8c332af
> 
> Are all 54K of these required?

Ouch, this looks like a case of git format-patch scripting gone bad. Anyway, the
patches applies cleanly to Linus's master branch. I'll go look into the
scripting issue.

Thanks!

 - Joel


