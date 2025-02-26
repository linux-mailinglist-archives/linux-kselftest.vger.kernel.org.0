Return-Path: <linux-kselftest+bounces-27659-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6433CA46CDA
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 22:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 592D81685BC
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 21:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B8121CC66;
	Wed, 26 Feb 2025 21:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="onHpMYpf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115D214A627;
	Wed, 26 Feb 2025 21:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740603648; cv=fail; b=JWkBipF3t/sXzaql1gFi4D3Ofnn+T08L2yziPV6IBIoKF5c5cOXcbJ+1lB1Cm/FNRcDgqGGWjRE+uXBT5Ddz6QcP4HK61pBWu9YpFD/0Wr5TSG8fafSzZV3ZWvjvpXMdqV7RXvs+dtr2kirTlkDFM5UaAnO28Cbj1LBqcDJVaq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740603648; c=relaxed/simple;
	bh=We/BvxbV8DetBwF0sQWyVDG42RNdDpKtnefKzoUZkMA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KZrAOd+H22hevIZMp6iOIWz1yw1+FkkMbHoE8Goi28VrBrLyrRiO0Ka/0EhLIbKtnksIlURmBoHTATFoPL86a6MgCSq98U/GjwC/25V1zljoaKKyeW4Rqn88EX3aR5p/+moc2tVrzmjQIyhNpZPfxf3iFgA3NovQPaCHH2I5dDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=onHpMYpf; arc=fail smtp.client-ip=40.107.95.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hpyvifKVt0w3WpuDSQO+D11WnnHncsFUBCifhCH2ny9iri+qb99DQXYk6TAfloTxYAbuwEu+OLHLomZ9qmvE3Jb97ALzffXdnz9JAOscomM5CkZVNZzFsmJXgnzOc/4tvsD4+NgKbdrrjNmYw2MmXFADhn8jL4pIHEE+uKhwQtm5pLpHUsmbkhICJPb0/PVEDmsTEsfvQEN/EwyL/N1v9XceejBP4/HcYJ1bqkMpmf8AR7QjR4QB6St95zwVj1xSAOvxwg/CcMjb1TID6dDMcViKdy1hhdlM/XYrViBXiQM56ONu0Su8Hm+WsOjKf5AMtEjk54ktApKwMaklXRX9cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9e+NGenZY/0t6nz8IwsC8Vpwvr9TTxIJSQfYXmAblk=;
 b=L49Q0LnB/7p9x+qv1bZVoq36fkz/1E8zXnfGl8H+ILdVpT7zmCWZSnRpwkikGNnqX9AfQP7BXF2Ab6W5y2XRrgpHCZ19cir/jsdXlUremZBCihVESAiiAIkA0k17Xt0iukTfqWO4Ckik3OhqTOLLOgZoT4njIxdZsCfG37qWojhAi0G9Lo5SA1z/SAHYBorkDsGoU/j8GPV5HKZEWAviCwEOmjCvk2v3yu9ORCBhvErC+ggj6602WdHc9rvnLsN5U0Tq7rWGuAJrakeTWWhWhHM1rYc44qoXX2G/F8u8FbjaJqmCWfwdNaCaUVUDVmVp61c1COmfG3ppLycsCSe7yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9e+NGenZY/0t6nz8IwsC8Vpwvr9TTxIJSQfYXmAblk=;
 b=onHpMYpfnyl6vTrFPr0XWt84Eu8IaHTw/RMnnB2WW0oxP7zcYMe1gx58FCUNQUoakNtiYDlBtGPjEdR0XhSZLcU75mxln/Mw6/eVzhORfpxb9CN1yTYj307/+08bzeIM5UvOsiW9WwscFM8Eljho+0qHOqs8TGauEf/f8pEitdvrNJ3OCku2Tt2CsoMOgFa7Fc6J29tOfHtrLx74211Y45rp0tvOHwUZs1By3B2v30EddlKwMeHKcYeczXlUGWNU4TCnjiAQitVIq8e2qxp+WQz+1LdejqbrFYUajXwQmc6r3YOqWi2LVAXTxU7ciCO/Uy6Y/CSunjm9EQh9K815pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.19; Wed, 26 Feb 2025 21:00:39 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 21:00:38 +0000
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
Subject: [PATCH v9 0/8] Buddy allocator like (or non-uniform) folio split
Date: Wed, 26 Feb 2025 16:00:23 -0500
Message-ID: <20250226210032.2044041-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0001.namprd02.prod.outlook.com
 (2603:10b6:207:3c::14) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA1PR12MB5614:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fd22b4a-7e84-4850-8bbb-08dd56a89f8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GR7KiNFzog2KZ2lK+6vqX3V/BKfomm/gSdt1B3rc1xaI3M/MxtibwgUEYZE9?=
 =?us-ascii?Q?W6QUysnHzuiYWrJquBf6Wr+Q2OYR3AUgBQyaS1ONmQlcyboPGJwQrNX27Csf?=
 =?us-ascii?Q?MiwBQpjkkcQwChA9qoa+xet/kiNLJqWyClBmOc3srZ1tkiD5VGxHqgOqkS+4?=
 =?us-ascii?Q?BB/tIBToPFTV6Hm8SN3LWTricRVhyuEevUkb4AX5kiARrnPBNkzXgiwVr/Zm?=
 =?us-ascii?Q?59B7THAw35IGD9i1pUtdOrbdOHpZXnzFW2RIQbdPLl9Uiqlv8NRjpUaB2j09?=
 =?us-ascii?Q?gf4LjMzS6s/jOERoAnEdVJHBWaSJIrkKMMs9UKWS5Ma4Eo0L3qRbpNKQfHYp?=
 =?us-ascii?Q?4R5SN0JiflDRR9tL+EFD3pVNfcExuTLH1mFZEbSo5BJSV0y15O45t+6qdmvY?=
 =?us-ascii?Q?9tgaFsHbPmFqdJG7u20ZnxfZsH9c2tz6ac4rRu/ZRVuG5J9YmsdUVjKH8/kK?=
 =?us-ascii?Q?fA4vtsJacIX+c8KKsZQtHMEXwBHsR0L5GK9liH040c7RXSum7Vg1B7WhEwmw?=
 =?us-ascii?Q?HoypahbFdSmf0SRCFSl6lzB+CUdKnyGfEDiJBZDrr2ofM4eXszAHB/pf96Dq?=
 =?us-ascii?Q?NEDecuhsj51o2vE89lfCrGCt2zDqrxZYkPEk8ulrOLP1ISF9UDNJfBqZ0maw?=
 =?us-ascii?Q?nBm7zPUjuuROzJUZt7ywN+bNHqTURWlPxquCUyZBpoAxPLyfnSJW7KZgHHMT?=
 =?us-ascii?Q?pvIQVReLeFTNb5dgmSetFgqv9puzModJyqPp9rbf2kwvzFUKfQ3uBVnmd9hJ?=
 =?us-ascii?Q?N5xNbYnqWQzNuCEmICUUCOVx+3cxGMAP7OzDu9KS/W1vCVsZK+yM7T5RfS7e?=
 =?us-ascii?Q?wKQOHj+zwxd2RAbI3E1GcmnxJTGi5hWzgs6NdnXMb660GdlDw2saaDXYnA6S?=
 =?us-ascii?Q?sFOflv8hXPLSQVM9gKRJJiflkLPFmjEyLxX6xVlV8zUswnju41ecBGfPZQi7?=
 =?us-ascii?Q?dPzKl2gMbvyS39ehVqneszutR8PLGjkE50Iy8U5LgnCzBGJQmsZX0rhM1OiT?=
 =?us-ascii?Q?2+PpvpKF2W70Ssq2pAM2UkklsHABapAuS4sH7cSiNbLe5/fo6/1+lu1eSzFE?=
 =?us-ascii?Q?KxFlL6r/HFr1nnfk5dNUpBNxbkwMuGrDfdOlBQCSpm8CAawMk3DwK7+u/hc8?=
 =?us-ascii?Q?EfG1kTaGrJI3LLOZ9gHSEONsG4bFVfe9Z7HO5hONOildsxDJhMJ+4fS6PtXb?=
 =?us-ascii?Q?DrR0+4bZp3ql7R9j9sAmjtndfBpYdQBqAjhutW0AH7vlgSil6VcLRKGQtQVe?=
 =?us-ascii?Q?/C+ja7idRSnIZ+0ifca4wdU4233tMbFw/FB8Qh2IAo76aKruLa2rJKXXPgy6?=
 =?us-ascii?Q?QYDpat6+WEIXG4HvV6vb70cZIiiYxFrIkAV7ct7nyXCLNR7i/ZpLmu9ea8Kv?=
 =?us-ascii?Q?oTvG0I27yxMldT/IHm9EWmPQMUZU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rJXB72Ug16D7rtF4WeW0a5hcLx0uSp+alFPGO+rf+gpdpn2nDMBl/O5ENNZB?=
 =?us-ascii?Q?snRY+38iizJb2zwdFeRN20YkvaHer2OTr2CYMeGS/aL+La0dd9beomvxzod1?=
 =?us-ascii?Q?ZMdIsiTAnk6KWZgCsM9Q/NCr8UkPRq/OilK9Bi3dnx3QMj04rUlMuW3hLgjr?=
 =?us-ascii?Q?0OQtNJ/9gnXk3qRENad57RsEjLI8qijYA/7d+7vBpJOkj5FBga+tbaFYN76m?=
 =?us-ascii?Q?FpctAHKkUtproN15ZjrxV+f89/tp2GQYOma/hjsy9hdn1u329q+Bm+gadimf?=
 =?us-ascii?Q?xIjKd25FbdCYKOKyyc168zp9/uZxpEzxptQKvkyNAcOG6zj6JGu6nbKoUixz?=
 =?us-ascii?Q?q4Mrto2RQD5kGrWOCPN1Xq9qUFWlGd0EsVYD8yXsF/46wY087siJW50ZIUNw?=
 =?us-ascii?Q?BxEHD7bBpPgFCG3nkV/RUqaU7k8oLbhD+i0lcQDDbBEH4gGComYV4FKMOKPl?=
 =?us-ascii?Q?PvG+nX8VNN5fMBp2oUyO9PtEDp8Smv26zJuQI+zCI60IupHc7txYxRmuq1ix?=
 =?us-ascii?Q?bZQbcPkHrt2atjTnmkPV1D/kLNoE7Li8oGdncgPynWW2TeAnhaq3qN0cX2bT?=
 =?us-ascii?Q?3bRepX/BS99AibOTh+0+CRyGSVkxMOCaTUpF3Gog0THokiHny0DnpkhEFOuZ?=
 =?us-ascii?Q?C3JNYwTcE80tftso+aqloKMCb5NW09a6Pyts6Y8G27u023Ob9ia2ZizfKLcA?=
 =?us-ascii?Q?5xLjLQig6V/MpmgdLqtOgUb9Na17I7wdOr22yfSrO/RftHMJ3AyadByE7N4z?=
 =?us-ascii?Q?LBc3I3A34nZUUSqO0fA77HMxB1k6saH42qjrEI8rtFRaMX//p2/3u/onKGaq?=
 =?us-ascii?Q?qGQ57C+LO15yLKWfVKERJZU8GvpAzuBonroWI+XP52JvDgrd2VnJ1XA8c2cE?=
 =?us-ascii?Q?7pSmpJByFk9oe9hk9gdeXIcD8xTXM/p3Hh4AdqAd2hrEYPHqg+6tNvTtnex6?=
 =?us-ascii?Q?e+qE8YSaKTuGGTVMDrtQ+EuvJuck9uLhSSvxPvbj5bfFdJlO9AvKpWsQJaEA?=
 =?us-ascii?Q?HecNs7Eiws2zHOpZWtECGvJMb4a8vN813NgN1ejZUENEVqb+PSjvqsDE6LQv?=
 =?us-ascii?Q?+ttBd9VI3JEIujf8s521OGQh7eVAy5oaQqU9qutNFsag02kH1G/FfVXnbg3T?=
 =?us-ascii?Q?ldhdZzUGsRhqBBRM+xIsLAQG8wLafpSyYYEQyt7G5L+y8EGg8Ap/hK3Jj3ep?=
 =?us-ascii?Q?wkL/lDpsLdmAhgNrQX0krpJFyUJrmZiWFSUuT2NR9q7W5iUy7e29kmr4tSOK?=
 =?us-ascii?Q?BKA4GN2k5AIfGsSqEjtMA2iqDf1XnnNl8DUKoqhzSH6upn9DYfdOghVa0i/1?=
 =?us-ascii?Q?PYUaLPsmStw6YTVNxEbcz31s2UrwyjgFH1vPUebgLby3kx3x67AEgrVh0VHe?=
 =?us-ascii?Q?UgR4MVXJvnhBI+WPBUnZ/tmP4MDOHQKtaeo/Ew7oUKEDig82Fbg2BLSsVNq1?=
 =?us-ascii?Q?Eh/A5r73sWQhTNqFGTcQ6qbA7yqwpP7RChvUncdF/r8iy6yX2d2UddqCerLH?=
 =?us-ascii?Q?bVJ97KWpZEbSxXqO0HvucO8qsV7sk9dQ2hbbAGmcj7hdi86rKbM1hy8U9I1b?=
 =?us-ascii?Q?z2tzwGm+B6WIiZi3nKDzZzmSfi9QnpwvKPuR6SU7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fd22b4a-7e84-4850-8bbb-08dd56a89f8c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 21:00:38.9109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hxBFVF4cI6paa3ykXQ9IiwT3m9og/fehPol4P38aKzCYebkkiifvfiYpLvFZEbhB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5614

Hi all,

This patchset adds a new buddy allocator like (or non-uniform) large folio
split from a order-n folio to order-m with m < n. It reduces

1. the total number of after-split folios from 2^(n-m) to n-m+1;

2. the amount of memory needed for multi-index xarray split from 2^(n/6-m/6) to
   n/6-m/6, assuming XA_CHUNK_SHIFT=6;

3. keep more large folios after a split from all order-m folios to
   order-(n-1) to order-m folios.

For example, to split an order-9 to order-0, folio split generates 10
(or 11 for anonymous memory) folios instead of 512, allocates 1 xa_node
instead of 8, and leaves 1 order-8, 1 order-7, ..., 1 order-1 and 2 order-0
folios (or 4 order-0 for anonymous memory) instead of 512 order-0 folios.

Instead of duplicating existing split_huge_page*() code, __folio_split()
is introduced as the shared backend code for both
split_huge_page_to_list_to_order() and folio_split(). __folio_split()
can support both uniform split and buddy allocator like (or non-uniform) split.
All existing split_huge_page*() users can be gradually converted to use
folio_split() if possible. In this patchset, I converted
truncate_inode_partial_folio() to use folio_split().

xfstests quick group passed for both tmpfs and xfs.

It is on top of mm-everything-2025-02-26-03-56 with V8 reverted. It is ready to
be merged.

Changelog
===
From V8[11]:
1. Removed gfp parameter from xas_try_split() and GFP_NOWAIT is used all
   the time. (per Baolin Wang)
2. Used __xas_init_node_for_split() instead of
   __xas_alloc_node_for_split() and moved node allocation out. It fixed
   a bug when xa_node is pre-allocated by xas_nomem() before
   xas_try_split() is called without being initialized for split.

From V7[9]:
1. Fixed a wrong function name in lib/test_xarray.c.
2. Made __split_folio_to_order() never fail, since the old order check
   is already done in __folio_split(). (per David Hildenbrand)
3. Fixed an issue reported by syzbot[10] by not dropping the original
   folio during truncate.
4. Fixed a WARNING when READ_ONLY_THP_FOR_FS is enabled. (Thank David
   Hildenbrand for reporting the issue)
5. Used two separate struct page* parameters, split_at and lock_at, to
   specify at which subpage the non-uniform split happens and which subpage
   to keep locked after the split, respectively. It improves code
   readability.

From V6[8]:
1. Added an xarray function xas_try_split() to support iterative folio split,
   removing the need of using xas_split_alloc() and xas_split(). The
   function guarantees that at most one xa_node is allocated for each
   call.
2. Added concrete numbers of after-split folios and xa_node savings to
   cover letter, commit log. (per Andrew)

From V5[7]:
1. Split shmem to any lower order patches are in mm tree, so dropped
   from this series.
2. Rename split_folio_at() to try_folio_split() to clarify that
   non-uniform split will not be used if it is not supported.

From V4[6]:
1. Enabled shmem support in both uniform and buddy allocator like split
   and added selftests for it.
2. Added functions to check if uniform split and buddy allocator like
   split are supported for the given folio and order.
3. Made truncate fall back to uniform split if buddy allocator split is
   not supported (CONFIG_READ_ONLY_THP_FOR_FS and FS without large folio).
4. Added the missing folio_clear_has_hwpoisoned() to
   __split_unmapped_folio().

From V3[5]:
1. Used xas_split_alloc(GFP_NOWAIT) instead of xas_nomem(), since extra
   operations inside xas_split_alloc() are needed for correctness.
2. Enabled folio_split() for shmem and no issue was found with xfstests
   quick test group.
3. Split both ends of a truncate range in truncate_inode_partial_folio()
   to avoid wasting memory in shmem truncate (per David Hildenbrand).
4. Removed page_in_folio_offset() since page_folio() does the same
   thing.
5. Finished truncate related tests from xfstests quick test group on XFS and
   tmpfs without issues.
6. Disabled buddy allocator like split on CONFIG_READ_ONLY_THP_FOR_FS
   and FS without large folio. This check was missed in the prior
   versions.

From V2[3]:
1. Incorporated all the feedback from Kirill[4].
2. Used GFP_NOWAIT for xas_nomem().
3. Tested the code path when xas_nomem() fails.
4. Added selftests for folio_split().
5. Fixed no THP config build error.

From V1[2]:
1. Split the original patch 1 into multiple ones for easy review (per
   Kirill).
2. Added xas_destroy() to avoid memory leak.
3. Fixed nr_dropped not used error (per kernel test robot).
4. Added proper error handling when xas_nomem() fails to allocate memory
   for xas_split() during buddy allocator like split.

From RFC[1]:
1. Merged backend code of split_huge_page_to_list_to_order() and
   folio_split(). The same code is used for both uniform split and buddy
   allocator like split.
2. Use xas_nomem() instead of xas_split_alloc() for folio_split().
3. folio_split() now leaves the first after-split folio unlocked,
   instead of the one containing the given page, since
   the caller of truncate_inode_partial_folio() locks and unlocks the
   first folio.
4. Extended split_huge_page debugfs to use folio_split().
5. Added truncate_inode_partial_folio() as first user of folio_split().


Design
===

folio_split() splits a large folio in the same way as buddy allocator
splits a large free page for allocation. The purpose is to minimize the
number of folios after the split. For example, if user wants to free the
3rd subpage in a order-9 folio, folio_split() will split the order-9 folio
as:
O-0, O-0, O-0, O-0, O-2, O-3, O-4, O-5, O-6, O-7, O-8 if it is anon
O-1,      O-0, O-0, O-2, O-3, O-4, O-5, O-6, O-7, O-9 if it is pagecache
Since anon folio does not support order-1 yet.

The split process is similar to existing approach:
1. Unmap all page mappings (split PMD mappings if exist);
2. Split meta data like memcg, page owner, page alloc tag;
3. Copy meta data in struct folio to sub pages, but instead of spliting
   the whole folio into multiple smaller ones with the same order in a
   shot, this approach splits the folio iteratively. Taking the example
   above, this approach first splits the original order-9 into two order-8,
   then splits left part of order-8 to two order-7 and so on;
4. Post-process split folios, like write mapping->i_pages for pagecache,
   adjust folio refcounts, add split folios to corresponding list;
5. Remap split folios
6. Unlock split folios.


__split_unmapped_folio() and __split_folio_to_order() replace
__split_huge_page() and __split_huge_page_tail() respectively.
__split_unmapped_folio() uses different approaches to perform
uniform split and buddy allocator like split:
1. uniform split: one single call to __split_folio_to_order() is used to
   uniformly split the given folio. All resulting folios are put back to
   the list after split. The folio containing the given page is left to
   caller to unlock and others are unlocked.

2. buddy allocator like (or non-uniform) split: (old_order - new_order) calls
   to __split_folio_to_order() are used to split the given folio at order N to
   order N-1. After each call, the target folio is changed to the one
   containing the page, which is given as a folio_split() parameter.
   After each call, folios not containing the page are put back to the list.
   The folio containing the page is put back to the list when its order
   is new_order. All folios are unlocked except the first folio, which
   is left to caller to unlock.


Patch Overview
===
1. Patch 1 added a new xarray function xas_try_split() to perform
   iterative xarray split.
2. Patch 2 added __split_unmapped_folio() and __split_folio_to_order() to
   prepare for moving to new backend split code.

3. Patch 3 moved common code in split_huge_page_to_list_to_order() to
   __folio_split().

4. Patch 4 added new folio_split() and made
   split_huge_page_to_list_to_order() share the new
   __split_unmapped_folio() with folio_split().

5. Patch 5 removed no longer used __split_huge_page() and
   __split_huge_page_tail().

6. Patch 6 added a new in_folio_offset to split_huge_page debugfs for
   folio_split() test.

7. Patch 7 used try_folio_split() for truncate operation.

8. Patch 8 added folio_split() tests.


Any comments and/or suggestions are welcome. Thanks.

[1] https://lore.kernel.org/linux-mm/20241008223748.555845-1-ziy@nvidia.com/
[2] https://lore.kernel.org/linux-mm/20241028180932.1319265-1-ziy@nvidia.com/
[3] https://lore.kernel.org/linux-mm/20241101150357.1752726-1-ziy@nvidia.com/
[4] https://lore.kernel.org/linux-mm/e6ppwz5t4p4kvir6eqzoto4y5fmdjdxdyvxvtw43ncly4l4ogr@7ruqsay6i2h2/
[5] https://lore.kernel.org/linux-mm/20241205001839.2582020-1-ziy@nvidia.com/
[6] https://lore.kernel.org/linux-mm/20250106165513.104899-1-ziy@nvidia.com/
[7] https://lore.kernel.org/linux-mm/20250116211042.741543-1-ziy@nvidia.com/
[8] https://lore.kernel.org/linux-mm/20250205031417.1771278-1-ziy@nvidia.com/
[9] https://lore.kernel.org/linux-mm/20250211155034.268962-1-ziy@nvidia.com/
[10] https://lore.kernel.org/all/67af65cb.050a0220.21dd3.004a.GAE@google.com/
[11] https://lore.kernel.org/linux-mm/20250218235012.1542225-1-ziy@nvidia.com/


Zi Yan (8):
  xarray: add xas_try_split() to split a multi-index entry
  mm/huge_memory: add two new (not yet used) functions for folio_split()
  mm/huge_memory: move folio split common code to __folio_split()
  mm/huge_memory: add buddy allocator like (non-uniform) folio_split()
  mm/huge_memory: remove the old, unused __split_huge_page()
  mm/huge_memory: add folio_split() to debugfs testing interface
  mm/truncate: use buddy allocator like folio split for truncate
    operation
  selftests/mm: add tests for folio_split(), buddy allocator like split

 Documentation/core-api/xarray.rst             |  14 +-
 include/linux/huge_mm.h                       |  36 +
 include/linux/xarray.h                        |   6 +
 lib/test_xarray.c                             |  52 ++
 lib/xarray.c                                  | 131 ++-
 mm/huge_memory.c                              | 755 ++++++++++++------
 mm/truncate.c                                 |  31 +-
 tools/testing/radix-tree/Makefile             |   1 +
 .../selftests/mm/split_huge_page_test.c       |  34 +-
 9 files changed, 783 insertions(+), 277 deletions(-)

-- 
2.47.2


