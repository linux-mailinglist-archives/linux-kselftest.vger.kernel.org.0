Return-Path: <linux-kselftest+bounces-25791-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9673A2829B
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 04:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41A3E3A6ACC
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 03:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7166921D584;
	Wed,  5 Feb 2025 03:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OTXRPkhu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2077.outbound.protection.outlook.com [40.107.212.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F649218EB4;
	Wed,  5 Feb 2025 03:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738725297; cv=fail; b=Gwh9i4gSM31ryy/UUytGOFd6mxuImq/ZiCnhtgjv5zgmzavYX04Css7az1JloUaClB/b+kANDBq+6qfqrp/CNmglj79XfAEfETrQUbDopKXbHDpAX/0fcAlJx5SpjGkpqrEfL/omomOFtyJtomj+h1miZKWffWkXd2sxgQ7GZlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738725297; c=relaxed/simple;
	bh=UEWUd+N/jLqsQ4zCOxSdnZYZJewC2MH0AfG2oZf+j7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SJSgWVB8auSlYKx5L9d0eNUQQaD10wDpHJwJ/sTwsZvB5GCebCVTY3/3CW/fq5Ng7aAeYejefpGkwGe4Ux94vl2+S2XK5aUcS7bUrnDQEvP/Yg+4aW76AepkusrQvXm69dZma3xtsy836aSwQYL16sgGLXI/zm9B492oUQ+qJWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OTXRPkhu; arc=fail smtp.client-ip=40.107.212.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=abkkq9NPJ8faUZrhIJHqj8jV9hZStL64rAiZlGT/Ep5lK/kqJMp8jmi8IOnmCcBshWFK62VWls0Lx74TVbwZ4c9W45dzao1KB6ald7Kmmuptw35PNDBCEm2DYG/ikOqJbloMc6CNr/X4KRv80Ya6LvTVfP/Kwk2mq2zH2PQPDebq4H9Yqvg0nHQy0c9W54cHGNMCbTyMlNW3OjgE+Z4Px/eNTx46kR60BNyEJ267/uAYa1yDNk9r4ae8eN/5/iSdBm2Jqa/VuE+yodYjBC+rJGyE8y+0NimzDjMk2UfHbQLZfR2zcDvWHA0yf7kROQxHyY19fjfhl3BSl99W2MnZpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zC07S7lCAXJ1lYnVEktSFOP5Mkmv0FFf6DYkZBYrTRk=;
 b=GwqT5uJh7NjUBdKr6rc11EVy45b3CHxNtuTz5HSFS7fXwJyMM/Bj8y6hfAImMvXUmFen/qQL4ScuigXQWs3zxjyR8L6jHfzeITIbD83rQuWGWr3RJ7RKw7ODtlBC85K1cnPP2xq1xvrIPYpa8gQ/3LkrFaZWyD/lChxsH7SN932FX7Wl6nKXyCbydnDiJhoPyPuFT1eJaHD5496ukOIVRtZwytoDMZr+lKnav6qxH6M0tGvrezwPToQLcZ8QVG60YY5n5okbv4WkWN+bRS0FgJEvgXCtw3qv2fxYlogSX08rvzpSNOzE4ero/0MiWcSdvaAr11dmS7YIatHGD7sK2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zC07S7lCAXJ1lYnVEktSFOP5Mkmv0FFf6DYkZBYrTRk=;
 b=OTXRPkhu26+WICBAPXR4ODIXU25OiyLSCYATEKfI+N6RvJMaXt6GnEvMODsnM+cSFKrbp0W6WJkjkrJ1z1ZqSsDkO55ohbb1KLByezsaS45Iu1WGiGbco6R8vxXZVi+iprGfMtxSJ1BC9LfYH+EQGXezZxnUV2Fn/Z6XQxdOU5t0p0GPMQ1+ySa2PTNKLDh7ErWO1B9g81mWou8YjeoFIgSI2PmDPqzQeMRW4UBl/WtVGN82FpXBnbHFAghriEpVIlxFs1lVytBVYiJZHORZSgECsh9r4mRoM6tR5yMXB0MdZBP4LPIs7+YGYsSOjfqaxcq3WB93WAKwtcnttmlCTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MW6PR12MB8865.namprd12.prod.outlook.com (2603:10b6:303:23b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 03:14:43 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 03:14:43 +0000
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
Subject: [PATCH v6 6/7] mm/truncate: use buddy allocator like folio split for truncate operation.
Date: Tue,  4 Feb 2025 22:14:16 -0500
Message-ID: <20250205031417.1771278-7-ziy@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: af665be6-3696-436c-dd85-08dd45933c6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8U1GIf2Bw0WCKNivIKqs1Nx858p3zL7D8PKor36xvbFNnVe3TmInP5CYVCC4?=
 =?us-ascii?Q?JSea8eZkECIeEbTlR/OlQE3vpV1xIfjuoOcOQN5nHZS3AyyxXpC/NGw+wTTW?=
 =?us-ascii?Q?PRoQ2MugJFO2lO5m5q7s2Oa6HDCS6vIgVFAxEoirs8J2HQBG71qDgtbeEfyT?=
 =?us-ascii?Q?/ibeg5x+HyjHJkxoR92tv4hZgTFhVUJNCeZA2iFA4oEpbkyPsUNMkMGLGbrR?=
 =?us-ascii?Q?Il73FkqI899cKjOM/lac1wVPRmM1YUFT9tbhgnjn3/KNYS8KG2MfmgqulKeu?=
 =?us-ascii?Q?uOi5+9Z7lcrrUNMgox0epe5vJOlE/IOSo+HcdK5Q2PNIJMBJKy5J699cw52k?=
 =?us-ascii?Q?A1vbKYBREorv3XK+KCARqUjV8cH7esVhdUtjcPiUpiMCJUFoZBF5Yk/fafPJ?=
 =?us-ascii?Q?8oJ9Zm0WodOhi0OpxHIVK7sz+1XG7Xxg6AI4MSj0XxqGQ9+udMRS73EYVoha?=
 =?us-ascii?Q?nEPZccAhABB54imtt7j13lsdR3BhGhrvh/Bf3tl6n4ZGQ+5AHZSHKAvCb5Jd?=
 =?us-ascii?Q?Gad8T/9vGvew+OHpsmI24s3vObxiuIta0OCl1pSjEo9DyE6f3cwCA1GdJcbS?=
 =?us-ascii?Q?jR0VTDPsteaKS419ksUL0JPDpXYIgHK2XvBWhTXsWy8rAE9jxkw6gzi58K79?=
 =?us-ascii?Q?XUDTE/QDS4LAstO4bfrOdNfInlMf4GcqX2WaZwavAgNPGSGBq5fCSH+F2ldF?=
 =?us-ascii?Q?g0zOAtS9X+ANRSre4sfcLvukVGLTRfLzUFjK+ZwutJNpVHus1CdFcO2MPUz6?=
 =?us-ascii?Q?2Ac2SOdWHcT98QNU6T1tkfb9Odu5YRBmTGjJkIoIRgIwu1pqkHj58PXiTL+O?=
 =?us-ascii?Q?gu0SM2YqRRFsYbIVyBE4chy+h5zLWaoNTLVbh9yOKLzJRPv9d3i2r/ZJMWpN?=
 =?us-ascii?Q?If0tWGhUZiM2eF/K4q2/KMiILS2ohqOIGlTV050AYsoZ12+uQsI3jVR4vM7x?=
 =?us-ascii?Q?y3zp4bIy6sSWi182waG8dlI/7EjmzhptQaWejAfpcRFtPp//qd1HWtzjXQT5?=
 =?us-ascii?Q?Yrl/yNnzrRPWtNj9VTFT27oGDCeeWsDnk+tQb81Q6+4lH/Wv7za0k3vgWa+l?=
 =?us-ascii?Q?HuzZ4MsGkSrLKhdIrSOED5p0OWXKSNIMJjmmHvppi7dGR2V1JcsFIEI+3k83?=
 =?us-ascii?Q?tXD9k8HVfzFXTTk0f5i2+PBpfK92rv6PaTUgK/3PToddLccF3ItQWpb6fiWe?=
 =?us-ascii?Q?ZAWY0EandmhTy2A9GoMW/MaE+6kyp60QSILpuWAUyXEjmQGhV5KvmmUUtcA7?=
 =?us-ascii?Q?3lso/thnggD+eVOui3LJ5nMqxz42+SGYfhLA5tHPdE74mzmztc9AtlchsWVf?=
 =?us-ascii?Q?UrC3tTz7CXRID+tf2iOKJtZ/zqJ7d11yXe/8xSw3rp6LYLvmJ4tQiqHmD/KC?=
 =?us-ascii?Q?VXvmBcSYMCW9T1yCUf+ZjxuN+4/2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VOpojWrpmdNYFWspaYQb3g0lAnm4DPlB+tkeVr1tWal5U2H0SMI/vhw/Cu5/?=
 =?us-ascii?Q?k2kBysB+4hhrlTY21u0msXJPi4CMWdxzdQyhTIZgA949b9rno14Kt4wg3JJ/?=
 =?us-ascii?Q?wpGsc+tEPt26RIOB8Zhzhxfrw7xyhltDFp+WpEo+nrDd39FCwGTBqzu7dDzD?=
 =?us-ascii?Q?mUCfaON8i+Foke+5aEJEssKKHC30SSlxdlLugVUdlgtHbL0FlZL2GcmgUSSw?=
 =?us-ascii?Q?zBqb9Tn/1I1OQFVBRBZb//5Anfc/EkY21BXfnACTANihxUuykT3n+qMzF/Cs?=
 =?us-ascii?Q?VBH2HxuMWAveYgUuS8j3kA+tXYa6wIkUodQpfN5yQAahKTKHxgkVM3AUAcma?=
 =?us-ascii?Q?MRry1FOVr78qvfgW7jK1YgjStxgnQi+YOwGQTO27MRfJZXw1i3CRuIACHWsj?=
 =?us-ascii?Q?cUYHNgj9lOMCqidVaBhi8mU9UyJLJhB0Eh1Pfo2kQ8S8ccUulFpVa8B8zl4s?=
 =?us-ascii?Q?01eEYgtddF213aCVSDnO4ydwHLSiYlJ8G84mZAF+Fi59oJIsvCwc2ATohUlf?=
 =?us-ascii?Q?YmrE61OeUfhJqqnRRiLtVeXrGfICuR6IAQNojuWcLSu7Sd+z8Jj9FUJmU0O7?=
 =?us-ascii?Q?VdlQTeMW0bZCrslHgXpSYf+7kGJKBIPWgpJQXR8HQZlY0rv8814z+DTtMyG8?=
 =?us-ascii?Q?5OwcYWZEDI0en0sWmRH3wzXJhQhdi1b9vNzwps9S0UqVeYlPyPscLRqk6yGd?=
 =?us-ascii?Q?8uyAi3R1/zgvLnUdJDNfzwfkJcF6WaIcxS8qLLAYLvK+okqmRiJ7NMKTXr/i?=
 =?us-ascii?Q?avUMcVJ6vdQakJ7cprou+ytsOKvCJAwGcT9xIaR6+pVlyypEVtywP7zgJURg?=
 =?us-ascii?Q?0nJLpbDkOJSxI017IXJx4Dgh/yRijgWKLCBLfrKCGXZZSxcGgI2VWsf7nGpb?=
 =?us-ascii?Q?h2+JWDPTtCof9kV85Xa9Zs7/kGbX9/lYrAQfzZ+kdN5WpLwtBiWOHQ1pdXZa?=
 =?us-ascii?Q?1AVMYu4dMWltKRLD9FBzuMrh8NBgMxVx3+hIIBmDs9LYa14ZSUI58p9f6yGu?=
 =?us-ascii?Q?0kcmQfjHdPfx/6MIwsGLONP6ToCi5hUSHZTrqYbzJzHRvPwscdX+u0RiFmwC?=
 =?us-ascii?Q?xv9AA3OfwnE687PMEj4o9yx4iUO7/xf2pAya1zvxWqFZ8wZxl3LZpZVUfkZn?=
 =?us-ascii?Q?3MJ6UHvbRwPzX7+J68PEIx2zqUcvLPnkV6L9pKc228d+lF/qXDqzgVchkVNk?=
 =?us-ascii?Q?Duj1d1WIlkv7RUA1W2wdDYZ8ABdXGXcqmT09WnRFTx1OPSEpX4m3avDjTKwC?=
 =?us-ascii?Q?RxCwcMBMkgqxo59uQwNW9wbZlImbpGZXCsUjxBKmi5xIs+ouFfh6XOfGHKip?=
 =?us-ascii?Q?kGP867Qn90rNiuBHm4yiUYlCJRkgZpEgYyHzYU1HuN360l6GCWr7V6NWvvqG?=
 =?us-ascii?Q?1YOQj0EE1O8BF+s7/RWBrqy2+Z/1OzukGoS/X4VjEtH3q2zlGiY5KwGtY201?=
 =?us-ascii?Q?0no/CLwYy4mxhFXa2NXugYlTR9IQaRZDzFMTwRRbnYcBh3j0qhqDAwR9WIHP?=
 =?us-ascii?Q?BVkf1gyut2mq46Op7IX2KgtIxynyXRGKqTqmxhphTgan/VvjyJp+a3hhAPWB?=
 =?us-ascii?Q?HlJxwvZVzxhd34VYXXYjqL88QuoGNFeJEYgD9GSA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af665be6-3696-436c-dd85-08dd45933c6b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 03:14:43.3875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m0ogFDV977PKnR+2R0zea/X7f49H+enPGijuLjjgpUGKos2QTu5fqSDrV8dTBMvr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8865

Instead of splitting the large folio uniformly during truncation, try to
use buddy allocator like split at the start of truncation range to minimize
the number of resulting folios if it is supported. try_folio_split() is
introduced to use folio_split() if supported and fall back to uniform
split otherwise.

For example, to truncate a order-4 folio
[0, 1, 2, 3, 4, 5, ..., 15]
between [3, 10] (inclusive), folio_split() splits the folio to
[0,1], [2], [3], [4..7], [8..15] and [3], [4..7] can be dropped and
[8..15] is kept with zeros in [8..10], then another folio_split() is
done at 10, so [8..10] can be dropped.

One possible optimization is to make folio_split() to split a folio
based on a given range, like [3..10] above. But that complicates
folio_split(), so it will be investigated when necessary.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/huge_mm.h | 36 ++++++++++++++++++++++++++++++++++++
 mm/huge_memory.c        |  4 ++--
 mm/truncate.c           | 31 ++++++++++++++++++++++++++++++-
 3 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index e1bea54820ff..2bd181142b96 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -341,6 +341,36 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		unsigned int new_order);
 int min_order_for_split(struct folio *folio);
 int split_folio_to_list(struct folio *folio, struct list_head *list);
+bool uniform_split_supported(struct folio *folio, unsigned int new_order,
+		bool warns);
+bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
+		bool warns);
+int folio_split(struct folio *folio, unsigned int new_order, struct page *page,
+		struct list_head *list);
+/*
+ * try_folio_split - try to split a @folio at @page using non uniform split.
+ * @folio: folio to be split
+ * @page: split to order-0 at the given page
+ * @list: store the after-split folios
+ *
+ * Try to split a @folio at @page using non uniform split to order-0, if
+ * non uniform split is not supported, fall back to uniform split.
+ *
+ * Return: 0: split is successful, otherwise split failed.
+ */
+static inline int try_folio_split(struct folio *folio, struct page *page,
+		struct list_head *list)
+{
+	int ret = min_order_for_split(folio);
+
+	if (ret < 0)
+		return ret;
+
+	if (!non_uniform_split_supported(folio, 0, false))
+		return split_huge_page_to_list_to_order(&folio->page, list,
+				ret);
+	return folio_split(folio, ret, page, list);
+}
 static inline int split_huge_page(struct page *page)
 {
 	struct folio *folio = page_folio(page);
@@ -533,6 +563,12 @@ static inline int split_folio_to_list(struct folio *folio, struct list_head *lis
 	return 0;
 }
 
+static inline int try_folio_split(struct folio *folio, struct page *page,
+		struct list_head *list)
+{
+	return 0;
+}
+
 static inline void deferred_split_folio(struct folio *folio, bool partially_mapped) {}
 #define split_huge_pmd(__vma, __pmd, __address)	\
 	do { } while (0)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index dad6819901a8..06087c8d0931 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3534,7 +3534,7 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
 	return ret;
 }
 
-static bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
+bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
 		bool warns)
 {
 	/* order-1 is not supported for anonymous THP. */
@@ -3567,7 +3567,7 @@ static bool non_uniform_split_supported(struct folio *folio, unsigned int new_or
 }
 
 /* See comments in non_uniform_split_supported() */
-static bool uniform_split_supported(struct folio *folio, unsigned int new_order,
+bool uniform_split_supported(struct folio *folio, unsigned int new_order,
 		bool warns)
 {
 	if (folio_test_anon(folio) && new_order == 1) {
diff --git a/mm/truncate.c b/mm/truncate.c
index e922ceb66c44..6a1f5d21679c 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -178,6 +178,7 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 {
 	loff_t pos = folio_pos(folio);
 	unsigned int offset, length;
+	struct page *split_at, *split_at2;
 
 	if (pos < start)
 		offset = start - pos;
@@ -207,8 +208,36 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 		folio_invalidate(folio, offset, length);
 	if (!folio_test_large(folio))
 		return true;
-	if (split_folio(folio) == 0)
+
+	split_at = folio_page(folio, PAGE_ALIGN_DOWN(offset) / PAGE_SIZE);
+	split_at2 = folio_page(folio,
+			PAGE_ALIGN_DOWN(offset + length) / PAGE_SIZE);
+
+	if (!try_folio_split(folio, split_at, NULL)) {
+		/*
+		 * try to split at offset + length to make sure folios within
+		 * the range can be dropped, especially to avoid memory waste
+		 * for shmem truncate
+		 */
+		struct folio *folio2 = page_folio(split_at2);
+
+		if (!folio_try_get(folio2))
+			goto no_split;
+
+		if (!folio_test_large(folio2))
+			goto out;
+
+		if (!folio_trylock(folio2))
+			goto out;
+
+		/* split result does not matter here */
+		try_folio_split(folio2, split_at2, NULL);
+		folio_unlock(folio2);
+out:
+		folio_put(folio2);
+no_split:
 		return true;
+	}
 	if (folio_test_dirty(folio))
 		return false;
 	truncate_inode_folio(folio->mapping, folio);
-- 
2.47.2


