Return-Path: <linux-kselftest+bounces-24686-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D04A143D7
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 22:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB9B71643E8
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 21:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E446244F8E;
	Thu, 16 Jan 2025 21:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZPZfRt35"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D67232364;
	Thu, 16 Jan 2025 21:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737061876; cv=fail; b=qBv6J1IyFbJrOMVeyJ5aE9bmjPZ6mNb/kk8LsS8RFbx7pywT/KEVfr3yJdSBZTcz1SUAK/2oGhlPdCP8Gwol6tLbiDY5LQ5+nEH44mCM4hpu3vnnOWRo5o/dNhKNoLP64lh7WVIZLlV/aqnyRYxkslvZa5swK/zvF8wmXHjws+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737061876; c=relaxed/simple;
	bh=mG+r7wIvm6iSgwaqSfaWBN3zl44eahKVhx72foTGs28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jh7uo/TY3sq3w+xNIJ4q6wh3XvffOTk60YLAR48cnPCU/VoaOb1Ki50xukdPYPAII2IoSZyH+fcyAa8QNOHRXrrq/r4HuPpCrELrsYwtGGZU9MBLP3u0J2bjDzVJm3qDG7OF4PoDCAN5erCk7yZFhA7wqd4uOh2IYidJxXg3T98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZPZfRt35; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pZMFaKvcC8CTnFSqvdG8Y9J5hJF2+gIQTMGG9FONKwn2aqNgIMdPWO93K6sDZfk3LlJe36pTWbH3ljaq75ZPyOzc39lRYc1goLMZ0V+ocZ/NH/Wt1ywOb1lszmRC2yDqS63lHk+WoLs9usVqT9A+GIARNWsKgeedYmwoMqk+OPaYcSzM2n5JpwuqkKGepKGA2gksPUvF9XI6x1Vi3YyocYbJJrIKBeCGprR34X6klFNbmuDZ3NrrJafMjYOk8BWvlFGU5lIUYM3unnVR8LyLgFk1k/a2T8c8opG8DyuKHIDJXQuYYzEgxLc/LDFGIcJRhrnm1usiS6Tb7CgrWoPHAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sOP6cfEHCGqXZ+l3ZzVwerXuZKCP7nJJu/MyQzTkN0Q=;
 b=uvA4uiyKU0H3weiZWZ5tE5WfCEImip/oERZgqs1uD3f2Sokgfvf9KctKgfp6OqMLYhPoOFgiWjUnM6yz+8EZ7oj/LpvdPqZsUGZjv4lAckD82fO0uXTG8FgK7MHEaw65I+mjmWG4fpTFkd7y5xAfJLPNIfubRXUfPwU7+m+9Op2+Z+OoV6xsnzFtgpQWzdj6lprNIjf5dYssCqY6+2cGm/cYphxtQWRl2wi5XfOiBZaw0GqgCyQ5NK1hKFjho+WVpUpdt86dryDfS32HGB6CUd6BIGCemdWe1qddvsXqRjTJZC8+1D8cUqa1hxRejZCorGnSreSnSHXS1VN1Q5TDkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sOP6cfEHCGqXZ+l3ZzVwerXuZKCP7nJJu/MyQzTkN0Q=;
 b=ZPZfRt35RKHL8v3GK1EEevLgFZIix4h7SOso0O8bHKk2lh4gKCwklHAm+Me6A8e/D+5yPAOpxRrIjJBwV58xud0fdzt6eTFYR7sYhS8y/7fbRUNJQU49FU5+u1yS/UfjjReAqhYyZcRDdnF/4lBHZU7w/2bTpCGbBMCgcJiaHs0oJrP2Fcu9Afy1FkEPr/CIcXvB0nOpxIgz49YC3GYyPeL4tDIxIPWyUtgD95rAyZJFvO6HARjpNz/fwPS4f6dX0gq33OjTpXhrcF1qW+atLQTwZfQ9W4sdMBjlM2x6KNF2lvVsbFTeze1DMektgVbbWX0XlVIunRC8ekjMWhuObA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 LV8PR12MB9232.namprd12.prod.outlook.com (2603:10b6:408:182::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.15; Thu, 16 Jan
 2025 21:11:05 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%3]) with mapi id 15.20.8356.014; Thu, 16 Jan 2025
 21:11:05 +0000
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
Subject: [PATCH v5 10/10] selftests/mm: add tests for folio_split(), buddy allocator like split.
Date: Thu, 16 Jan 2025 16:10:42 -0500
Message-ID: <20250116211042.741543-11-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250116211042.741543-1-ziy@nvidia.com>
References: <20250116211042.741543-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::16) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|LV8PR12MB9232:EE_
X-MS-Office365-Filtering-Correlation-Id: 50bafa8e-1846-4aec-f716-08dd36724a04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JGZy8xx+aOcqBewk6GQrrY//XYpb8NjA56i7m5VX6th/dSgbaFg2tdiSQ2mt?=
 =?us-ascii?Q?M5wJpEJhyID0e5C3KKlYfbvryUNwhjLW5YoCXRgqHwG+3Q7EX76U70n6dOsB?=
 =?us-ascii?Q?Gw67jxWYDRFd96Eu3IUHgF0sjLW2MS58DfbUh4wUl9UJRhZ+ABZzLWwXffzk?=
 =?us-ascii?Q?9XPNd117HfywF5OKik+kUHKQyfQqrijVVnCUJBfFnvNN57avKVUvtuz27vxB?=
 =?us-ascii?Q?XP3bnSKraLCslgAiSB0yCBYHAaigAWZ9T8HEe9G44u+1+diNp2QbbhoD7EYV?=
 =?us-ascii?Q?kcoppCyPfM1pN8a05zHIkFguHhGxRm/7kxM//wCVGDKM2UjWiVKK87bwUAdW?=
 =?us-ascii?Q?GNHDIml5InWzyQfR2t6Nr9gGfbBkgWhowCfFibjbNljbrTaDGM+ZfLe/egQY?=
 =?us-ascii?Q?v2J7CbCBRxN1GSzTjptl7inrXdkgv+3jUBoRghFv/vrXnx8huKTpvtqs7cLh?=
 =?us-ascii?Q?nKyFxJj9MnyuZDr9zBe8iB67G1M40MzYIOuyC2pu1Og3qFIiniUrL33R6pk/?=
 =?us-ascii?Q?GdRbRZFirSsFMBbg2MEAF/+Sathyha3NV/ZG8zEJK8MfHqFeVsCTwIRoOuvR?=
 =?us-ascii?Q?RQhA8L3ek3X1Vuix5ZRFI4tVF3QF53ypC89RPZSpBwXkB8fvtcF4sLEiK9XL?=
 =?us-ascii?Q?JTqDy2SKiN+JPTJlcXmTZQ9FPAJKxsaSKkvXvJ2F5RykYWmbkXtdwVWUfSO4?=
 =?us-ascii?Q?QDITQtASuWJX9IfKv7QuZeewvEZ63uCVHJtxBdRVRCqQQTVEMFeusHAo1Gcr?=
 =?us-ascii?Q?TEMXm7de5kAYdo9kP6PuMJWzez1WMz5kDNmso5BvA2CJzBMA/jeFM6lmUn16?=
 =?us-ascii?Q?DSwCuRgAp3UFAoATwsVN1c5E2OMaJD+XnXVLmH+H4RzpcULjYqjD1c3VVDaM?=
 =?us-ascii?Q?IFqcJo2qPANDUOuSsxjiHxr76XstSpzXGAQJ6Sp0bVriJhAMga4/7Bb12Kwh?=
 =?us-ascii?Q?hJpuISYJv+XRPhYedZzBAiCzUAVqfS/dy2V55jWhFm16diJcSIRF5SYMIHZo?=
 =?us-ascii?Q?vKxvgjBUTL567f0RhuY838mQeTUlLsoWvBO+JWZMvo3Z+PKrk25bPtYU53DW?=
 =?us-ascii?Q?EIZJKDqEROFE0QSZWVY/7JBmXwDdJQNlmGRclXyMi8Q+50unqKgEglf8Y8X9?=
 =?us-ascii?Q?yLi5ZSM75pNNkqBVPQTgJITTFIeSCHFmqkmpzux6uqimiEX+hfj80RUtQVjN?=
 =?us-ascii?Q?bzv2m3Uwa6amhI3c3xSzSA8+REVgrKZp/x27SXSdCzYag80qIRJj4IrLIzI5?=
 =?us-ascii?Q?wetR9xMIs22312AyIElqgzoubt/q2hZAOzIEsdFfKDMd+am4iCYwRJY+hQWF?=
 =?us-ascii?Q?NSpaXcyLF6ml94XBqSinlf6E/ENW3Nq3+8DVORjEpAm1BPJPi79ZSAFgpoGM?=
 =?us-ascii?Q?DD4pAOk+YAQL6Hy5pMoFwCmn89eK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FrSg8o0wYhe33+ke0jSNc92xCElBEbk+/zQsL/alBmbI1x4B3r21zTQgWWU6?=
 =?us-ascii?Q?lvQ94T69MOkK/2jvxSK3+93z2rRL9Hi7M+5o3pMlAAV4laLbAygPR2oHenWm?=
 =?us-ascii?Q?rfFN20mEzCbE9EEqF4FhL+uUquOZ5+pqs15oVBmfmw5T/gW8WKvnRW//WP+i?=
 =?us-ascii?Q?9ukj5ao6Mf2EyA60gIFUbJ9H1zv0bZcs0jgqeSiXkMT/bFuO1F/JmDg0tSHV?=
 =?us-ascii?Q?geGT0ESx18o5fQ0xkVRP7n1D7E4wOi/Tm3TOa1kIbnyqseKekafmKyPCApnL?=
 =?us-ascii?Q?p3G+bJy30G9OjZ6wLnYs/7Y4Bf57HZbHAjQ96B5R3ONz48TkrJqiLbNfgM+u?=
 =?us-ascii?Q?d/E/0XRxHR+vC0TGOzJqVqRYeuHQ3zz1vdhx+uCGnXx2QwBRgixHZfEgyvuo?=
 =?us-ascii?Q?mBkIdAt+8wC12OyGewzT8e1T5bCVbXEXr+CTVL7pnvWMKfQjEP46mGh8Obku?=
 =?us-ascii?Q?5QXwqgbLxhnkWDBBeTLUsaDmXb09kyvT84uE+ue99Rw7PtZVVTuNePIQI4hG?=
 =?us-ascii?Q?uUSVjknIeUUaS3EqtwKxgFqguP0rCOY166p0WivE6hNQXspWN9cmWSb/zHj5?=
 =?us-ascii?Q?wl8WfdYfUokM0kfg9pdXRHQrGuJvusYYcSDzQdjsObLxsdWn58FRZ88/N4bB?=
 =?us-ascii?Q?tzw5YVgpPur+UkBe2gxY4gSTpn0q/QgfgJd3UvOHKvd2YV0Bhbm4llSMSVC8?=
 =?us-ascii?Q?tnLPb1kvnrGc1oEmApSz3tvtIST07OYPDqmOr4eOkoj5QfAq92TlK8cv6aNi?=
 =?us-ascii?Q?pfy6GAShukktpcIDDVuF+cfQZJU9WQDde2uOy4iqFsCabh/0P8fWw8ne+nCm?=
 =?us-ascii?Q?r8TfDsAgNfw7lPcKWi76AzwaxqTQtOegEBzaGd9ak+lgDWzLWOfedB7oI36J?=
 =?us-ascii?Q?bqRT8SPwv5OMT6Q3fAEjOvv8H39ewMEK0o88l0yTE+VY2aiI8jlnv+qiYy8I?=
 =?us-ascii?Q?y4qdFqs/+TU/o50i+6J0NO8sSAqGSZgMZ7tTDwctqyxpClqyrQxeYLrsK/ES?=
 =?us-ascii?Q?vj6QlQeNcbzNp2H8rrqvPgMuCFPeTNMcXbnBiUcr+pWj3nQ+Z9sbcDyo/85L?=
 =?us-ascii?Q?+MVL7xGQ0+WAy4ID2b4gTDbl7SPZoAKxpuwNgXLs2vCue9gi1TYZyvZN7acA?=
 =?us-ascii?Q?CirKAkWQ/LfAg/TKoD4NslPrpbn+Qr44oQ+Ggrnp/O/j7JLgI9Yg1RvKFogn?=
 =?us-ascii?Q?rZxA5IjmgOZhgNgcS/5QPBAbg+DxEjX4NNXeyDaLVQTdShJXi1nYZwjbIOMw?=
 =?us-ascii?Q?dKOz0e/tm/kGqdgcExF4UMDCRfvMmopJ5bIXsKjUzby0jVdKXUEV4VCo1qGJ?=
 =?us-ascii?Q?/sDYic5v06DU9g9GpeN/J7jO8n8RWnuLoq1oyXgtEH7dGP7pEm+gHLVs0XlR?=
 =?us-ascii?Q?VBj31odIxBASW1zZAj/hxjvPPUIN1tmtA0qv47ivxIduqUlODDThTcKgx9OB?=
 =?us-ascii?Q?IRdDaB0zqdb2FSq/iUafPMs4HJaTVFJ8hFkddr8CeUvc+mZ7KEP1Oik0RO4S?=
 =?us-ascii?Q?EQ2AJapL7UXJOpKbK9SazIjaEduzbc1Vy7vSxPsEVAk9ex9Augmtrz8ebH7R?=
 =?us-ascii?Q?sB/t9fXmQCrBwJ+mdkWf2csYkqed/Bv3YBA5daeC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50bafa8e-1846-4aec-f716-08dd36724a04
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 21:11:05.3442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zN8ny5HbwPfUARtXhYNe0dXwUZJzk7CO50hSaRwtsgT2xP6ApmN7BvhKo9LBZ/Yc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9232

It splits page cache folios to orders from 0 to 8 at different in-folio
offset.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 .../selftests/mm/split_huge_page_test.c       | 34 +++++++++++++++----
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index 766c1f3a1d78..070813b9e04a 100644
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
@@ -474,7 +475,8 @@ int create_pagecache_thp_and_fd(const char *testfile, size_t fd_size, int *fd,
 	return -1;
 }
 
-void split_thp_in_pagecache_to_order(size_t fd_size, int order, const char *fs_loc)
+void split_thp_in_pagecache_to_order_at(size_t fd_size, const char *fs_loc,
+		int order, int offset)
 {
 	int fd;
 	char *addr;
@@ -492,7 +494,12 @@ void split_thp_in_pagecache_to_order(size_t fd_size, int order, const char *fs_l
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
@@ -511,9 +518,15 @@ void split_thp_in_pagecache_to_order(size_t fd_size, int order, const char *fs_l
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
@@ -524,6 +537,7 @@ int main(int argc, char **argv)
 	char fs_loc_template[] = "/tmp/thp_fs_XXXXXX";
 	const char *fs_loc;
 	bool created_tmp;
+	int offset;
 
 	ksft_print_header();
 
@@ -535,7 +549,7 @@ int main(int argc, char **argv)
 	if (argc > 1)
 		optional_xfs_path = argv[1];
 
-	ksft_set_plan(1+8+1+9+9);
+	ksft_set_plan(1+8+1+9+9+8*4+2);
 
 	pagesize = getpagesize();
 	pageshift = ffs(pagesize) - 1;
@@ -558,7 +572,13 @@ int main(int argc, char **argv)
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
2.45.2


