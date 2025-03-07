Return-Path: <linux-kselftest+bounces-28514-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75872A56F5D
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 18:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 693AF7AB2B8
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 17:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562EA24A062;
	Fri,  7 Mar 2025 17:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ex8VJ9xi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA73248874;
	Fri,  7 Mar 2025 17:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741369230; cv=fail; b=XzTgl7DTXRoIgg5oigswnCEEwpP0zCzjTSVGYxWrPQAKI5rqU6LDRn9YBc5tT284L53VxTIpyG7VB68ed4fK0/OoVuQQkRqcDnYNQCistnGPldUiJwwFsz1zDE140DMFV0zYtDSvH/ZyyVL9X2ooLcck6AJQHe3EcHkMR7dt9Y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741369230; c=relaxed/simple;
	bh=+HZl73lEwqnppHpoETmqp0jWraUux8I0jsjhfmh4Qiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=epT3cqYBf/zz+Q9jUyArq+TtUnPktND/+W4b22qrO86GI5s61FTbzWHNfI6rq+9NJllqFSy2MQ6HwWTYZcr6iuXnIKC50qhb5TGwYnTzOQlJxXdIbBXkv1c0N3T17d7LJ+Q9tbox6BzbjyN4VwDxWmv8dyYltkCHxAAuHckfvpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ex8VJ9xi; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vssDaFEdF8cq2Nbz+xc46Jm6SyqO3X58nR2rNqWjoEoHzRLHj/FWS1v4L/inuKDEYTDuTufoHRRPh4ilzlt/k1Bf906ktdNt3kYrvp379WP0tKUwVVv6o7QzLBDtGdv7+Yr6f/cILBzE8RE6+h2Hizm9/d4+qXjjyX3wxDjPrpMCrice8gYU7IM5MHjbuP7eIetRyvoNt88/F/cBRkhGTVwHBOXrkVGQvEOMb+4rZFW889hW6jRu0h16pmwszQALE+PnEQ7mLPMG0K+OhgoGvpToFCwGGMGXptJduXaLT6jcz9UcYqB79wZKIPCD2ofIrGW0bA2FlWIg1TyWShcNmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZgrkPhISa1K9KKRxthtvg4n6DwyTM7a7N/h+qLHQZpA=;
 b=DCuncu7XtU71ep/hjYrfj4+yITHz0W3QWv086x7HZLks9HARJ5GFpUJJfSLLyzhqFyh1xCqngxnETV4AxDT48FQDtjidKybXGIQ1FAzOhDQ0y3NJaRRmRT+BQQl56ZmwTQySiX2aPR0/6n0lcSNHRZhTw2CYq+D3wTsy04wD0p5ff17qwBSuGeLFNGxBbrduYAcz307nIUM/+JMJT7BUHbF4291EsnPcAly6d3qCxDWx05aVTPRp0yYTRvuevmVsDP0oIJXDvMTNjOGBav68joPZd2s0uQxwIeVlrac8mvYvStsQeh2JygOHmdlTF1brEKe7zTIZ8nLpTCoLoFxFvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgrkPhISa1K9KKRxthtvg4n6DwyTM7a7N/h+qLHQZpA=;
 b=Ex8VJ9xio9rZcFvxwgFFCBu3zRd5ByHYRPB9P2favvEwIERGPU44fc5uXLgmB54swIi1z0/87r5D8tg1G99QQli2xZpuLMn2Uesft4s774c8evVu+3KDFg8jdXFSmm1c9UE5Hz5WtN01gcDS/Z1qhIpeyassJ1NKlV5VgkVJrztGv6uOTu6pQu/DnrloS1AS/zmil3S5nI57yTmByxrDqy6A3/UHwi0Ui/5/TZPy+XpR0EVVYtFPEHoxkEe/6e+Anc39wtWse+n7iEyFNKa44VIJz5LycBZso+0hBfbcI3kLEe8pd6BjEOWcRJWTqyNUhbAFkKswUyZC2cMN9RidgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 LV2PR12MB6014.namprd12.prod.outlook.com (2603:10b6:408:170::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 17:40:16 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8511.020; Fri, 7 Mar 2025
 17:40:16 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Yu Zhao <yuzhao@google.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v10 6/8] mm/huge_memory: add folio_split() to debugfs testing interface
Date: Fri,  7 Mar 2025 12:39:59 -0500
Message-ID: <20250307174001.242794-7-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250307174001.242794-1-ziy@nvidia.com>
References: <20250307174001.242794-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0083.namprd03.prod.outlook.com
 (2603:10b6:408:fc::28) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|LV2PR12MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c38b2aa-87a7-4c25-8960-08dd5d9f1f2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9BZvG6fv2I0H1Ly8uKfQlrtSxH96CIYKxXRQ/EQHfkI3iCXZBZ96J8z/IQJT?=
 =?us-ascii?Q?VflCjlKnOg64jUkRvWClkyTEzYrTeB/rPbpNOJw8/rmUW2ScRGp83xJ2t3vJ?=
 =?us-ascii?Q?bTxoMzyxs4lBzbJk9kiE1RxVynVdWA9N8InrXPh7/Y9rOb5V8MSr8CuAkKo+?=
 =?us-ascii?Q?xuGjk+4Z8tL5yNkXB3mnMzj36Oy82qSKJFe10yc+2d58vAdMzORlyUA9RXfe?=
 =?us-ascii?Q?dAi38X2gCqJ4vhx20O5VQVBnmtT3T0yn/FnBzai0hFkiZCxEX3tEH59z3RZU?=
 =?us-ascii?Q?mHkKeuvsL6GiZUX8lTLwtZYQN8Oo6YMYkqA4tbQl3xx7qsxQmCvgFI2DxXd9?=
 =?us-ascii?Q?xQ4xANTaEY7pscdeRuUfhYNWesrvt/P2uFOPi4BKumKB7+9l4itOuNg7/tpO?=
 =?us-ascii?Q?gfsS7A0AsNArjwUMgyhXA26ElXprvvOX09Tck0smxFy+xm1tuBlvOB6SuUBm?=
 =?us-ascii?Q?IBuTJc9BXJWpSIqrYEQohiqaxM6NFUlBiSTNzJt/PzUUZHBTOJNx1o6+rdFV?=
 =?us-ascii?Q?ADQiL/36wJNwrCqUxisNDz8ZyNRM4nme5ffxGvp2VlgukHmBIvg2Hr21l/T+?=
 =?us-ascii?Q?flhod1h9IKXRHQOGtMOWTidHyDWc4Mrn8wTqqKTp6WGTA5l1Tc8rfWtazHrc?=
 =?us-ascii?Q?hBt6kTHgGqvRNgdxV59fmMBUNpsU2WWQ46eXix+idGTtkfXbNpJXrTIYdWem?=
 =?us-ascii?Q?52BIKBYDhgvcl28GX3fYXtyiJVoTujCX7scWI/+mw+Joe7/od7E1RWe8sRIO?=
 =?us-ascii?Q?3fJqY6DotlKNR5ZwWOADNuZCjAXTpvqf6iBrWKVd/PO/iY5tgCVVx9/y1CQJ?=
 =?us-ascii?Q?LNpywUOS1CEA+Eo/PpP/AwavGqpcRMWr2k5xN3PT38pcLLkrr25YVSOZqvs1?=
 =?us-ascii?Q?DLgzp7u2ZEkqnuJDv9LOQ+kNU5//r9+dQhV9wbvfBRJDjRZv+Q6EFIA0sy3z?=
 =?us-ascii?Q?0cihkIkPs4lMPPzMtyqZrNtcM9X3IcnQotPtXOJDiQaa2R4vZvEiA2rwicO0?=
 =?us-ascii?Q?klfaRdXUcapE/IwUdLq4aqoQkmLVKLGLxbQim+Ofd2MaIgu/jXk45SAdzBzG?=
 =?us-ascii?Q?0Ntfti+C8X9QPy/C50Ha88wNuXWCrqiazyyVDkv39ZV9BneeDe1pu1g8tXiM?=
 =?us-ascii?Q?AnBn1Em2j96schB2xqLx+qCD8rCbF/dRpUHlmfCsdz7uGqbRRkWvT0DQ2lIW?=
 =?us-ascii?Q?KGSYtKTpQ+BV7eRJOeHuHgPvbuGd4m5M8iBgfHLezxd6X4+OQBjV13f7SiWT?=
 =?us-ascii?Q?1+jkm7MKkgaR/iRGXrolE8g9sK0JdHr0HPTrDIG751MYN+mh/CCBv0/hDuKG?=
 =?us-ascii?Q?MRrbXqossHc25RGLnws58jD+Y8fmhyVey7LS/IBGs/DW7g1/xcxoICejueXF?=
 =?us-ascii?Q?BR97JtZhn2qWxTOTy0ZHNK1i6htN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NZ83g5cOkAxqvG4o5EHWcN6lVrk65HoWw80TgsohhUETCQklAzt65tIrMTdM?=
 =?us-ascii?Q?9aWxsC6zI/6qMu2Utx/rQcqsqwMhySAteNNaux8QD9/+GXIh3sItY8emQ2QW?=
 =?us-ascii?Q?UldU9XWD1STJ1kYrHv/vy808+RWU1yYv6ge+T6a9RRAJSOQx/LDS9kM79G4C?=
 =?us-ascii?Q?Obo0svZ/Mw8u2rkNGEDlmkMvy+HDCwynqgxqZgaKTjjkmkHTFUKhvgquHr2I?=
 =?us-ascii?Q?7pjXQiP0eBCCkZuabFABwrTAJzU15ANfBUc/njkAbPkQN+H3q5473aeL6Dis?=
 =?us-ascii?Q?Mztkfqjl8NtL4F1QygF6ywHvSq8X5dXXjG2prG6xzQeQsA4pWEeRkTclk7kt?=
 =?us-ascii?Q?y+OTJ1kkYb5jyoifpqmBAa6evCm+RFbh/vfd68vi/m3PPMV7VQTdwCVGepu6?=
 =?us-ascii?Q?qMT8m5/0MtQkn4F8QFlUBi5OTEdQC1FuzFvynCcS85NPFmLp1V3rkxTaAhXy?=
 =?us-ascii?Q?74N4wl8QoUw3AM/KIdzw9wpUsHcNRVXUf/xPhxyJ1NVIa2nnNMn7Q3KfYlrC?=
 =?us-ascii?Q?KPcSzeKGY1bqeRLNm+OHmfNQVT9W0YU0L6jdS4TkRpbCFkRVFKzt63G2CVlh?=
 =?us-ascii?Q?2vjvHtgCOuxtNWZ91r/zPrhDZBnsVss/82IfeLcvW1yMGY0Zhn4WcMZKRXiN?=
 =?us-ascii?Q?LPryBtdWPCjq+1XxsIMy1nLVrSZeywt+pfcjlbHBKbuTjYBmEnFIiIojAzw3?=
 =?us-ascii?Q?ChC1c0KWR0+aTqplb5gBvKlHuhhmUEqnFe59YUVOLmNeyXL3YWzyGvvN6B7X?=
 =?us-ascii?Q?gBGRYfI7hYdcmgU62WCyzFYk7eEkqY3MdwjuiI06mICbgjdqHbRGiVBrBfNp?=
 =?us-ascii?Q?Z7r7h+bAYeoTN9sLbjn0YhZWfVcz7VDZn9g09LTogM6sjm3ox1DcOgpRFF9l?=
 =?us-ascii?Q?gDoM8xIqR/m20Tx+qno6nLizwyI3U+F7SSKbyY4jOY5v5N6qJyLdqFNrgLHf?=
 =?us-ascii?Q?OEPYLAD3b6tGqDZFD0+nAxpbHlHe5ndYzn9eeGBTen/mOvDDbm6/lnAMuhBL?=
 =?us-ascii?Q?fT2xmTyF0ab3XjIsXhaGVrKOBHKhjsJ9zCI1TeY++Dy4LekMY0h3Qj3ZRmxi?=
 =?us-ascii?Q?rAq6FMJr9I2UDxBRE+GrHpQybFbnTBjSLIccjuOCAR4TN+Ik6hGOeG2a6cVi?=
 =?us-ascii?Q?A2gvP6GoFkUlPFFv72UoTmt/IP9QEl+0Kj659oHWle+V5pDgZPo9iXMEiyVC?=
 =?us-ascii?Q?27eGKvZ2ibLFWXADGgAtLHPIHA3HBv3gx5ZgJ7N2fgADCSEVQewn35Ozq3lf?=
 =?us-ascii?Q?ytEw4X8J93fGw1PAeqkCVg88ErogTkiGZyOh60pFkApLm1h2Bu6m9f3Q9zMB?=
 =?us-ascii?Q?gqjqkql7EwRlAJbLPPa/x98BKV0oV172C8n+0W03LekzDpLn+rW/OtCkhqbd?=
 =?us-ascii?Q?fhNyGr+EOtLcW+7wsFvzeoic1cyHgkSiZi8obj20z5+3YqJWQwBEDv54Q8Vd?=
 =?us-ascii?Q?llZJsEfK06zlpmAjW3Va40fhd9N5A2LgkD4oeJ6UBYsNqBYfMHJP+Bm8yk49?=
 =?us-ascii?Q?+ABr3bz9YUl6W3yD9lyipfHKhq4gh9QiuBfHNexqLN7gM1791yXQhcZxJkXT?=
 =?us-ascii?Q?UpqvR6SRCR70JE7bzMOcZHJK6yJ8WInG5g4qdy64?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c38b2aa-87a7-4c25-8960-08dd5d9f1f2b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 17:40:16.1870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8rWF7XfKpjp3ysjCk59kVWJQlD7Cc7TGRtXpfl0pVJUF4Er0irGitb6FJkmIUPAh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6014

This allows to test folio_split() by specifying an additional in folio
page offset parameter to split_huge_page debugfs interface.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Kirill A. Shuemov <kirill.shutemov@linux.intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Yang Shi <yang@os.amperecomputing.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Kairui Song <kasong@tencent.com>
---
 mm/huge_memory.c | 47 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 6cc97d592797..d44b6d4b7f32 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4325,7 +4325,8 @@ static inline bool vma_not_suitable_for_thp_split(struct vm_area_struct *vma)
 }
 
 static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
-				unsigned long vaddr_end, unsigned int new_order)
+				unsigned long vaddr_end, unsigned int new_order,
+				long in_folio_offset)
 {
 	int ret = 0;
 	struct task_struct *task;
@@ -4409,8 +4410,16 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
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
 
@@ -4433,7 +4442,8 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 }
 
 static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
-				pgoff_t off_end, unsigned int new_order)
+				pgoff_t off_end, unsigned int new_order,
+				long in_folio_offset)
 {
 	struct filename *file;
 	struct file *candidate;
@@ -4482,8 +4492,15 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
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
@@ -4516,6 +4533,7 @@ static ssize_t split_huge_pages_write(struct file *file, const char __user *buf,
 	int pid;
 	unsigned long vaddr_start, vaddr_end;
 	unsigned int new_order = 0;
+	long in_folio_offset = -1;
 
 	ret = mutex_lock_interruptible(&split_debug_mutex);
 	if (ret)
@@ -4544,30 +4562,33 @@ static ssize_t split_huge_pages_write(struct file *file, const char __user *buf,
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


