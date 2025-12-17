Return-Path: <linux-kselftest+bounces-47672-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 393EDCC9638
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 20:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3C2D300F5BB
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 19:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3578E2C11CF;
	Wed, 17 Dec 2025 19:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lloOMXGd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012047.outbound.protection.outlook.com [40.107.200.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7397262B;
	Wed, 17 Dec 2025 19:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765998885; cv=fail; b=IxA6CADB3Z1H/vNvoPPB/DfSvA4eW6/jCjagyDbgY34K2X/qsVGfVTw8Ow+86rFMc7X6oTgADLw3w0Dz+B/t+oJCatcjj2ygqOIgTNTTTu/iin8HKOlYlF7VKPuS5ynoEqI0UCrkRFCK1pzP8fhLT93Xsv0uoS5k3ZcCQVSQnig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765998885; c=relaxed/simple;
	bh=k7CacBXn0Zpme2Z+3TcLAgNid7mE0VT/c/c5JOuGsNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K1914zhmmrmistGP3W+gGpC8YPis8EX5ld/iqQjZdWC6T8lLxxfs6B88NV1v7iojZrIz98VWccwSqYpZRUrjrXYlq0ld8iQIv9V3/KTnhig9MP3IvaG/wP1ZWq4O5gQH7QyFQnoIOz7wwWhz7CwkOboop9amEkCwae+Qc+NkmoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lloOMXGd; arc=fail smtp.client-ip=40.107.200.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sKyIdnYCUtIvWKYevlOeWMr2x9LHEkqttMv+3oBT9oBDnzbINCvoQEYlW15Vsh9W6gZniBSwvWbxZnmUOb/SGUtUHvdbJNlB6BV367CN25qziUnCdgQv9VT0rgacKA/DXMPxGDnzqc21KQpCOSLZlqA0Xh2DmR2tQQUA1RRi87OWWJLd5SwzvcRFmcr778gW8CHUQYRnCTdsOd9f7971rGef9Aby7z816zHxCtf79LQvxKRVJ10iYvN8FhfdrTInUVM5pYnqKYNQQzlOJgoJ4glmAVW+ysFMw1nWYSiNvHQTKsuygOanUuPDLIVD5KLIZpRYJZq0/O4uJ28ecUFBKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1FYv+Mz7VTBBpNFUUTTxRNPFgvfvjOiXaeYxmd/jF7M=;
 b=IQgKvF/M4rLXA3ty8lzrvwH9wsTz4aqy+B6HkwCODrrovgCXEklvvp0c8hJCiiR18sNh/VpZ4mE2NHUSauUTHUB7WbHRiXsrkP9h+Ru8YglL6QitFidsl7XVRBQ2ZVY/EscSpmb8gicO4gMJeHtPXWnFYlr3VQACmVraGlPrJYDVlBKWtCKx51HkKKm44KKGIHT5kqE5eJDVi8AiEmVcpt+Cf7zM0lXsG4KUpF+dh/p40EvAOtBT9ih4UKuc+qI7xyKsJvXdZhM0uNSEHmFNADl9pqUBcioljHwg6YOKKmdNmeXA7LjsyboekDyeJ8muttx9ax5nN0kz5uzqBv+XTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FYv+Mz7VTBBpNFUUTTxRNPFgvfvjOiXaeYxmd/jF7M=;
 b=lloOMXGdKiTDtLq9esoipykUmnQWGORrvEdh7bAdngKNhmdJkkx9fy0UYYesWYq/xn5mll/OpEC/UlrjMyFNdKsp3/hNuJ99Bizi+xxHZ6Iw6fkJ1itPIAQExr8usZI2DzoYyyK3Iyf0GNgmVqFD5P5+Q+eW2YqIxzhlkK5ZvtJoFm9UZ0sN5XvQMaDzOX2dtg7Egi9R+G8bHjtPKFdRSUELlHjPjdCKjOcDNpSP1diT6iHTusQy6oXmTqpMCInfcZPcoVODerAl5Cq6ns3SRhlmrnOwiNmNFD30c/2HhC7KTBy3PRCfDp4Ih1HU/gF5/DivPWYY17evPa/cPo6j/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 09:40:02 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 09:40:02 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Shuah Khan <shuah@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] sched/debug: Add support to change sched_ext server params
Date: Wed, 17 Dec 2025 10:35:43 +0100
Message-ID: <20251217093923.1556187-6-arighi@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217093923.1556187-1-arighi@nvidia.com>
References: <20251217093923.1556187-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0002.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB6413:EE_
X-MS-Office365-Filtering-Correlation-Id: 3884f92a-6fee-4706-7c75-08de3d504089
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EDClEjtlKuGYI1c/Fz5k6gsddfX0SlVt2wjCg4TeNeu5Tf9dnlSJH0VsLBKT?=
 =?us-ascii?Q?MaCyXUgNsbyhC1N2c2CtmTtc9smVGSoht020uyjvA6cTxLMDvldFTrPcZ+5L?=
 =?us-ascii?Q?DjdX5M8PxTqKoqPhegkmdGFoBnBXMkzVlOaW6jEOmX0s3s28bqTOqhlIVImu?=
 =?us-ascii?Q?cmPauiToI+Raqv7MYOUi5dfFuMbbeQl1vESSsy6X6OE1ziaW5sSp0x8wyb3U?=
 =?us-ascii?Q?LvXnsykRAJLhAyeGKU4Zzb1xCu9kJ51UttdezNhDC4f3G7v1bLcwG5x6YEAU?=
 =?us-ascii?Q?XzbFU7ErZq2swPY8ISFdO9JSvNaJtYtvAqNwz6ejX/+JDGBNXKbwpL95ziMZ?=
 =?us-ascii?Q?zv7mpLZ7X5OWQI5t7d05UeVhAH35VL2lqMizW9pyI3i+Hxgg4JSkSEhQl/6R?=
 =?us-ascii?Q?NGbYhGjEPo8jQPGMkVw3elxN069LkX9iBcrzQgJR+4FT58C8AEy5w8nq7Mfz?=
 =?us-ascii?Q?3/pgA/1YR47XXG9xWXdnx79rFG/JEHbqqDN/QRsHtoIZYWSmcO+5ZJaljpTv?=
 =?us-ascii?Q?iA9yHGCS4Qq2anmyBu68K/lxbppjmKXY3vtQsfpnWesyf5T/SeJ+d0z5X67w?=
 =?us-ascii?Q?AE9pQNs38ghGuynmk/MxSo435Ja5jkpbF9aNY8EveNlVDPIqntHJJGCfy5hr?=
 =?us-ascii?Q?L56B9nXInKCU6UHnoh3WsA3Y6vdjpO/BXfn4JhC2+DcWSVLaHMoAZbuDs8up?=
 =?us-ascii?Q?bEBRwTZnA11mPCtb44ldilX63aq59h92QYuTDRxqww7nOxypCAhlsylH8j7Y?=
 =?us-ascii?Q?CQhQc6VY1zdGtvhs65DabwlmtqEtfb1VQdPftYaD3BmqIosgvxgoG4v76fmT?=
 =?us-ascii?Q?pSQQzR81HzqZuYv1SJawX1snE60vNIhrjJr5xAWFFP/tPyWdcRMXQB9RYuw3?=
 =?us-ascii?Q?MyxHRhjf/oI5Q4X9UbCZDEzaXEV5ocLsap6EnEbA2BVqExb6NFMMigW53FRV?=
 =?us-ascii?Q?sNsH0/FwcTSYTtiV75Uezo/zBlBkPqO8T9hD/henNIWZGfZKIFaDtI4cFMke?=
 =?us-ascii?Q?dLlRbJsfiJnCPkVlGkmWRjiFw1GmXmLwAn1GQchfSMDFJgTpvJz2KAL5BIUL?=
 =?us-ascii?Q?xFKtjR2E+6vC9GlH8JtewhxNc30FArXbsMJqsVP2Os+e9/5NB02ih/ePL+2G?=
 =?us-ascii?Q?qOg2ZIUIuTdn5FJxkq6jp0xr8aFcp2QyIjYN3RUab64tAduBd9kwgjoFSNlQ?=
 =?us-ascii?Q?63NyeuXvEUz7/DhNYl5tKpEOU2MI1E8PYRliRIJrgCwGuxmQrLfZC9n2B09P?=
 =?us-ascii?Q?/UXFzd7PSxWHlCX5VftC8Nz/bWVkHcDRIThiaN36Jw1dbt2lgZwnDDxNd5Cb?=
 =?us-ascii?Q?Zo7A4HH33lkiShz16Xb1hQUbo/TUa0TQz16/lAsaidHzlk2SriW+M7dOMCKl?=
 =?us-ascii?Q?6rzPz1WRNZf8hVJjeTGwrqjpUL552t/r5imhKK7hP3xn+VMfKM672BL/hg1m?=
 =?us-ascii?Q?nVkknn4ee1mKcLq8DMcK0NO5YH1Jnq6V?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h3iml7tLT7MdOVmBNV9WfKqbaGqScyyfCJ3oWoS23rWTJYfRosSO24tsWrw1?=
 =?us-ascii?Q?ot9KdlFoqvnoDhYy9/2/XAi4imHYmqNj4LcZgy00Ch+6mM6R/iuQfihoCzw0?=
 =?us-ascii?Q?U4wvCH9js2imLkNQ3ITTyrpiRZ6o7lw6HGa8PJK2WoxBZttqS2b3r2KlB+Qt?=
 =?us-ascii?Q?FDCAcM0oB9u6oPcNrzZi4X8ij+bXXPN+pW/j99ITmppOhd3B4+h2BSx8fzH4?=
 =?us-ascii?Q?jaCxiwO/zSO3L6vhCvKXurUzb0gB4hzVyl+ZXyG+AzUwedEbJEDNQuEu+y3M?=
 =?us-ascii?Q?oZYIApy1eKWtHm+OU/u8eHxxY4T0zSEXqHNsooZHM0AnoLRA81elu/cLSN3w?=
 =?us-ascii?Q?Y1dmnD8NxsuW3AWFvYb3z1YtGABVcgLEdmBhtwZyqNZew088EGrEJ+Mjmjlp?=
 =?us-ascii?Q?XzN6T01/FgYORKTY/LlJDeEKiRKatE/rDHEPHwap+Thb5MseO2JKX4aJ2S0a?=
 =?us-ascii?Q?pQ9+Czd1bI7kC2hhmWiSp/2dnyIPvX0Lmjc4shv8Y8GM84aRuzcWb0YC3aGo?=
 =?us-ascii?Q?0XAeFKedJN+cfs2U7STAgwwYxvHfFzl/w6OIxHJpshl1NbiylB1j/8ulSwco?=
 =?us-ascii?Q?XdZLXqbAN7mKBNMVuyGDYPqMpCj/SWL7UMpQigF7Ozt+SWkjXvH6HzbUiPM8?=
 =?us-ascii?Q?QdtmAXV88RcPrIijKV0hPWyWl/Q5z64s0Xo0n0bIQJwIws3Zt5unesiIWa5c?=
 =?us-ascii?Q?LeVJklJKcBRRETu/yLYb3puZhAHh89YUFveE8GTfIbeNWdUB4B7l42ETEVv4?=
 =?us-ascii?Q?VnZmKn1TyDUrXdcM7E3OhaZLh+OC+cf420kJePBYzr93r1xsuUtVyO3zJWMz?=
 =?us-ascii?Q?0SOa37W1aPdO8PF2sysGsosOKtju4H+frRaMD0n+hkENX8+FMO3AuGqeokNc?=
 =?us-ascii?Q?+IqUM30AOQdeRjgyD9+K3+MBgU8YsO5KsL9HQWDvf8eXKPkIaT5CpLsqY2XZ?=
 =?us-ascii?Q?cwyJoOWvY6q0uR8d9n+P1tqcxMroC1eWONsmMMuHQrGqsh14dsL91kXXxOJN?=
 =?us-ascii?Q?wE3gkTwAMQC9/sIhStw2qdVC3+QbNcB8Dyeg04ZknAdFji3bR2N0NH5cTI01?=
 =?us-ascii?Q?4V3gV1CDmc06FLBLBccXlWs8fCo3NYuM3Miu1o1TDbGKnvpOzgvQPHrsOnDr?=
 =?us-ascii?Q?2gKXq9KgNjnkyKHErg26ZefIALUwrTRpNwq8ZwRdsELucU0HUhYxqkfg8wjX?=
 =?us-ascii?Q?Ex1oyDlINrbd9ldwy7yYL9LZPCCItrUxGmleMzfNPMgcRqCwYibZEK7Y9ZBg?=
 =?us-ascii?Q?T2ZBxXn56ua2dg0jrHu4lI3JR9jL7K52a4w+BXVysQCAb9QcICgEgr7J/19Z?=
 =?us-ascii?Q?NUgZQB0/RCoiS23yTGbrraHCkAiLSgBT5HSoxQ0w4Tmcf+i+7sVRUClZE19R?=
 =?us-ascii?Q?ckHmwG4ibbc6VzlGA+qyJjbcK9VmhUDl7VCVuTMvJ99gklQwvs1dyjhmxuEm?=
 =?us-ascii?Q?DY5l5lrqR8uxPLDw1LaVL5vBbVEI6kvQqFdhSwNX0kztXQV89pPxuhuSU84x?=
 =?us-ascii?Q?w3O4lq9YR//JhWTjzFSYg4hYzMtfO0HafV42iCuU2t65H4yoKKWF81ncI9Ai?=
 =?us-ascii?Q?PkPhKESdxtmjsZ1WvSz57yb8i9OWo3M94mXlDlE5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3884f92a-6fee-4706-7c75-08de3d504089
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 09:40:02.3807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sHc22RkFLguR1JiL/mVtSbtYs7Z51kpx6p+nBqDA0LzDgD1IHkG3MDKn5RJjDEbwKT5hdpY9ssy/vTy6sD/W6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6413

From: Joel Fernandes <joelagnelf@nvidia.com>

When a sched_ext server is loaded, tasks in the fair class are
automatically moved to the sched_ext class. Add support to modify the
ext server parameters similar to how the fair server parameters are
modified.

Re-use common code between ext and fair servers as needed.

v2: - use dl_se->dl_server to determine if dl_se is a DL server
      (Peter Zijlstra)
    - depend on CONFIG_SCHED_CLASS_EXT (Andrea Righi)

Tested-by: Christian Loehle <christian.loehle@arm.com>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Co-developed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/debug.c | 157 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 133 insertions(+), 24 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index dd793f8f3858a..2e9896668c6fd 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -336,14 +336,16 @@ enum dl_param {
 	DL_PERIOD,
 };
 
-static unsigned long fair_server_period_max = (1UL << 22) * NSEC_PER_USEC; /* ~4 seconds */
-static unsigned long fair_server_period_min = (100) * NSEC_PER_USEC;     /* 100 us */
+static unsigned long dl_server_period_max = (1UL << 22) * NSEC_PER_USEC; /* ~4 seconds */
+static unsigned long dl_server_period_min = (100) * NSEC_PER_USEC;     /* 100 us */
 
-static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubuf,
-				       size_t cnt, loff_t *ppos, enum dl_param param)
+static ssize_t sched_server_write_common(struct file *filp, const char __user *ubuf,
+					 size_t cnt, loff_t *ppos, enum dl_param param,
+					 void *server)
 {
 	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
 	struct rq *rq = cpu_rq(cpu);
+	struct sched_dl_entity *dl_se = (struct sched_dl_entity *)server;
 	u64 runtime, period;
 	int retval = 0;
 	size_t err;
@@ -356,8 +358,8 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 	scoped_guard (rq_lock_irqsave, rq) {
 		bool is_active;
 
-		runtime  = rq->fair_server.dl_runtime;
-		period = rq->fair_server.dl_period;
+		runtime = dl_se->dl_runtime;
+		period = dl_se->dl_period;
 
 		switch (param) {
 		case DL_RUNTIME:
@@ -373,25 +375,25 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 		}
 
 		if (runtime > period ||
-		    period > fair_server_period_max ||
-		    period < fair_server_period_min) {
+		    period > dl_server_period_max ||
+		    period < dl_server_period_min) {
 			return  -EINVAL;
 		}
 
-		is_active = dl_server_active(&rq->fair_server);
+		is_active = dl_server_active(dl_se);
 		if (is_active) {
 			update_rq_clock(rq);
-			dl_server_stop(&rq->fair_server);
+			dl_server_stop(dl_se);
 		}
 
-		retval = dl_server_apply_params(&rq->fair_server, runtime, period, 0);
+		retval = dl_server_apply_params(dl_se, runtime, period, 0);
 
 		if (!runtime)
-			printk_deferred("Fair server disabled in CPU %d, system may crash due to starvation.\n",
-					cpu_of(rq));
+			printk_deferred("%s server disabled in CPU %d, system may crash due to starvation.\n",
+					server == &rq->fair_server ? "Fair" : "Ext", cpu_of(rq));
 
 		if (is_active && runtime)
-			dl_server_start(&rq->fair_server);
+			dl_server_start(dl_se);
 
 		if (retval < 0)
 			return retval;
@@ -401,36 +403,42 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 	return cnt;
 }
 
-static size_t sched_fair_server_show(struct seq_file *m, void *v, enum dl_param param)
+static size_t sched_server_show_common(struct seq_file *m, void *v, enum dl_param param,
+				       void *server)
 {
-	unsigned long cpu = (unsigned long) m->private;
-	struct rq *rq = cpu_rq(cpu);
+	struct sched_dl_entity *dl_se = (struct sched_dl_entity *)server;
 	u64 value;
 
 	switch (param) {
 	case DL_RUNTIME:
-		value = rq->fair_server.dl_runtime;
+		value = dl_se->dl_runtime;
 		break;
 	case DL_PERIOD:
-		value = rq->fair_server.dl_period;
+		value = dl_se->dl_period;
 		break;
 	}
 
 	seq_printf(m, "%llu\n", value);
 	return 0;
-
 }
 
 static ssize_t
 sched_fair_server_runtime_write(struct file *filp, const char __user *ubuf,
 				size_t cnt, loff_t *ppos)
 {
-	return sched_fair_server_write(filp, ubuf, cnt, ppos, DL_RUNTIME);
+	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_write_common(filp, ubuf, cnt, ppos, DL_RUNTIME,
+					&rq->fair_server);
 }
 
 static int sched_fair_server_runtime_show(struct seq_file *m, void *v)
 {
-	return sched_fair_server_show(m, v, DL_RUNTIME);
+	unsigned long cpu = (unsigned long) m->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_show_common(m, v, DL_RUNTIME, &rq->fair_server);
 }
 
 static int sched_fair_server_runtime_open(struct inode *inode, struct file *filp)
@@ -446,16 +454,57 @@ static const struct file_operations fair_server_runtime_fops = {
 	.release	= single_release,
 };
 
+#ifdef CONFIG_SCHED_CLASS_EXT
+static ssize_t
+sched_ext_server_runtime_write(struct file *filp, const char __user *ubuf,
+			       size_t cnt, loff_t *ppos)
+{
+	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_write_common(filp, ubuf, cnt, ppos, DL_RUNTIME,
+					&rq->ext_server);
+}
+
+static int sched_ext_server_runtime_show(struct seq_file *m, void *v)
+{
+	unsigned long cpu = (unsigned long) m->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_show_common(m, v, DL_RUNTIME, &rq->ext_server);
+}
+
+static int sched_ext_server_runtime_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, sched_ext_server_runtime_show, inode->i_private);
+}
+
+static const struct file_operations ext_server_runtime_fops = {
+	.open		= sched_ext_server_runtime_open,
+	.write		= sched_ext_server_runtime_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+#endif /* CONFIG_SCHED_CLASS_EXT */
+
 static ssize_t
 sched_fair_server_period_write(struct file *filp, const char __user *ubuf,
 			       size_t cnt, loff_t *ppos)
 {
-	return sched_fair_server_write(filp, ubuf, cnt, ppos, DL_PERIOD);
+	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_write_common(filp, ubuf, cnt, ppos, DL_PERIOD,
+					&rq->fair_server);
 }
 
 static int sched_fair_server_period_show(struct seq_file *m, void *v)
 {
-	return sched_fair_server_show(m, v, DL_PERIOD);
+	unsigned long cpu = (unsigned long) m->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_show_common(m, v, DL_PERIOD, &rq->fair_server);
 }
 
 static int sched_fair_server_period_open(struct inode *inode, struct file *filp)
@@ -471,6 +520,40 @@ static const struct file_operations fair_server_period_fops = {
 	.release	= single_release,
 };
 
+#ifdef CONFIG_SCHED_CLASS_EXT
+static ssize_t
+sched_ext_server_period_write(struct file *filp, const char __user *ubuf,
+			      size_t cnt, loff_t *ppos)
+{
+	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_write_common(filp, ubuf, cnt, ppos, DL_PERIOD,
+					&rq->ext_server);
+}
+
+static int sched_ext_server_period_show(struct seq_file *m, void *v)
+{
+	unsigned long cpu = (unsigned long) m->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_show_common(m, v, DL_PERIOD, &rq->ext_server);
+}
+
+static int sched_ext_server_period_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, sched_ext_server_period_show, inode->i_private);
+}
+
+static const struct file_operations ext_server_period_fops = {
+	.open		= sched_ext_server_period_open,
+	.write		= sched_ext_server_period_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+#endif /* CONFIG_SCHED_CLASS_EXT */
+
 static struct dentry *debugfs_sched;
 
 static void debugfs_fair_server_init(void)
@@ -494,6 +577,29 @@ static void debugfs_fair_server_init(void)
 	}
 }
 
+#ifdef CONFIG_SCHED_CLASS_EXT
+static void debugfs_ext_server_init(void)
+{
+	struct dentry *d_ext;
+	unsigned long cpu;
+
+	d_ext = debugfs_create_dir("ext_server", debugfs_sched);
+	if (!d_ext)
+		return;
+
+	for_each_possible_cpu(cpu) {
+		struct dentry *d_cpu;
+		char buf[32];
+
+		snprintf(buf, sizeof(buf), "cpu%lu", cpu);
+		d_cpu = debugfs_create_dir(buf, d_ext);
+
+		debugfs_create_file("runtime", 0644, d_cpu, (void *) cpu, &ext_server_runtime_fops);
+		debugfs_create_file("period", 0644, d_cpu, (void *) cpu, &ext_server_period_fops);
+	}
+}
+#endif /* CONFIG_SCHED_CLASS_EXT */
+
 static __init int sched_init_debug(void)
 {
 	struct dentry __maybe_unused *numa;
@@ -532,6 +638,9 @@ static __init int sched_init_debug(void)
 	debugfs_create_file("debug", 0444, debugfs_sched, NULL, &sched_debug_fops);
 
 	debugfs_fair_server_init();
+#ifdef CONFIG_SCHED_CLASS_EXT
+	debugfs_ext_server_init();
+#endif
 
 	return 0;
 }
-- 
2.52.0


