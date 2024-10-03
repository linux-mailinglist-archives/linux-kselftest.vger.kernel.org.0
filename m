Return-Path: <linux-kselftest+bounces-18962-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EF098ED90
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 13:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0EB91F22AEB
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 11:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E853152166;
	Thu,  3 Oct 2024 11:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N7hCGD9s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51C31459E4;
	Thu,  3 Oct 2024 11:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727953520; cv=fail; b=Ovqo66nSYFWduEiGmeMuDtkJCO2+DKNBHZ8eXdwBt0CnzUpM/mGngN1Cmvlx09Yv/aiQTcnGK6oZoxBGG+TBCOLVcq3NqHGDzQTqnFi15tD6/N07790CBF6e0C0X80G1PyfQWP2STbuG9MQxkBy2cp/bEiB+VGs9xgebnyHuAmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727953520; c=relaxed/simple;
	bh=dWpyAOVh+RtZranIiYVT08t7yBiq7LNIuuqzINdyOiE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z9bP1xhxJJWiICMSfKouchCj20v7hVbT93lFlBKiAQ3EfjHfpWAxMquEr5hA5I31Yqy2myEZifeq2FIjbZX/T7p9Es87wq7ooMI54sJ4fAw/M0hSQy8tA/PWtncX8s42RnhvgZhPeZbOONo2lpc6xGF8GI3/gfOM1iQcaKBrfR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N7hCGD9s; arc=fail smtp.client-ip=40.107.244.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdtkzqM9ZDeKBLf+P6qXkdSGqNwkcphsyHVsVsl24PTIXLM0Y4v25U6moA1+hwajZRwfnFICW01nIuslGLrWbf/3VviFnomiCJBqAKFHENOHcIJQ/Wrl5mm5r5/F+FEdFFh7n+czUdue7LiKHVM0TffL/G95Eoc9m9TJWAu9VPjIfPwSXEbZwbPU4gMVYE1dWUvXpD5OLtOGXPlYP5mg8bTEK6dBTlyOJZfIHkCqCwioCx2lUxIBC2rBKekyQq55vAI7VYZ0wapJEzWxbh/aK2PVkFocttkrEz3sIFo+UrYNSvAZ9btNORkxxGrOpSI7kF/DGBNITPypvz9YVumJWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dX0q7bvdKVACVDELRS6IWhaxC1Qb8fO+WkkE4O2xz3o=;
 b=XMdciwIoEGzHD8U3fXvFAUQNBOmvqmjbDI+/ndwMvwY/A5LfVfVTjY+pIhefJ55WABFlS55PdgR1MJXU1yNHte3rPntqsLn4L2keZy5dEoR1YY6aDNbHEnhhdxEuTUSt4fSuHEWjdUG/aLg7fI8GH4CIvnz44/9at6X0LWepZxhwNh4XQeyKAcL8QNKPeyGQAsiZp8d4iFIeQs1NCNBY119rNoXMRiNjix8R9Nl6xggST4Z9R/aSLV1I3/4e306t/YGeqMb6SNqp8KTbCZ8kims2eBox1Ha2GMo0qOy+O2gH0cNAgRPfDLARQIMSGF7bG6mxCRvJpc9AV5tmmmtCMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dX0q7bvdKVACVDELRS6IWhaxC1Qb8fO+WkkE4O2xz3o=;
 b=N7hCGD9svG9tlTirnVuK/hTVVr91Qe3oDHoKwhz2wGmn3oNyvlZZ4yXiTNM2ttPVfWYwoBKVbS0ZrpdRQNTVTww40J5w3/wwlJlLi0891mPK/AIysdEHPYf295PNXsHx/bOfjmDREOeJ28GQ/e6jb6x+ihPRftC7hF5slkWYZRQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 PH7PR12MB7379.namprd12.prod.outlook.com (2603:10b6:510:20e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 11:05:16 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%5]) with mapi id 15.20.8026.017; Thu, 3 Oct 2024
 11:05:15 +0000
Message-ID: <d6b59dfe-9566-4164-9b64-28bd2c3f806f@amd.com>
Date: Thu, 3 Oct 2024 16:35:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/5] x86/cpu: Add virt tag in /proc/cpuinfo
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pbonzini@redhat.com, shuah@kernel.org, nikunj@amd.com,
 thomas.lendacky@amd.com, vkuznets@redhat.com, bp@alien8.de,
 babu.moger@amd.com
References: <20241001063413.687787-1-manali.shukla@amd.com>
 <20241001063413.687787-2-manali.shukla@amd.com> <ZvwmA-Z_T44zcSJZ@google.com>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <ZvwmA-Z_T44zcSJZ@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0158.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::28) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|PH7PR12MB7379:EE_
X-MS-Office365-Filtering-Correlation-Id: b95649f9-b7fb-477f-89e8-08dce39b4220
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGxscCtPQVF0WnhkRzkzRlRSTGhPanVhVmwzUXZ4TXlTZEJ0cUZOMER1cmtQ?=
 =?utf-8?B?Y1U4YXpYaUVqQUVSaXAwZzdpUlBBT0IvUlZwWnoyVDNFbjhtWXRkcXF6eTlH?=
 =?utf-8?B?bG5WOXFZdUU1TmNpZ3NWRmNaY2svVUxTVE1FMkIxckxJUGNodHJ5REVDU2Vj?=
 =?utf-8?B?SXMrc2xLTTE3NXprQ2htYXh3S2E5elhUbGNEaE1CblZmWXBRaHlPdTRyNXVG?=
 =?utf-8?B?Z29KcVJ4WVRPaEM2azFkMjhsa0pEYzBXT05wb1A1a2xsQk9UL0NVR1NTTEZN?=
 =?utf-8?B?YU5oRmUzNXZIWCs3b2hBMCtnZUFxV0pTamQvb05DTXNXd1BZcWlrRjhSZHBY?=
 =?utf-8?B?MFV6dlgwWmdkNm1QN1puNW1zZXlKRVJaeUcycmJLS01zRW9RcmVnRENOeFRE?=
 =?utf-8?B?bVJYWVN2NE84NExUOFVwVlBJdDRTcTZyOUFmZERYWkd0Qng0bHFpQUhUSHRk?=
 =?utf-8?B?aFFVQVR6eENIelB2WjVGcnZ5NGJCL3hjaThmZ3JoV2Rsa0JHYjNPc0ZYTUR5?=
 =?utf-8?B?RGpVRTVFOSt6WXlwWi9wUDZaUWx2NHlXQkVzR3lJQkNSY0l4K0UrL0V2Znl1?=
 =?utf-8?B?WVljb3V3RlpnN0wvVHJOV3NjT2ZWUkNEWnNQZWNHS29GdGg5SHQvNUNsV2VW?=
 =?utf-8?B?aXYwSjdwQitoeVdlbWhaVnQ5MUVuS2VHRWxDaHpiNXZjWFlYLzhnQXczTTgr?=
 =?utf-8?B?OGtaZVlKSXRtYWEzdDJIbFY2VWs3MzAyY2J6Q3FmWnlNY2NRTGpTeFl5VStD?=
 =?utf-8?B?U2d4dUZsK2RWUVY2WmdlMW1EcldLZnRvSURkYWc1RTNZTW9aMFk5Q2JVbkMr?=
 =?utf-8?B?bE5oVHh5ZENyVm5mTityTEI3OGIzQjJleDFTNklzVkphc05yWWFkTHZBaTBh?=
 =?utf-8?B?d2JPUVdzd1Q0SnRURCt0UFpXanRFa0RHMHpJRVVrWHFmZW1WUkxmaEJlYk1G?=
 =?utf-8?B?Tnd2K2lQZ1lmQW5KK2kxaE1RMnFyN21ocEpkSDNLQ2ZzWGJRUVJaSUIzQzhm?=
 =?utf-8?B?VEhtZGJCbUpIY2ZlQVZUeDhaY2ZRVEhiNGwrdm9JZEtZbGszRlZ5MmVLTHM5?=
 =?utf-8?B?YjZ5WHZUeHZHTjZ3U1h6WDBMRWdsRW1wSHdOLzI3eE9ESEM5VG1kYTIwWEZC?=
 =?utf-8?B?T0FyQkZZS0twK2h1T0ZuazVGU0NFa0NNeGtWMGZEUWFwOVlPOXBMdHdhY1lS?=
 =?utf-8?B?MlJwN1FlOFFJcWMvcWNHU1cwYzhBdkNzNTEwVFRqRmhJcHpCN3lMUG5wRTFt?=
 =?utf-8?B?K2Nmd2hycjBwWVFra042WlVjSWU1NVNQK3UvSTNrZThBRFZvc3owQXhydVRt?=
 =?utf-8?B?UjJaV0p1b3ZLa0poTStoRVZybVRzY1gzOVJUQ2o0QnlqMElEVmJIaWJWR3Ew?=
 =?utf-8?B?KzlLeXR3RDJScDRuWmZ0ZVhCRzdUZ1J0U3QyeE5YbVA0TDV2czVpakFBUUVT?=
 =?utf-8?B?MGRkaHJPcksxdmJaUlJxTXhHbWxLQkpCd2lQSmxlNXFmVk9pdm85R1lHUEdp?=
 =?utf-8?B?emdyVHBmT0t6Nk1HSTRPQ2YyM0k1Y1AvMXFhMklRQ3I3LytmSG5NYy9ZbXNz?=
 =?utf-8?B?Qi9HbEhHemQ4dXN4M0g2QjJXNnlhQk1qSUZ5eEpLbk9Nd280KytBNk5YSkgw?=
 =?utf-8?B?czJBM1JMV2xtalFFL3B1WVBxemViRUpjeDdvcm91UkF6a3RBaVNIMDZHZ2JZ?=
 =?utf-8?B?UnJRVUI1UGF1QjJqQUpzaElhVU1uYWNpRHlYdUluU3grUjlQNGFqTTR3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjdoNGJmZ1o3K1dWdUtXNW5yVFV1L3NuK1dYOEJ4K3kvTDZoRzVvNkVZSlJR?=
 =?utf-8?B?enFoS2pwV1NnTCtzNUpLSnQxK2VxUXE5VStOb2wrdDA2NUswRndua3g2Rklt?=
 =?utf-8?B?T0ZLdVNIMDBHZEZkMmVPRi9aaFRFc216U3RDRTZzbkttU0sxa2lJcVU4bjMy?=
 =?utf-8?B?M1hsTjVCR1VuM3h2UkxqWGpxdDFCYnZ5S0o4Um1jNEkvVDl0aVNyVEphQ2o2?=
 =?utf-8?B?MVpnNnJCbW1LNkVHUGp3Y0R4YVBoSmFWTW0xKzZkS1BaN1Q3ZFNxZHczTEpl?=
 =?utf-8?B?K3p2eU1yRkJncmJSUWdLcWttcXZkMERmWWd4NjhpNGM3Q01nS2poK3RmTGgx?=
 =?utf-8?B?cnd2UHNBWjg3dzh2dS9WRFBEeUt6RzArQWFKTkxjZitqS1N0RmVFeTRFM0sy?=
 =?utf-8?B?Sm44VXQrVFE3NVE5RERONFBSdXF6aFJuaWJXaDNDbWttNGxYbkFuQ1hwaDBy?=
 =?utf-8?B?VHQxQnRvRkt1WUw2ZU1hakhsUUJkTEt1Mit2cytsMkpaTWV2enJxTGoyNks0?=
 =?utf-8?B?TS9mTzFURzNGcUh3Zi9PYVFYU2hsOC9adVdNTkhCblVybkNXcW1pVUVEL0hV?=
 =?utf-8?B?OFhJaDRZZ1N6TnJIZUUrRzJlb2VTcmVEQXQwZDYxRFlVV25QaEhnNitFbmxo?=
 =?utf-8?B?WFNaSkJlQ3V1QXRlaS8xVGcwUEpWL2kyeWdyYzhla2JPd2ZhQS9yZzNTOFdG?=
 =?utf-8?B?a2VzWmFrZDZubWovY2NtN0hjcmhOSllwOTRjSnpsZTN1OWZNK3U0MVJIdytP?=
 =?utf-8?B?a3pXWU1kU0JCTWE5cUw5TkgxaVBxRS9GK2w1R0NvdjEyTmtFZnh1Z01nOGtC?=
 =?utf-8?B?RHEzN21uRUIxZHJWdW5LQjJZM2EreXRvMlZjcGNQMWc0MDdQeTY0SVBURzFT?=
 =?utf-8?B?WEUyOVkrNzNpVDhrUWR2cmUzdmVNbWxvY3NXNHRUS0tMM0ptdHlIM3dBRmZ5?=
 =?utf-8?B?NmpHWWJMWmxtaTRjdDZMNkkyT2Y5MG5pVThiZ1doUU90OWRPbjFSTm83VEJO?=
 =?utf-8?B?WURvenJHRXhPU3hsTlJEd0pCb3NHdlpBNXRPMlV0NS9menA1TTZDcmlqczVx?=
 =?utf-8?B?dHpZLzA5dmpQU2xTZkk1d3ZRRHJFdWQrQzBKQjd5ekczenlVVVEzd3RKNW9q?=
 =?utf-8?B?cXFhK2pvTUFXdmxWVFRmSEhSNjlSYXRiQy85akNpbHNBV0VUZ05MdlZtYTlp?=
 =?utf-8?B?SHpuMUNiaTUxdFk2ZzJrcXFKTDZKRk9CSkx3OFNRem1yR0JVOWZGTkhsaE5S?=
 =?utf-8?B?UVUwcENjNlJCNUIwNmhkenFKdXVObWp0dFR5REdmN2RGRlV6MWc4YndJeFM0?=
 =?utf-8?B?RnlCQ0FDRFlsdHFKcVZMa2FjV0pjZTBvOWovU1lUZFM3LzBGWFVrWkdJa1V5?=
 =?utf-8?B?aUlVbnJzcFZqZ1RlQzhuVEZtTW4zZlZscDdubGI2SGpoV3RhZmJGZFU0QjFt?=
 =?utf-8?B?cDFTbktjdldMNVcvOVlxTnM4VnVUaXhxRDJwdko2RmExcWhPNnlmeGZkejRJ?=
 =?utf-8?B?TmxDQlVVWGVReEhpbWRvTkN4Sm0vOFUwVjNUSityZlJuNVFsbE9CYU1JaXNX?=
 =?utf-8?B?UzV1MkFxcXFaaVRHb1dIQU9HVGsySWdBYUxIeCtsODlFMVRhdERBalRnOWFW?=
 =?utf-8?B?VExvSWVNcUhkMC9hZEpXMFl1V2FWM1gxOUYwNE9iUzdqN1pod252N05lVk9v?=
 =?utf-8?B?OVVHbkxVSGJuQi9sK3JQYjIvVlFlcS9hd2VVM2tjZExEbDY5SXNTWG9tcmh5?=
 =?utf-8?B?aXlOQVNuWk42ODRDMnExMis1L3JndVR5MUVSKys1bDUra1o3OXN4YmZSQnU1?=
 =?utf-8?B?OU8rZ1B4SnFndy9nZjBCQWMwTzQ1WEN5Y3AvYVpmR3Zsa01xYTBweGJ1a3ll?=
 =?utf-8?B?YjhKWE1DOUJjTFp2T1ZodkNJSGNHWlVBVWlXQy9SdzlMSjY2ZmkxdGN4RXV3?=
 =?utf-8?B?NTB0VENQbTdlVElOb2k0bFBnT3gyQUdrM0ovRGt6M0ROd0VLenFJTytQbDhB?=
 =?utf-8?B?NHNzMVRRSkR3T3MxOC9WckFMbXloV0E2clBJL3U4Z0tnZm04WjdiWllTaUJS?=
 =?utf-8?B?L1l3RjhTTm5waFpkKzY3UTY1OFlyYk14SkRRMjdOcEdtRzQvanFLejhFM0dm?=
 =?utf-8?Q?CNKvF7YCRufY2XHejGfkIH8xn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b95649f9-b7fb-477f-89e8-08dce39b4220
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 11:05:15.2115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IAMaervoTiA3UKxBg73skhDdJ7hIBN80kv3xFcAI0k+yYZSHrPIs7n4bMqWd7vRD/29E5h6yADduSjaLeLeHXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7379

On 10/1/2024 10:11 PM, Sean Christopherson wrote:
> On Tue, Oct 01, 2024, Manali Shukla wrote:
>> Add support for generating Virtualization feature names in capflags.c
>> and use the resulting x86_virt_flags to print the virt flags in
>> /proc/cpuinfo.
>>
>> Currently, it is difficult to check if a feature is supported in _KVM_.
>> Manually querying cpuid to know whether the feature is supported or not
>> can be quite tedious at times.
>>
>> Print the features supported in KVM hypervisor in a dedicated "virt"
>> line instead of adding them to the common "flags".
> 
> First off, printing flags in a separate section doesn't magically connect them
> to KVM support.  E.g. if you cut this series after patch 2, BUS_LOCK_THRESHOLD
> will show up in "virt" despite KVM not supporting the feature.
> 
> Second, deviating from the X86_FEATURE_* syntax will make it _harder_ for KVM to
> manage its configuration.
> 
> Third, this is completely orthogonal to supporting bus lock threshold in KVM,
> i.e. belongs in a separate series.

Okay. I agree to your point. I will remove the patch from this series.

-Manali



