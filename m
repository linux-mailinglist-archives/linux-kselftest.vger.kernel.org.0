Return-Path: <linux-kselftest+bounces-9320-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 905928BA5CE
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 05:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFAE81C22361
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 03:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACC929429;
	Fri,  3 May 2024 03:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O6XzoCOA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C6D22339;
	Fri,  3 May 2024 03:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714708275; cv=fail; b=IcVIpE1hV9FqStRnSsPwDqXagg7W7hCCATgJkxZEeOASy09NRFgybrClxVskJwpIL5sANxI8u28+o3+A2sbqmCzW8OoGlC5MKg8g+wAG3xwMZ6YOuYOQrqpN88NuoARBeBedk74Z1GGZ6xJsoHNujON9oJDsksG511t+rU1kCBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714708275; c=relaxed/simple;
	bh=417ntnB9MrrTmbxeBWGwgKj5y/u954m6VJ328OcPGzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Grv6ulagjezG9IPT8rvNc8EITAAOFvU+wr+3p04TYygnd01JvWRUGL1TXSdyQcRQcou3TeKrWaONoA5LeamGdsxxWUsgwr0+/Iq+uQUhlBKmUqPj0wAfzSx4lkLAOTCZVeBf8UYCJjQRWhQKQ5QQwAoOebtreCIYMlIq0KaF6AA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O6XzoCOA; arc=fail smtp.client-ip=40.107.94.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2A8uwtfYWrbCBFI/gIfs7LEWlDnWdeaNMrDFRsxuMR5Jk9Z130MO0ZRu4pv+jcec1KcerpW37MBjGI75FgSqX6igJRcw9rqscyQfXV1L0WCdJgmRhFNnKyvn5ftylhuT+ueaBTVkHLgZCDdJB/JIoF4RDCZBRqoWE+yTSShDNd1fc/xe0/s2MPe6uUqFXK2OfGfXLsF5twImqOK2YGhxVAFPG3/Tb8v3eWBQL642SlLUM++gfACbWT+Li5d3ny0E7PL4ZM6yzX023uSehzZcQUZ/3D6F6tMLM8U1HNjlcfTFmevZHYECGatTHQNd/9B9rySYOfhe15P9liOKald+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VY5K6QS7gWPPRtUIjjZpOjz8cFslahzMJZL8S6Pxl24=;
 b=ctdswpoJ5bLa585NuZLtihwtYwk6AY/m3fe4KUripKhcNgB6rbPGS6c+9q+YZ28/aVPrdFeePuuLAtlf9R3tfZpc3gMHDeflMp8nXGofsF92rfTo2iGJVZJ58UYCxy9OXh7jQFeq07BHigGVAEVN0CfRJlY/GRyhc4aI0E1fIRaVuk4TX7qJkYR3EvhQMro45AI1tFz/r8RwwP+y6zyDi5u+n4Nu9YsDw8SEMAl6vZZfzpPmnAn8HW/qvSBbEiRwDybc4C0uPkIPcuJ6jHtcz/6OqxpSSNYMfeB6vpS6j/Snrxpz9gTH4q24qgih9snW56phcZiArbEz5n7o9Ci31Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VY5K6QS7gWPPRtUIjjZpOjz8cFslahzMJZL8S6Pxl24=;
 b=O6XzoCOArNHSkXGWe9CU3OkEAxm8Zay4V4O9hYnTbq7HMssI20xcxXRAxgseDWZcsyqAuJ4D4VX7WFXdwAEAt1HxEtemxiElBr5787kBxdRpkBEl7J06f0Rkaqyrol0bvD9e36iczQ+fsETNdxg+CrkQiYxpkO6OVeQ8s4za+jV4LH7J0EcTi02zrF/n9S5ODX915xYYipYR9mBtc1iELvocLUP7myfijEB31vMsrVdyrpIXGwOtYnjHdVv4zwg4R7pGSB8gEu1vxsOGtSiaKZP7QyewXhn++ynM8DHEeApI4D8c+z1k3VZa7mJZxg6gWzDCHFVIruVHGcT3Z9aIkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by LV2PR12MB5941.namprd12.prod.outlook.com (2603:10b6:408:172::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Fri, 3 May
 2024 03:51:09 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7519.035; Fri, 3 May 2024
 03:51:09 +0000
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
Subject: [PATCH 2/4] selftests/cgroup: fix clang warnings: uninitialized fd variable
Date: Thu,  2 May 2024 20:51:03 -0700
Message-ID: <20240503035105.93280-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240503035105.93280-1-jhubbard@nvidia.com>
References: <20240503035105.93280-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0105.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::46) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|LV2PR12MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bae8b1d-5763-45a1-3c81-08dc6b24444b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l9cyRRJOG9mKldp+jsF38ZxWuk4dOqg+iYqYSo0zzp+zjpfOzcZEzCy4Ln7L?=
 =?us-ascii?Q?dVFQBeQw5AMdUBcsCVaPo3wF6SfPTRwYbi0h9FCYbL1mqeSemcEQFOIfwoRr?=
 =?us-ascii?Q?oEG0nyKehhISs4fUqwc5BsIyNZgvS4vmtqS1Ty/O6x0xqETIbRqhbe+eQ4+g?=
 =?us-ascii?Q?sRrq0Q7P+Ujq5UwnKas5uYd8EzPkx7dDd4+fyeMKxwqwAgQhwwTP574HVWeR?=
 =?us-ascii?Q?eZpkwB37XgSEm+VqoVTniK9aEofEIo4jC0xf1GzSPT3qKOtTsiW1n6vT7g4D?=
 =?us-ascii?Q?nek/Tg+Tnk2xrGbi9ARuqssavNzK4X4QyAFVp6ikxm+czxGfzqV9NOX7clU9?=
 =?us-ascii?Q?J7evJLC6IEuavlZ61eJpyjjalM7SCWZzVq0CNLHIQKihv+pA0+PSpcRRci7f?=
 =?us-ascii?Q?+hmYwCjh7b5sE0V7M/btKFiO76Q5Z33UlYGNOG9wQuuZo9SeawkpnZ4un94B?=
 =?us-ascii?Q?2VsI6Wp0gH4lwmG7bDM3LxLhqozIz/JWk2oWvwILoPoIFKzpeYTOQjSNW/zb?=
 =?us-ascii?Q?dfEERduwPSfFdYMVgJFfehAX0YP3flgMGgUxI1c8xD7wYox/a7wxBB9aEnKd?=
 =?us-ascii?Q?z2bMFRVw6H9RqLYGyUBUHhuDnNjvaznQ5pXt60U1C3mi/wdExfTYsJr+RGal?=
 =?us-ascii?Q?3Mr7n+VxrvVaapwSNHLrOYfwmomQWhngssntpV8Kyo2n13yX1/c5+oIPqRUA?=
 =?us-ascii?Q?m0JBGgLUZyzXuDhYlyU9hVHAQOtxWupuMUQltRt7X3HzmoaGi/FYjl1YusTB?=
 =?us-ascii?Q?xmICsM+txFAQcaX753Kxr0B2QZ6iEQRjswgL6BR+sEXjWEOqo/1b/W5qsqWA?=
 =?us-ascii?Q?kS8vzQ5MZgPn1VRD8BHFOXxuSKvxNCtro/DQEDT32mcnZhDV7TKUJYXRrnE4?=
 =?us-ascii?Q?DA24oWkE0+EHKDk5VEAzArBWQQjtNJ2L6PorTkorQaSrPFJkiZSN0fr9KLZq?=
 =?us-ascii?Q?mSNMp8phSF/QkR5uOpcLbyw6c46/IHK6eNAEu/r+8lF+wGO3pg8ZzJQ+esxQ?=
 =?us-ascii?Q?72Wfn+XrCqUY1BL0jBpzaDmFgvenQIBJVkxsuvngyctm9brYwIrpXKoWC8yH?=
 =?us-ascii?Q?7Pi2HHzge9a9IZVcrP6pia01PYTQtw777k6w7g8LkClxj5rCD2pU1ipTlI0p?=
 =?us-ascii?Q?IOVy+b9cqjDdK2mmp7vFcylAakkfiTxohlFCawndDBWojqxpWPsMmtaUAe5Q?=
 =?us-ascii?Q?AMYrxmLAbAnMHYT1Wwfq0zW3X+4YJ8yFGTcmgwzUyoTCS+fUuQw9b5wLpDH3?=
 =?us-ascii?Q?6UAR5BwLVKWUcIDiiwbyjfwXCsS+ksLIsRsOMs+lhQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qcR21lO+rXzh5N3sssXtCrSuInWzjZwa+YnKBnBRvyKjVvPhSMyNthOGIJiM?=
 =?us-ascii?Q?K4vKRE3ceN7yGzIW+kyZpEd4jaGmMrzFTcyml+kIGYybfFE7qtpS9KhS7zwc?=
 =?us-ascii?Q?6tQAIu0w5vAIF84CekclhMhJn5vTiYewpCcOpDhxpzrczT1hyKLOvQfQ0vb9?=
 =?us-ascii?Q?Jl+Kb1Aij2ew4REk12f+Pl8JybJW4v5WcplQIzI/vQEGDUDo7y3aHVGokILo?=
 =?us-ascii?Q?oNMzUM0D5/e1xwLg3+dX0KzxE11QiMHNcMj3I3hxQeWSaEaj3Wo4fg2EoT9P?=
 =?us-ascii?Q?VlGeWW5l27q98ur3OKRvAo7x9ybdPe7yTMbsjD5AJszorY6UPjPaNzH94kbk?=
 =?us-ascii?Q?oVPuX95sJMz14jnt38HFgAoIkPqPpJhzxFmTOz1+ofCw8iUALLA3ZzZPQ6B5?=
 =?us-ascii?Q?H33v1WVXk1u61yyw3cehFYtd3lqUMqbnhiLb09p1dohWM9NHGxfUekAsIV8z?=
 =?us-ascii?Q?nupbOowsrNM/qu4Uougu2ITpvEQFbnCxW3C/K/K1qnWbztq8GHLUfCOH3GFV?=
 =?us-ascii?Q?xmAPQsZRoHJpZTLpRa0nrDxnvzgRYF1GMFbv9VQtp5B5G/nck5fhjv8OC0a/?=
 =?us-ascii?Q?KO/AzvtaIaeFootffpFnH5xHkslExbsjeZgI+CsnQlVzecyPzSgIUrbJcaD/?=
 =?us-ascii?Q?jYgkKSkbV1cF5LV9/syJCrwrjShWvdONM45qbIIXXsZwJr3LYH5IaqTe/WqN?=
 =?us-ascii?Q?DNpJfIhbX65ekF8yE/u5rzxhpoJeGH2Q48QBsn+asFonQTXG2aO9VRfEdVUp?=
 =?us-ascii?Q?PFadZaqOP00oe2qQJ5lJGmtBGj2dFdp0XmaKxOoEkAKNeGElHUl5jB24G8sI?=
 =?us-ascii?Q?cR8ZiQonZAiAmbM3aIoPkUd59f83zqC8hDuRG+NgC019rORa+4iHLrnc7tf6?=
 =?us-ascii?Q?aq1QjaayRwS3Qn3WS5REnZa85Ke1tFpDy9p0R8zBhSrck3vscn5FFlZ/Zfv5?=
 =?us-ascii?Q?BXbkpHVRB/M2WXycUr4ZR08BXqq9YZ1aIIEI0vbHuF+4CXN+SkgRAgRC81OD?=
 =?us-ascii?Q?9pt1uT4yGi7TkZohItk/8sj7LkMxXjyMHfVlrB1gwN5992vTPDCXBlGIhjmi?=
 =?us-ascii?Q?Ik+3MBxhTiYmOasjmtGasf+sCB4lHFYxCumynxszfHRmZwqScTXGy32XBVLa?=
 =?us-ascii?Q?ZIgaD4sFMODgxnBW9DtRBth5Pf5ET/X51BIg14rqNfMr28UJgoc4mLNwPHJa?=
 =?us-ascii?Q?HYBT/7QQ0gvw1pxX1nhJo21FiGM6JWciSocUKDvgX8b4cKb/ArbD15Uk+H7g?=
 =?us-ascii?Q?l//oNBYCAuXd7akCRybzOBjOqSF+gV0TxT1qYL6yZ63z3WsxmbUGd9RvRoVJ?=
 =?us-ascii?Q?3fB4jqVYRDGoX4ouNHZo/SII+580wG36/xBZBn62Xby9WCI6KXuk9V53AGdK?=
 =?us-ascii?Q?PD/SsKWu851MFZIgSZksoxGdSQVjiGFPUnK12v1PeYfl2/yktYw9bTgD7vtL?=
 =?us-ascii?Q?Toxa1/d/ColuS194HXYvHkeLttNvTJOtKF3OnZsmPTWzEordDEg7hwtPNTNf?=
 =?us-ascii?Q?y44lc5X+eobEphSm2+uHtef9AnWOlwv7WESHKiVHsamfvbLVgBDTo46LN/Ak?=
 =?us-ascii?Q?NsRVdqGN30xN8W5nSsQq+KeXH0KUdUxBDMSMgVvf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bae8b1d-5763-45a1-3c81-08dc6b24444b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 03:51:08.9521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SfcXSMxPWHCeDzvWHyhCglLwyDZnepBQW3R1X5GPejEG2Zwt5J1rF01HtWYw4YgRZPKC9mfo7EQwfYjIRNjTcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5941

First of all, in order to build with clang at all, one must first apply
Valentin Obst's build fix for LLVM [1]. Once that is done, then when
building with clang, via:

    make LLVM=1 -C tools/testing/selftests

...clang warns about fd being used uninitialized, in
test_memcg_reclaim()'s error handling path.

Fix this by initializing fd to -1.

[1] https://lore.kernel.org/all/20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de/

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/cgroup/test_memcontrol.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index c7c9572003a8..a97832b0c1cd 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -716,7 +716,9 @@ static bool reclaim_until(const char *memcg, long goal)
  */
 static int test_memcg_reclaim(const char *root)
 {
-	int ret = KSFT_FAIL, fd, retries;
+	int ret = KSFT_FAIL;
+	int fd = -1;
+	int retries;
 	char *memcg;
 	long current, expected_usage;
 
-- 
2.45.0


