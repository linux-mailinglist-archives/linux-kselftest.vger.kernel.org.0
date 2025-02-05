Return-Path: <linux-kselftest+bounces-25790-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1341AA28299
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 04:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BB5A3A6614
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 03:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF29218AB3;
	Wed,  5 Feb 2025 03:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pb9cqA/+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2077.outbound.protection.outlook.com [40.107.212.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8321E214A7F;
	Wed,  5 Feb 2025 03:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738725295; cv=fail; b=sXztgnih3Xn5liId7wXPzmJrwW71sPuVxTlLqlPi1LMlDxpZrSTTAz2SNRGa5lqKz2jljvi0zBFsW8gjNfWBZgAqrMe5lZHo8HKWEdz0M3V6/Dqv/0w8L2AU9YftbeU7pi1Zy2kdjjJsaC328buhrz3+YvZ4JkfukrklU9lTTqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738725295; c=relaxed/simple;
	bh=Ycq35FVFHUh3+lXFduO0LGjUEXQ/XsJt+EdRiAspq7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P0MpiRqvQc8uaBn1zboaJE+n730BRw24/MwUUvlm4B+W91Rd3TLi3EB1bptIg6AmodjIsis5gxLcc0RD5tIvI20co6Mn4I0Bk59MiOwFFq4mn4/O3ae0hALPBc2BpIu54t7rJgDpf240AgPqoScH/4cIfbGgH5DHLF/VKeaZoy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pb9cqA/+; arc=fail smtp.client-ip=40.107.212.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GvhBmNihZJYFX+6p0BuT5TXlt8G8KA+eneaeUyBzCQxGWVrMyeT1u7wO3Fo0/LAJcQ9M4Mq+Q52oBneFhoIt5/6PJL76WA4GmYJV8ubqEm7aFtsi10ZyuV4uYXpsKNFY3OYWoEzJ21KdxnENGmzeUr08B0y01yZKKqHXbn/skvJQXGqxphLZJSGYOZuUIy/ezYbbl3G7xFyL+4PUWqOahbM1rRxZfrdSWVEqexDR37fhYFIyS6WpSkGVrOwUyI/WQaH8qaDipa7phfAcYOfrOUS5u5MVYYVYFqn3OX3j6OOcJ0NvArRKckfZcQjEXemILbMeBscwO+Xr9ZjjYNctiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APQ4/MGbBmdCGLmDFlteEcEqhBpNZsR+DIcsiodcQmc=;
 b=xGdPXY8wLwo1Gh/nvNwQVGHLCajU9zrfwV8TwvRFSHPPR4pC9qKMF/QjOjGRxe2S+dwBmZwK86aWZDFy2xIaXoqoYcm2XjIhCCOzoCwkzsy/rmCHnkeJK6ot6p3tW/o00FKil9gf9+AulLW4rgirrpgEM24tjq0vK6C7a3S1QegdUlUQxOmjZhpaveUgvdWFsKAUa7Q7hSV0f+aaADTMI03Fvqa6NV2znmvZb0b4/Hk4w7VBe6TSq5MW5k1t0Ubc1l8V4nT+20+cO5Fm6PmJOTKpUClM1L08TY7jpoqsdqnYXYaXzxqn8GvlcXNuHcqdqpZEsA8Mp6Qjy+tTewNWEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APQ4/MGbBmdCGLmDFlteEcEqhBpNZsR+DIcsiodcQmc=;
 b=pb9cqA/+tEscKswnH+2SnjCx8lOc+FfH9whfLM27Q3HvoHi4QZlCwaLtb8Hbpm2LLfW2rZJsyUgL5oLnOp5K/pEp7ZKoMwFz5/LmUUCpRjrmRde8NiLspfL8Wepcz0ZvpVi+wh+voOmS3+DSSjyRnmVBo1nPuIlMOBD/0m+k9zpMVttM6YEsJTHb7JRyVIt4pdyp8yOkWtUEvthRP55C8RVF0K6BBjHlOg8DgmYdPW5mM7iQxcu/9ghZpTFt/oUza6z5jrHfdcjUXTqroAhYbPz1xg6WpVPUp7KBBmGsYxytxpxLLOANP7gzeb7juB6E22mp5kdm7unXdi3j0Z7k+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MW6PR12MB8865.namprd12.prod.outlook.com (2603:10b6:303:23b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 03:14:41 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 03:14:41 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Yu Zhao <yuzhao@google.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v6 5/7] mm/huge_memory: add folio_split() to debugfs testing interface.
Date: Tue,  4 Feb 2025 22:14:15 -0500
Message-ID: <20250205031417.1771278-6-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250205031417.1771278-1-ziy@nvidia.com>
References: <20250205031417.1771278-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P221CA0001.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::7) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MW6PR12MB8865:EE_
X-MS-Office365-Filtering-Correlation-Id: 24979d01-c439-4f49-65af-08dd45933b74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/oR5lpOH4r6RJVnvFNq0RuceuYg8dAryvnjbGqh5qzLpqXQfs/Pmi+fsFjGz?=
 =?us-ascii?Q?ZMM1htO/8KARKGBgo7Y6HqvSoIFdwQh23L9OCj+GiXwZfzdt1fsRra7hWgkO?=
 =?us-ascii?Q?fN3HdRtyUfpeaVCchpzRhziPg4m57FphtRP+atdiZnCf3IegNZidNnvhlNvS?=
 =?us-ascii?Q?dR6pT5M4eeTcI6B5gZcv/DgI0HIwSWZKnSTtlHf8LnPiwoNRywN222xxGGD9?=
 =?us-ascii?Q?OStwZSffe0iAtAaQLXlpA/mwcXC9OAMmjB+btSOCRnChJ6wpql9Swkh2Un1U?=
 =?us-ascii?Q?UEon64oJuDkDM2MXdwEpCqeFhqPRfLJlyoi8aqrSpKeViKmfvcoOoTz5uJt+?=
 =?us-ascii?Q?eNZ9PEJ0eFWm2nI7w+5uwstsJ/3+l4+vtor2ZX1fDYMTK+RiqxdrpcSq3u4b?=
 =?us-ascii?Q?IYYptCGFyxNxjg20aBhZgjgNIPzt/k7KnRhwVL/bYQS+tWVuLVLLYPOpZuFg?=
 =?us-ascii?Q?TGSFdgT6Xly8NFmT3zQdWHE7v9+OoXdzvzYc3c01q2G9ipVGgRDHO35IkiCE?=
 =?us-ascii?Q?Es8FU0pVC3y1p/7YYwBfVEBcOt06DO4wzYrzyJO17vVYK1zUCSJHyHB0flV9?=
 =?us-ascii?Q?+6/qPg/YKJwzAhD106t7adumy/qGKdXpGHB2fm5oJCvsyyO0xOhP64mxbjvE?=
 =?us-ascii?Q?QYsJ8CGiAsvuevxQ/vVQUZHDpzXHFp8A2Pw4OsR4mgMtkDACi38Jc8PpUiEK?=
 =?us-ascii?Q?B4oRmAx4ugXVUCQ2oBnjivC2gu5e0WyooG67QeNA7t6mz7DcYSofUimr0s6O?=
 =?us-ascii?Q?/c51TxU+ly5rdhQj1bNyIcI3TNagNIJfdAPDK05H8vqy4kQxImqtlTxaaTQW?=
 =?us-ascii?Q?DHcOGAlFf6oMxDaYI4KUNO4YzQPmEqXHdSgnhHjXEBNIA8MrYbOIBM2USniw?=
 =?us-ascii?Q?Zbw7kILdvwG6Ek1Ns87ytdrE7i4bZO9CMilH/mfqib6dgdfTqgmtB6XrBk0n?=
 =?us-ascii?Q?8Qby4NR98CanQKs9Fd13Tpc1vpjonzwqjjS3Ad5bcjq+hrJ3hKJRPnOVniQP?=
 =?us-ascii?Q?u4km0HbHEZLinLfGITkFDXvJ7JZ8SBK7kavyfYnnwxCn+HuvXyuMz5ClcCZT?=
 =?us-ascii?Q?RQPlt6DrRttltDPXA3nY6ZzplxI7JApwwkdFjwKckobIXlaGCHSDWqLDV/oR?=
 =?us-ascii?Q?aj/4nL05ibXUq/ZQfkxE79eExALe3Y72qqXy+karS8OU3ZReRfHeLr2uMd6w?=
 =?us-ascii?Q?4N839Z/yCCxfNl4eRO+PbSqNDKW4iL0BMaNeEO8CcLkRc8Im9PLJKZJ/pi79?=
 =?us-ascii?Q?qcU/lG6DeGswLPp6cGtj9OWWsio1Lod7Ols+nmSNcwpxhUehD8e+pzpY+0mI?=
 =?us-ascii?Q?1/BGuiFQ7OIt84XkaWXm1g35odxmKd2W71SD1sYE5AP7Q40l8uPeOKXTYwLZ?=
 =?us-ascii?Q?BIrftE+koRFepUW3l+rSBRoN0luC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6wQ13kAVJhbPF7hYg95kXzT0KzjAOulqbWRlTTRuMAEespSQyDaGrnSsuenT?=
 =?us-ascii?Q?TgWnxj2JQ/T3KZCVh+D6exDAEhV9sDZnxscm39v5qpR/3jZXGWR8TlUx759+?=
 =?us-ascii?Q?PK7O2LwXgpKItwCAJ50UaSTVpXrUzSPH15UAYfJ+sKmDIufWoYR32/JXAx/S?=
 =?us-ascii?Q?1MBRoplmYo91OALuosmBfpRJI6ZeojeMpYuhRVczTXaXv6ofGbd0JkP4RJ57?=
 =?us-ascii?Q?kiwJ6NbGIgOi9dNw+Y5v0ibZMC5ZOfANfU95WgMf7XpDmdhI6Wz9co4K/dM5?=
 =?us-ascii?Q?g1lS1YN+OvfcbzwWK4zCUPG9QY1GMNnbYaBpAgudQMoUv3pw6/lF7CyyYkx4?=
 =?us-ascii?Q?/H1XlvLRaGbZMvMBePyHCh+vjeCgiyYiUTt/cXAajOgh99Ud5WzM5kNcmc3P?=
 =?us-ascii?Q?hupE6A9D20KaPfKyHZJKH0fL85NQiAuvDICjDDOJFgtZtgadXTABcscoKKJ8?=
 =?us-ascii?Q?nfRvc0D8xbclWgOoXb1RVrQm5CS5mcmbe4bmQWFVVHyKukLvbPrssQLglz51?=
 =?us-ascii?Q?Gbfm23VBO2b2h5uZ/61h7kBhvi3shjASXlcIPx2SsyMssT4m2H/G6/Um2sMW?=
 =?us-ascii?Q?PFJXRhXAsdjarmaOmH9zRIOI9kD5Mp3GIPd/USVtKhfjOZCit0Yaqba8Zs+l?=
 =?us-ascii?Q?w1yFhFi8R88yKREpOmsz9aWCxBrtZtdt6yy1KrDYofj1CkRIOkcsSP3196WK?=
 =?us-ascii?Q?LjH42HE8zaT4h2LbNQg9kwo/sOLZf02hpe7qTHTJjQF0sNsqkOnIMREcIXeD?=
 =?us-ascii?Q?xp195K8Zu6yOjLCm/fDhveDHYzyE05zbMyIWt61jVCa05JUTWLt+roB682M7?=
 =?us-ascii?Q?qAH6bpjtGTr4oi3GGOihCpIKRm97BDEQlXt+coPi1lB8nCezkDY5onP1nBeg?=
 =?us-ascii?Q?1UXI9dIcuTg7TQJZsxEyM56z+PsRdFj11f90yKCADP0iQ944m34fwJJ/1EzG?=
 =?us-ascii?Q?vgA7T2Q5l3kOsmGdvceZ3+H+JPRJflLOFrSqlZBBFOUi8VsKkVLkQNrGbVij?=
 =?us-ascii?Q?Tue/f8ACk0tTtTncS1X8POUvyPogW+M8yyNiaQuRMCpXTCWQiH4kjjgCnzuD?=
 =?us-ascii?Q?h78kOJ9OKFOQcSoiOLXV4N9ucfc0roLTiFubb56IqGmvNQI3fDyuC/vDYHgL?=
 =?us-ascii?Q?Zl+MrnMeNsLWTRkbvUdwyRPQXOIbMplLJFv+Ii19/cxvZVwG2+uJdvskCiNX?=
 =?us-ascii?Q?uO3MTRPl9VCYrYOqVTowblDU035fMhA0F1rjBSCrQ4Y2Av+LHHDHkpUTqEw+?=
 =?us-ascii?Q?Ba4tsALRob7F/CjHikTBfiEZXx1J23WrpRw/zucIrlGAta3C/ggUJFNERe2a?=
 =?us-ascii?Q?D629caUxqsMfWMI4c7FH/Ou8BuqIp0NUn7mA8ROQxRbXP+bfVD+VmGGHJDVk?=
 =?us-ascii?Q?1gzd35if8v977CL+mCoFSDnDLtdTkfN6UEFJLxCO87xCCywzbPzSAa+WFjfe?=
 =?us-ascii?Q?PlIKwy2G3E624QElOKwE7afxMIH+ESQKpE1cO74eE7bhAftmhSKwqRc3x4/A?=
 =?us-ascii?Q?f04HXFwGA0tbwYzyTOaEYhHtzcTENWEOzdWaFqRy4DnuX1U1hhBkTVCjSD0X?=
 =?us-ascii?Q?RoQ4auYih6Kcuex1YyItkhHiU5bzL7Sfcwubz7ML?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24979d01-c439-4f49-65af-08dd45933b74
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 03:14:41.7762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kUqwzOiSXC6ayTr5lG0EMB0lXKu9QbdUZJdy6UcrX6CL84pB6SGwirzHWjdCXqr0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8865

This allows to test folio_split() by specifying an additional in folio
page offset parameter to split_huge_page debugfs interface.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 47 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 36594eef5c24..dad6819901a8 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4180,7 +4180,8 @@ static inline bool vma_not_suitable_for_thp_split(struct vm_area_struct *vma)
 }
 
 static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
-				unsigned long vaddr_end, unsigned int new_order)
+				unsigned long vaddr_end, unsigned int new_order,
+				long in_folio_offset)
 {
 	int ret = 0;
 	struct task_struct *task;
@@ -4264,8 +4265,16 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 		if (!folio_test_anon(folio) && folio->mapping != mapping)
 			goto unlock;
 
-		if (!split_folio_to_order(folio, target_order))
-			split++;
+		if (in_folio_offset < 0 ||
+		    in_folio_offset >= folio_nr_pages(folio)) {
+			if (!split_folio_to_order(folio, target_order))
+				split++;
+		} else {
+			struct page *split_at = folio_page(folio,
+							   in_folio_offset);
+			if (!folio_split(folio, target_order, split_at, NULL))
+				split++;
+		}
 
 unlock:
 
@@ -4288,7 +4297,8 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 }
 
 static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
-				pgoff_t off_end, unsigned int new_order)
+				pgoff_t off_end, unsigned int new_order,
+				long in_folio_offset)
 {
 	struct filename *file;
 	struct file *candidate;
@@ -4337,8 +4347,15 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
 		if (folio->mapping != mapping)
 			goto unlock;
 
-		if (!split_folio_to_order(folio, target_order))
-			split++;
+		if (in_folio_offset < 0 || in_folio_offset >= nr_pages) {
+			if (!split_folio_to_order(folio, target_order))
+				split++;
+		} else {
+			struct page *split_at = folio_page(folio,
+							   in_folio_offset);
+			if (!folio_split(folio, target_order, split_at, NULL))
+				split++;
+		}
 
 unlock:
 		folio_unlock(folio);
@@ -4371,6 +4388,7 @@ static ssize_t split_huge_pages_write(struct file *file, const char __user *buf,
 	int pid;
 	unsigned long vaddr_start, vaddr_end;
 	unsigned int new_order = 0;
+	long in_folio_offset = -1;
 
 	ret = mutex_lock_interruptible(&split_debug_mutex);
 	if (ret)
@@ -4399,30 +4417,33 @@ static ssize_t split_huge_pages_write(struct file *file, const char __user *buf,
 			goto out;
 		}
 
-		ret = sscanf(tok_buf, "0x%lx,0x%lx,%d", &off_start,
-			    &off_end, &new_order);
-		if (ret != 2 && ret != 3) {
+		ret = sscanf(tok_buf, "0x%lx,0x%lx,%d,%ld", &off_start, &off_end,
+				&new_order, &in_folio_offset);
+		if (ret != 2 && ret != 3 && ret != 4) {
 			ret = -EINVAL;
 			goto out;
 		}
-		ret = split_huge_pages_in_file(file_path, off_start, off_end, new_order);
+		ret = split_huge_pages_in_file(file_path, off_start, off_end,
+				new_order, in_folio_offset);
 		if (!ret)
 			ret = input_len;
 
 		goto out;
 	}
 
-	ret = sscanf(input_buf, "%d,0x%lx,0x%lx,%d", &pid, &vaddr_start, &vaddr_end, &new_order);
+	ret = sscanf(input_buf, "%d,0x%lx,0x%lx,%d,%ld", &pid, &vaddr_start,
+			&vaddr_end, &new_order, &in_folio_offset);
 	if (ret == 1 && pid == 1) {
 		split_huge_pages_all();
 		ret = strlen(input_buf);
 		goto out;
-	} else if (ret != 3 && ret != 4) {
+	} else if (ret != 3 && ret != 4 && ret != 5) {
 		ret = -EINVAL;
 		goto out;
 	}
 
-	ret = split_huge_pages_pid(pid, vaddr_start, vaddr_end, new_order);
+	ret = split_huge_pages_pid(pid, vaddr_start, vaddr_end, new_order,
+			in_folio_offset);
 	if (!ret)
 		ret = strlen(input_buf);
 out:
-- 
2.47.2


