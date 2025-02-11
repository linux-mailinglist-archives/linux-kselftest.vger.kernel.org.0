Return-Path: <linux-kselftest+bounces-26385-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9EDA31042
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 16:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AED1C168AA2
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 15:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1720A257ADF;
	Tue, 11 Feb 2025 15:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZDSEGA3H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2076.outbound.protection.outlook.com [40.107.100.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4172B257420;
	Tue, 11 Feb 2025 15:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739289064; cv=fail; b=AJBPgA8FNHmfHS5EakomiD/MmsOvKWeyS78+2IXY/9Hrs46sZTdObkY7uYUfj2anpqewIAPFu7+U/221KOcwC4d64Le3BbZ8qM00668WmYMEuqu+nfKQvugOQtSf9zCgGutjeq7OfsfDxKv+N/H3xE4v49tSj1EC4N9VxAVZ+vY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739289064; c=relaxed/simple;
	bh=siUAkUsrYmN0xTkGTYj67zOhBR+jzX37/9m2FaJA0aI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GlEvWG5FZqi1rkFX+/bOopqsU+iZNVudWmzSoyvnbWbpUrbkVi+zE7nxlc/0rev8cRdiyLzCG0tcj5sv8xKKw++k4g053UZDpLV+O7f6/YVknacCnY89KrYArXCTbet/fq9XK1O+4kZe70XJiHjEKCMmrROgDTo2TE0mXMgws1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZDSEGA3H; arc=fail smtp.client-ip=40.107.100.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rYZ2qIGSecvwJjS3H/rNFuqBJgOHvCgAfwhKz9FYNsUQrhxN3LL4RghYxd0Lh0G1Tw4THHDq+08XSkqlDqhx3EXdcs3e8cT3ctZOadRKSxhO78sv7yd7+37dNApkYVxvQ3B73nuytmmpTPVO79G6BjOcwtakD7Rse9RhemTlIB0A3KnV3OH9mY/9qLj1Y9nrLHv3YWg3zXt38YG1Tuv6DKGjKIb8Klhxl7ycmWaDwpi63GSdC+7F+htXJH/fTm1HVyTvZhm951zxXnj5YU6nrr5PkY/LSLCUpU+hXaWZnTKilJuQrob0Kxp4OQoeM7s0kanbPFJvHdjHzzXHSVPHTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxUrFoVdwqE7hmVfm5+m5yVYkjr3vlGolGIklz7tl8A=;
 b=VUnEDNELhawETTd1oH5c383kYqDuLEnZ7NqeLWZywhxuVx9hONiqqfNEjP/HP7Fqd9eLfh9P4o7RBwVjqJoSKdzgLLyTrJ18mEexeQXyPMVYQ4HU7MAbu6hr388ioPwZBllhkNTbdlIy45RrR+KgydIsc+P068E4oQsDlDtdOudil0K1Ir2ByDXo0SbfGhJsFqBi2XQydujjAmnBb4nhj486hrUQ5k4qz9s9XioEmoqA2Zm61kI5aOS7TMMdtyEVbWmw5/8UCHzszUIx5Cnb3hCCF9h3b1Xfstdq86tI+9neGPjlDj118ZsonbUUh1HiAj42ebCTeXft/u5M0nYKYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxUrFoVdwqE7hmVfm5+m5yVYkjr3vlGolGIklz7tl8A=;
 b=ZDSEGA3H9+nCp7UDQkiM2XqFgc3cNttZ8XMtsMTJG7mLHtLB+cTv089Pxv1eUkisyptl5Cm/ooePfKZUaXv0wSQrmZtk4FqyHbZQwo6IwVQd121XC3O+DUldCQQjo4tiOB5vLpFnHjLL4lfbyLrF8ZO3LNS+4veH36tM6ay7Fjf+4rpPoJZQfiAGnrA1oPiNrBS4IswumZ4n3+poWdLVWqzD47X/AL3g7sKtzvoN4N1VRP4Gh/Pdhc5gWcjbG5En17NzNC7gSlBwjxe5rR93tywuwrNYiRVSTihczJCcIIvBrNwftYTSk+Jp/i3wuT+6dICsX7y46WmI1AEJxmfOJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA3PR12MB8764.namprd12.prod.outlook.com (2603:10b6:806:317::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 15:50:54 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 15:50:53 +0000
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
Subject: [PATCH v7 8/8] selftests/mm: add tests for folio_split(), buddy allocator like split.
Date: Tue, 11 Feb 2025 10:50:33 -0500
Message-ID: <20250211155034.268962-9-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250211155034.268962-1-ziy@nvidia.com>
References: <20250211155034.268962-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::7) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA3PR12MB8764:EE_
X-MS-Office365-Filtering-Correlation-Id: 05b75c12-2b70-4c46-5839-08dd4ab3ddcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pDHmo/hQ6hkzTmw36NNUOXl783mBkhAP/mEk8Zj3sgnyUpJ+jp5MdUejWniL?=
 =?us-ascii?Q?HArkOItqvy5Upq0SAZHosXO30nx9CmYcCreVNKaCCkEFHdmQXYpcFt9HQTWA?=
 =?us-ascii?Q?wEproOGZPpdKHiO/wkV55mnZgi+HIG4lJ1dX64lpevaCAuzpZPrp0nmaoERe?=
 =?us-ascii?Q?7bQttWgl1PUsmcsffHysepbFZqSsKAbmLn/EMoQ8ps2GRXKOBx5xkog0Bw+A?=
 =?us-ascii?Q?TOzP79xQ7YiYS9hbv3MWUozp7f8jwQS+OrkiYuTPFUkeXth4au9vdAOVrmX4?=
 =?us-ascii?Q?2Q6MT3WfZHTMtUbUifg+lqM+d2y9o5Xeg3YGBAHQdqV+j/mVcii0f6f/Z+jv?=
 =?us-ascii?Q?aLPoC/Ep5kvJ/61N28X32xLLNpTfK3+CIDQRA/h+sPbasTRdl+cNr6rTGfh1?=
 =?us-ascii?Q?nzcLasArm488BHnZtlaUYmGfu8c28hHaQVuGND2fT0jBfo/WkeUzycwnChg5?=
 =?us-ascii?Q?CQPoN9LCAiMx+V2XhH+vZwG3eXOBy3IePq6EZjk37XqsKU0zPDA+uSg8PY5y?=
 =?us-ascii?Q?MscRfU9Uq4W8v27B3cnRjbffKTXlhOPHxBDrRtjkRf5712HfcS99SeASlN0c?=
 =?us-ascii?Q?QuU2yejybpoPb+lto/ysFxUkGzdwtbwTMsM3IqLMOdZZq5gdEUviyFSsm3KJ?=
 =?us-ascii?Q?ZKe2JTZsoOSUaskNuz8j7/PJGl0SS1VX7JMJTDnVVxyNYD/oI6LwaROAOIQM?=
 =?us-ascii?Q?jNHqo84cbqoHG+ZkzxMPnEK8PQRn5pmk/MIL8BDtLJlMg2IfoRFLz/ADHXG7?=
 =?us-ascii?Q?wwd40VGLDtpqKE7W9urOezgpSsgY5yTNIX/7UP9IeezDQYtJOWRysgk6+Ize?=
 =?us-ascii?Q?PR9Cb37iNN3gEnEzsCxmbP193foUll4/8RrR2v9us+5+RireyXZK7eutz/RU?=
 =?us-ascii?Q?JF9tuK33/jJiKHNQk4pdbGEFHu8D/ETXZ9Hne0rmK4XVk2ZnS1/nWuftzvef?=
 =?us-ascii?Q?qGTeaGipsZYBFji1VQTPUVSIHBJImU/i6x4E8M+iAHezj5RpYKdW9ewah13i?=
 =?us-ascii?Q?hBj8iO1MxaZhQ1qkeL88d51TDEZaKvnYARJWC6B/miKDMYY8VK3Qvl920ioU?=
 =?us-ascii?Q?MH/nZSYno62X0qXWUZobrDTLrTdwJqbtxC7VpF3zeozll7BH1jBleWyKJqIV?=
 =?us-ascii?Q?S9yaTRHBib8GVQCDTkjD7t8A37dQo8p60TUjgo3ZIcfYZbwPZPH6BUET80V+?=
 =?us-ascii?Q?DCCz75HYJTgCkJsM3KeyL+BOF/3qzDx2sqAMc76xwUUpmc0eZX+HQr6LR3zh?=
 =?us-ascii?Q?9+wbxMcsoXGOcQ8fb+L+/9LfkFHQQopaw5hQgCOwYsKN3xI1kYljilq6ED5I?=
 =?us-ascii?Q?LFhVGmh7+vgk+wBX+gUTuDjOnCYJ0atp/Kp/pKLnzSBpdO/0jup7xDiT/a/1?=
 =?us-ascii?Q?6RIwKRY2tax8yWzkBEOzkoinbQGU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xZHcuYiK9xLKyeLtJdpVmTpND+67JNZE1DixL8z0zMoXHXBnEadhlV5PV8nR?=
 =?us-ascii?Q?/uw2eRAqguJKfWNGGhKyNCLb2rH9/XSm6GoMg6ZixwKjIwjhfLzoTEfH8uYU?=
 =?us-ascii?Q?h7E8ff86z1KPXDwPW4ls++sTh6SjatNTuN8AgwBQ6KISAWYBB5kFlWtfaxM5?=
 =?us-ascii?Q?sv/CUbbUd3CJhEuPjeVcRWPwy9aXGD97GDJi4jAfTyC/bSnpr48n0sOZBoZi?=
 =?us-ascii?Q?Nm5/w4/VwDFLTFpoVwzeIsEelS8kGeIBiOCpkkl278+KGutwbsHrOHhLOAQ0?=
 =?us-ascii?Q?SrtUSPYHS14BRdtbpPSgZ2N8JoG1LMSq357ccFpeomNYsidy+zesInBZoVOx?=
 =?us-ascii?Q?CdLm6Z3cZQhn4vyRLACgAL+rPjalrDGbdKltfjDS3rDF74Glw1HWH62v6VjC?=
 =?us-ascii?Q?SNsYz132cog6H6qHshEVmLr4AR4hJve1ebCDMPtW5LB5eI8Tv2Wi4nNMhrv8?=
 =?us-ascii?Q?8TtlIIRiLp94t6KMWK1PCv12XelfEqbJ14vquXL2tcqh8OfvV9kwkVmmkbTD?=
 =?us-ascii?Q?Ifo7n8cWT20yAUsDx3WjprsQHTiJnTn9phRLcmIMYvOvLyxKUNTdR9bvOTsJ?=
 =?us-ascii?Q?bQaVJbP+OnwHOdbTjxE4gm3xDWmeV7pfk/af8wDStP2XaILXlWkokSLDAZhv?=
 =?us-ascii?Q?X5twsp1YgYOcrWHLIfPYYSfkl+iiMmtc1p12OG6mlJOU9O55VQg6u8AQdM6U?=
 =?us-ascii?Q?xpeiiEUr7Zsp1e9MY+clIxNuMIcQp/EKYoK+aP6CimyJyzIN5niZ0WhSjKPz?=
 =?us-ascii?Q?X1sp4051B1ZRgs2/6VAVjBWew4uZX15N0fAt864+BbnfWDmGZzHGZg8CG9IL?=
 =?us-ascii?Q?srj5XoMqRvDG1DhWTXtmee7/DhmXwXFDMfHYtfcoUOAP6DF+h1lfTBb9fQTP?=
 =?us-ascii?Q?KJUBFv+ar1eZpEBBRMn6V5LHZfW1P1SZ6LXmmQUElPvvWIvzeWFnVQ+dH7z7?=
 =?us-ascii?Q?JHd6dbrhKpxaSpu5m2Lgv8ni7e/NgbEBY8RMHKWWX8//6bblVns5nbKxm3Nz?=
 =?us-ascii?Q?MACXCteT9KpH23fzz+DwE9YhVqLrVMmBfznfGOpwYrvnwasxD9HxYV1OmBKF?=
 =?us-ascii?Q?2u1Lcltf6/o1JePkUdjnNPhZx0FAOGeCzy+HeyFG1mAa7RH9BXKp4jfLsOFf?=
 =?us-ascii?Q?1/RGK/ex3v86uxPFn3xNKzNgfQMGI4onqWOpalUNDz3WHuUairWCw/aZYAnq?=
 =?us-ascii?Q?15ehjxH879a6HS9hvE3uPQ/ctkLxfrGAFhk9S3ZoXlSloTEboeeFSNF9N4QL?=
 =?us-ascii?Q?uEHJ0lLCGXCEdFTvpYNe/sQsMtRPbqs9mVkeAk6i9y9yo6jGdnanRX+KibAY?=
 =?us-ascii?Q?9D1QWPAwgBxPqZ6Jfl65E3P+Rn3G228B8eSoey/aWvTetycHlS5SF9WX6lyi?=
 =?us-ascii?Q?gzxK7ENt5dKnt/DBxrv3+dYux19CDnndsoG6SnxjPb1Ky/xC/cGP+k6En3F7?=
 =?us-ascii?Q?l7yD1ekHihxUHyB2DynvMflWr5/3ueZ3cDzGAgCCumm3AoHDUhoCcNpjs5zb?=
 =?us-ascii?Q?xMCaqt5PvhgsM+EWNtam8Nqm72YtX2WAJeBzf3w1v9if/idUkhqhoAgjqFNW?=
 =?us-ascii?Q?09dVwz/8EW/A4rvtFr+Nzi53TstzUadx9gSEMzYW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b75c12-2b70-4c46-5839-08dd4ab3ddcb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 15:50:53.8579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /TsT4nkRAkPSleweoi1K/qJi8NptEo3mQTu1ePrBGBZ3c48S49e58XIhmYYTt47h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8764

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


