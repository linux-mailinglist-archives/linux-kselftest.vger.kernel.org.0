Return-Path: <linux-kselftest+bounces-11463-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A02B900F39
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 04:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 845972818F3
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 02:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15608C05;
	Sat,  8 Jun 2024 02:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="igXwC/Z9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0D128FA;
	Sat,  8 Jun 2024 02:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717812971; cv=fail; b=TATjzwKFdkqrKSCRCrA87bjIMhck/DbqfkNS5lqv1RKRkSwk5EhhJHHBOAM6Co5qAHXkqt2tPN3ZFVF4Et+IsIcYNNOVVbSRUioOzsp5k4UD4lfyT2PlAV2UK0pyZs0r3SavNeLGDCRwgpLIj2SmpZ3ypsktkgOQo1tBnISln5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717812971; c=relaxed/simple;
	bh=g1pIyMFUEHuGS4V/jcLZMxXIfL5fAgt0NCAtJ3t5L7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gq3bQOYNif67DxMGCPJJ4uOePCCIvUxfMMLHEktg56cB6+f21IQ7gMKnldmFBMPkZi8GIJzFg4rSt/MR2TNMfIYjANc15IAhG7iQBCJ9FRCNyZdAW9btT3xlYJsr5/Jnax0MQeFCYNk8ZVOXxw10VA3DfF5AXd35aKwYcv4ZYIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=igXwC/Z9; arc=fail smtp.client-ip=40.107.94.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRvfv3UHV5BtEwxOzMCFWHiwMzZF1N0Vf/YM7McOANiGMwvr986z9NIKjDb8dnDBvtwQqhzNdRwcM04Ehftwh7NyQWj8s+sfCpleiyFJRiNv33r4xEaQHuTyNcD13a15YBmZYcVEK50OqDuw1PG8bn45I20z5w4WPjVM3hZTJyIKrYR1eKA+6JIpLK75GFXQaLDiLyH2Re6pMPTLV6igCIBBurMHgsOVSvwmAxBbuFAOB8ENFFOVPO2abyzahUWKwIvDBBIG3U1j9CeNjlX/rkvMbI24JgDsRzsB+/BurrncMmxglKhGFSHPX8aVmqORqqD+P637SA7omp1/CUCw5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLghDUpRXW93s7SnWsXhkaq1OO2Ep1zNLABf+cX+qug=;
 b=WDh1shC0qq7i/IsxhRo+C9hQuwYkd4va9Y94sUwp8RBZO5FBehT04gLYZhw+ufgyUAbJzk0Ilw4E8U6XPf3M0sdlKBUrq2Hlhudtf7nEoAs2iEt+1UPyjxYUSZ2kQ5Wcaz429+nLPyle9SoQDNMrqoq6tcB/CfxrRCUL7+jjz/Gdmf/DCOL/p3EIMrOo+gecXQPpP71GeGUFGNLvRlpzNTAopmciS3aIsZWfN5m9FY4hPl5ubw6dJQXvHa3InSWMYDj+HnJ3BBDyccOJv53cnAPstXCgEjod2huH6jGqZxjpW2OreAuN6bco+t80S7czuoonZUN/E6C1AnEVai4FQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLghDUpRXW93s7SnWsXhkaq1OO2Ep1zNLABf+cX+qug=;
 b=igXwC/Z9Sh101PecpCr+/YXyCG+n2RSgenrisumuNSXMjjePbA87qkzbn/cdpd7U7bZVmrZs3P8GIZD7s/Tf0PhaGZ8+7+UKRotfDiysrEJHdbs3hNFygcUvIyuAua9VHPsnsA4LXmKQRma/knF6EREi9EkFAdM5Hwi1NKBU15D36pT8n7Ozt4VTIRNWhWUJB3KQrmV2A0/xY2hFI/A80WsQRKzY48p2Qwuj0HKz+v531edVXbqEPlPoMTBgz9zUcHs3aW5+HknpM03uiTSQGujCV7cX0NemsJfcCvkc6PV+xkCUFb9Meif79ZHOra+C1LHvuuTzP4cQhPbPwYUB1w==
Received: from PH7P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::34)
 by PH7PR12MB8107.namprd12.prod.outlook.com (2603:10b6:510:2bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Sat, 8 Jun
 2024 02:16:05 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:510:33a:cafe::63) by PH7P222CA0013.outlook.office365.com
 (2603:10b6:510:33a::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.22 via Frontend
 Transport; Sat, 8 Jun 2024 02:16:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Sat, 8 Jun 2024 02:16:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 7 Jun 2024
 19:15:50 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 7 Jun 2024
 19:15:49 -0700
Message-ID: <507937be-603c-4382-ac23-dc6c5ee01841@nvidia.com>
Date: Fri, 7 Jun 2024 19:15:48 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] mm/selftests: kvm, mdwe fixes to avoid requiring
 "make headers"
To: Andrew Morton <akpm@linux-foundation.org>, Jeff Xu <jeffxu@chromium.org>,
	Shuah Khan <shuah@kernel.org>
CC: Andrei Vagin <avagin@google.com>, Axel Rasmussen
	<axelrasmussen@google.com>, Christian Brauner <brauner@kernel.org>, "David
 Hildenbrand" <david@redhat.com>, Kees Cook <kees@kernel.org>, Kent Overstreet
	<kent.overstreet@linux.dev>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Peter Xu
	<peterx@redhat.com>, Rich Felker <dalias@libc.org>, <linux-mm@kvack.org>,
	<linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20240608021023.176027-1-jhubbard@nvidia.com>
 <20240608021023.176027-4-jhubbard@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20240608021023.176027-4-jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|PH7PR12MB8107:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b7d5a6f-23c7-4078-a27a-08dc8760f3a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|82310400017|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHFLZDMxb0RTS3BkQkxUNGZtOCt6V2xBMHpVbmxONSs2TVhnMWlIUGNKeEYv?=
 =?utf-8?B?dkd0SVhNNEFZU3Z6UzhuTVJ3WTQzTDdjMHFFZWpzRWFMTzIvUmVvUDZPZGpa?=
 =?utf-8?B?QlhXWUwrOVc2NkpHNUt0cjIyQ0V2dU14bStXZEs2bGVaSHZuWnhwbWN6RFdk?=
 =?utf-8?B?VGo0RVd0SkFvczdTSDQ2VGdlWFJEelMvVzN5NFVzY2dkenFuYkpZM0VMdllk?=
 =?utf-8?B?a0xRN1Y0czBQTHlVcFJKWEFSdnIvMGR6MlE1QmJpM2hGVmZjVzVEL2NzNktq?=
 =?utf-8?B?MS8xZERvZEY2Z2lneDdlbS9WYkRUVTZLdWtZNkRjMDBuQldlV0R6WmhLUE9w?=
 =?utf-8?B?dFlCS3I0RVQvdFhwblZEZ2dyMFQ0ZWtiZGJ3NTNBZ1IzczJIa0JJamVHYzI5?=
 =?utf-8?B?akVKOUdNVkVWUWNQZDIrQ1RpSGdraGxJNnVJVUxHU3JyNjRZM3JjZ1Rxb0NH?=
 =?utf-8?B?Ym5rV0FUeTdrZ1Ntd0ZBRGZsZU1IZHV5YkM0d2hZUjB1K0pRTEJXdmc5Uzlo?=
 =?utf-8?B?L0w5YlIrcGtrcUpTYVEySkN3ZVBiNFc1VXNCaklUdWxyN1ltVjJUWUh1V05Z?=
 =?utf-8?B?RkdqQy9yM3V3dVlCb2ZGN2wwSW5lV3phbE1jcDdIdlVWTEtTN0FHM3dwa1Rm?=
 =?utf-8?B?Skg3QitNVXIzbkl3M01xMy9FMGNhSmpjTzhxSHl5Ym5NQVZONGRoZnA3Mnkx?=
 =?utf-8?B?NjlZOXJEdWNZY2F0bWtmbm1oVXo2NFRZaEczUllRRTdPT3ZicHdneDc4MC9h?=
 =?utf-8?B?Mk04RUV0cjBwaGVJTjV6TlZySXBwSUJLNTVidnZNUDBVOVMrMUhoSmVhQVo1?=
 =?utf-8?B?VDNLa0RLemJGSk10RHRyOFNwdUN3UkVQZTRua3Nqdys2V1NuMENIb0djZTNo?=
 =?utf-8?B?VUU0bkRBMGNyYWtJSzRqdmwzK2pzNEdMUDEza0V1QzdaSFV0WFhmUWJyMzBU?=
 =?utf-8?B?bDVFNmlYWUVzL25vbmdhbE9UK3ZiYkRncWZpZlQyWUR0Mkl0dnpGVHlkR0RK?=
 =?utf-8?B?QU4rU0NKVVhIcjg0Qk9RQURQMXBsUDAvUHBWaWVDei9PSWdTeXg3R3MraXhk?=
 =?utf-8?B?Y251eExaVFY2T2g3VmQ4dFVwaEFRNGk5dGhrNzVicWo1TllkOGgzYWNGTFRp?=
 =?utf-8?B?dzZvUk1DbGF2dTVMZTVqSUQ3WXBUUWUxQTFWT09xQnZocHJJLy9jV1hMdUxO?=
 =?utf-8?B?M3JCd0FEclUrc2Mxa21vYzFJc0lsTkZXWHI1YzJ4NUs1QlFpNGF4NGZpNlpl?=
 =?utf-8?B?UmJpYmlLNk83Wi9hZDlmVDYza2ZPcWc4Wk1vSlVPOEx1QmwzTnNLd3A3WFRW?=
 =?utf-8?B?UWZNOUtBdVI1VVNFZUJQMk5HSE1Hai9iV3Z0ZnJPLzg1eWFjTjNQU05HUU1B?=
 =?utf-8?B?TDlPNjQ0d0NmMDBudnhBZGNkSHRoelpMN0pmUXBJYnVJT05TM0daVDQ4NDZi?=
 =?utf-8?B?NUtsZUZFY2J3dE12UlVJejVhdVNOMHJiTUJmY0ZkZTdLSCtGS2l6Q1B3SC9J?=
 =?utf-8?B?bzlmVjVNWGpBczdIS0haU3IwN0xGOE1RU0k3cXkxQmpjbGxWUC9jRzBrVnYy?=
 =?utf-8?B?UUZCR01BYW84U3ZSTEJkUVF6a1ZxL3R6ZkNwd0FPbEk2cjFKM2lLSkw0ajZQ?=
 =?utf-8?B?eWZqNEhvTjM2QTlUTVZQRDBpbE5YeHc0T3ZqY3dHY0YyTWpadVV1SHUrZmk2?=
 =?utf-8?B?OTZDOUtqbWRuTlkvSDVRakVoMm85bUR4dWVka0FzZzhsV1lTUGdUM0tDSGxK?=
 =?utf-8?B?QUUwMEZmTy9wRDhweksxM2FycEpSODZCR1IwcGVFOEVYdm9qeDU3bEZERzI4?=
 =?utf-8?B?Qkpudk9WZ1RjaEdnMTMwMGhKVGFoeDZNVVZzeExZTjU4anNEbWlJUjBnWitT?=
 =?utf-8?B?MlNvS0JlN2ZUQnJLaHVubEZyVWJqbUhQZUpzZzF5WHBxSkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400017)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2024 02:16:05.3159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b7d5a6f-23c7-4078-a27a-08dc8760f3a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8107

On 6/7/24 7:10 PM, John Hubbard wrote:
> On Ubuntu 23.04, the kvm and mdwe selftests/mm build fails due to
> missing a few items that are found in prctl.h. Here is an excerpt of the
> build failures:

The subject line is confused: it really should start with "selftests/mm",
not "mm/selftests". :)


thanks,
John Hubbard
NVIDIA

> 
> ksm_tests.c:252:13: error: use of undeclared identifier 'PR_SET_MEMORY_MERGE'
> ...
> mdwe_test.c:26:18: error: use of undeclared identifier 'PR_SET_MDWE'
> mdwe_test.c:38:18: error: use of undeclared identifier 'PR_GET_MDWE'
> 
> Fix these errors by adding the missing items to vm_util.h, and include
> vm_util.h from mdwe_test.c.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>   tools/testing/selftests/mm/mdwe_test.c |  1 +
>   tools/testing/selftests/mm/vm_util.h   | 15 +++++++++++++++
>   2 files changed, 16 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/mdwe_test.c b/tools/testing/selftests/mm/mdwe_test.c
> index 200bedcdc32e..cfe0b64d1567 100644
> --- a/tools/testing/selftests/mm/mdwe_test.c
> +++ b/tools/testing/selftests/mm/mdwe_test.c
> @@ -15,6 +15,7 @@
>   #include <unistd.h>
>   
>   #include "../kselftest_harness.h"
> +#include "vm_util.h"
>   
>   #ifndef __aarch64__
>   # define PROT_BTI	0
> diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
> index 9007c420d52c..99cbb7c0ea9d 100644
> --- a/tools/testing/selftests/mm/vm_util.h
> +++ b/tools/testing/selftests/mm/vm_util.h
> @@ -61,3 +61,18 @@ unsigned long get_free_hugepages(void);
>   
>   #define PAGEMAP_PRESENT(ent)	(((ent) & (1ull << 63)) != 0)
>   #define PAGEMAP_PFN(ent)	((ent) & ((1ull << 55) - 1))
> +
> +#ifndef PR_SET_MEMORY_MERGE
> +#define PR_SET_MEMORY_MERGE		67
> +#endif
> +
> +#ifndef PR_GET_MEMORY_MERGE
> +#define PR_GET_MEMORY_MERGE		68
> +#endif
> +
> +#ifndef PR_SET_MDWE
> +#define PR_SET_MDWE			65
> +#define PR_MDWE_REFUSE_EXEC_GAIN	(1UL << 0)
> +#define PR_MDWE_NO_INHERIT		(1UL << 1)
> +#define PR_GET_MDWE			66
> +#endif


