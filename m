Return-Path: <linux-kselftest+bounces-24683-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B86A143D1
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 22:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81837165203
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 21:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCB424386A;
	Thu, 16 Jan 2025 21:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iJhc1Wsq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1F2243851;
	Thu, 16 Jan 2025 21:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737061870; cv=fail; b=CH5QhvE7lwhFOd8RPXYpN4vfyMkfxC/SFPcgH4w2gKFph1At6B+QPiHx+FotQXq06s0N0VmnSKugL8tlndXVvtpAxzymk2CbzGEdlScQaR6PO4khzUSeUUwDGySeDYo1KdGkqfhaeRQ/IxaKCJMgi7HjMODz4qaVRNz4g5EgNSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737061870; c=relaxed/simple;
	bh=m4yuyB/UMwaiFVRQIm/Zk9rlKdWvUvFmBfnAaJgW8qY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jYPo3gqE6HZNoJ1Txa4PpQg5LnJJD7K1hhBAroUi6NXKZNPs8mUzXsrVshyw6s6lx/jEz1jfc2Xr0mTZUq0wQO5J3nmS8gewJRQ4vsrQ7rJPWFYsZ+ORqfTnrAa74KVKzMPCZg9H6/CJNhYSdGTTpSfVyOBvsv0O/aKc3ccP6p0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iJhc1Wsq; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f1A+g/Cyfm3Fo/aTnxoUqtuIalPPP7LkL6fmrZ60snSzGjCRmxnD8RiEkmudre2fR+FBhX71saUdjRIvypN/K0NBZswSZ+WvKCeH4IMicpbnom/eDOpNGQ6WrHaSmEs3jMa8nanIbvVYgDDfa0exg5q+HKL6CSLwTofc16v9VM2iA6kdV/XT2Y13ySyoAzTzkOKaelu/7TosBQJT0kOyV63dgBEgtmv0MjiR26VD1Pllt2NZZTXWQ0+4cHUk59URKniZcitXcUrdUup51nrG0XaxhAG6Bapo/1hIT0MzQzAqU1LSg7PoUgFKwo/dAohyUgn5R1wUdAXuPOTpcrAcBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOqylMIuudUNGPgU0fB6u1DImPM4IOntSMTYtCzMeCs=;
 b=SNFRVRpPCpxTg7KRylbNKLPqE+xxpS0QDsvohkHo196Xi40edFw+IqZsTmKfOnszaC8DwJKYBWib6MMyxVsrBb5ZfwTKRn6WxTcBmUu5WvkHQLvIgtG2ihSu31b3YStyw9yiC20tx9iXBayUcDJhsCEkfQhs+ol/rcWq7Ot/6YQ8yCZXv6kl1HstMe0be1oL45XKx7ILUH4ct/gXUMri91JasqSHXvQdCRIQwAOUCEsL3HdbIazK81f6Qd0+KcZbOG4iUNo7dmibK2hGRetp1ek3ShKX6bgKiJEGczn+HSehg8kIfxRhv9VR61uJRyXbQ8iDeeRUFXjPzD71DlU/ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOqylMIuudUNGPgU0fB6u1DImPM4IOntSMTYtCzMeCs=;
 b=iJhc1WsqGJl3QUeUE9KPJYoyhqBiOJmMWOsgBzo4fj+aKrq+WpQx8Z5Xq+t7xccFbqY0KoNpb0x+KumOLP/nJi0dEvbGqmk5Pfq8bTmTe9BzSF4UJb/iBmeyZkULjLctdfLAGGATzzXtJY4COpQduN87KR6pQRrThN18jhQJhemj12oM9dvIMfGnRBKHRYJO+wQbe1EBN0Y8xFMpzvcYDnKA6YLWynWCU0NbvTnRPr1T+KM4pn2NkNfHCrl7Ve3wVgSLwS3UBDxqUPFHl6yp/jcjQhC1u+7SUPLPoVXEEgfaqJvg7U3KTLK11KbNnYJQ/4u3tnjiZCxmAZj5gEfOZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 LV8PR12MB9232.namprd12.prod.outlook.com (2603:10b6:408:182::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.15; Thu, 16 Jan
 2025 21:11:01 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%3]) with mapi id 15.20.8356.014; Thu, 16 Jan 2025
 21:11:01 +0000
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
Subject: [PATCH v5 07/10] mm/huge_memory: remove the old, unused __split_huge_page()
Date: Thu, 16 Jan 2025 16:10:39 -0500
Message-ID: <20250116211042.741543-8-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250116211042.741543-1-ziy@nvidia.com>
References: <20250116211042.741543-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0022.namprd04.prod.outlook.com
 (2603:10b6:408:ee::27) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|LV8PR12MB9232:EE_
X-MS-Office365-Filtering-Correlation-Id: 0887114e-ab42-414c-bc27-08dd367247df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7wz4c+IEnmhMm0/HWlAeVoInSzarIXxxIVi5okZg403MXOJXDcQyXmAu5+BF?=
 =?us-ascii?Q?8gpCHWuYOnmkCgBuNxnTLPT2Nd/hx1ey10eyfRkgIfVcAjm/DXNpVQPEahT1?=
 =?us-ascii?Q?zPXzw3UmjhDBdsI+jHQhiG/i2EqpLq43Hgkel+cxuJdLq6+w09JyXMxGy8D1?=
 =?us-ascii?Q?KdfVGptArXi71nxt5o3qq55TfL9rm9Atf2j7JOAS81YnqQG95FxU2+QjLcs4?=
 =?us-ascii?Q?Gq2ONw/FI9ePveacznlwgVEv4cU93+0cFqHf9Mi8oDAqNA8BuuKAxoYD/azk?=
 =?us-ascii?Q?N5HjIve4D/L82pc5jl7eNCPyL9U3nEtrSBaoEsk087XeMdyM7nkeDbJQerLj?=
 =?us-ascii?Q?de2lp9XaDBn7LWaP+bSmUTp0oW7AU3VxQWozcarXfi+TzHYm75szQJwaUdJ2?=
 =?us-ascii?Q?TcBmRrr4pbSfTFqsSsDC3+YcwRnKa1EJIuHjEiryK3QhQK24jOWj9TvopYtp?=
 =?us-ascii?Q?o7UfnJwKBqar5/j0Y9t25ZxEoo+bs3HbZ9FtcovrnoCW3vUVodVLyOCMJBoD?=
 =?us-ascii?Q?JyQebWryltViOPxH6EQRMRb/kngIWyogpG8DtFBeDetVKtXilltz2ypnx583?=
 =?us-ascii?Q?mW/AergdA0D9+0RHaisFFReQ+nB0ZhQ0fAVcJQdsUONKMpI9YkvM584tw0TU?=
 =?us-ascii?Q?Le4reVGpTNQ29dhFYjkBjohe4maHmC8qNFG+7HepvwHSlrxfJePrXUKq/PP1?=
 =?us-ascii?Q?3ysIH9psz9wr0QcfVSeptS1wn3+GJIwBQlrv/r15AvfbJQey3uNTm3NxhXjI?=
 =?us-ascii?Q?JHLkzYM/IWrVJQE/OOIvmrzVVGv6+qiYzWQ2SMvxXjzd30ldqnh5PkXwKpJ7?=
 =?us-ascii?Q?tM8e3dN+2fQFriP7wJHiUiUS6kfa/Sgb82uqaWD3KFRoXfdn0mD4G5G6fgL7?=
 =?us-ascii?Q?WlSRumdpWhpJsZUDQC9pRnstCYmaQn4R4PVU189l+qPf8dAdSrxJ7qxV2EAW?=
 =?us-ascii?Q?e407w0s8wwT9ZKOCZRn3J5C48HpKaebDxngMtRxtQxtnL96y/tWOEbfZq4hh?=
 =?us-ascii?Q?35oQN57dRg0G2cKhIIMZUviY19PfwvYMeT3RddrahwcPD5eQKq2n5/0tWwyB?=
 =?us-ascii?Q?4dauCRwtWddeZc0eaa2YFUJDDpl3BZcZ6YToRnBkkq02PD2oybrZ25JQlu6H?=
 =?us-ascii?Q?OcrM0XWhF0hueu7GKWlxaGR0D5pjs86t7K9MKNNtdcnhSk+1Bl+dkwyt57cF?=
 =?us-ascii?Q?3D1OuTkbmJoUlbrLrMaBV4hDEFrqVm5RgvnZHrJh7Q+bJoPpdjTzyrUXieE8?=
 =?us-ascii?Q?LY9qdgwL1UL9tWyocY3JjftrA3LF6pa5Ng0mQ1Am/YfHjwJ9MO5BSTitdNRT?=
 =?us-ascii?Q?PlE5/dZE9lc+MPJ72iliFf7yUZ2F0JJKorLR6BVI5dDX+rf+58cIV0IbnweM?=
 =?us-ascii?Q?RnsQYtah9O9iLm33hg24W+PMuiWP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fEOikwA2HHd58CXC+r3iDUhtrou7NjE0y+W3u56Jk6++vcgOMGo7E7RJFiV2?=
 =?us-ascii?Q?ZHefpZncSXJzxN/lnZelSr5mUmoZ+z8SpAyyUzRBq5GVC4Nvk0OTAmvEeqGz?=
 =?us-ascii?Q?/9llWQM9P/VcxVKxa3GHZnOvn3qo/BZp2BjVKLMcgenHaE5sPsNqUO7FF9Ua?=
 =?us-ascii?Q?Qyo7/jdmYi3do6E21P0hIATTYqamJ/Xxe+BqHXSzg4WQKJEUGV+Iq1si3hvV?=
 =?us-ascii?Q?0mPAu6YMlv7YS7YSkYrPA+ApL/NXY4bC8JmBb1CjID4yD/C1CpNvBQVd8gEt?=
 =?us-ascii?Q?BODL82UnmBq0chg9ddwEoGD7jnsAWXIrOjQj/hiLu7bU7Ge3p0/d0DWezESi?=
 =?us-ascii?Q?lMRAap2ZghF9k9c2us0ePCeDPqOwqYtadLyOXUiF5SNM7tAJm7bpNP62CCui?=
 =?us-ascii?Q?+01FMgOO7C/kIDZ34QPZBxCH/4RAu2FCaKYpx5MC9ew82Ui92ExK++yaA7SX?=
 =?us-ascii?Q?qinwbQmas0F0bw+FudwG+D5vRLCCIwton6RJAkuXC6LattfqPSGsZJYAahNJ?=
 =?us-ascii?Q?Ifgmra2VxFMruEGdyUSh7xHdSLRmsn5hWFolWQcGyZSMqGtamE5y1EAmg49g?=
 =?us-ascii?Q?D1/nO275T7JBFUT6qge24N71hOEBsJfYoVI45SjIiOtqEsKfcE6ds4IQ1nzK?=
 =?us-ascii?Q?sab/ffhFYuBBa7pZm4HvSYyJb+Kpaja5aM2O0itOw/OcvKbmovz095SuD6K2?=
 =?us-ascii?Q?Wq9N6FEFm8uidY+/Wp+ajSj5Dq+gROSe1zDq4Na5RIvSJ2+3LjOrBbeYIpz1?=
 =?us-ascii?Q?Zh/Q72io1isCKw9MmBJnbn75R40r7tGCe5PQg6HQ8cpV7vhL9sxKD/eGQtGr?=
 =?us-ascii?Q?6v4HTCN/m+EgcYRLsrJ9vnzFXrbQvO2Of3vF3+LHM2qXqCcSKCOH7a/+H0Su?=
 =?us-ascii?Q?yt0hFA1Isp9lGjB8/vgeiS1kTYE5DH2hmJlpw9vh+/MFaFBlTPSop/k9TB83?=
 =?us-ascii?Q?xwkBEZzGsun+DcXp4DXv2yGcM2XHhPB+tZTdEAOeEGCW75IOJpwqDTSd+o5A?=
 =?us-ascii?Q?bpwVliKFSKzeT6RtkX9fiQ8EPuPqiBRl4Tsfp8G6+rT/iPcu+3Ne6lXG9Jt9?=
 =?us-ascii?Q?PN5U80Hn28WkajA7MpdsfSVEAm4J9UvLec25FbQyiCgATsflzYKedsrCCw9L?=
 =?us-ascii?Q?kcfRWqMxDI4I77LafUq+OFxJa9ZOva5LHGnTCqaVrA8kztN6D1DPW8bkgIVy?=
 =?us-ascii?Q?UDmPlvsiIPXpA3qxHgkjPlpCzY5utiLkKyPkjskx4v8BMQcDiRKWqTfWvdae?=
 =?us-ascii?Q?zsvy+48H+HaJ5ruefi4hrcFWX/AQNjvK0/ZmyDquE5i/LvWcpHLswtl0rfi6?=
 =?us-ascii?Q?IMYUgAgvOuqS0jMZLivqDVg4j34XItg2eD3QH3kMFipVhGpEBRyz9NObYRzA?=
 =?us-ascii?Q?BX2xJqgZb9KOk6xsW27SsskGz9InpFIIMssNEDZ2pBrDawOPA2KSvJwBdjyc?=
 =?us-ascii?Q?4TcIuk6dsYS46Y+XlVgdx/8aFQoF00HIJL57g0a+34EIrOeRm16po799epBT?=
 =?us-ascii?Q?SW4C1dlFEuQ/6+P6ulJnoKI6O/E9ApWTcsxNqCQq7ZQELbgj3XWPOYK6R71e?=
 =?us-ascii?Q?n23SkJUkfbADNCsqgAe2HrLQbyVjMw9ktHbPvihF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0887114e-ab42-414c-bc27-08dd367247df
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 21:11:01.7617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d2vr0WTdj5VVU9RQDfYQT3p+iQmZ3G7GW/Wm6lqbivi7B1nEKDBTCGBbNvokaYPT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9232

Now split_huge_page_to_list_to_order() uses the new backend split code in
__folio_split_without_mapping(), the old __split_huge_page() and
__split_huge_page_tail() can be removed.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 207 -----------------------------------------------
 1 file changed, 207 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d9f5ca61d78c..2fead9586e34 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3165,213 +3165,6 @@ static void lru_add_page_tail(struct folio *folio, struct page *tail,
 	}
 }
 
-static void __split_huge_page_tail(struct folio *folio, int tail,
-		struct lruvec *lruvec, struct list_head *list,
-		unsigned int new_order)
-{
-	struct page *head = &folio->page;
-	struct page *page_tail = head + tail;
-	/*
-	 * Careful: new_folio is not a "real" folio before we cleared PageTail.
-	 * Don't pass it around before clear_compound_head().
-	 */
-	struct folio *new_folio = (struct folio *)page_tail;
-
-	VM_BUG_ON_PAGE(atomic_read(&page_tail->_mapcount) != -1, page_tail);
-
-	/*
-	 * Clone page flags before unfreezing refcount.
-	 *
-	 * After successful get_page_unless_zero() might follow flags change,
-	 * for example lock_page() which set PG_waiters.
-	 *
-	 * Note that for mapped sub-pages of an anonymous THP,
-	 * PG_anon_exclusive has been cleared in unmap_folio() and is stored in
-	 * the migration entry instead from where remap_page() will restore it.
-	 * We can still have PG_anon_exclusive set on effectively unmapped and
-	 * unreferenced sub-pages of an anonymous THP: we can simply drop
-	 * PG_anon_exclusive (-> PG_mappedtodisk) for these here.
-	 */
-	page_tail->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
-	page_tail->flags |= (head->flags &
-			((1L << PG_referenced) |
-			 (1L << PG_swapbacked) |
-			 (1L << PG_swapcache) |
-			 (1L << PG_mlocked) |
-			 (1L << PG_uptodate) |
-			 (1L << PG_active) |
-			 (1L << PG_workingset) |
-			 (1L << PG_locked) |
-			 (1L << PG_unevictable) |
-#ifdef CONFIG_ARCH_USES_PG_ARCH_2
-			 (1L << PG_arch_2) |
-#endif
-#ifdef CONFIG_ARCH_USES_PG_ARCH_3
-			 (1L << PG_arch_3) |
-#endif
-			 (1L << PG_dirty) |
-			 LRU_GEN_MASK | LRU_REFS_MASK));
-
-	/* ->mapping in first and second tail page is replaced by other uses */
-	VM_BUG_ON_PAGE(tail > 2 && page_tail->mapping != TAIL_MAPPING,
-			page_tail);
-	new_folio->mapping = folio->mapping;
-	new_folio->index = folio->index + tail;
-
-	/*
-	 * page->private should not be set in tail pages. Fix up and warn once
-	 * if private is unexpectedly set.
-	 */
-	if (unlikely(page_tail->private)) {
-		VM_WARN_ON_ONCE_PAGE(true, page_tail);
-		page_tail->private = 0;
-	}
-	if (folio_test_swapcache(folio))
-		new_folio->swap.val = folio->swap.val + tail;
-
-	/* Page flags must be visible before we make the page non-compound. */
-	smp_wmb();
-
-	/*
-	 * Clear PageTail before unfreezing page refcount.
-	 *
-	 * After successful get_page_unless_zero() might follow put_page()
-	 * which needs correct compound_head().
-	 */
-	clear_compound_head(page_tail);
-	if (new_order) {
-		prep_compound_page(page_tail, new_order);
-		folio_set_large_rmappable(new_folio);
-	}
-
-	/* Finally unfreeze refcount. Additional reference from page cache. */
-	page_ref_unfreeze(page_tail,
-		1 + ((!folio_test_anon(folio) || folio_test_swapcache(folio)) ?
-			     folio_nr_pages(new_folio) : 0));
-
-	if (folio_test_young(folio))
-		folio_set_young(new_folio);
-	if (folio_test_idle(folio))
-		folio_set_idle(new_folio);
-
-	folio_xchg_last_cpupid(new_folio, folio_last_cpupid(folio));
-
-	/*
-	 * always add to the tail because some iterators expect new
-	 * pages to show after the currently processed elements - e.g.
-	 * migrate_pages
-	 */
-	lru_add_page_tail(folio, page_tail, lruvec, list);
-}
-
-static void __split_huge_page(struct page *page, struct list_head *list,
-		pgoff_t end, unsigned int new_order)
-{
-	struct folio *folio = page_folio(page);
-	struct page *head = &folio->page;
-	struct lruvec *lruvec;
-	struct address_space *swap_cache = NULL;
-	unsigned long offset = 0;
-	int i, nr_dropped = 0;
-	unsigned int new_nr = 1 << new_order;
-	int order = folio_order(folio);
-	unsigned int nr = 1 << order;
-
-	/* complete memcg works before add pages to LRU */
-	split_page_memcg(head, order, new_order);
-
-	if (folio_test_anon(folio) && folio_test_swapcache(folio)) {
-		offset = swap_cache_index(folio->swap);
-		swap_cache = swap_address_space(folio->swap);
-		xa_lock(&swap_cache->i_pages);
-	}
-
-	/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
-	lruvec = folio_lruvec_lock(folio);
-
-	folio_clear_has_hwpoisoned(folio);
-
-	for (i = nr - new_nr; i >= new_nr; i -= new_nr) {
-		struct folio *tail;
-		__split_huge_page_tail(folio, i, lruvec, list, new_order);
-		tail = page_folio(head + i);
-		/* Some pages can be beyond EOF: drop them from page cache */
-		if (tail->index >= end) {
-			if (shmem_mapping(folio->mapping))
-				nr_dropped += new_nr;
-			else if (folio_test_clear_dirty(tail))
-				folio_account_cleaned(tail,
-					inode_to_wb(folio->mapping->host));
-			__filemap_remove_folio(tail, NULL);
-			folio_put(tail);
-		} else if (!folio_test_anon(folio)) {
-			__xa_store(&folio->mapping->i_pages, tail->index,
-					tail, 0);
-		} else if (swap_cache) {
-			__xa_store(&swap_cache->i_pages, offset + i,
-					tail, 0);
-		}
-	}
-
-	if (!new_order)
-		ClearPageCompound(head);
-	else {
-		struct folio *new_folio = (struct folio *)head;
-
-		folio_set_order(new_folio, new_order);
-	}
-	unlock_page_lruvec(lruvec);
-	/* Caller disabled irqs, so they are still disabled here */
-
-	split_page_owner(head, order, new_order);
-	pgalloc_tag_split(folio, order, new_order);
-
-	/* See comment in __split_huge_page_tail() */
-	if (folio_test_anon(folio)) {
-		/* Additional pin to swap cache */
-		if (folio_test_swapcache(folio)) {
-			folio_ref_add(folio, 1 + new_nr);
-			xa_unlock(&swap_cache->i_pages);
-		} else {
-			folio_ref_inc(folio);
-		}
-	} else {
-		/* Additional pin to page cache */
-		folio_ref_add(folio, 1 + new_nr);
-		xa_unlock(&folio->mapping->i_pages);
-	}
-	local_irq_enable();
-
-	if (nr_dropped)
-		shmem_uncharge(folio->mapping->host, nr_dropped);
-	remap_page(folio, nr, PageAnon(head) ? RMP_USE_SHARED_ZEROPAGE : 0);
-
-	/*
-	 * set page to its compound_head when split to non order-0 pages, so
-	 * we can skip unlocking it below, since PG_locked is transferred to
-	 * the compound_head of the page and the caller will unlock it.
-	 */
-	if (new_order)
-		page = compound_head(page);
-
-	for (i = 0; i < nr; i += new_nr) {
-		struct page *subpage = head + i;
-		struct folio *new_folio = page_folio(subpage);
-		if (subpage == page)
-			continue;
-		folio_unlock(new_folio);
-
-		/*
-		 * Subpages may be freed if there wasn't any mapping
-		 * like if add_to_swap() is running on a lru page that
-		 * had its mapping zapped. And freeing these pages
-		 * requires taking the lru_lock so we do the put_page
-		 * of the tail pages after the split is complete.
-		 */
-		free_page_and_swap_cache(subpage);
-	}
-}
-
 /* Racy check whether the huge page can be split */
 bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins)
 {
-- 
2.45.2


