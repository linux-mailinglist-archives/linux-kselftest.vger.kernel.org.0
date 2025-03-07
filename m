Return-Path: <linux-kselftest+bounces-28516-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD42A56F64
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 18:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D57F3A13F0
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 17:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02E424DFFC;
	Fri,  7 Mar 2025 17:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QQqJuUuD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45C324C090;
	Fri,  7 Mar 2025 17:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741369234; cv=fail; b=Aq1V1FYEcWdJOUvPNJ3MFmnUr5uV8puKujP8PKvRvwkLcyCyfjEx926QgWcmFWrQIGvBmzFLrhFL9USB5rlLk1S1CXzKNnzD8KWev21ISpNnJTDTI6mUO81L/xoYA2AYyGa1Tr9iouw3oATMp68CnswcxhzG72jjm0KKTHQ5sIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741369234; c=relaxed/simple;
	bh=jYs708DdXKQyS5N94usQ+368uwc0DMTFKuT7/7FErrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LZHxh/AkJ3tvL8K+Zfbm5P55L8NGZiH1dOQxfFWkDkksQNG8uyPf93LnG0wwey5XuP/e7QnVLISe8ESpxoFk5fG2AVLALZjAi9PSe79vCXbwBciEjDsOk8M5Yzo7pZp7rpenx3sLdFAofBJY0ZsLEwRHUVe+1KZfmtMk8bGIrxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QQqJuUuD; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=im/YBZmNMhWo93cPNyxZAmMq9KIc710mpX+gK9blfKbPn53j6PCP0VvZGuk7u97nHU/11AwLtPtvzUs8oqOv/ffzT7hVZ62bfrrfgtJ6S1qHk2eihwUfRvFl3pzeEDyiTStD59sTGPih4WozXYOsMzKMgbEkRL3329cfOLdFprKSrr8/9uzb8soWuSQ9gkZJA91kHf7lGb90RtgGejLtMrLq62m9Vd6CdOpgzCGVGaPWi4PWCeahyl/pkvDq2Iie4cCqMVButrvjUEtZhefvael9ERHMjuc5dHGoU22FG9MgvAcQWRlBvZdJUwuVy3mvWrn/OtQRiD1DDNA+We2nnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EU/UsANrLIuJHJQZyVRl3KO3Nn3lqvBBpTugjGoZsIE=;
 b=qDEbC9MF/p0srvPjRW5XGgncOSl7880FJ7jWV4GxWgBUjR4yBG/Uy1a5fpTyuuJFY88tXlg14n33R/t2O4DpLZbiwnFmgf7L6pG8GcHYWDxDJYS7snqO0wpRu+mcL0b9u/OJrPwuod+sDDLwPJ4l2Fudvy0wSxgONEpw7b/xFWpZ3c3CAUuD/a8Wdf1aMBu+sYzivE7jkGr64UaSXF9lBHqwBUbXg7Qp6kfoVUU5h1ARq9Unvvoonx4hUKQ63GxJjFZHND6ul/9SnKtw4ycaWUuZrSZhRHPBwoW4lKZ+T9GgV/iJsVojDhdJFy8Sj1cU2WhR+tEsmAJtIvtdA/DFFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EU/UsANrLIuJHJQZyVRl3KO3Nn3lqvBBpTugjGoZsIE=;
 b=QQqJuUuDaAc60gak+anhdN539mruKXcuW+bdlx8519u3zOL1onw6o1cLmpmYsR9eBQA8OwMYKjYoSv2jfhl77DDudcADy3T5MMNIDo9HYvPF+/TRZTw3EQRURaXm8Vf1y2FcdLO44HmC5g4NeNdoKNg0WOVoZ+Hn6bMPO7fG1Mth1PuwjJoFB6YjyZuqD2UsW6zrzSqpv4qod+9MNCOQXi9O+g6zPqVusLauE6x+vsPdEMDe8JAtQ8y/U3lbsyKCBl58pAa4qPPjpKzSJOlz++//ucRMhbjkYGQvuKBAz6qovlzMJo6nUTTYFrUHR0tkOqsgQcVcwmchnmuoa1kNQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 LV2PR12MB6014.namprd12.prod.outlook.com (2603:10b6:408:170::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 17:40:19 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8511.020; Fri, 7 Mar 2025
 17:40:19 +0000
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
Subject: [PATCH v10 8/8] selftests/mm: add tests for folio_split(), buddy allocator like split
Date: Fri,  7 Mar 2025 12:40:01 -0500
Message-ID: <20250307174001.242794-9-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250307174001.242794-1-ziy@nvidia.com>
References: <20250307174001.242794-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0127.namprd03.prod.outlook.com
 (2603:10b6:208:32e::12) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|LV2PR12MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b1ec0c4-8235-476d-7c8a-08dd5d9f2118
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gBsVQo0vJBwP6WM85h9zTOVMLG+dB9y4Q9ABNWmZL9MmK+NTxKoQWU3D0vho?=
 =?us-ascii?Q?EDw6oNuX5pcgA8h8M8HHDQx76WSXy6YS69NowB8kKpZ8y8ZpXBnaqyKzsfzF?=
 =?us-ascii?Q?Pk/Wjip6WJKkOy3wMoXbkpUn786P3Hw93lN8hb1d4WwxZODtQaZDjv5tiTU6?=
 =?us-ascii?Q?7oKaJepaZRiS0hPybwraYj9P9Aycv5vxB6kZI69Ph+u1nGr40tGkaF9sW75Y?=
 =?us-ascii?Q?XSdxETRKd/8S19uSOoe56pP4L7gJej8SlEmdWi5NohyeG22f5Nvo9UcyuCP4?=
 =?us-ascii?Q?DPg6gSxan4zak7XXkXyGyyAUXgno360g4fr0nmVliG+TrJIrJZ1LG4p8On4F?=
 =?us-ascii?Q?jIeU80Up8v9q2Uh7fK00snDirVGUmiiiIJVJTa/gZxPCHLCY9OGaKJsI2gQ6?=
 =?us-ascii?Q?peqopLCGxYnsd/2YSjLd5GKJiWzdhHO/IRJuFh/P5aJAsf0TklJuDyvxHxbV?=
 =?us-ascii?Q?6hUmS17r2uv4BnOcUsrrThtlyaXPJcMIycGLP7pWEkOgk2o38iKpN7blmJ+8?=
 =?us-ascii?Q?fMIouZDWYGeqfENu0+vTkcD4YJjOxY9+JpPAKlB/9oHGLFCTV5cYS2c/oZ93?=
 =?us-ascii?Q?y9d22xAvLCqGhElYHvNp+OwdokVGt4RNqhXAObUUxSHA+lMzwWyRXlm0qW+7?=
 =?us-ascii?Q?EoC8WyrhM79E4KLphYYPos7s9OVao5YwVITQ/RYadss9ra43hi0K4SjVMRS1?=
 =?us-ascii?Q?FGtwYiuQR3BX49gqZd3APVQVnBMxihOi84Uv/TBZ73zF6mSScfcN4yC+nkgU?=
 =?us-ascii?Q?AmiCPm6nrtIjbXa0t1FwsFyk9JLJblpjTdP14qvcD7GFqiNGv0bghC/4hwIw?=
 =?us-ascii?Q?GLpvLI1B2obAg8vQI0AARJIh/gAt8R368/IhUyi29qjs/V1cH/wEZ+b9icCC?=
 =?us-ascii?Q?mi8o5+SKD5UfPibVc5r5srfMtVobKq0VTu0orwc7VUnU5y3UE3O7Vrk3iJVZ?=
 =?us-ascii?Q?qm7wQDfG8AFbo/gZttRkwtvhax1MH83gv9S5cYvMmkwJziorAIJ0SmCtEu6g?=
 =?us-ascii?Q?WKWDrWkBRnSi/onjL21uMqa4bIIEPG7anLf/D8njN1VzpmP67TF11Qry3x8X?=
 =?us-ascii?Q?6qBLNPfbq8JNMx1CBOLHXLy0ELsx5r0zJbOsjp2GfVYgooYosP/h5B873ORu?=
 =?us-ascii?Q?sg6OB2p4EF0IHUro3NwDFzO5rWccidOdF6oV3JRY4d8DX0gpms2OT4H71x5w?=
 =?us-ascii?Q?+/4NLZsUMRuK1MP6H8AGnfke2OrUqBijwkyoKVZbdFNMOiQaySfveBjzFc0X?=
 =?us-ascii?Q?+0b1W/ekTl3S49uY+0axegsiYsPJH87KVasF+pD/W1r0L+pXpQvthvC+Gi3b?=
 =?us-ascii?Q?V0AtPMePVKMfAdZKoXBkGraL2LgoWb1WcIZ0sHRyo1xjV/X1DBF74h9NaAb2?=
 =?us-ascii?Q?DiH4sEfEaPXM75BoYNL0L+QfgnwZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mr04GzhqoY+C1koUb0QHWSny4KwHQ9uVVlqLOXuXr6eyS7zwDt6020H4XUY2?=
 =?us-ascii?Q?NFaBhYuyBN5oa/lXTWwT1LMW4CDOrm3gORKJNYc97L02LOrJDqcVpmoeTp3r?=
 =?us-ascii?Q?2if/bQSQMKjpD/1ky6WUG5TJgh5q/r2TCDX203aueW8m3LAoxdjpPsTEoZ+Z?=
 =?us-ascii?Q?2bFXqh+XxuA2E4edQPZOyP+3O4/wGElmlCS9IlIHfJ0nhTDJRhkdmiUSw3n6?=
 =?us-ascii?Q?wOhkrIa19jfHriBLlLMDcYLKZdc5n7nbZnPbxkuGPKXbK22e9bk1DWS5UIox?=
 =?us-ascii?Q?BTz9BiUOb4SVH39TSWuS/dIT+PF3L4YWRH74mJbTmNi4Fxatoqq2b6bvyfQJ?=
 =?us-ascii?Q?/AjFRsTnPpL5QEKfScKWtQh0y76sqC2SzxpzE07maimQNVQ1yWvmSoBDSqbL?=
 =?us-ascii?Q?a0EFl3drHxLMfPBDoSMXePiyZpGHDkUOw1QkIbGu/OY3XIWmCDR5ggKdoKUO?=
 =?us-ascii?Q?NIwS9V8rgcEbVkaDz4xisqDqmFkFhhSTaenbVG0o9IEXjIR2x59XnFDZRDAn?=
 =?us-ascii?Q?TGKtzdF7CZRT/kdZISagcwTMcLzVYwV6MOOMPueFfPEfMFgZW2Q5Ey9KyONl?=
 =?us-ascii?Q?HteiIRDHyKoGWRaQzie7AOQJfz4ZgH5Yenje0NtsDJ+F770MnZMf6ZrzivaX?=
 =?us-ascii?Q?UdQOqNvo8adA181ceVdyltkItely7f5xsEUczjsnLhIIqJXY3WeI6rdUWyEt?=
 =?us-ascii?Q?38VLkLuPZxbkr3J9Ur0GAa8jxty5bxvwlbjeItplYIasqfLAB4IBwiBUQewa?=
 =?us-ascii?Q?ZuA+XwcvkVpwAuDj5vlFZhb0FvlFWS+Yb9sF6MTRw5UvvypY5VyoULoOxswL?=
 =?us-ascii?Q?hLQEe6AB7WQbJqwO303/oQNed+I60gmjWBGInaqON5bYQD3RgeaM9tqT1YiC?=
 =?us-ascii?Q?9MUhAvTLQHSQFZC9x2wo8yF6cvwT6LAlvvQwzDEEG99+2bl2PyJJrTQcMUHE?=
 =?us-ascii?Q?oZEL6zm3oYsWZM3t8LdA3uR3p9WQeI4aXa7mafnOvm1gFztWsB2zmOB5pp7x?=
 =?us-ascii?Q?y8dPoWUOCdzURA99gStr8lch/Q74n/YhbTAQXQ7lsmFz1kb1Dc2tjcULRl1Z?=
 =?us-ascii?Q?6zIqmSWTyEsP8KlK/Np7EFFCvtVx8zFQFSmfeDdk8RyTXxed9f1jcHqr1sIE?=
 =?us-ascii?Q?bhfe9wJVGv/Z1Ah2QeUeEkRJrmcM/qQT69FOd6YqDgEKqGkd68tFJIzaqFdc?=
 =?us-ascii?Q?Q8aUYJEEOHsN85UJawxqQYyCl6WzLdxOmdWkH2h8YWN74Pfhxs5/aKVSVq50?=
 =?us-ascii?Q?4dUl02+16AFah6t3L1SS0tu2JNbvfstO8SfjfO24Ee19+FAJivE/AAKRW7di?=
 =?us-ascii?Q?PNF8wtNC1qzH5amKMLoADgpCJBbINXoMlTW64zGyKKZWIKDgI9NRpDgA6toP?=
 =?us-ascii?Q?3u00JdUHKt6nxio6yZnKQuHU6gp4gYBrsb5JGRZmB5v4UaGRktUlDaH3Ms5L?=
 =?us-ascii?Q?cSFhfhLtEq5fTtmNrOZc+ikbJJEmc6JGlth+YlAkj8b04zEPhRLICHHtWcZd?=
 =?us-ascii?Q?+Fq4uCLyQ1MxVEArTCNyWx/DEexXI+XA6qKdLYXq3ZQNExcTNh+Xr1ZzOxvB?=
 =?us-ascii?Q?EIK7n9xoirWeFcZmBoDEHgfh7xzOle9wN35l8L8W?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1ec0c4-8235-476d-7c8a-08dd5d9f2118
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 17:40:19.4359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W+2Ndelv22zYigcxYPvj5DilNrWhQy4CAnU8GMT1MGsFeFkyYovsKdKAPX9hA3zk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6014

It splits page cache folios to orders from 0 to 8 at different in-folio
offset.

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
 .../selftests/mm/split_huge_page_test.c       | 34 +++++++++++++++----
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index e0304046b1a0..719c5e2a6624 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -14,6 +14,7 @@
 #include <fcntl.h>
 #include <sys/mman.h>
 #include <sys/mount.h>
+#include <sys/param.h>
 #include <malloc.h>
 #include <stdbool.h>
 #include <time.h>
@@ -456,7 +457,8 @@ int create_pagecache_thp_and_fd(const char *testfile, size_t fd_size, int *fd,
 	return -1;
 }
 
-void split_thp_in_pagecache_to_order(size_t fd_size, int order, const char *fs_loc)
+void split_thp_in_pagecache_to_order_at(size_t fd_size, const char *fs_loc,
+		int order, int offset)
 {
 	int fd;
 	char *addr;
@@ -474,7 +476,12 @@ void split_thp_in_pagecache_to_order(size_t fd_size, int order, const char *fs_l
 		return;
 	err = 0;
 
-	write_debugfs(PID_FMT, getpid(), (uint64_t)addr, (uint64_t)addr + fd_size, order);
+	if (offset == -1)
+		write_debugfs(PID_FMT, getpid(), (uint64_t)addr,
+			      (uint64_t)addr + fd_size, order);
+	else
+		write_debugfs(PID_FMT, getpid(), (uint64_t)addr,
+			      (uint64_t)addr + fd_size, order, offset);
 
 	for (i = 0; i < fd_size; i++)
 		if (*(addr + i) != (char)i) {
@@ -493,9 +500,15 @@ void split_thp_in_pagecache_to_order(size_t fd_size, int order, const char *fs_l
 	munmap(addr, fd_size);
 	close(fd);
 	unlink(testfile);
-	if (err)
-		ksft_exit_fail_msg("Split PMD-mapped pagecache folio to order %d failed\n", order);
-	ksft_test_result_pass("Split PMD-mapped pagecache folio to order %d passed\n", order);
+	if (offset == -1) {
+		if (err)
+			ksft_exit_fail_msg("Split PMD-mapped pagecache folio to order %d failed\n", order);
+		ksft_test_result_pass("Split PMD-mapped pagecache folio to order %d passed\n", order);
+	} else {
+		if (err)
+			ksft_exit_fail_msg("Split PMD-mapped pagecache folio to order %d at in-folio offset %d failed\n", order, offset);
+		ksft_test_result_pass("Split PMD-mapped pagecache folio to order %d at in-folio offset %d passed\n", order, offset);
+	}
 }
 
 int main(int argc, char **argv)
@@ -506,6 +519,7 @@ int main(int argc, char **argv)
 	char fs_loc_template[] = "/tmp/thp_fs_XXXXXX";
 	const char *fs_loc;
 	bool created_tmp;
+	int offset;
 
 	ksft_print_header();
 
@@ -517,7 +531,7 @@ int main(int argc, char **argv)
 	if (argc > 1)
 		optional_xfs_path = argv[1];
 
-	ksft_set_plan(1+8+1+9+9);
+	ksft_set_plan(1+8+1+9+9+8*4+2);
 
 	pagesize = getpagesize();
 	pageshift = ffs(pagesize) - 1;
@@ -540,7 +554,13 @@ int main(int argc, char **argv)
 	created_tmp = prepare_thp_fs(optional_xfs_path, fs_loc_template,
 			&fs_loc);
 	for (i = 8; i >= 0; i--)
-		split_thp_in_pagecache_to_order(fd_size, i, fs_loc);
+		split_thp_in_pagecache_to_order_at(fd_size, fs_loc, i, -1);
+
+	for (i = 0; i < 9; i++)
+		for (offset = 0;
+		     offset < pmd_pagesize / pagesize;
+		     offset += MAX(pmd_pagesize / pagesize / 4, 1 << i))
+			split_thp_in_pagecache_to_order_at(fd_size, fs_loc, i, offset);
 	cleanup_thp_fs(fs_loc, created_tmp);
 
 	ksft_finished();
-- 
2.47.2


