Return-Path: <linux-kselftest+bounces-9741-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3ED8C0604
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 23:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CF8C1F21FEB
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 21:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BB4131758;
	Wed,  8 May 2024 21:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g023Vkdp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2084.outbound.protection.outlook.com [40.107.96.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C11C131748;
	Wed,  8 May 2024 21:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715202346; cv=fail; b=Q+HScfrO7REU7Spqy7ZmJPszkLcp5fXM3NkddyRuiGJ/ONo1U/r4Vs+cuU3Wbh4KCiUfHSfwaDpWRWowqtORmGgkDDYAMxXIUgQX9HMJkSouGu0WMchSpFpd4kbtDv7AgRritc3yWLyoB7ZABZQXaa0+3/rWOY4G6sDiCNSo1W8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715202346; c=relaxed/simple;
	bh=NaRNLSQWKFEIV7U3nHCj4C5MGh35tpfhKN5A6gOpCBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FR/V6pTzK+MpHGjOlrij1VfLqbLYTH8NpOrZ4FEa9MB9pFD+hKmuzhjemnKsSBQKpN1d26IiRtNqO7jNfClEialMWJKMyo90VOWEZBNCsL1BJQD4nTrd8BP1YWIkkWesiuqPTouCf1dcQfCbrA9TJWgHqFwFwraH4u9LbMc24+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g023Vkdp; arc=fail smtp.client-ip=40.107.96.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9RItxznLl/BaSRMYH+/dF/qDwWgh/cyryXXlkwuM8m9tEvXfJCFrRXzfbXtySxYYM6G2qH1xrJUPjQio0DPAI5KBtqYZbk3knHgDiGBYad5BgCS0uoowOGCkxieBOogM9ObkNX3JWSmMJzHlJ4UuxjEljuaGhZdJg51rtvnECM8ZkXDRIZrZWCMi5OjSKxnFbgX6pIF7PbfreqooGIgBxUDEJdsgv+NniybDtQY/05KVOSIbU9Hsy8tUJZNsDp9AUNd72fnJxw9QeKNb07E1hJjJbsG4yqz1SdTRROT6SmsPU7ykvnBVx2E42BG6f2ZoRjC96LAXrhHwRirHYR3Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aUFA+EX3e76PP8hx+tvmNnrFTe7ecx4YWUmMgLgl61k=;
 b=k4/qbgnwTBt+8uHJ6fQOY8jG+lGPRJdGtrxnzes3LljXI6f+8jBMPw+ysv6uhej9iDbyJynGGW0wCTwhV+rpoTa3ZSy7x/EFYrWwJubTQyftHLIN8CrhI5Ayp/CO2kHywODtpF2UyS5OJfzFdepyrGUPWgFXNmbLXK8Vq/gWS/o+v96+1M3RR4skHd5NFzni6jezD0iDv1msIfYxlfbVTEPlyvr8ngNgJWiIhQ7+5JiMy9nVJj7pojM1A970RuMWj9Y4N/XsvMAsE6jPObLcKc1FPKBik166Ru/MMlozPO4MB/3GG8xDBZkTDGxa0YkAm7CQ2UVDSUeCTc8ywZ7WCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUFA+EX3e76PP8hx+tvmNnrFTe7ecx4YWUmMgLgl61k=;
 b=g023VkdpzANRS5VWiifXpswA/goUFYlGBmZjQhB8sq5k3T4E6F+ZnbAiKt7n0QrJRclSfsAJ6OLcuozRwH74i8qLFFevPGcpxvWaVcKfQQb4GpN8aUSIsY+pQ+wBRNCqz2/8ywkbLxh8+1i8zfTlt1ZcfQ2cuwQmJbu4IIyrLNFeqAQ4qA0B1/f5a2GhvaKGQMTWva98W0quEzPnpWbi43lfbGd9YIYBM6S/nIxIUmBtVejVQweM5xPDl6d7LZthwvfI1dI9Ll4gby4EcQ+J0GROIWNcnZn5Joh5AiZVhw9atJDXBwLPecsPqX3Pzr4lTs3tAdpB41N49wDYvlbsxA==
Received: from BL0PR02CA0042.namprd02.prod.outlook.com (2603:10b6:207:3d::19)
 by SN7PR12MB6813.namprd12.prod.outlook.com (2603:10b6:806:267::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Wed, 8 May
 2024 21:05:41 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:207:3d:cafe::68) by BL0PR02CA0042.outlook.office365.com
 (2603:10b6:207:3d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46 via Frontend
 Transport; Wed, 8 May 2024 21:05:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 21:05:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 May 2024
 14:05:24 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 May 2024
 14:05:23 -0700
Message-ID: <dbca543e-224b-4fa5-ba23-37f4957ff79d@nvidia.com>
Date: Wed, 8 May 2024 14:05:22 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] selftests/futex: pass _GNU_SOURCE without a value to
 the compiler
To: Shuah Khan <shuah@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?=
	<andrealmeid@igalia.com>, "Nysal Jan K . A" <nysal@linux.ibm.com>, Mark Brown
	<broonie@kernel.org>, Valentin Obst <kernel@valentinobst.de>,
	<linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	<llvm@lists.linux.dev>, Edward Liaw <edliaw@google.com>
References: <20240503041843.99136-1-jhubbard@nvidia.com>
 <20240503041843.99136-4-jhubbard@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20240503041843.99136-4-jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|SN7PR12MB6813:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ba0131a-4623-468a-1cae-08dc6fa29e28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|1800799015|7416005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGVNTnA2emg4NXI5QmhNZnhaaWdHeGJHTGlub2lDQ3QzbVRSVVYyeDNibnNr?=
 =?utf-8?B?RWlkYWJYN3VOQVRLbGZUdUFDUmdQNk1GdVRRNmN6Nis1ZUlsVXBQNTBMcXVZ?=
 =?utf-8?B?UW9wUjdVNzBMZEp5cEExRVhaRk5aaW1PcE5FTkJjUFBqZmRESjBwT2puMVl2?=
 =?utf-8?B?UGhhUlVRSXNrNGxxMHRERWRDeUFYQ0EvbUFqbDJwWjFHUWh2ZUhOWDdYSWdF?=
 =?utf-8?B?aWZiYjEzTWVCTitnVHVmY0dQWnA2VmQ4YmVib2FPTmxIQmRxSGxrRlQrYUV1?=
 =?utf-8?B?L3BJVnVrcUFzZmRUeHVPR05LMVRPUVJWSVNhRURGWGZ4bU1QcWY0R25aa2RD?=
 =?utf-8?B?bWxDZno3WkVROWF0NUNqWkhDeTNKdFNJYUNHL2pDNDE4blFMMVZ4S0pUNGox?=
 =?utf-8?B?TjlzekFwK2FJelh2aGxwYktnM1p5K1hXK2JyTzZJT3BLWlRtMDd3TTdTNXBo?=
 =?utf-8?B?dzlUc0E3M2ZobmZwL2dqU2lJelkvS3BvUm55Ty9CelpVOVJsdC9LcG4zR3dN?=
 =?utf-8?B?NGR1N09uMlBvcUg1bVFFNHYxS2tKVkp4cG5xQktMNmJFb0FIWmV5NCtSOHBF?=
 =?utf-8?B?dHlzSXg4dk81cWEyUWlLYlZ5ZU9hWUVQZkNDQ0FuQ1ExT00zT2pqMDY2Y1JY?=
 =?utf-8?B?clByV1p5Z1IyUXUrWlVic25uaWU2MjVsRWVLR2VjRFlRMWpVZ05SWitBR3BE?=
 =?utf-8?B?eGlzYWxiV0NRSFJRdGFTeW05cDJySVFRMnBEaExpTXlLaDZacXYzUUN3cFRt?=
 =?utf-8?B?R1p2SWFTTWRwaGNnSVBlODR1aE9mVis2VnA0UVVTNnY2ckNKTC9WbDJNUFQ5?=
 =?utf-8?B?V3VBYkxkL0xlMkN2Um5IT0hVcXZaMnI2azY2dnozVzcxUDJ1U2NkcEdlY0JV?=
 =?utf-8?B?aEswdjIzY2V3ZEtUWTlHT2pFakVvY3FIU1Z0UVlBNUlCWjZqem5SZ0g1N0No?=
 =?utf-8?B?Q051YlFPcGNydi96ZTRidUxveGFQMUpKaGRGaURMcE82WHZ1Sk5leEE1SUlQ?=
 =?utf-8?B?cW1KMXlNUGJwVjRaalJJbjRXYmNyajZkVGhudXlJdk45b0V6T3gwbGRVcks4?=
 =?utf-8?B?eEYvdE82bWtwN2RpWUE4Vm5QOVlvMTBJeHE2bHRWK1Q1VjJtUXZ5Z01YRHhX?=
 =?utf-8?B?NDc5Wml0bmMxbkJzUlllSzIvaUF5RC81N0ZwUnZUdXNZY3pJN21IWTY5dmxO?=
 =?utf-8?B?blZ4MlNqZVBWZEFCY2owTVl6ODQ0cGJ1bVdaVHU3MG16SHNBV1pYOGp5ZDZq?=
 =?utf-8?B?SGxiNHFNMFRYdExQL01od0VIZEppRVFDS2s4N2FUUkdjczFSWlcwU0RPb3Ew?=
 =?utf-8?B?RlpsbjVOU3hLK1hIUEN0VnUxcWpYQy9IQWJpVDZDVTFkcGp6OFJBMlJpYVRL?=
 =?utf-8?B?RUIrMHhqTWpzQWJ0QXJkUlF4dyt3cVhINS9HaDN5Mmw3VlMzaVVKUEpXNU9s?=
 =?utf-8?B?djdKMjRwaXlFdHBVVXI2RGV5blFZZVBoUEQvaGxUS2VqV1JEUmM5b0NMVlR3?=
 =?utf-8?B?K01ZbkN6ay9GQkZlYzloRFFENnU3SVEvOVNpNGJUNW9RMHRUVGwweUxxKzVz?=
 =?utf-8?B?elUxRE05cXJPVkgwcFN1VFBtcWFCSkN0UVZsTWJrRGdhd0VoU0xJVE84bkNs?=
 =?utf-8?B?OEFUNDhDdElYT0RxZkRZbHlHbkNJeExxcEZSRnBGUVIyM1ExWmc4VDFXSjlU?=
 =?utf-8?B?elZwOEpkb0hIR1VGdURON1phUXQrUVZQeFVkWnFKNkM4ZTFjQUdQVEJXdU8v?=
 =?utf-8?B?WkxRd2JZVTdGdklObUdaeU1mVTRYeVBtclhjcTJMR0ZEMDVvaG1XV1dyT29j?=
 =?utf-8?B?WndHb3hxeG1qSVp4VVdEb1p0OGhMZG9TSWxiS3FGcFBQdUNQZEZ5RFlJQkhZ?=
 =?utf-8?Q?XqpetpzN1xZst?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(7416005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 21:05:40.6550
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba0131a-4623-468a-1cae-08dc6fa29e28
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6813

On 5/2/24 9:18 PM, John Hubbard wrote:
> It's slightly better to set _GNU_SOURCE in the source code, but if one
> must do it via the compiler invocation, then the best way to do so is
> this:

Hi Shuah, Edward and all,

This patch now seems to be obsolete, due to Edward Liaw's comprehensive
fix, "[PATCH v2 0/5] Define _GNU_SOURCE for sources using" [1].

[1] https://lore.kernel.org/20240507214254.2787305-1-edliaw@google.com

A process question for Shuah: shall I gather up the selftest patches
that have reviews and acks, and post them with the versions incremented?

I'm new to this list, and I'm not sure of your exact workflow. And there
are admittedly a flurry of patches involved.

[1] https://lore.kernel.org/20240507214254.2787305-1-edliaw@google.com

thanks,
-- 
John Hubbard
NVIDIA

> 
>      $(CC) -D_GNU_SOURCE=
> 
> ...because otherwise, if this form is used:
> 
>      $(CC) -D_GNU_SOURCE
> 
> ...then that leads the compiler to set a value, as if you had passed in:
> 
>      $(CC) -D_GNU_SOURCE=1
> 
> That, in turn, leads to warnings under both gcc and clang, like this:
> 
>      futex_requeue_pi.c:20: warning: "_GNU_SOURCE" redefined
> 
> Fix this by using the "-D_GNU_SOURCE=" form.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>   tools/testing/selftests/futex/functional/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
> index a392d0917b4e..994fa3468f17 100644
> --- a/tools/testing/selftests/futex/functional/Makefile
> +++ b/tools/testing/selftests/futex/functional/Makefile
> @@ -1,6 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0
>   INCLUDES := -I../include -I../../ $(KHDR_INCLUDES)
> -CFLAGS := $(CFLAGS) -g -O2 -Wall -D_GNU_SOURCE -pthread $(INCLUDES) $(KHDR_INCLUDES)
> +CFLAGS := $(CFLAGS) -g -O2 -Wall -D_GNU_SOURCE= -pthread $(INCLUDES) $(KHDR_INCLUDES)
>   LDLIBS := -lpthread -lrt
>   
>   LOCAL_HDRS := \



