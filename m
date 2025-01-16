Return-Path: <linux-kselftest+bounces-24679-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A625EA143C8
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 22:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F15F3A61CA
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 21:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35F92419FC;
	Thu, 16 Jan 2025 21:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RaMV0+l4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010B7233531;
	Thu, 16 Jan 2025 21:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737061862; cv=fail; b=XTLJuatuFSkj+Z3/ZI+sAVeZHUic6Lp0zMfa7koXXY/nsGpxNIhTOcBeh25yKSydSZIcaSwcLVs/fA3y59244gIku1WGRleV9GPQ+hgAShcfvA+4KvzEbpRBkXenoXZoYRJRyaw6Ja3VBnGIF9sPoknsQJaiSN6z5l1FxkchZNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737061862; c=relaxed/simple;
	bh=T4KOVk3YmZRr56rb+N4ojQl/KcthCGWqoc/XmqpifPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MmMGqKVfrVYKNrNKdrcSmTY2PYkfq/XC2u6lLqBe/5fYbO3kOQKg4FZ+b2vieLePaB8nbxWAAwoFikIOgFupBhgmkYRnv8xh5rUODx+AHTuhVsULAseSPAwV/QvDeDWJ7ag9z/PErGfBIsZJNHrTVIVBZUCXNErj+qkmM+mBZVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RaMV0+l4; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bpqn9zmGuYAueUF4Vk3dgNEC8wv5qXsokM2RMtDqPt/ttqlZLEMU8bEPtNJc0pxvdF+KwHbKT1WWDtB4FUL3LWg7ej0tnTZGV0qrShK+0XIvtgGw4kJ0x+0XWvv8J1CnU0CqFoC33wmpPri6qBy1FjeJtDw0L3KP4GZz28/Cs0IEVeGJvqNP0pi5tnWAo+T/5B9ycHzY7M9hdyqW98Dp8kTL9oLWMTBhfpttYAwhkRWGEmX65zpnK+fcrIA3UiEBWATpXQmj0uKxJAxUnUelJ01m/MTmbUhUKnLT3Z690OujbNxRLMouqECmI1lMqUW9DLWd78r6eiHuF0esZRMTbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+VIhU8kstbeGfQ+N4xdwZUJPMEuC70nkJxjLzw3k2yY=;
 b=sTzqa87pBEDs73CZVkOOehODSsvT3azYzKP2C/j7ybYm8ZrIfS3qyJ2lHlf7GqOOVdqk8SMBX8YCJQJn4pXESS3UFehnWYHMtmC1zSr04Vs8ePMtIqI9LHzbO5QHYjzOSiVLUKfSYPBSDQ6YcKzCHFlGEIfMuQ8UdDTZ4XZLQaNux9YkbURSrW4Sjbzh7O0ChIWvhadmCQgIx05iWQSBgYnoloCQr5PjR/nkX7H7mVBKD1Wqj+KeWdJMoa26ipW2NRRINFOKEc8HeRjH4CpQVrPo78PWfSyL9xRF8sO7daZqps1msmU0NGdWnkMa7vDukjrJgAUTiZkf9ROYAKWdLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VIhU8kstbeGfQ+N4xdwZUJPMEuC70nkJxjLzw3k2yY=;
 b=RaMV0+l4G6K70kxdYm8R8INUYHRarKVp8VKdLKeKr7qURlSllrGDcCVORP8P+Q4gzJhpdoQLrsRQ9HY8mC9JvhPXuuEJdniulxsAvkUd4Ik/6zYdOv/0yKFLAnUpZjoQLoSAu9g0WJ1lZa5ztVR/U9JIpJ7TNcmi4czys5XhA3Qj/ra534xez5mE4DdwWF/lSPs1udS7AprKxUN4oO/icWrPgbXvR90CNCSJrzGdjF6Ewy+Z3PTNTO08V9ZGSKbddRQJTJS1DOzdlrQG1YtkrVO2UtZcf+8dp0iRWqluFPNNjebGWa3oo3IY59zggq0Lp75qaCfwkw007Gr1BCwCPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 LV8PR12MB9232.namprd12.prod.outlook.com (2603:10b6:408:182::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.15; Thu, 16 Jan
 2025 21:10:55 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%3]) with mapi id 15.20.8356.014; Thu, 16 Jan 2025
 21:10:55 +0000
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
Subject: [PATCH v5 03/10] selftests/mm: test splitting file-backed THP to any lower order.
Date: Thu, 16 Jan 2025 16:10:35 -0500
Message-ID: <20250116211042.741543-4-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250116211042.741543-1-ziy@nvidia.com>
References: <20250116211042.741543-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:408:ee::10) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|LV8PR12MB9232:EE_
X-MS-Office365-Filtering-Correlation-Id: b26881d1-45c9-4c7d-35b5-08dd3672442b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FPrWHfWQnODQlsdt7aLk9yFitewQCtB8H21TXjnOGEUa54CIsH5TSarsM+E8?=
 =?us-ascii?Q?Z6SrtMrwoU9LkZz4cQCO3YGJ0QfROCcmncXEvBi6tAkqsfHZtwO1YvDOAFRg?=
 =?us-ascii?Q?Rrbow8cCrVYFnPVP3dOLDeL07opIgappk/rEEzm7uXEsSUD4EDDZs2N+FPAc?=
 =?us-ascii?Q?LxRMHt7Yy+3lb9ZA5PEZGIHfG/wgeyc/JeKRo/dQqXfw+6JARdY+Pdk+UPEv?=
 =?us-ascii?Q?lNpyWNPTjdjEf5l+dhmBAQLbnB9Td1y68ewOfsIBCelyBvR2/OVvr93MIrk1?=
 =?us-ascii?Q?V76Q3Wd/8iKx4ePVqwgteohIs7vglRD9nfXoQoRsLtol5vZx93KotNsmrnpt?=
 =?us-ascii?Q?7nn/9CcdlVhXrjAabbjFnZ+/iBUpiEVbdo4eylNImOnJV4MGCuG55OsM2aRk?=
 =?us-ascii?Q?tAtO/P7C8inMf3oCRZ1QkgVx9Vup+8+6dmT8x2KpSpKEEGdr/II47NL78Wqt?=
 =?us-ascii?Q?loHCeU0MseGIMFjIUh0Kufq++e0ao30Xrn2ZGe0U9z90WmQC0nLIFSUNMwfW?=
 =?us-ascii?Q?HCffHTF701f+Sreslz9xsxY3z/kpAxodig87Q/rBsL0DwcWnEqABnc7D9zT4?=
 =?us-ascii?Q?VbaS4BBLiYsaRExf8QItEsJErqUg9fIpEkKzb//W+C7bV9WjyEKPUw2yY6L7?=
 =?us-ascii?Q?sj3t/AaYGYW16iqAsjpdR+u+xXlz8Wup7nGnVx63Blk+NiyVM2VP7OY8pn4Z?=
 =?us-ascii?Q?pgzwB8aTacv+nWaWbOQFP69jhK23G3wxwsYnZV85IWqb1zl8hQHQEvPRHhKK?=
 =?us-ascii?Q?1eOR+3qmP7ampwo9dxVqe9EIUkKTvU8PpeUpBVSr1YU2CUwsrEZDw0ax9PWP?=
 =?us-ascii?Q?tLKhaL8m7pMCv9jVotFnGiJ39AXmsENn55blqqkTeKD3Kq48F59zF7UFMu9V?=
 =?us-ascii?Q?YgI+WjsdJjSRqA8de5+UjARpK0P4V2t72qnaSdBNIuN3l3kUQOP5YGC59OX4?=
 =?us-ascii?Q?Mu5Amn1bQQ78z3vhLFu/NSYqASye8xeHIxjo8YU+v95Jl1F75xQPhuagZWaI?=
 =?us-ascii?Q?H0peKvKxlOqCH2eY6QvdXWPVIRbYSgZMLu0OirAvNqyXUNO0d+IzZqQjBcco?=
 =?us-ascii?Q?1JnR3JHrQb7mTvxlK0PoW0Q9j8euMmynotJzWUM8r0tztI/p1IifeEWFBH7b?=
 =?us-ascii?Q?+Y85nXRZBPZtjW7OSykaV08WbJaX+Qm3Z4bdgG1yBb38ZJO5SBbC7DCxqzdp?=
 =?us-ascii?Q?BOybMzvcxfqPT7BPjbD/pQWXraZ+p1PVlN5wF+Nf9fNMqfuIJjhqMfdKvn+d?=
 =?us-ascii?Q?HxgFfZeXH/dbMYopF4p4S1haxOJXhScf2VTKUMhmnc8E2bBFEBP9gbvX6vf3?=
 =?us-ascii?Q?OE5yWgiIdNoKK+Zafpx48tqEu88bGHkPdnivWxLugQLbWsDzBtptjcCcTk6i?=
 =?us-ascii?Q?ZXwZdhTr6jSs4VvRzeKXGQ0rwRMi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HOQtCadabhr339CSzlKXDF8yEX9FJsAiNlGR6FP+rBM3rIYUuUtq7xcBkSrB?=
 =?us-ascii?Q?Wn5jv2quFEXajYhBeoM9W+MU04g1gJ3nFBvSgZifMplytwOutKU+b1ATTIGM?=
 =?us-ascii?Q?dXtYkae9vGVSGJH0IbAnA3JgKGt3KBmlG+KCNv0IM6W93kHBCDtWXN3am0GZ?=
 =?us-ascii?Q?KFDhsEDAIJPfaZI90g/9/pk1oTXsWHLyZg9YJ04kTL/8LKf8/JcW0itoF09i?=
 =?us-ascii?Q?8EkqpbzaS0svtpMp6oRHA6zjFkAcODCVl1Lf7jbg/GL+jCkK/K+fqV9fAEKy?=
 =?us-ascii?Q?IrPGAMcms2pRSgValM/QAIMZB1E+ycQboMXqEUdBG8pnV3BPLC175+kid4zn?=
 =?us-ascii?Q?dgB7SAlPhGWu9kjNErFsiZjYw5HvR/hqscZaKHcj0JjPlNoXpqogOGpzosJq?=
 =?us-ascii?Q?myUkrQ7CdbrvEjp5bYa0SkxdBW7Akz62//pASqABesUOD6MFGlXQ5Oaz4E1b?=
 =?us-ascii?Q?3PSe3tejry1VNHDcRyW35fTXBku/PY52Y7lMPD66y4W7kRGAGHNxEJ7SPpsQ?=
 =?us-ascii?Q?RSkEceUMNqc2xOq2rAu9Ah6crCpPKH7ovqOl6HjFv5PbtCmXaAJ506Ie9VFw?=
 =?us-ascii?Q?gUeXJd6+Eg1Xhf6Ze0fztdum94nz1xcsXtK2QDjDaVHdw0H6SCl4ZIaMUg6X?=
 =?us-ascii?Q?9E2FpVT3BI17ZFhw7Xqbl3SbxD/pga2p3BBY3H0pTU/fDsJW7/VeasnxoQIy?=
 =?us-ascii?Q?eQfnwRsqnnLrEgEge23xZYzZ10rsRyDuXGnkc1LRVZQLlOgJ82lu1GynyFs7?=
 =?us-ascii?Q?5fvcelxUIG052ZUqHS84ujARFqeOtAtvmlz0l6AsqfwcYi1IEwJCb075deHc?=
 =?us-ascii?Q?kMBD21AGcJ79yim6NuLFClsWuWfH8F21n8fTvWO8NkGTqyxBidWu6chNpiD0?=
 =?us-ascii?Q?jx/7TnGK5E/OLUvxcKKy4qEvO8evvV2kV6RINSzP90T75r7sIFqwdCiO+nmI?=
 =?us-ascii?Q?zoGdyeGeYAOYDe6dubyiQzoGzH2jugOjHL0F0F/qsjcSo3oEixToBL8QstX2?=
 =?us-ascii?Q?CfG3t2ZYAANqzK/dIGtKYA04xdXUZ2ujBnYBH6VXU84Gs+yb6plno65/Digo?=
 =?us-ascii?Q?rB5c+A5iAEGms3NDx2IeYAPg0OR0Aao08EhNz4WAZB497I+pVaem/rhRFpcS?=
 =?us-ascii?Q?MPGJeYYRGf8M0xdawCZiJVykwS1B3BIDGuJCt647LRMVE7WKlXWouX0p9NI8?=
 =?us-ascii?Q?3CExxze1MmdmeYCIUPJi05kwzOiVJ+YK5tdbZyGJILtfJ4pa5/n/8nu2jVZm?=
 =?us-ascii?Q?pSR5g0AcRuB87xkvlHq9yTFQ/vivT4s4KE+9FZBcxj2vF3UuCOpnIlZR9T2j?=
 =?us-ascii?Q?AU7hhR99+MjH2IQSNXenb4kTZV48fzA00W5kcfksFpyv8cUV091TJczpmzS1?=
 =?us-ascii?Q?dHLntB0XiwP+006DM0Xa2Txm2edDG1n3wd0Gmi2L/zy9EiT30sShYAMTgFfx?=
 =?us-ascii?Q?2025nKtBORZ6UQ5ceNuET5O324uyoor093uTpYhXhkGeKVmVtN50awRFkH3R?=
 =?us-ascii?Q?MuhA6PHXW/Xi/95ZUh7ivEvsbmxSqr4oCd4B1tGwKlYU9JbZd62eXW5lyHzZ?=
 =?us-ascii?Q?5wfaIMX7jxcmmwnnnK7w7h6lyuzT3X/i7+Kk+/HS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b26881d1-45c9-4c7d-35b5-08dd3672442b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 21:10:55.5474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rngwo7Z6YsINEmckS615TUsDviz/jGjsF6FZjIreGaWyTi//mQi1/0MYpzToRHde
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9232

Now split_huge_page*() supports shmem THP split to any lower order.
Test it.

The test now reads file content out after split to check if the split
corrupts the file data.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 .../selftests/mm/split_huge_page_test.c       | 30 ++++++++++++++-----
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index eccaa347140b..766c1f3a1d78 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -261,14 +261,16 @@ void split_pte_mapped_thp(void)
 	close(kpageflags_fd);
 }
 
-void split_file_backed_thp(void)
+void split_file_backed_thp(int order)
 {
 	int status;
 	int fd, shmem_sysctl_fd;
 	ssize_t num_written, num_read;
 	char tmpfs_template[] = "/tmp/thp_split_XXXXXX";
 	const char *tmpfs_loc = mkdtemp(tmpfs_template);
-	char testfile[INPUT_MAX], sysctl_buf[INPUT_MAX] = {0};
+	char testfile[INPUT_MAX];
+	char sysctl_buf[INPUT_MAX] = {0};
+	char file_buf[INPUT_MAX] = {0};
 	uint64_t pgoff_start = 0, pgoff_end = 1024;
 	const char *shmem_sysctl = "/sys/kernel/mm/transparent_hugepage/shmem_enabled";
 	char *opt1, *opt2;
@@ -314,7 +316,7 @@ void split_file_backed_thp(void)
 		ksft_exit_fail_msg("Fail to create file-backed THP split testing file\n");
 	}
 
-	fd = open(testfile, O_CREAT|O_WRONLY, 0664);
+	fd = open(testfile, O_CREAT|O_RDWR, 0664);
 	if (fd == -1) {
 		ksft_perror("Cannot open testing file");
 		goto cleanup;
@@ -322,7 +324,6 @@ void split_file_backed_thp(void)
 
 	/* write something to the file, so a file-backed THP can be allocated */
 	num_written = write(fd, tmpfs_loc, strlen(tmpfs_loc) + 1);
-	close(fd);
 
 	if (num_written < 1) {
 		ksft_perror("Fail to write data to testing file");
@@ -330,8 +331,22 @@ void split_file_backed_thp(void)
 	}
 
 	/* split the file-backed THP */
-	write_debugfs(PATH_FMT, testfile, pgoff_start, pgoff_end, 0);
+	write_debugfs(PATH_FMT, testfile, pgoff_start, pgoff_end, order);
+
+	/* check file content after split */
+	num_read = lseek(fd, 0, SEEK_SET);
+	if (num_read == -1) {
+		ksft_perror("Cannot lseek file");
+		goto cleanup;
+	}
 
+	num_read = read(fd, file_buf, num_written);
+	if (num_read < 1 || strncmp(file_buf, tmpfs_loc, num_read)) {
+		ksft_print_msg("File content changed, origin: %s, now: %s\n", tmpfs_loc, file_buf);
+		goto cleanup;
+	}
+
+	close(fd);
 	status = unlink(testfile);
 	if (status) {
 		ksft_perror("Cannot remove testing file");
@@ -520,7 +535,7 @@ int main(int argc, char **argv)
 	if (argc > 1)
 		optional_xfs_path = argv[1];
 
-	ksft_set_plan(1+8+2+9);
+	ksft_set_plan(1+8+1+9+9);
 
 	pagesize = getpagesize();
 	pageshift = ffs(pagesize) - 1;
@@ -537,7 +552,8 @@ int main(int argc, char **argv)
 			split_pmd_thp_to_order(i);
 
 	split_pte_mapped_thp();
-	split_file_backed_thp();
+	for (i = 0; i < 9; i++)
+		split_file_backed_thp(i);
 
 	created_tmp = prepare_thp_fs(optional_xfs_path, fs_loc_template,
 			&fs_loc);
-- 
2.45.2


