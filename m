Return-Path: <linux-kselftest+bounces-25792-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C36C0A28298
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 04:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F523188663F
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 03:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF7C21D5A1;
	Wed,  5 Feb 2025 03:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qzaNC6SN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2077.outbound.protection.outlook.com [40.107.212.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9406721D587;
	Wed,  5 Feb 2025 03:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738725299; cv=fail; b=XfFJnyLNKQWy0PgwQA4jZMGHLH1UKjRmEUumWqBGcPwpnkFvwAPDJwQ6/OKk7okzayUUkjNggbOxjSZrZm3FAZEHxnsfQxgkk0paXDfMlPXWnsg+/nDYPtMr29ek3Ug+qBm6EsRX9X8cZo0Jhdi9d2/kicpyTMMrCCSH00qDyvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738725299; c=relaxed/simple;
	bh=siUAkUsrYmN0xTkGTYj67zOhBR+jzX37/9m2FaJA0aI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gaCv5NNh55TuLbzrn+KrcKG1MoDNSIsUOCobDOlPr34crpgMfiTDgtBmHViAwLANSFDl80PFBRo9YxhYS3r+jeBYapHXEfQgku2Pony0sOfsIYA8f3+1d70zuwuos1cFWBw/pDX8ogRgsBrNvcI0eSLEpvvKGD2ScIcWJT84PvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qzaNC6SN; arc=fail smtp.client-ip=40.107.212.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ULZkSTDI1Jmvq4Mlx5/YW+lxnTJKXcwmWndf0xhJAd4FbPitJ1mesS4eq2WPFTfHJzbi8E5mQZrusblX0NEg6KmAEdCxmL6DMgcvdv8Q8xsRbXgu2zVi1KlOiv3R3RVjpMk3gxFkqQPSz1lF0g+u6Ms9Y8prh0KFeiQ0LfBu6VbFSBSEJ30q2taYnIPG2aH2reJQmRPFwhM3rirm7drZZs/qP64XEgpH+akhEdFGROApgm/iOwdb3oHbcpIPUxPR4zFOyv4fR0PJtDrG3KGb+76L6NuNE9olTmrBn+y9ZmHo5FJNhdCGu3etkv2sKxNbw7PG5s6QQHzayIked7/Qrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxUrFoVdwqE7hmVfm5+m5yVYkjr3vlGolGIklz7tl8A=;
 b=JFliUcM6vMDCaeAjuneSerrZDFnCxIVwj3rDBVQSDjO/xgVmT3/uLdRaVlqGCBylTaOgV7i65SNNbyFGzPO/eq/FFR+7LYTFnAGKg7HZfvDEfs86x5xFAM9DWava8NewS5+7uZQP6FSYo69748IPbV95duVzHzE5Y+za0JfSA8xChhJLb7gPI7x08Slss24bcHlFahfV5olEnliPQxTt4H6G4SGZ742ZkYn21cCuafuhfjDtbUhq9TLCYCSdho4LqPWZrrUChowrhS6vPgAIdkAOutkHv9CjyKKVZ9Z1eTatzoJ9fCib6CgEZoaKUDBCQZ7OO15b3XTJehlEVJqbGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxUrFoVdwqE7hmVfm5+m5yVYkjr3vlGolGIklz7tl8A=;
 b=qzaNC6SNS4gq9+klUs9yG050FOU3veBr08UY4MJMa8+3tWaeZBAx/MpAlOJanX5DOa+4lQUab8f+1//5MGrHMRnXg6hwQ98M+DQVtYnbnYMI8Tv6MPa7rgfqyJ8zwahH3E+P7xY3h0HZ05kgGXvSNBjSuCAutVbTb4KrRBovao0DvI+VYVzly8ZM7rBbQuMaGoi/dzk1kc+35wnWySPbDwGXSs+voKyEJjRWj8nB6Txx98nINcAieMvB+x2oImD6smhXWq8G50Qp2WegjRXxURfG499t3gYasPgfsl3G5rCXT0GLOWuPRpDrDuodZBe4quAqV4w93LmifzXWIk88og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MW6PR12MB8865.namprd12.prod.outlook.com (2603:10b6:303:23b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 03:14:44 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 03:14:44 +0000
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
Subject: [PATCH v6 7/7] selftests/mm: add tests for folio_split(), buddy allocator like split.
Date: Tue,  4 Feb 2025 22:14:17 -0500
Message-ID: <20250205031417.1771278-8-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250205031417.1771278-1-ziy@nvidia.com>
References: <20250205031417.1771278-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0120.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::35) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MW6PR12MB8865:EE_
X-MS-Office365-Filtering-Correlation-Id: ed24231e-e2cd-4927-a02e-08dd45933d1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HVycuM3lpXf+iC4Z3Xceq4CfuhpOxomVLeeDEf59GKjabDjuRv3AFxH8iL4I?=
 =?us-ascii?Q?OJLld48iCrlzLP0/QqOaJD4J4aRGCNj8vuZTmkLfGddgPHZRH94BPrDTzylF?=
 =?us-ascii?Q?mZminvyTeo3e8XyrKxhMjdWsFfhsiwKvgvJSVsrks/VudqUGN+Obe1W1+VSX?=
 =?us-ascii?Q?L8R8ELHU6QbISeyHW1uT+Tt8ORq+Pd7Z49xO7egawNqV4h7goxuevwK0ULfX?=
 =?us-ascii?Q?AvcIAp81gtU5t9SUPFJW+OytcpHe+B/H4NtTWl6QnlLd7hJNsZlXXnD5BarE?=
 =?us-ascii?Q?KIA+zK/5clSZ3jK2/TrIm1t0ptZsIEawuCGMQnusiPyDap8u1aYBkDNgLASh?=
 =?us-ascii?Q?yG4NoIvA2TTIDwjLM92RtFUNBV1OUGoE4LDQwYyKk9/W92/xxqvwLzQWnE32?=
 =?us-ascii?Q?zmI5NbSDguomTUlQLeNZfyklSdzNUMgwLV0dZGFtyI0SRZ0suvWIB83ojy65?=
 =?us-ascii?Q?4b3zsFKudoPQdmaUSs/qLmQ7PV2OEwbAgkCL6b7jXb7SwiiDDAvzykLvSjeO?=
 =?us-ascii?Q?JwRrv0dUQF+mjUBqj8ADxWrPe5zUmh7TJilQguvJKeOg4vh9Ogq3JmKNzd4W?=
 =?us-ascii?Q?vyZNWiCU08KWGaObVqEcvM0annCgueG7bfZ6LuAFaaR/MpjT6JS86Z5S2OrU?=
 =?us-ascii?Q?tExRMenMS7w1KKoRXrpYSxw4EQ/cxU4KWx+parD1tV/MsHZvQTDQNdR2ZJy1?=
 =?us-ascii?Q?02GvGc4xmA9YbXCrTGFajWkTDnc961jnxb1/Cvwr0ZozUmM2yk778jFniTyE?=
 =?us-ascii?Q?PHd8+If1zGeeC+3mTBZKrJcZXUecav5iSyC7KuDkqxhGEfVELIiXjFJxTFBo?=
 =?us-ascii?Q?NLdQUg2F2y3HPeez6yxsS44s2zc72DyHKJGX+YwgoaE9TZjcWztnMl8w1lrt?=
 =?us-ascii?Q?RRrLyZZs7JVngV1iSxUoRSAgv3E4wAAm0eq6m1op0FTSlpjwlQ5iVB9AOzSl?=
 =?us-ascii?Q?w5rJTei7D1mWd8ux2ROfN+Ufc0qaYAPIiXHTyp9c8IYIeXs30sIPUI58nN7h?=
 =?us-ascii?Q?O58fyNP5VXHyuq8ob+0HeeXH7e0Fn+/Sd6v19s/SA3MI1WCBKsnFZcThVQal?=
 =?us-ascii?Q?Kp7QqqWgjUIoqKUJsRI9g6IAAuABc2VoB0XYGOJXtJUxp1fSfAW7mtbq+buL?=
 =?us-ascii?Q?2oWtFCfeawdaHqyYuxxQvuZVRBU9XGf1aAoElThSv387mlKugyAJKTMck6x8?=
 =?us-ascii?Q?f1rGfZ8y+TddNyu1kPBc79fSRkcmtwwgembFzqVQtgabQzvvOSr3hcxlF7aI?=
 =?us-ascii?Q?qJBAOo3YSLxKbR4wPh1jnt1NRiP+x4FF73jiHgtcg+pKVSMJOKhXdh41r6xR?=
 =?us-ascii?Q?btIh+5e/u+k59XwRRWxDzL/EMo1GzpMUHZgf6EQ6I8UoZd1aagCy5AVsnj+Q?=
 =?us-ascii?Q?vbw09aY2gN77OuyEO6w2tBHddzQE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3sT57NCMf5aKvJ9Xn05efc67wiDHQ/T/yKdAOgk+KhGGL6IXDyrYXNQYFxQu?=
 =?us-ascii?Q?5yot8rV1uf0p79E7ewPDQzIigemgnkyFLg5HPfscDLQkBcmlXkcCQf285mao?=
 =?us-ascii?Q?tWJRYBZ+OfnnRx5wbmfDD+xzVSUTJJjR/JFGp//FUW9x5iQ0RLqRah8PFcIc?=
 =?us-ascii?Q?J6NugCe3dCMcuZtdqabd01jHy63lHufBtLOa8D0ViGXCu+NSPbozHv+WlOT5?=
 =?us-ascii?Q?9ANrW0308gMJMXoInkeX0ZM3qCm417AB0Ec6know2d51wRSTI92q1TO8bp5D?=
 =?us-ascii?Q?T/pfTv082Dps89fcdaxJh0lYGN7ueQiMhYHYtoWl0+fgTLhBm8KcpwI/I36z?=
 =?us-ascii?Q?20GZeMV9B2EwSiCPDGXqJbt6Y7NS0kgTZ7GmuMZfwZ3vpq9zP72axO9pxobW?=
 =?us-ascii?Q?KZAjO+rM2MhUEPrxMXgpow11Z2E8xYKeh3fAZCy2Q7HPIOwmV74VEtD+7Ays?=
 =?us-ascii?Q?7Msru9zSDzqbmgFTGmOj1WuwI+eOP5GIJPnmS62JEWYidjXUidyMWHfk9Aiu?=
 =?us-ascii?Q?YlV3aXZM0CSQBP6652f9a6amoaT1GX6sjdBll8427gLmkmGVxgbNNrnnMfZN?=
 =?us-ascii?Q?NELTCJiCk3YXk2wtaMCTixchdtoRxf6oenMJMxN596BOOfNp9FpqwNjr0dNT?=
 =?us-ascii?Q?y4ct1gupvCHpiAIKaHpfV/a/EI3Lzq1GUyTdB5hCVMuaf/rflFL5+qEvj/4l?=
 =?us-ascii?Q?1FcwfW77VmWzzrWpelzB84bw+17bZgwyMOFr5AI2fqhCEnlq8/Z9bepyYFgv?=
 =?us-ascii?Q?InmQwHP8VrTn4QLSPs+/pVtHSbfD+s2JdQ0zazBccqCpvUkhYRMAMvDJccD7?=
 =?us-ascii?Q?6fFS1Sepspws2o38Yp4JI0Q1ygE7KC2kgQ1gq6vjm8Lh94672a4+N8YkWbZ+?=
 =?us-ascii?Q?7XtMCRkdXvNMOJkM1DPxEGjGfU/oSNcnS0XWq3Jzy3Ao1jt/rjSApNIV3R3Y?=
 =?us-ascii?Q?kPqOWkqSHaiaLyQPTq4lspadkVZrqEFdgw9dt7EchFdPdl0skClh4RpYhow/?=
 =?us-ascii?Q?W+/KOwydEL3vZWHgA6RjEuP/mjwC1MV1HoStOkVmD92uZk29iH+R0uM9xalY?=
 =?us-ascii?Q?Aw1v3YexfxWiGnqZYIOkSM3UOkGUO0X95pTpr/sMgs6ooAQl3nAFBBIjxQle?=
 =?us-ascii?Q?KSgkdYxkz7Jui/VFjueiFUF1ZmHEu4JWySQIBwixU4DrfuIGCnTgYjynmVlW?=
 =?us-ascii?Q?mwTa9I8lcwsGZU538K7Ea1O9/J1/xo0TsvFbhjXewTTO78vwUnX+DGBt3IhA?=
 =?us-ascii?Q?LGLQvqyQ/QHDFDiBw80FXx+HglOS2aI/bItiesdT2e/OOtnvQU99mZ8OmpwY?=
 =?us-ascii?Q?2Ntla+Z3bd00tpyuNw2H/vz+UVPetXfzASrpoTzuOE66zMBd1spUq4Qcc0RT?=
 =?us-ascii?Q?S2gvTd2mRS9xtMbUrBJxtVS2ZZlCjpyA9/UsU3OVxOPs4B/2Z4OTAWFFufPz?=
 =?us-ascii?Q?dp+24ccSbGd4O+E/OjcgRRURGXYdbVbKurkdty+Pax7mYZp1fOJREwg+hVmT?=
 =?us-ascii?Q?UXbntPcb+noqDqFQEZz1GhGitTAHWlRRl9bKbOALBXCVCeUu9uYsNfnYCCv8?=
 =?us-ascii?Q?8xNj5xUpdJWI8UEOqteRMLMMDRhAPOv98Jgj8+m6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed24231e-e2cd-4927-a02e-08dd45933d1c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 03:14:44.5564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OP5JOI0O0A5okmAh0o3b6R77J7UVdUZIWKQcTZq+6ZDBL6a3aJfx7rqfz5pmtFqd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8865

It splits page cache folios to orders from 0 to 8 at different in-folio
offset.

Signed-off-by: Zi Yan <ziy@nvidia.com>
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


