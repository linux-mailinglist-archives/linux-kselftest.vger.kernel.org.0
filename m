Return-Path: <linux-kselftest+bounces-9322-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 220FD8BA5D5
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 05:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD2A82844A9
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 03:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7439956750;
	Fri,  3 May 2024 03:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yk3uGBVN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99B6D29E;
	Fri,  3 May 2024 03:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714708278; cv=fail; b=LL/Zv1Ox9JycfmM7I+j3fzLiNiP/8xNfq4zQlosE2RF8cwBTNmuapXd1gcstebXMtIrOoXm/5cwR0F6vHX7qYJ4lYucjYMe2WsRDG+Y1/yaatQwOkFifceWFqSIt0yRu5voJiKgr4tsCT+xY48k91YBX3R5jQBSxVsYVBl6Jwh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714708278; c=relaxed/simple;
	bh=BDHLtMEIEzZMGw3MmdXRT433IYCSaFZA9hzavxG62BY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UMZB2CEA2K1Vb7woh/wiaxEHAmUYcUnrnpwwa7S+xSw/SeYM59tWIc5ANZXrQQ4gMEE8tomwYbedi3ih7EkwSUqW8UFJ+a2yUnsVM8PGGFHRRIKSWBfkMmfE4Tb2GBn0iVDFoFpjjmnjs/pA0pA+h8dc7vctmwrlo1l/EnId6l8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Yk3uGBVN; arc=fail smtp.client-ip=40.107.94.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGONHHzWBWqkI1SEm+3gK7UxfNAO9NqGarkuCpUYgS8OMy6ZxF2HOSbeMzqtmLqe19RUY8Le3UqoZCQyjd77OeAv5luXWUN8zaX9IaWiVxw8UMzqFZ+NjlfSoxgmXqCjIqU6VOWl9yt5NPpeEd/hQ8OCwVMnruShJ2GiizhmdGrBe4rlxfbSK6HIOfzkhvKxOEjWgfh6/w+hDSjiNSYreDKe41rK2C7hDwVb2xEXSTs6pcX5uC4kphIVwJcTtjcgTifjRooCUAyYO8liwwPVC93nTNV28ak0ToRPNjfWDhf4Gypj+57CTQ4WJcwAkbQUwFRPXY3ay/1OgaucLM0WHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9WR5gBtXv5RhOqz26Rn5f7ugl+K5+DGwc1J+hEvwes=;
 b=Ll3CZIY1gMUC48rNUQQ5rjmVTrNWWNRdeL56f1l+gjSNawDj+od3Kzns8/qmPBQYjiyjutMbi4RuZBSIKq/mdbWLEQBi0wLU1D/Dl1Vu3tw+jZA2ePXkUH11ragCt2PwAKLHsUROBTkM/yEEkTnJi20CAjjz4j7dJBwZUlHwLmguUQFTMyGyX4k8CozbTFs59GwSt93lhUODRECvpT7KEOnU6lFECxE8XpVY8q6dXQvn1m/EIb1PFkM+OfpWrS1W9/Gubm/9PD3eAL1ypdboJLWV/lY8aqbU9LYXsO4AdWRhIvTxLEhbcyUwS+1R62ilXJ71ubW390sIehTOJNYPZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9WR5gBtXv5RhOqz26Rn5f7ugl+K5+DGwc1J+hEvwes=;
 b=Yk3uGBVNIMfHmMQ5t1wFZTxIH83eq3VYcXLgKOIRSTR7PZg5PpU/vU2BV8LGLalDZmPtFSiswE9GlvEcHdQY/vpSsMmDgvKqmI6XnURfr8UXtkrDaqrymoLEwTwJqcNMhs4kvI108Bvil1mHkxPY8XFrISztJZOEUVfBBeeLN6Gut6R9V+yhRXYjZOnNFGWe/lq874IdYDyySrN9wH5yzQ7C2gO2Ulv0MjpI4x7U1Mb4fdS6gwoMcRxISuJJpLXFIbaxhlriyPzHM+U9v2OroMoQA2r2gd2Ws/o+oS/LE7qGE3fmtQudDuhOrA7jaNRvKVuFPKIEKwQPel+9dfsSCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by LV2PR12MB5941.namprd12.prod.outlook.com (2603:10b6:408:172::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Fri, 3 May
 2024 03:51:10 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7519.035; Fri, 3 May 2024
 03:51:10 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Waiman Long <longman@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 4/4] selftests/cgroup: fix uninitialized variables in test_zswap.c
Date: Thu,  2 May 2024 20:51:05 -0700
Message-ID: <20240503035105.93280-5-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240503035105.93280-1-jhubbard@nvidia.com>
References: <20240503035105.93280-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0066.namprd03.prod.outlook.com
 (2603:10b6:a03:331::11) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|LV2PR12MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: c6f64795-4aba-4d09-1df1-08dc6b24454e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qpMz3QmN7eLRPcMERVe6qgqYo1f0dz/W1jEWmdEHTW02fp79KTBcOYfyDPBS?=
 =?us-ascii?Q?xNHVrlqgOUoutaTyj2fXFjbRjiqQ9ART/BGssEqcHsbQNQsEYEL0Vtxmryq9?=
 =?us-ascii?Q?b3pAtKzKJ8C2DLiD52NrWFdb9zffXRb7BF4dcEyRxmB0mu4fwvkHG+yDUC73?=
 =?us-ascii?Q?JQGUkpC1FJo8P48UJtaDEUEK+Kkg+Hn1dK2Coj5w4QQxWCwKc9hQnvkxFeGI?=
 =?us-ascii?Q?TW9STro2pLnZfoTh/58HQiLFXdWGm2xIiIzoo9Op64C99dKBeZigLra9gNaJ?=
 =?us-ascii?Q?FmzEaXsw+k3DB4H2OMkwmO/2+jjGAjNYdXsajnjIpXfxu2SmyUD6Zumfe3PC?=
 =?us-ascii?Q?pKW7+WbYb2uvUkhrrCIAPmzO9+Lb2Y9jqRRQaIZGQe6tFy6ZCnbYSXOKLexf?=
 =?us-ascii?Q?eVDxi1PENWR1S7psHmLAI86kS1sHKDMf0EJUxy/qgx31W5CWRWmPeWMhXDTy?=
 =?us-ascii?Q?2BzX/d1/pz+XoJW9QyAPUCWv07MMG2f8lZGgnJuEhgqlUVCfg5wy7sjl0PL5?=
 =?us-ascii?Q?MHSdwNWsADiYpYV6Gu9IFtN5KgcFr6HgE616hlI6HE0N3vieCbxTXi7Go31b?=
 =?us-ascii?Q?cDNY1sycrxPa7pFugDG+oLYT7zJJyejj6hGhp6zQGceMyawKmqR3AjO1ZBI5?=
 =?us-ascii?Q?Y0DGRf1BY4GLFLXy7mQ2QAHBl/7ekNC+7osze0j47lNXDaVYCqTPDETPoGJA?=
 =?us-ascii?Q?hgob7S+jIrkbALGJypw/bjgNKCk1SNLA3IAdntPlqsDWCxXsVZeGuXyQUDq/?=
 =?us-ascii?Q?+FUQ0vN0WL2qLZ/rZ0UzeltnuEJqTxPLxZpcdilPtn3j1yRVt9W3t1hIDqee?=
 =?us-ascii?Q?XOdGABuJ3FKRqUqs4YbiMeeRwlwAIZNBWsLZsNfaPkuQe7tm1umx6vWBFkWL?=
 =?us-ascii?Q?klhBgbT8V61bDlHll17q0na3Sm7iTywEd5pIItl+O4FFruacC07EZbDtIpYd?=
 =?us-ascii?Q?+MZBSQt1k7JQYG2iMXuT+HpwfdfSyX9vpyVRY2azfgsYCfoA4o+C2mnj0pdX?=
 =?us-ascii?Q?BMVzmGI19HQTglJsF0CHf1bnD/K26zqiAhBbyfZ/r16UY9gT0jCAgGBvpW33?=
 =?us-ascii?Q?0nS1shmEwYw8fNWpFjL/o9xJLDJBwqsbMraFsEV3OeO07vjIhlMAFQ4ADhAR?=
 =?us-ascii?Q?ZfJLnSfyjqyHkEtDd449EKFNxZr/SCnLW6iAT2rgxjUSqVLWKu+L28PaeaMT?=
 =?us-ascii?Q?ZuYmxN4/7aEo+jkTuy6lb/03GlOQUYa9ULoR2sBtVNOKfdkKOoNBODUBzRmb?=
 =?us-ascii?Q?IqRXohUt3/vFRl+ewBkGCg0n/FbQJGOmdh1dqVL8Wg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?avnkGjO8HoCCrykirEHUS+UmO20eAbBTCFn1MrRuhw9kPgyTjaVGZb8BiKoX?=
 =?us-ascii?Q?FvgFibPdesHYUsFmEMTnQqXQwg98El7OrkbR2+TXjPNy7LgWZo10oiQDagvH?=
 =?us-ascii?Q?8yeFRxNB1Oq3zsjFpp6iamXfjG8CZQOg2SeXJ/kK4+mtt6Xl9V96WF/Quall?=
 =?us-ascii?Q?UkVWivlgc7cyODo4hvCCuUjOyT0A68P3kBgUlu9vHTBk+w8ESeVdwrD7caw9?=
 =?us-ascii?Q?XAPJlT25vhgf95y9x5epYk48jhCH5x2FZ4gTzN9oEcmUdvnUszaHcWVo9L1S?=
 =?us-ascii?Q?ajioikE4KN+oHfILHxbhJs0EBt7NxCFpxF3M4RjWLFN8mUlpeEAZzUWaxs5E?=
 =?us-ascii?Q?i02i5VcWCtsdh7IYSrbho7LI9ADecnADHWot1/cAxafvb/Zoc/X4fo6oM+Fe?=
 =?us-ascii?Q?5nT58/fnZhLUqizjyFU5mM1qnwH75hwzzVD7Pyw+9rzqBVzqaThdVmHH+0Qs?=
 =?us-ascii?Q?TVTeqlmkU/mjx2QRFewzuZT+XiM2DFMPTeOzl1GmTRT3Q2L6tEm6rzPpNqj/?=
 =?us-ascii?Q?mRJIOt6X24CHMWQiQD0pDKWvkcZ4bouZ9k0ctMmJML0gjsjqm0aLUWbOTTNc?=
 =?us-ascii?Q?h+k+wIqpsHk5wlgzWhm5yxaz1CibC01PB6sqizizBFoTih/KTWamKW5pppuH?=
 =?us-ascii?Q?lEAP6mOtV1AAknBw5/G7edPVD+Q7qFtc5SP3RWusHqLE/+7GBkM+1IWTxm8d?=
 =?us-ascii?Q?4+zeWSyQd6pdv0dTDDJ3fp+3C/CKOl64VJGXR+zdf/qf3Quopi+q1mYZlQG6?=
 =?us-ascii?Q?Q6TI8KoPXNtjH35wJL20xbzUTwFUNZa5LgoUahY7Squ6FDKAxas4Xb4+MYeX?=
 =?us-ascii?Q?VeSO24+SB9RTqI6smIm4ckZeXGuLDphbXYhB6w58e5Z0GurSUSMR0rppFcRF?=
 =?us-ascii?Q?FAI4ZHFSHOcw/jaw5IH4UsaD73HDfXF63o1CnY/q5FoQKwvejG/YJjVd4Qpd?=
 =?us-ascii?Q?ttcq9YA4wJinxIdkrxQwNyyHJK2WGNjVbyzEvZ7IDpMdWzQ4Gc+UlfXxE2KE?=
 =?us-ascii?Q?TgQKWTIGkaPgaE/qV3+3k8TslYiiKm5C0b2MsMV0bRJrORDWXvJR2sQIecHq?=
 =?us-ascii?Q?YM7c1n4kOBcY6/HcCoi4djdaeTMX72I+rXFSEPFjqD5hhEkzB5IgtQMr3kXB?=
 =?us-ascii?Q?eXUi46vaSHurb7pdwdNpg9nA4z98hC0UD8Ydj0yf7T1yZcbTlP50W8AAD3MA?=
 =?us-ascii?Q?aP1lQqzLb7LyNXOFVt2Y5JQKYcowY3JvVIO+ifNMWGz4f4xAS40AmS1RntDK?=
 =?us-ascii?Q?bNJ+tU2AtY+3lOMrxHbDv+svZi+vbkfSIjh+zYsuQLU3pQVCIqjDByxKZtVo?=
 =?us-ascii?Q?vBk3Z7oEjfSfqb6oQS9Kc5hoN4+DV58KTT/0EJFnisvG4Syb2ty6jaxmnIIP?=
 =?us-ascii?Q?DL1UTnEpLhsNPb84yG/wLZHK9brf6JVK1UfsfzScTma2K7ZobYvm0PnwnAiF?=
 =?us-ascii?Q?vtmVzhmNnfePK9qJlPvfWNO2GEuscT6eBu55+bXj0DaDwIfDE/T1eJARcQXJ?=
 =?us-ascii?Q?nlBRjxfSX6MwtksUv9w1HhekK7rKbKQZ4A3OjGm0CNnj2/Dzc5am6bZ5/SQm?=
 =?us-ascii?Q?Es1nOWmC+q/UKyRD2fwB+XW66xDlbDeHmxg/so51?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f64795-4aba-4d09-1df1-08dc6b24454e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 03:51:10.6566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qzSnx0lCpzoXUcIapPFYR8xB+3Yu2Ak3eEWST3lH/p5cBA6cRK0sWrJnWhtvEOjWuqJ7IjQkReFcYGV/d+DddA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5941

First of all, in order to build with clang at all, one must first apply
Valentin Obst's build fix for LLVM [1]. Once that is done, then when
building with clang, via:

    make LLVM=1 -C tools/testing/selftests

...clang finds and warning about some uninitialized variables. Fix these
by initializing them.

[1] https://lore.kernel.org/all/20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de/

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/cgroup/test_zswap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
index f0e488ed90d8..6aac80eadc5d 100644
--- a/tools/testing/selftests/cgroup/test_zswap.c
+++ b/tools/testing/selftests/cgroup/test_zswap.c
@@ -257,7 +257,7 @@ static int test_no_invasive_cgroup_shrink(const char *root)
 {
 	int ret = KSFT_FAIL;
 	size_t control_allocation_size = MB(10);
-	char *control_allocation, *wb_group = NULL, *control_group = NULL;
+	char *control_allocation = NULL, *wb_group = NULL, *control_group = NULL;
 
 	wb_group = setup_test_group_1M(root, "per_memcg_wb_test1");
 	if (!wb_group)
@@ -342,7 +342,7 @@ static int test_no_kmem_bypass(const char *root)
 	struct sysinfo sys_info;
 	int ret = KSFT_FAIL;
 	int child_status;
-	char *test_group;
+	char *test_group = NULL;
 	pid_t child_pid;
 
 	/* Read sys info and compute test values accordingly */
-- 
2.45.0


