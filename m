Return-Path: <linux-kselftest+bounces-24685-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 150B4A143D5
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 22:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 311BA1643E8
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 21:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2512442EA;
	Thu, 16 Jan 2025 21:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="duZMO+BB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1022442D0;
	Thu, 16 Jan 2025 21:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737061874; cv=fail; b=mJ/DKhB9ZrCx5ncZWLw6yt6VfuQ17zTSKp2Jo+YD2ytQJVB2ly5oKTNgoH6EyOBFrP0DqZyrfLfJQA7vK6jxhwfnM+h6g3VakFk1I9WO5ZYzduHKfC3kZfxV8zszitjQYh8nbBYbdLqdr/f57y0hlt5tscuCndhLIvDgPdSYYx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737061874; c=relaxed/simple;
	bh=glsB2MPdVu/FnwswW3Mt+eUYN2nGdILbyNBnFhTuOyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ps22Um2ix0W7RNaJuZajkLJCt2jW6mY2ZPdE2H9eUfWTwEjjW3Cfvm2FMNnNbzQQP3H1uKggbuP36k1q7DBBpI+WAWFuGU0dicYzivJ96mA3WgkxAiBdnizYR7Wp8rVpGBjy7wq/KOOyH2+TmQ4rVE9kdT/gqOgWO24i14Kvwf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=duZMO+BB; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lGhSGYmThYrb20lplfb3yep17uY/QbVcEUMA6QX3ES+G/yfrMtG6u8TRrbiZsc3pzF63tHYJZVRCCJ7/uFKBZg6UWJqtLYmk78dMj3rlCnKfkeH7Ox9nYhXd2Xk76Aj1iZjxt/swhNnVJbjm635Jn78rLJIylhGEx4kItzw7lxnzyfWvRIAS/zEoSGhD6ZlaGHACJuMj6ReNRvdzVZr8lI6/rKz7LKv5X2/021NLHAXEdZLv3LVa3iZ38Vtivsxe63pMYgieJRyN3o4c5lXxJzhBu9e6NbYVDeQUDF08Y+PCu+V0p1yszPrc32kyn1SS/NPnSn6CJq5cYZojvuOOcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6dN5S3nRphg4c7HTWzXe7uTKVAHTiFZ5ttyec/A78c=;
 b=y+o0OGtYpeUdwa7CkVECq8DTxlQ92J9Qi4K4clUjaDH7NjXXRXGYgwsZJdIYlPVt6yQjSDhauY872JMPLzBa+Sr2ZEEUXL8udyh+loOATo0IMRTX7LgzzHeELfvKFEK82wu39mLYq5zlCFfyeXV0K2Lp+fwxZ8+OQ+uG4GJk6sAQfzbFqRquSPN+UlZFd65yKSqKIzZSfJWzyfGf5ip6umUqIKjOZLN9ShXyJgmyXQeM3ZEF/VsIu9w0HPfr6PnrSwBVn/vO8vv4yX36Eq30xiuwPe0gIRKZb80pRAThiszvrzCQ9HJpHl5jmLxM18V+KvEZWTWOXvl8/pN5GV/XkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6dN5S3nRphg4c7HTWzXe7uTKVAHTiFZ5ttyec/A78c=;
 b=duZMO+BBlKLq3b8HHljzmXtjV1oaI0XJ9jCCoX40YHcnhWcjmwNd/6ekLMGeeDD+65rkWu5Yy6xsL+8+YXNIARD/4BWKh1pOeFPGQE3xe+lMemgRs2yDgN+XRLkG7/Z23b1bHDHkwQHx0dON1T84VvWT4TAzwG14JXFI55JFJx74fPa9T10uLUgj/gRfSEiWMbOm8iycSlIvgrFcazmGsClnZnu/tBa00DjFEkqME+jeQg41uHjMrEX7bTwxMdzxpRpmIwTR1hYsd+903DDH9BH5ZxJS40KLjt2aIxCgiWlsm+K+GHkpFW2LrOqLLhVNpviKataInM7gAFr5wdhIrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 LV8PR12MB9232.namprd12.prod.outlook.com (2603:10b6:408:182::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.15; Thu, 16 Jan
 2025 21:11:04 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%3]) with mapi id 15.20.8356.014; Thu, 16 Jan 2025
 21:11:04 +0000
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
Subject: [PATCH v5 09/10] mm/truncate: use folio_split() for truncate operation.
Date: Thu, 16 Jan 2025 16:10:41 -0500
Message-ID: <20250116211042.741543-10-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250116211042.741543-1-ziy@nvidia.com>
References: <20250116211042.741543-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P220CA0025.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::33) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|LV8PR12MB9232:EE_
X-MS-Office365-Filtering-Correlation-Id: ff17b66b-d95b-445d-6d81-08dd36724954
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?12IiEFxlki9MviFmFafuO5P5+vXaB8G+eMDUqmjsma/ZiLCLNPJ7nbqeNtOs?=
 =?us-ascii?Q?px/EPi33s6kP9vQQTajDInrIWgWxB1v0CaY2H5AjVWMUVUokAt8kIIY2FJXo?=
 =?us-ascii?Q?sRUdqyaGvorZhzLUkl5Jzso/UV35TccbvinP+8z9EAaObCCBy/g73bmUFijN?=
 =?us-ascii?Q?gsgt3SCxojBCnp3QiG656kpIOs2oPTKVowdzVNo3A609HreG4QFnIrdEu5Rt?=
 =?us-ascii?Q?nw/KwtUhyFtktQ0uyh/N4Naow5Wmp0HiG0vbJVP/ArE8aTxXhTOToE+LaQvy?=
 =?us-ascii?Q?cvE+VULRVgdw77KedrQR5SILS63SAzgb4wBP246/Hcli8s3ww9UyZZu+u/Bk?=
 =?us-ascii?Q?a3GnA/8XsI1aAhfkmXyhqygVig1g0ykmvErIG3QtZ+reMX45bjsROMMGTnCz?=
 =?us-ascii?Q?nvVTZJTkv2W4Os07ceGYxdbu3PyeGUu5iLFFS2OUqXOuYhaIGa3QDVBRGTSh?=
 =?us-ascii?Q?8h24ukXkTSJTfTGYNCVtrH+SZgSYQNM5bgCW8PX2wqhxcDhbD2TsJtyjkT6a?=
 =?us-ascii?Q?OyHGsuByip03WiRoGbTw2Y7RzE9UjQRnux6bv59cH4l63f3l9UAr10fhurch?=
 =?us-ascii?Q?MAfPzl8KPAhxtr8Xe986cqr53mtVc2tB0f/Sy+dSV8GSSCvW2N0pBvKH1CLW?=
 =?us-ascii?Q?pHL1Ahu92dRig45HA7GLyHOutI5wiC3JYfr26lXovLOL2X289VU3JlkDTuWR?=
 =?us-ascii?Q?RGICqhwMjqzjxNfd5XD40H3lTvBvLTaPnNLr0BNJgORisIUzLSt5kcMLbug1?=
 =?us-ascii?Q?HEjch7kQBYdUTABjo5FS4JopvC5r6LEre4UbaZxnKU7A3DAd9VWMa0XIX1OW?=
 =?us-ascii?Q?jQbsLbiWdB+FZXDIL88AqnVvP2lvJJMeCvkJgQLrPyVnY3/snQz9DEf7lCf9?=
 =?us-ascii?Q?86RkUKtg9z4dsnKhmlYbRFufBJ14x8m9oVjc5Lak5zBBOld6/jAslwJppZd4?=
 =?us-ascii?Q?wJJpVYs1fG300Z6BELasvz2TzSp79EXhnsHrrwWpcftP46DTc1SD5s712guU?=
 =?us-ascii?Q?GWNoggBQjPg3vAasDMBGCW8u+gplbyDl3z6OXIegch79Ph0nn64hoeMTFmJP?=
 =?us-ascii?Q?XGCVtqMTePaoL+GQGVTpWo5onBABF49kGqy6rpWnOs2hFBN7X0EghTfWwP2U?=
 =?us-ascii?Q?sENzDc5fkekqwJnih1QdOeiPS7CsXRi9evBtQ2jCq0PrPlmSpn0DKmuxFSiS?=
 =?us-ascii?Q?QNzq4gLaphAk5YWp6yCs35Ugt7GYsFCSeSWzHU7OZF8tlq7eMysSSpR0i4UF?=
 =?us-ascii?Q?5yX7JR1HwE9ubz7doYkHulBxUXrSyEBEiY1BaIsULkVtMjn7tjGT4SAy0k0F?=
 =?us-ascii?Q?q/hJECd++0v7kCK3Bh5i+5kVJDgkU8ejozNNno+bS3V64XKnofP9EJgdgY8n?=
 =?us-ascii?Q?jVc/iwcW4GSoowKuusFBNzKU2uiA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Aj+37zTQXbfX5cLSDo2GVm3uQSh8cQiKvCV2JMjP8Zi+5oL+XcFijwzckiP7?=
 =?us-ascii?Q?M4wlgvsLwv9Z30Qsr+YmP87hbaZ+YauT93J1z5C7JPVmecnldyU/nSbN0Djm?=
 =?us-ascii?Q?n8qdOqRsRpeIuL1p/l7m/9lCQsnTR8UnRFIiZe1KFHGywMyMbR4G1XLO5kqu?=
 =?us-ascii?Q?xGklCpwZpueJu6lmOBwPeKGslstdOt/9KbwS4Opck4Wq7B9xMUFy64QMMYTb?=
 =?us-ascii?Q?pLLR8Pbu9wRf7WFqLDLgUmp4L8rLCt7r70aJ/n0RynBT7FOvrXJilOZh/ZVy?=
 =?us-ascii?Q?VKOVZclv4eK3aCiZSuLe2V48KGHbU0sdXWyIxdrp/l1PDD0P8KGDZR3For9A?=
 =?us-ascii?Q?//drC6q2Gjsyq75m4DU4+Bw3jIxpposylx5gkxpuqJgdK/tAwWLjCBhNA/2k?=
 =?us-ascii?Q?2x6YsM4zI3yLPE+2Mw5BNW/X/MOC2tWhv7I32K7XEfGyT5VD3DeI5EzQVkwK?=
 =?us-ascii?Q?5PPiScv3adPiekV4QK9s1kMm3BYQC5mtNvqXVk+Oz4DvZ2Q3xgim5jPC6lDX?=
 =?us-ascii?Q?RGlIUI7/wt8zealtYLMXpB9DF1fKpCL/Gp0YIcR0NYv2eWNDb3x0BVzyIvn7?=
 =?us-ascii?Q?yyWRnaPT2s24x3bM3VU4WLdPyEdvZMUYp9Tf6MBCiPkvclBzV8ebx/FobxnK?=
 =?us-ascii?Q?DyweAAJRvs393sG0VN8Wl7/l2h4eXi5XEo01hcNpaoNbohPRnnXX/CoVbk65?=
 =?us-ascii?Q?lw9j21BS7+0WekQmAJlif6WZdRKjt+HmLyoE0qLW9Eatjgo6Uy99QDqQaVyU?=
 =?us-ascii?Q?8+nLwNvJrqGstNDPuhQ/1P6CszzsVImofJQr3CctOk/1u6iJUWbe+wo4xpmL?=
 =?us-ascii?Q?brwIsuU+4PmV8UyecNBHyU/WGuPNIUKV4tFdeyyWpcsNWTx/PIOU2m2sFQnO?=
 =?us-ascii?Q?mtpT38Vol2fjcdcMxtOWZEYxcUSmNcstJ2kJGp47E6+eFGU37jqpI5orVtqO?=
 =?us-ascii?Q?qjz+xJEZsiH+HVDxvUp+DKPEQgR//oQy5PjAtyyeWxaX1xbLyWNMPi/dWbnV?=
 =?us-ascii?Q?LgbLvF5zBwSlYfnAEG61FnjEgG6coUTBPGHnCH591m+qB6G9fkDtzrsjjh4a?=
 =?us-ascii?Q?M/Vh9xbke6VG8teuHo9vq7IR1+9phZaf4ZXXsQ68gnzDYxTzThAwFDQv5uBj?=
 =?us-ascii?Q?V84qjJH25CFHi1pT9OU4Fund4JxF67AKAVn7u4pj2PqLh1Dl4vyZVtB7NF4z?=
 =?us-ascii?Q?0bYgOTwSq1+L0P+5XwGnOQOsWFE1LdR4CAgr8PRVwaBtv4nLJwnFenbH+rZw?=
 =?us-ascii?Q?qztP75xlPHkwZYLEDaCTfrpq9IomGZe0Ri2CRUFCwbtJKzRx41NZQUc15wgn?=
 =?us-ascii?Q?SO7uqbv5i/yROBI7RRrUTQvR3w6QTTBUsCPO0keVyVlpqhbSAdmRwgdtYUut?=
 =?us-ascii?Q?e2GVh6d8ptVIzUjOU02dC+KvxjVLfQ93EiqR2yLlBflwGd88U+N0UPCuAeJk?=
 =?us-ascii?Q?iG7KrW3JbM7ysRSE/uMmyhTA4iuTINY5n90mRXYODefddUmQLFcow8ImRDwU?=
 =?us-ascii?Q?WqmvhgD0YLAJXxWoZ4ukcnn7MDLr1EHk91S4BjRB/g2b73RMXLvN76yCr8V9?=
 =?us-ascii?Q?AM2mMUgqN1gYzoj1gHUCt6BdW+c+329IdTqNS2LM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff17b66b-d95b-445d-6d81-08dd36724954
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 21:11:04.2194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cFM1RMLo1XIDCs1olJjtZhE0c/D92WD+Cr+phcvGTRfLO+8EoCX18NUkkyyr1dHS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9232

Instead of splitting the large folio uniformly during truncation, try to
use buddy allocator like split at the start of truncation range to minimize
the number of resulting folios if it is supported.

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
 include/linux/huge_mm.h | 24 ++++++++++++++++++++++++
 mm/huge_memory.c        |  4 ++--
 mm/truncate.c           | 31 ++++++++++++++++++++++++++++++-
 3 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 93e509b6c00e..2bdb4959a00f 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -341,6 +341,24 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		unsigned int new_order);
 int min_order_for_split(struct folio *folio);
 int split_folio_to_list(struct folio *folio, struct list_head *list);
+bool uniform_split_supported(struct folio *folio, unsigned int new_order,
+		bool warns);
+bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
+		bool warns);
+int folio_split(struct folio *folio, unsigned int new_order, struct page *page,
+		struct list_head *list);
+static inline int split_folio_at(struct folio *folio, struct page *page,
+		struct list_head *list)
+{
+	int ret = min_order_for_split(folio);
+
+	if (ret < 0)
+		return ret;
+
+	if (!non_uniform_split_supported(folio, 0, false))
+		return split_folio(folio);
+	return folio_split(folio, ret, page, list);
+}
 static inline int split_huge_page(struct page *page)
 {
 	struct folio *folio = page_folio(page);
@@ -533,6 +551,12 @@ static inline int split_folio_to_list(struct folio *folio, struct list_head *lis
 	return 0;
 }
 
+static inline int split_folio_at(struct folio *folio, struct page *page,
+		struct list_head *list)
+{
+	return 0;
+}
+
 static inline void deferred_split_folio(struct folio *folio, bool partially_mapped) {}
 #define split_huge_pmd(__vma, __pmd, __address)	\
 	do { } while (0)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ddba3e36b46b..67642c716de1 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3531,7 +3531,7 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
 	return ret;
 }
 
-static bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
+bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
 		bool warns)
 {
 	/* order-1 is not supported for anonymous THP. */
@@ -3564,7 +3564,7 @@ static bool non_uniform_split_supported(struct folio *folio, unsigned int new_or
 }
 
 /* See comments in non_uniform_split_supported() */
-static bool uniform_split_supported(struct folio *folio, unsigned int new_order,
+bool uniform_split_supported(struct folio *folio, unsigned int new_order,
 		bool warns)
 {
 	if (folio_test_anon(folio) && new_order == 1) {
diff --git a/mm/truncate.c b/mm/truncate.c
index e2e115adfbc5..a9679696fb93 100644
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
+	if (!split_folio_at(folio, split_at, NULL)) {
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
+		split_folio_at(folio2, split_at2, NULL);
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
2.45.2


