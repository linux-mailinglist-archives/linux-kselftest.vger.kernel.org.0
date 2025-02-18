Return-Path: <linux-kselftest+bounces-26919-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22514A3ACD7
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 00:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E295E1750FF
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 23:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DAA1DF277;
	Tue, 18 Feb 2025 23:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XSLbfr+2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED241DE4C4;
	Tue, 18 Feb 2025 23:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739922640; cv=fail; b=CrKnwaoc8KX4J6GoLzmSqZN+y6IV8AMQCMy1jBymLEtMzp8jf1wCL34pRqnoVM891Lq6R7928E+0/9H280Pio27Z0WLgkscrYVIwtNtiIPUwq1kxqMOI7Ct71+bitUYQYL+L538km4vgn/27Nv4GVVTfO8qLO51gPE6M+xFVtlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739922640; c=relaxed/simple;
	bh=ufWe9ZEWcKo16BeR3J089CNd6WeiCcjcex1zA+tFkno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PqxOoJYJIB63XlL1u5YzOLmAUYXtCoHJjfX5IpkLBNd2eP7tYRF+W+iUs6Gkc+aK5l5uScnEOR9QbnHwEyNk/whlJF47VLIclfXaQCNQTtEoLgM4qEkjBZQQblkpw/rb/FdQpdJ04qTNryEhT4LjPF+hGUDnvcj06akL0YH8HfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XSLbfr+2; arc=fail smtp.client-ip=40.107.237.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AftDVJMWB4+8YgUHzs6wm8VtRoR3gX+/bcKBFOvYhYucSDjH5H76lQj3aDJ2GbyKVCrzNBZIHelUkgjW1fMS7diD0RvK3fT5XXABQQiKI6qhnPtuEM0OOBGLrJU/LlH/HtyNWJGZHtu6q8nEzEnrX7w4AUp6RK+HGP+2aGh8PR5CyAGdy06USTgmDY3Js7gkBYgQ99l1hFaHZMl2jg/QpA5P0CeAAKqtZd+fOfsYDwxW4QXBRtfMzm+s20YIbnZzFrx5CNDQiNLt76I/WOlf2s5b9m0kRhMYqQxJlLSBE894cWOA2IXVGhIyHW21eE0ECJuZroUIAYD0HqrtIA7CgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Do02JI1EZFcQWrSMpFxurM4sFuf/GMUE6etfB8ub98=;
 b=Y628s7JQzSl1FpUlY5+DDyt1on0/QbmcAhSGKC7BTn5O3UBn3iwxywMZkiA/HFMuWAHAbqmBc/hvJ/PZnocpISmftftwQIXCSsipXN/4ZAEs2yu75Zb5uhQDSgBHLB+k/Aa1Lh0r42QrXoWbR06PcLq2zGSGgcQ2AH+xGsx5YsXcq7AIylbd1VRWoqY7zxPJLnlE+8eLpMPK9em7dOEnKJCDz0VWR54wOIc6yqXmUwPb7WpVFHozlyyIJJqPLnrUHcTQUrUlDjF/A2jhBMZ5N3QPSNv/YCgqkIS985mqg7OdZPhaXEpwy1cXbLdG4bNVv+A+EoJ25PSvq1CsXWo/eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Do02JI1EZFcQWrSMpFxurM4sFuf/GMUE6etfB8ub98=;
 b=XSLbfr+2nfaY3leSEyYW28DPxWLWL5tFW0Hri5VH/tXYUcTP/pWblhrHg1Mrm9eqcB5ZnagUMaUzLf2MNtF98RQWtFGTEVNaZvDwaFdnpzT2Kho25E5m7WnaaRg8f2XRykCuXuYP7VNfartC+XXmdQHQKsO6Pl5bGxZVF6qTLA5uWvtiACu1411Un60mgfBvJlUB9rH9XZIe8+XrFacjo5oieYipArN5QyaFahuUuSESWXcLFc/K4THVLJMoqba1Vdgiyo0EJDu66RbvdS79GlLZL+JMVhQim3evvIhkpBQUdzOI5jbBQrKS8ZvikGYw3MY9mEoWgPxWk/xLH6Dz2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.14; Tue, 18 Feb 2025 23:50:28 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 23:50:28 +0000
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
Subject: [PATCH v8 8/8] selftests/mm: add tests for folio_split(), buddy allocator like split
Date: Tue, 18 Feb 2025 18:50:12 -0500
Message-ID: <20250218235012.1542225-9-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250218235012.1542225-1-ziy@nvidia.com>
References: <20250218235012.1542225-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:208:530::23) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH2PR12MB4326:EE_
X-MS-Office365-Filtering-Correlation-Id: 11e44858-f593-46d1-d281-08dd507705ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TeOfJHbOI5XidJieygFeYOB75RQd4pRC2eJsk3PvkI3U72dXLYiNexroL4Ps?=
 =?us-ascii?Q?8TTF1VyPSAfrPM8xdtfDl48/HZ6qAhTCtr2xgq/+03/uVTOaF5pd74ahjLzq?=
 =?us-ascii?Q?P3SpDOV4qrVRqoclIBtT4dutD16Xh+lMM37xd5Ii7d+jWZ9/Ee6SLSoONArZ?=
 =?us-ascii?Q?c7INJ9/IBr7p8I0hw1ejJQFde/YinKP147HtQSqbHkPsPrJijQoLEHp8mvo9?=
 =?us-ascii?Q?sbEPfNt1fMiCBUU10Fb5YWJkPolCIh6lEzLALsPmCB+/V2zqREDoSippC/1V?=
 =?us-ascii?Q?FOVusAn44PQ+0En5136j4dk1Vq0krcZsZ87sWP4bvAD7ervGffQNgLKJhaxs?=
 =?us-ascii?Q?h+pP2902vO85sCYydIZAgj9m67ybrvjBdrIn249DDFF5QoqpquVNoVeGZNOC?=
 =?us-ascii?Q?nDo3ohJZgPs/4r2oWj2e6+A6FTkEPMyyi3MdscFBCQuktXm3xKrO6OgdUdzL?=
 =?us-ascii?Q?XRSJC3hy6IEoV3pqX5GDfO7Yqrxv20OJ4hrvsTo+bWnHNAYR3xqoYMQRt9rv?=
 =?us-ascii?Q?UD0WihSvySuhQ3vL/j2DCZqhLe4Aqn0ykH/g6tgWmmRJhGHrMy83auitmp/7?=
 =?us-ascii?Q?kt7vdmvaDXTDDseumsHypSGXdqL19jINXHN6riOVY38rRrYc+yB67BIwZisy?=
 =?us-ascii?Q?dq7t/COAsyApexUFQJUtowDjHshyUtArB1tLOOE0I0cAtl4H83brAB90ggcN?=
 =?us-ascii?Q?Yol/3Bj7cfaRzfF1Xd4uzE4ELVQ7g04M/IwVzy3j2+wPPxaysVHtryZvekf6?=
 =?us-ascii?Q?wqcErIPvHI/mgjJZECdwGOQZHzng5CM+LTQysx+UiGk8vzkExA3Rffk+AA+q?=
 =?us-ascii?Q?jUKaU4/VP//tX2ZiXuKzy2krTta8qZRCQJXPrYuxnzKATdNmaxfeqYs4HgkY?=
 =?us-ascii?Q?srB2toLuDGffnzLLVLwunfKQZjhy3LNcV6/4ihQmFPyEnW0YmMsA4u+zcr9r?=
 =?us-ascii?Q?yacLk9ouqS3A2BOp54jR17z0DL1/2abv5cSAtj8mu2SOZc/uo1og5Bb8GpN+?=
 =?us-ascii?Q?B0qcVBQSTHp0ASGI1JVgynqWIFN/RG5ermhoHzMoN5zMMDYsOv3jApimrEcR?=
 =?us-ascii?Q?UUyRiDlgf0WaQt4C4ZU2FYo6JuFBxKxqyNyZOu3HqwGh5AID0gP1Ljnfw1AY?=
 =?us-ascii?Q?mrfNP43BfC7WpfLVJnhFxicO/hhhS3LrFbW0hU2oShZZTjcKM9micRk812ab?=
 =?us-ascii?Q?n7C1LCuAqnSNBFOgxVWCdVIHiJOGD2SGAH+guSF7LeMb2Ha0pD+LjilsDTPD?=
 =?us-ascii?Q?EF744wb6tu2bai2FzlYpn8NOTpc/UyMi45Nysw+xhSEUyW/A6PfZ7Gj+9Q/x?=
 =?us-ascii?Q?7cr5C9WtvYB3S43k6XcnjodERA6obRUHSrWVIDK4oXH7q5915XCUacmvFxtq?=
 =?us-ascii?Q?dMXdDJXBF07ffSj1twRuiANuftRF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qKWB4Mz4V2dh1l4/8NIN5u8nYYy7r46eN6LHe+fzgjNpsc1RGdC6F3CWi25I?=
 =?us-ascii?Q?Uikdj1uDanI3ARWOIB1OBnYBVDia3DQQ5Z84lf0UpbLa0y4tPvsNFPF4Qp8b?=
 =?us-ascii?Q?gc/G4vTeAfoGa3R1LFS8m8HV700iBnbQ7geSfdLLNcSh7AQSvZPFdRjDMH/L?=
 =?us-ascii?Q?jbPe2X/75+IOY48I4djSvBGluaNYSZ7Tpi+xSAB38pAaHysCMDkL6QIzjhiU?=
 =?us-ascii?Q?Kym7fe49sovkFC4X4QsFJJlPiT7x7y3doalFrrOOOpPW/1lQtERCTBYCaF7N?=
 =?us-ascii?Q?GESww1dH72VeemWqEeoApIqJwlzRlVDD/K1xA3nm7TC7ZwgM95lCQ0KBVz9d?=
 =?us-ascii?Q?q/5heFFeCiB/ZJTiMTMno12PoqsptyFxmN1I44UeM6ZI3kJAiZWlIwrJ0u5/?=
 =?us-ascii?Q?LDyussnyyONCCFv71nfNX5d1B3LWQkF4mKg+jGTCZcXjMjd6exmfH0dZWR1u?=
 =?us-ascii?Q?BQNdv8/yg6Pck0Z41+lj7RuW+G7ozRgw77yOjKQWrKQjxcRs6vdtvjxCtGAc?=
 =?us-ascii?Q?QXIzsWAtoLmFzwVuZaJhsyV9txo/uaRRqSQBWUdXnPahCtxURI/9ayavvrrH?=
 =?us-ascii?Q?gBltq9GF+LjKqA6zpae5AcmI8vjtU24xgwegxLKknxBLpDEXNJYY/0f26IGI?=
 =?us-ascii?Q?Lg6FIte/PEt5ClPqEBs6/8ym1dUDBTrgy5LLPmkfCCoUSax8R5S+0tpLNYVx?=
 =?us-ascii?Q?Js4CVXQZeOskhsVTFyyZR+wXEGnSceI1IegjFt5rn0OLcZhUHXk62WBADCKN?=
 =?us-ascii?Q?VBPIdnLvUFGXuqUBD6kPFMV/uRq7CSSuNt9nom4NqT9rUEt+73M1zd0frhlD?=
 =?us-ascii?Q?aw6VRS+7advPeM1OGHcv59NO/edjgrM+Jg2x+iNdnnDHuBMY4ZFjBMrTValg?=
 =?us-ascii?Q?c9zWRJoJQmZFQdyK103Gk2lTIEqnScCvevlnvGdpVP0pUQOvT2gLDXJ49oLb?=
 =?us-ascii?Q?08FeJ1XCAF3KmbXms4K4pkazpTUgOTpdF6QssaECBDSjrJ+i7IpXN+vHugOy?=
 =?us-ascii?Q?kwOc9WcJbpgETPJHpHQ/an6yMME4j27R9KgRxrb/YJyLASwZ1M63nILW7Ji2?=
 =?us-ascii?Q?K1hE8Cc0wDYinl3Iur8/T0zZMAu82CWsTXIVAfmOEYU3QxAMSVZYiQ9e/HO2?=
 =?us-ascii?Q?HgYq2bVoTdzWrMJ/UdYflVHchDTAOHkBPkSXfNK7WzIAx3vdjcQ9BTX27aTP?=
 =?us-ascii?Q?kM1lefXVG1F+xLdHxt46maBb/kq7Ae2xEg1kiza+eaz9SC/3R/SDzIlqmutI?=
 =?us-ascii?Q?GCphV6b3vX3G/caen08gWO1eeemAOtWUAj84G2+3/achRn89QUFIFU4W2H71?=
 =?us-ascii?Q?GtEMqs11tm7tH2+OuHJpBpI4L28JQGk6IczNjvbBmg7TMFpdTYrnvaDxmdMT?=
 =?us-ascii?Q?x3TYB/4s+F1NcBpZ2HGy8SmQRxdLgNZlEreCxhwo09N+EbJyFYVw2zRA/xD+?=
 =?us-ascii?Q?jJ+Yj7yZy2Oge4VZ9VHQZfhayeiyU57SOoaN7rC874H1lC9woEz1s4tKfRcv?=
 =?us-ascii?Q?JJUvbIV+TPyqoM6S913It1hAbnkQYZPs7G9fV4kQ/IgqhK2DzNZJjEbkD45d?=
 =?us-ascii?Q?KRHeO8EcOQo2ZLcBAAUX0cQySpnM+eETADgUZ3mY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e44858-f593-46d1-d281-08dd507705ad
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 23:50:28.4291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tKgXbSMw8weK4xSGe2xYWZ4D+e+krfEJhpRucMMdS5PDCm03W9MVNvSrft5EsTvb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4326

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


