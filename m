Return-Path: <linux-kselftest+bounces-26806-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D77A38CF8
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 21:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BD54189805E
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 20:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4E223FC5F;
	Mon, 17 Feb 2025 19:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="mPjRh7Br"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022080.outbound.protection.outlook.com [40.107.193.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C3023F28F;
	Mon, 17 Feb 2025 19:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739822391; cv=fail; b=URTJMRfCb9LLzw6w8xrOlLiNkzEbyhoi2E9ewPHkP9y8865pKLuJkH5vC8JSVpLnien6vbzSuarAcCy4CEZJK2YjzjDEDnzolM8IoohS31BNtX5sZQtWkwnfe+H5umcsScd/u1qEFKYsjTDivs+PuGupmdc8TkzuIvrVfYwNb0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739822391; c=relaxed/simple;
	bh=30Vw1PUw5W45rgcHVp8yr5y1afKdmVBqj7B+xISWjxQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cqqv7MmPo5GhwQeYAz61ja/o2XyDi/wJwuGwkMoEyTZTPOvg13ASyJAeYSByjYOrC6NIieQAz2pO30gzAIZrHTqdIjQ0EnO5nLR4QXiPz7h4TKcPyg9BSNRGp+oM2MkgfoCyZY2nA9lhUvLPrWTyNs7P0n6ikPAnw8xicc74crg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=mPjRh7Br; arc=fail smtp.client-ip=40.107.193.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eXZ8xBM02BAPCTBvQ0YRZOmoaGTAaYeYeqwrlF8OUL7rUBnh8DbnuJnM3dfGnWPUIUDbc2yNJYnCGvUOGvrh983de6bF1sk9NdDXyc6enTpdUZ1pau4Nda4q9s4iSSLAmV2O6cULCpwimV5iN2ifnrPXXfXLVSW6Xj6nprUDH2VHL5mnaqYZIAAuPw2a9ErNNfYYuuY4hrE9Kr46Jh5K95hX7P2Y3tVwYUcL1BmNp5G38wVmdkZbfrlNB2nnDsFBIJPDJG1CmpOOZKrhUZ2lRVj5yhhWqgybbaoc4C5mivNngcuuEAC2+Bxc8L4qeKTXUWIlpUhnfWA5bNf9KwTyDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FRC8uTDSCp/0ImtkBn4lTLtxfuHEHOtwhiQM+BSqKU=;
 b=v1rJAWV1/PFq9lk3IhltGyTAxQPQyeB56XYIn9TOB7Fjh93Kp4wJbtsPiqyUK6zv/l4BFwNRFlHMnKcua7Jm7hjh+25DFmvhYI6b5PkEWP8Pa9fWmuKdk1yCz/xGF01ZFeuVO8FqPvmLhBU7Eow8SFaWGv7vYziBF17MdGNdfP7kJUZmWFnb/ZAoO4TAmxNBzqXsML6Z2khz2dmCGvfEZs+KKz32tHAEYfSQ6gEq7C07X3NIyXirpz5DZAVIyZLyKIpZ1yj1O7kVoPQY6B82hDUF0ftc6GMY9n+vcQWf4EyAR5Appo8JFGtbntwpgR0reQ1M8zWAwL7+I2hMFAHvuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FRC8uTDSCp/0ImtkBn4lTLtxfuHEHOtwhiQM+BSqKU=;
 b=mPjRh7BrOf+EGeNVVLlfnBg/IjGHnNDFeR5LsMTwDWJPPvBC/Qv3KM/ndU0mlgNWz2ONaHMcMXpd/9qf7qZIjeXqzr8hI/QybmE57pC3SeWl0XyVAVzaIP6Uv4cjnTK01m80dbCpnwUfWWl/hs4GdSB8n07o7v4WfW1q6TFwc5SpZkBOghoH4dEJUNPAYF1Q7Tr9XfZ9EAm74GHbhFoSI4aDAg0pl3K9eOUBkH1gIC6bevPNonF1e245y/RW2lHSzHM1PdaPLpfSWzrnMlhRFn7ftiadxqvmH+UTrNA5LvfvvNOtJs11uazVYGGHfcKh5/3BiG2ELSEMmsf1QGgSHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB9650.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:af::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Mon, 17 Feb
 2025 19:59:47 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 19:59:47 +0000
Message-ID: <822a9d2b-a9f3-45b4-8cad-077489015301@efficios.com>
Date: Mon, 17 Feb 2025 14:59:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rseq/selftests: Add test for mm_cid compaction
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>
References: <20250217112317.258716-1-gmonaco@redhat.com>
 <20250217112317.258716-3-gmonaco@redhat.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250217112317.258716-3-gmonaco@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQ1P288CA0007.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::12) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB9650:EE_
X-MS-Office365-Filtering-Correlation-Id: 383b5c6c-9ee6-47a1-e2d1-08dd4f8da144
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0hCNUJjQ0xVWDdBQUhjVS82U1Q0TGZRb2llam1yTmlxQklGMmF3SXhWSTZO?=
 =?utf-8?B?ME1qUlB6UkFHalFuT2dNU3ZWcTlKZk1lb0hyRjJlSHlQeEpNc2hXcWcvQ25o?=
 =?utf-8?B?Q0p3Y0xGUVNOMnBMWnlMTTIyZjZ5VUppc081dTR0bHg1WFN4YlRGMEd3V2FZ?=
 =?utf-8?B?UUxIZGtnVy9YaGxKcXpuN1VBcTl2cVJQWGFLbU1TNEhOQmVSS01Lbk51WkRp?=
 =?utf-8?B?dUV4ZXZJaXhxWkhPUE9sRVk4aWFQWlMra1RjRGNQdDR1VTVHK2YySjl1VmJ4?=
 =?utf-8?B?TDFEeld0QTF4a0VZWm5adGNDWXRRNzZ4Z2R1S1dDdGEvTUtSYXFBeFhHaWVP?=
 =?utf-8?B?WWMrbjVGN2JuaTdPRHNZdVVZaTVLdzlpc3lDK3MrR01aM3ZHSlgxNk9mY2ts?=
 =?utf-8?B?TGZVRDNiTVlKN0F5N3lkc3NNaGE3N0UrOUhyeFFEYXZKYkYvZ21LYmEraUo4?=
 =?utf-8?B?Y3RjWlVMQzYwT0h1eHlkTE9talcwZVBkSTdPUjlPWjVHOFQvWmV6TFhUeURV?=
 =?utf-8?B?YzRoY0ZSTEd0bW4vRSs1NGo5bit4VzR6NGYyNGtibVNVNStxVWdiM0d1bG5K?=
 =?utf-8?B?STF0d3FZdkdQODJnUVFiU3orcGR5Zy9YUWRKSi9saytQeWNrTHVPUGdUK3k3?=
 =?utf-8?B?VmtraHkvRHJtb21OV0drbFJGMzN6S3dNb0VyRlN5OEJ5T1RCekJEbTVxSTZY?=
 =?utf-8?B?Nk82Z3llZmJNZ3JBajVXS1Y3b28wWHJQYmZJODBOZ1BDeFFyVncwc3plSFov?=
 =?utf-8?B?UEdOMmFaUTZRRUtRY3FKQ1djUkc4VHRkdEFGei90SWRmQjlKV05jQUJ6MEw2?=
 =?utf-8?B?ZlQ0NFYvT2h2NnNtdkVuZXQ0N3RsdnRVT2lmdFJwRzMxaGJBNUQ2SHNCUDF4?=
 =?utf-8?B?QTJOdVBFUU43MUhoMFNHQkMwMVIvRnVmWUxJMUhISVY4dGJGK0IwWjFER0hv?=
 =?utf-8?B?Y1FkZzVTODlaT01Bb2MvVEZBZy9nUWIrNXVDRDFPNTdRN0pnMlJ4ejBOTlRj?=
 =?utf-8?B?WEM0STU2bTZ6Z3JTVERnWXlzcktXbVZvTzVIN1NoL2tJVVVIUlRPckp1ZTI5?=
 =?utf-8?B?czhxRXJYRm00VFUvT21vWHN4bGRYTVU1VUZlbDU0Sk42MmpZZ2J6bEhsczBa?=
 =?utf-8?B?U3BmamUyZVlMMyt2bzhQYVRmOHRQVDA2VFA0bTlOc3dNNDA3YmhXY3RhUkgv?=
 =?utf-8?B?dy9nWEJHazBudTRDcnBmNFZUQk4yUUhsVS9uVjEzckNIck9iSVo5UHhvdWsy?=
 =?utf-8?B?dUh3blcxR2RVSVF3alVlNjN3UXVvbUNTNUFkeHorZjEyVGdHcElVZjVJRTRL?=
 =?utf-8?B?TWtTWCsxaE5GSS96TVkvcWtnaldHK0x6djBLY3U0dzlNOXZEdjNLS25Qc0kv?=
 =?utf-8?B?QTh3RVY3c05tZzRVSHV3aGlZMHI3S293d044NGNmVDEvNDFBWU9JN3FrcWVq?=
 =?utf-8?B?N2hUejd1encrZlBPWEJHSFFZQ3BKSzU2dHNqYW13NVQ5QWVYMnJMK3RIWVBO?=
 =?utf-8?B?M21YZWJML1NWZDlITFpzb0ZlK3VYWHE4eTByR3FGeDFNQ21ia2c1MGpTTHpa?=
 =?utf-8?B?dG5VQWY0TlZXWkhyUy9pNGd3ZzQ0MFNMN1ZNR3NjeGVGZGtMd05Ec0RmRU1y?=
 =?utf-8?B?S01yVDBDVWhZc2xOdXhmQkIyY2pJdU1ZLy9pVlUyV2Q4ekVMUVZCS3lvVW54?=
 =?utf-8?B?NlIyd2h0U3Y3dmx5VXNhbUFnaVNQNFVVc3RaU0V2ZlE5L2s3WE9yS0RsVisz?=
 =?utf-8?Q?jznG7hvZwwexdIdB6boMJ7O68Ea9gadpfglvjlb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnR4d2p1aXRzclhXSGpkaHliek4vK0xWQ0ZySnI3L3Q4aXRZUzdUZHBTdWNz?=
 =?utf-8?B?U0dBUFM5WWZNZWoyRE10ck5OZU54WmlGYnVObHJlTi9paVBORUNKaXZPSEly?=
 =?utf-8?B?MmI5RVZpVEhaQlc5M25aVmFjV1l0SDQ1Q2dleElSL1FUeE1RRG5sWkNUQlZy?=
 =?utf-8?B?eFYrTnFkbjY3UkpSNlhRSlFMaXNvZ2tIRFMrdGhXYkJhcEZLV1Q1Tk9uUW01?=
 =?utf-8?B?MnRoOHM1NlIxRC9HQUxsbE5OM2FVcXNmTG1FZFlGdUdhbmVsSHliMDZQWFh0?=
 =?utf-8?B?RVBZaE1XTkJySEIzYVpVME1sKy80MUl1N2JyYURrQjJUVFlsK0JqVVNRVWxu?=
 =?utf-8?B?SkQyU1RBTll1TWQwd09Jb2pzZlhKMHZaV2ZTV0lFUU5aN2s2N1hRRnFoTkpR?=
 =?utf-8?B?K2JMOXlrMStKRlRBTDBUTUJYNnYzQTdoRUpsYWltL1pKRnprcUVJaS85dlVx?=
 =?utf-8?B?T0tNTVNaYitTSFFhU2s3TGdwTE1veXFEQnZzOU1BaXhCNGdhY1FkaDQ0N0Zp?=
 =?utf-8?B?OVZ2SjhCOFFHbTVBaTBRd1ZZWGRha25ITmx4alphYmV2dzRRWmkvcVJYcXlG?=
 =?utf-8?B?RGNHczk0eU9vR25oYjY0MUgyZVJzQ253dkVLMHk3dFVyc1RpMjJPNEJzZllx?=
 =?utf-8?B?SWhnNXBKdzFTZ3FMSEowSU1Qa2gyajY0WEVEYmU5elVMWnpKMUoyUXg4YUl0?=
 =?utf-8?B?YkdmeDVXYmovUFBpamQ2MDVQWHJXRVV3VnljWUhkSWcxVEtlNXJhTWtNZ2N6?=
 =?utf-8?B?YjJwRFdyaU1lL25HR3VuVlppOXVZbnRtRlRYL2JEaFp0Y0NaeXhFamV0QlNv?=
 =?utf-8?B?Mm5ZSHVCSGh5eXFoalhYZktPSG1za1VxeDM2eUZSM3U4QmxOYm9Sdkh6K0pM?=
 =?utf-8?B?eDVQcUdSY0krV0pTQzZ2bERaSVJScGJJVFBjL1l1M3YxSVl4Sjd2SXowNEls?=
 =?utf-8?B?MGV3aHBJNG45V3dwRE1iblQ4ZUlvaVZEVGt6b3J0UTlDaEJNWWszVFZCa0tN?=
 =?utf-8?B?Q2hxeWdQNzU2NkJ1cGdQZWpLcW5ibFRxVFRiMXRERys5VHBSSVcvU2xpRjV4?=
 =?utf-8?B?UWNjWCtKQ21ZbWdCcS9FM2UzQncrTlBJZWsrM0VpUUdjQ0JOaWxQYit1M2Za?=
 =?utf-8?B?WXFTa3dXYW9qbVQ3emZBWG5pb21VNFlUZmRhWkJGT3FWVzU4aTI5OHdBcWFh?=
 =?utf-8?B?bEovWG9uNEI0MHZSTHRHUzFraW1OcFJMNnNpV0IxcVJxZmpwMDYwWHZXNGZ0?=
 =?utf-8?B?ZHNBRSs0WXhVMmg2Q0FxQXUxZVQyeEhwTlMzR3pzVkkwMnRxMlJTUHpBTE5j?=
 =?utf-8?B?dm1qUU1QbU9DUEthaGZ2aDhhYlF4blNDVE5GampNQ3NiWU1MM1FPZERsSkhI?=
 =?utf-8?B?NXlCOVVJQXlXUUdYZmJQMm1HUCszNDZGbndWODNhVXd5MHFGZmhESXRwbXdv?=
 =?utf-8?B?cnFPdTMvQlY0OEVkajlKdkIwdWdWbHZwb2JJVENQVHNZVDBZZnJhQ0ErTXpG?=
 =?utf-8?B?ZnZCcGl6YktDZTNNMytxYW5RVmdkSUNNN285cmhveExwdUVxcjNVVG9XVjNl?=
 =?utf-8?B?a2ljMElqeDEzNTVjYlkxdUxmZ3ZxK0ZmNW5xY3NoZVp6bmRoY3V6RWY2NFBu?=
 =?utf-8?B?cDFacTdKN3pOcFZQWFJvL0FzdWowQ3pQcnE4VTIvQlp1NGpjSFR5SlhnMytP?=
 =?utf-8?B?U2h2Nmg3OXcvSTRycmM2MFlURmcwblJBYTQwOEJ1UEhXN1prZ3pwK0Z3TXJO?=
 =?utf-8?B?M1dkVHBRNEZyT3hMVFYyVFd2eE1XYk9ydGhQNVJySGZDYkloend2cUdWRnZV?=
 =?utf-8?B?TDZTTXRuT2hFTS81a1QybHVWaXJGNXpobXJpMjVraGRzZlljQ2RmL0RxcFNV?=
 =?utf-8?B?RElaOXRxNXhKUXI3aUp0TDk3bnNiY1g2R094VWhZTEVsR2tqWXNDVTVwcmpJ?=
 =?utf-8?B?dkZwaUQ5eS9jU0UvbVh5S3duRGh6RTVIN0NCWUFJbUVrcGlPd3dZbTRyL2J2?=
 =?utf-8?B?M0YzNHFQZGJtK2d6UTNvcWlVYm5WbzN4Vlc3YXlYMlBRYmREd3FsbmJvc1dx?=
 =?utf-8?B?TEkzeGpuVm5HZUd6U2RjeGFVTWNFejlkTWRpWUw5REZScVFjMTNJQmtSNks3?=
 =?utf-8?B?U1ZUZnpqNm5wbWUyY000Y2JTMUJRU2NYK1ZKaTBFRTJUTGtPTU5ZbVJ3djRN?=
 =?utf-8?Q?m2L5EaiMlzRlFAFSyz+IgBw=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 383b5c6c-9ee6-47a1-e2d1-08dd4f8da144
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 19:59:47.1906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /hhZsSKz3nB4bEpZEXja6SAkbdeuA92HWXrTEfcxzwDycBlTZOJL7zHX1EieVxWxFoqhf8FGYw8e8N3CVaQ2U1gSD91S0hcrpnZVXjnR4q8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9650

On 2025-02-17 06:23, Gabriele Monaco wrote:
> A task in the kernel (task_mm_cid_work) runs somewhat periodically to
> compact the mm_cid for each process. Add a test to validate that it runs
> correctly and timely.
> 
> The test spawns 1 thread pinned to each CPU, then each thread, including
> the main one, runs in short bursts for some time. During this period, the
> mm_cids should be spanning all numbers between 0 and nproc.
> 
> At the end of this phase, a thread with high enough mm_cid (>= nproc/2)
> is selected to be the new leader, all other threads terminate.
> 
> After some time, the only running thread should see 0 as mm_cid, if that
> doesn't happen, the compaction mechanism didn't work and the test fails.
> 
> Since mm_cid compaction is less likely for tasks running in short
> bursts, we increase the likelihood by just running a busy loop at every
> iteration. This compaction is a best effort work and this behaviour is
> currently acceptable.

I'm wondering what we can do to make this compaction scheme more
predictable.

The situation here is caused by the fact that the CID compaction
only happens on scheduler tick. If the workload is periodic and
runs in short bursts, chances are that the scheduler tick never
issue task_tick_mm_cid() for a given process, so no compaction.

So task_tick_mm_cid() basically does:

void task_tick_mm_cid(struct rq *rq, struct task_struct *curr)
{
         struct callback_head *work = &curr->cid_work;
         unsigned long now = jiffies;

         if (!curr->mm || (curr->flags & (PF_EXITING | PF_KTHREAD)) ||
             work->next != work)
                 return;
         if (time_before(now, READ_ONCE(curr->mm->mm_cid_next_scan)))
                 return;

         /* No page allocation under rq lock */
         task_work_add(curr, work, TWA_RESUME | TWAF_NO_ALLOC);
}

So typically we have a "time_before()" check that is hit and
paces the execution of this task_work every 100ms or so.

If we have periodic tasks, that means those tasks are necessarily
preempted so they are not current when the tick happens. If the
task cares about compaction of mm_cid, it means it has returned
to userspace after that preemption.

Sooo, we happen to have code in kernel/rseq.c called exactly at
that point:

__rseq_handle_notify_resume()

I wonder if we could perhaps just call task_tick_mm_cid() (or a version
of it renamed to something more meaningful) from
__rseq_handle_notify_resume() ? By combining time_before() checks from
the scheduler tick and at return to userspace after preemption, AFAIU
we'd be handling the periodic workload correctly, and therefore this
test for mm_cid compaction could check for more robust guarantees.

Thoughts ?

Thanks,

Mathieu

> 
> The test never fails if only 1 core is available, in which case, we
> cannot test anything as the only available mm_cid is 0.
> 
> Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>   tools/testing/selftests/rseq/.gitignore       |   1 +
>   tools/testing/selftests/rseq/Makefile         |   2 +-
>   .../selftests/rseq/mm_cid_compaction_test.c   | 208 ++++++++++++++++++
>   3 files changed, 210 insertions(+), 1 deletion(-)
>   create mode 100644 tools/testing/selftests/rseq/mm_cid_compaction_test.c
> 
> diff --git a/tools/testing/selftests/rseq/.gitignore b/tools/testing/selftests/rseq/.gitignore
> index 16496de5f6ce4..2c89f97e4f737 100644
> --- a/tools/testing/selftests/rseq/.gitignore
> +++ b/tools/testing/selftests/rseq/.gitignore
> @@ -3,6 +3,7 @@ basic_percpu_ops_test
>   basic_percpu_ops_mm_cid_test
>   basic_test
>   basic_rseq_op_test
> +mm_cid_compaction_test
>   param_test
>   param_test_benchmark
>   param_test_compare_twice
> diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
> index 5a3432fceb586..ce1b38f46a355 100644
> --- a/tools/testing/selftests/rseq/Makefile
> +++ b/tools/testing/selftests/rseq/Makefile
> @@ -16,7 +16,7 @@ OVERRIDE_TARGETS = 1
>   
>   TEST_GEN_PROGS = basic_test basic_percpu_ops_test basic_percpu_ops_mm_cid_test param_test \
>   		param_test_benchmark param_test_compare_twice param_test_mm_cid \
> -		param_test_mm_cid_benchmark param_test_mm_cid_compare_twice
> +		param_test_mm_cid_benchmark param_test_mm_cid_compare_twice mm_cid_compaction_test
>   
>   TEST_GEN_PROGS_EXTENDED = librseq.so
>   
> diff --git a/tools/testing/selftests/rseq/mm_cid_compaction_test.c b/tools/testing/selftests/rseq/mm_cid_compaction_test.c
> new file mode 100644
> index 0000000000000..8808500466d02
> --- /dev/null
> +++ b/tools/testing/selftests/rseq/mm_cid_compaction_test.c
> @@ -0,0 +1,208 @@
> +// SPDX-License-Identifier: LGPL-2.1
> +#define _GNU_SOURCE
> +#include <assert.h>
> +#include <pthread.h>
> +#include <sched.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <stddef.h>
> +
> +#include "../kselftest.h"
> +#include "rseq.h"
> +
> +#define VERBOSE 0
> +#define printf_verbose(fmt, ...)                    \
> +	do {                                        \
> +		if (VERBOSE)                        \
> +			printf(fmt, ##__VA_ARGS__); \
> +	} while (0)
> +
> +/* 0.5 s */
> +#define RUNNER_PERIOD 500000
> +/* Number of runs before we terminate or get the token */
> +#define THREAD_RUNS 5
> +
> +/*
> + * Number of times we check that the mm_cid were compacted.
> + * Checks are repeated every RUNNER_PERIOD.
> + */
> +#define MM_CID_COMPACT_TIMEOUT 10
> +
> +struct thread_args {
> +	int cpu;
> +	int num_cpus;
> +	pthread_mutex_t *token;
> +	pthread_barrier_t *barrier;
> +	pthread_t *tinfo;
> +	struct thread_args *args_head;
> +};
> +
> +static void __noreturn *thread_runner(void *arg)
> +{
> +	struct thread_args *args = arg;
> +	int i, ret, curr_mm_cid;
> +	cpu_set_t cpumask;
> +
> +	CPU_ZERO(&cpumask);
> +	CPU_SET(args->cpu, &cpumask);
> +	ret = pthread_setaffinity_np(pthread_self(), sizeof(cpumask), &cpumask);
> +	if (ret) {
> +		errno = ret;
> +		perror("Error: failed to set affinity");
> +		abort();
> +	}
> +	pthread_barrier_wait(args->barrier);
> +
> +	for (i = 0; i < THREAD_RUNS; i++)
> +		usleep(RUNNER_PERIOD);
> +	curr_mm_cid = rseq_current_mm_cid();
> +	/*
> +	 * We select one thread with high enough mm_cid to be the new leader.
> +	 * All other threads (including the main thread) will terminate.
> +	 * After some time, the mm_cid of the only remaining thread should
> +	 * converge to 0, if not, the test fails.
> +	 */
> +	if (curr_mm_cid >= args->num_cpus / 2 &&
> +	    !pthread_mutex_trylock(args->token)) {
> +		printf_verbose(
> +			"cpu%d has mm_cid=%d and will be the new leader.\n",
> +			sched_getcpu(), curr_mm_cid);
> +		for (i = 0; i < args->num_cpus; i++) {
> +			if (args->tinfo[i] == pthread_self())
> +				continue;
> +			ret = pthread_join(args->tinfo[i], NULL);
> +			if (ret) {
> +				errno = ret;
> +				perror("Error: failed to join thread");
> +				abort();
> +			}
> +		}
> +		pthread_barrier_destroy(args->barrier);
> +		free(args->tinfo);
> +		free(args->token);
> +		free(args->barrier);
> +		free(args->args_head);
> +
> +		for (i = 0; i < MM_CID_COMPACT_TIMEOUT; i++) {
> +			curr_mm_cid = rseq_current_mm_cid();
> +			printf_verbose("run %d: mm_cid=%d on cpu%d.\n", i,
> +				       curr_mm_cid, sched_getcpu());
> +			if (curr_mm_cid == 0)
> +				exit(EXIT_SUCCESS);
> +			/*
> +			 * Currently mm_cid compaction is less likely for tasks
> +			 * running in short bursts: increase likelihood by just
> +			 * running for some time doing nothing.
> +			 */
> +			for (int j = 0; j < 0xffff; j++)
> +				for (int k = 0; k < 0xffff; k++)
> +					asm("");
> +			usleep(RUNNER_PERIOD);
> +		}
> +		exit(EXIT_FAILURE);
> +	}
> +	printf_verbose("cpu%d has mm_cid=%d and is going to terminate.\n",
> +		       sched_getcpu(), curr_mm_cid);
> +	pthread_exit(NULL);
> +}
> +
> +int test_mm_cid_compaction(void)
> +{
> +	cpu_set_t affinity;
> +	int i, j, ret = 0, num_threads;
> +	pthread_t *tinfo;
> +	pthread_mutex_t *token;
> +	pthread_barrier_t *barrier;
> +	struct thread_args *args;
> +
> +	sched_getaffinity(0, sizeof(affinity), &affinity);
> +	num_threads = CPU_COUNT(&affinity);
> +	tinfo = calloc(num_threads, sizeof(*tinfo));
> +	if (!tinfo) {
> +		perror("Error: failed to allocate tinfo");
> +		return -1;
> +	}
> +	args = calloc(num_threads, sizeof(*args));
> +	if (!args) {
> +		perror("Error: failed to allocate args");
> +		ret = -1;
> +		goto out_free_tinfo;
> +	}
> +	token = malloc(sizeof(*token));
> +	if (!token) {
> +		perror("Error: failed to allocate token");
> +		ret = -1;
> +		goto out_free_args;
> +	}
> +	barrier = malloc(sizeof(*barrier));
> +	if (!barrier) {
> +		perror("Error: failed to allocate barrier");
> +		ret = -1;
> +		goto out_free_token;
> +	}
> +	if (num_threads == 1) {
> +		fprintf(stderr, "Cannot test on a single cpu. "
> +				"Skipping mm_cid_compaction test.\n");
> +		/* only skipping the test, this is not a failure */
> +		goto out_free_barrier;
> +	}
> +	pthread_mutex_init(token, NULL);
> +	ret = pthread_barrier_init(barrier, NULL, num_threads);
> +	if (ret) {
> +		errno = ret;
> +		perror("Error: failed to initialise barrier");
> +		goto out_free_barrier;
> +	}
> +	for (i = 0, j = 0; i < CPU_SETSIZE && j < num_threads; i++) {
> +		if (!CPU_ISSET(i, &affinity))
> +			continue;
> +		args[j].num_cpus = num_threads;
> +		args[j].tinfo = tinfo;
> +		args[j].token = token;
> +		args[j].barrier = barrier;
> +		args[j].cpu = i;
> +		args[j].args_head = args;
> +		if (!j) {
> +			/* The first thread is the main one */
> +			tinfo[0] = pthread_self();
> +			++j;
> +			continue;
> +		}
> +		ret = pthread_create(&tinfo[j], NULL, thread_runner, &args[j]);
> +		if (ret) {
> +			errno = ret;
> +			perror("Error: failed to create thread");
> +			abort();
> +		}
> +		++j;
> +	}
> +	printf_verbose("Started %d threads.\n", num_threads);
> +
> +	/* Also main thread will terminate if it is not selected as leader */
> +	thread_runner(&args[0]);
> +
> +	/* only reached in case of errors */
> +out_free_barrier:
> +	free(barrier);
> +out_free_token:
> +	free(token);
> +out_free_args:
> +	free(args);
> +out_free_tinfo:
> +	free(tinfo);
> +
> +	return ret;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	if (!rseq_mm_cid_available()) {
> +		fprintf(stderr, "Error: rseq_mm_cid unavailable\n");
> +		return -1;
> +	}
> +	if (test_mm_cid_compaction())
> +		return -1;
> +	return 0;
> +}


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

