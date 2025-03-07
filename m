Return-Path: <linux-kselftest+bounces-28508-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 166D4A56F4D
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 18:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC6A717A99E
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 17:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D953A241663;
	Fri,  7 Mar 2025 17:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g1y5NtZ6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26402405F2;
	Fri,  7 Mar 2025 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741369213; cv=fail; b=am1qQIFBNicYdrudvyDPwzqon/75tNfkGOsXBQyubC9WTKSgjY8XCOr7/gyzmeakk2VeogCnq4S9WuvItfUgoiYuU2sdRjnPSjfUuQyW1d9ESIhy2APxB4rqPU1/FJ3VCRqfRXqhwCVFYhY+Uc2sDJnoX+RCzU9Ld+iUUqgpUl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741369213; c=relaxed/simple;
	bh=zcfWciMbuipX+94Hg2Z2c4FQJ9EyBaA+rQLBoM0a5BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=laCcjME/2Nygz7vX3GjSaiJ6gdIzgxkis0rjuHQB+wMUI7OIopuaB4iHh8twnYoKb8/i2i2S0oJxoj04voqqFsf5Fc+6aAWbJhRU3VWzUoqtDJ8BhLjZMj8SjgyiHeA107RrQk8VSKQI/BgVkwsorbKlqGp5U0GHAIfc/2os8Pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g1y5NtZ6; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rlfoGJUu0GettZdiY8uzfbf57BjuGMpv6ZKJI/bEz+iVyJt37xbIv7U6r32SpRVEaygRww1kS1UwAhKHqMbzyhk+MDRonGybV8pMEsCRKZkoBC3tqxiYdL5O8AjZN50YAzfoXnlDoETNn44KeTV7kgdH6/8U/vyAk2cC4fA9SPUfCdv/Xwg6t/O8Slpzp2fmkdJ1vjhrhyEemxlnT1jwn44RSy/Zf/wMmwFug6ZpqfbrRhFuse7I1xArwN4zir/ZVhQs9ea5HFM/kFoLfTgsuh+LwI+okscbNt9EmIZFAbyWQtS3zOhXyFrcUOzyg/Z8jjv7deWjWbp9Gjt5Ydtogw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flV2jrwKGbPrv2l9PSHexLdRMWDinAN4uJabE2MUJUw=;
 b=JYlU6wqlgTvG5KFuhBJdB2vgLR/zLLNsfK1UMRkFLpe5rJJKpPpcegcSmTxCgwfwgWa5NV1vLpz4n2Cdx66V9/XQArMlX+DXwr5/27f8VUZT5oMqkK0Jk5yjELW6cEVCP7Li3W241Z/bxpJ98HYc3/qiOUqpKJwmMPFWMqfTS8ac1bziZEXqGhuttw4VxW5anyK6kDAkOn8nPIqF80p0k0uEg1Ux0ltYRdAqr+RVio1iXMOP+RgaMDL8sxVjqOPx+ijtnWybQHgLsw/qngt3my26Xdkasy9WTsT3SSg6re7FJhHfC9+9MEW2mzCW3pEsIoTSa29bLRgSvnQFrGBYCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flV2jrwKGbPrv2l9PSHexLdRMWDinAN4uJabE2MUJUw=;
 b=g1y5NtZ6Z1vvExn/crAKq0O/z62L1y7+jwQYel5vMWul3BRC1uaxq14em1jWTePfsf3HzjIzlbqY5/FBUu0nbdVZnf12YebZHtV9FnlRGiDBjrJ+SizEaEAWmwDlRyoF6iTjfxkylmlqFINL694bv3CwLdPrtqa3pE0qSFeikAk6Dg0sElJA7jndHNhWiu3i+0m0Iwy9XFVTImGgU4jYQ4i3E1puP7V9KEs50go5FvX8JS99meKIAB3dEeIpbMCb+AxB4WBs28iZQ/FIqzumjFXnP4tERBmqY2TbajEmq3+p30sExMt/bZasFQ0GDKBek4/qlgAfMeyIRojLSBCZJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 LV2PR12MB6014.namprd12.prod.outlook.com (2603:10b6:408:170::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 17:40:08 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8511.020; Fri, 7 Mar 2025
 17:40:07 +0000
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
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v10 0/8] Buddy allocator like (or non-uniform) folio split
Date: Fri,  7 Mar 2025 12:39:53 -0500
Message-ID: <20250307174001.242794-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0137.namprd02.prod.outlook.com
 (2603:10b6:208:35::42) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|LV2PR12MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: 391ff5e2-d08b-48d4-1446-08dd5d9f19fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zH3glB5sEhOwWNFF4Ejztvphci3oAPggOv78rFPe7YOS1OhpcqaXLx8TB3So?=
 =?us-ascii?Q?zgRhjx7Xp5vjmcDqwdDzxQDttzDHjJT1lAWTz3dxy8WfvqvP7VzNgPb9nMZJ?=
 =?us-ascii?Q?uAk1fhWvIXCjH72a00WcXmgzOwYhaLpHeLqNe/sRfW8ci5vQPCumymFLbSuh?=
 =?us-ascii?Q?fEOidZo0kEcT13RK7JvX0qyhn//NK8WZsjVPZjFeuw0g/LOwiUe8hO0dqEq8?=
 =?us-ascii?Q?Eas8pIQsDuXLcY1Om6q08o1ddZ8fdyLQv9xiI2DvReePHrbExF9z8PrF+MRq?=
 =?us-ascii?Q?3yjXL7N99bXmYRuY1VclgSt0kCtqCeb6LaTODmoOZssjAH5X8Op6rbose4QC?=
 =?us-ascii?Q?yIhFXwFH9VhCntBgZDJJdG3HHNw3FQJlrcEh+1oeWl0LqFdF8wzn6pHOXZqW?=
 =?us-ascii?Q?MESJUM6pJhPhGCWh9zShTSF7sK44zqhQfHyKNB6Jwf5jfiJIQp7dpMztXQKl?=
 =?us-ascii?Q?JUjrjdhKcrUYeCBilLLim8b67u1Di1otIFC3DZ76Dy/uc7SaU5cmRd/1F6HU?=
 =?us-ascii?Q?uI+QTu+qEfNRrNyqBI3phz14ACkaeuOQlRiTRTeQZtW8UXDwbtlSUAsOhQX8?=
 =?us-ascii?Q?4tEbxLUnGZ7yTXYkeep0RolB2YJD2oCmhYJ2o7pPxKnjkcgFph0NGiKW79IW?=
 =?us-ascii?Q?MihHn9iiNiqDOJBaFZmCGdYuacuvdaQW3PTDwhsBkSSJRZ8ZV7ce/uW/T2Mu?=
 =?us-ascii?Q?LmgD3yEW3cVJS3KlVbqD0tzT+njel3tZz5lxy2Oj+GgOjfv1dwZtM6/D+Arg?=
 =?us-ascii?Q?I0mw/Q6Rnne5N9WbwrR7saNdsnvB6+Wn/YCDXyys52a5hoVm9Dpe5ozJLCvD?=
 =?us-ascii?Q?/CnAbNwqyOttX2N79l0wc2Rn1jT//IJ3tDGOSKuyuhT3XMGZMEq0UgMwKe7w?=
 =?us-ascii?Q?fNmGELpHZJOCFQHByLtlZnXbx7fx1F2iHxwA8B6jAYL/Ttkp1lMy4lDg9/Lw?=
 =?us-ascii?Q?pa9uHdkrQJoa9KXzjRsoZHRbUmfb440INikpJusKQyr5e6I5tOcK18IXrm4z?=
 =?us-ascii?Q?GZ+lc7P3cLcaqYjPEKfjOngacibA/hq19TYx6BrIjngO5EzqfbUU27JWrZef?=
 =?us-ascii?Q?+7udQrU1AQeTst08Ci35I4yRkaPntrO90z99jzyJbImygGjuHEmqjDIXn/7q?=
 =?us-ascii?Q?Sw7GeuHOO6oZNgAFkGLAVc5ka/rhLgaPOThTAqccJiRdLivTlJBxVIcjs60u?=
 =?us-ascii?Q?RuMKL1GSH0zumUBI+FLmJyipQxSnBu7MYdH5pH5Nr3rMD/hdZg4FgE3Bj5zJ?=
 =?us-ascii?Q?Kv/xbK3naLrVXc3OWRgrwmBKY2bb7Lu1a0BYYl5pAPOqIGLsN87RiCTpVzud?=
 =?us-ascii?Q?h0k8L32jyICuVFAHyomaXj8UfI1lJW6T+w42r2A0JOyYXTig+midCyoNVrbd?=
 =?us-ascii?Q?ZEyVMtwyhk8lE+PwGkdP0DI1Xq8d?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Spl24PqH1wqNbSBEQHksimxaoHVZeE81vZryXQ/et5XRJ4i2VOt4N1VEP3kg?=
 =?us-ascii?Q?HJOjPd2sSAmUw5gWk76rTayjsCiR5cQCn1IbnEB1yO8Hf7tG4XKeuubObtXn?=
 =?us-ascii?Q?iDaRmugebJ1SyPImKJwLeeFZtgEI+EM+0Nzy4Ahij3F4ZO+CdcYqa/f5mvXP?=
 =?us-ascii?Q?B4ANrG7uCdaasWkPIOyNVcrVcD8NxNM5Tz4PHXCNIdKSq+GnNPuAY/JZPwqF?=
 =?us-ascii?Q?DpN9H1ibViSKR1mgGdNC1AA603mjxPtx6BkMLXdHd1InXRrSt9yV7IfX2K0H?=
 =?us-ascii?Q?09451OVFXLpZI5Zsp1ciUIaSQ5xSnJSdE0ruFeaapAcEhecB7pyFPNrDlExd?=
 =?us-ascii?Q?aobZGfs5OLc8svV/BuzQn/MKrqQfVneHyjS5s/LGoEfCocexDAGRaerYv0UB?=
 =?us-ascii?Q?yq/ZZzMl9WiIls1XT74ncjzbhgMrY9zfitAVnv/Su5LEtn3L8qO38dNlMUng?=
 =?us-ascii?Q?yotDq+EhlEQ0mniiBjjHOdc3MnJc0272Lhel1xZfBOXMlG7uNFjeN9lUVUxe?=
 =?us-ascii?Q?5WwDwH9digeYxeBd7lHRjtCcpwmwPKWQvOQu+ycGE4YiSS5zRKqvfuoQrXPp?=
 =?us-ascii?Q?l4oDta6VEuDEthc+H+53/B2U0j/D0CcY3BfsO2LEvBqSqGmFdz87PTg/Q5gs?=
 =?us-ascii?Q?w8su2x9SguolcAt6IuxVlPryCgsepR5MfVZ4yi4jG18HpAaCRjOtFHu8nc4z?=
 =?us-ascii?Q?tSHORhehXhBC2GgSD9UpXFGB7RVlo6kMde8QTzJoNuhTwYOivJhsMrztltVL?=
 =?us-ascii?Q?Mc+5f4dQQznaif0NCSrZEm+IQ14g4lDvBtvkDToYooU8uQX92Qj0cuCValQj?=
 =?us-ascii?Q?MYjA6R6Xib1+LpW8N17joGznmJ24QZ/1BYDcDy0Rikk7M9UYu3HOE2Z6BVFe?=
 =?us-ascii?Q?rEO7XiOOxNfNt4l4yVxhRyT4/fr22pbiAWLO6no8CQDCpPv/HWGpGasbMZVR?=
 =?us-ascii?Q?+3y3muWd3yTBjGuEIs6gqFURAuPIcfZT0oN0a1/ZareuDesIJKYYrHN98PMQ?=
 =?us-ascii?Q?wjxJqXAkvQ4x677KEwCXPMcHo7qHh94fJ7Zvxcso6ccjA9ZzDU5yOo81KyZS?=
 =?us-ascii?Q?I5o5o0ga3Wn0JwRBeMzCuzdAzVyPPpLl/Pcq6GkBon+oMNwCjdNb1T3zhkUH?=
 =?us-ascii?Q?66z5STEuFDm4HaVfnNFZbL/AQV5ggMsdfLXaPXzTU3zv9oOzqeZ0nnR56uWu?=
 =?us-ascii?Q?7q+3RCT6hEDh0bMfbdpFKg2merWoPgbWBsQG0wFt3DA8ArIO5KI9mhcWJA2Y?=
 =?us-ascii?Q?B26ksV0USZXOe1TMJYc2O/N0UPlcctWvEx7DDDEzGbPYVVI88B2jpGA+lxiY?=
 =?us-ascii?Q?qjy9it7/NFVfmkAtcg4Z4neal6M7TktJYFPzHqFwEfCpc5zmk4cpQZY8c69o?=
 =?us-ascii?Q?vrLdeAhIz53IbTr49P9sllAQqVO/3kjHmi1hTcZLYthodZ+wKNAdrV+qEXNj?=
 =?us-ascii?Q?l+aOUds6TT1dbJm9n+zoR8/dVYLEfvY0f4EUBquwEbKj43pLa3S1FBNXdd54?=
 =?us-ascii?Q?oKNiUmfcYV0DnP3BvJStBCYgtt9CqxyGpMKyzkRfw1Ml1yWi5SmuSRqFiTV4?=
 =?us-ascii?Q?xMjzpnSPkTNU10ICgmA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 391ff5e2-d08b-48d4-1446-08dd5d9f19fb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 17:40:07.4840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KtaZE3wHuTeSK9PDrJmSNeSM5X2I9W5Z5LY4QXoo4E7zY4vyNR80NE2LuVZdceHp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6014

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

xfstests quick group passed for both tmpfs and xfs. I also
semi-replicated Hugh's test[12] and ran it without any issue for almost
24 hours.

It is on top of mm-everything-2025-03-07-07-55. It is ready to be merged.

Changelog
===
From V9[13]
1. Incorporated Hugh's fixes[14] (Thanks Hugh):
   a) moved folio_set_order() in __split_folio_to_order() to be called
   only once for the input folio,
   b) used folio_test_swapcache() to catch both anon and shmem in swap
   cache cases,
   c) moved folio_next() out of for(;;),
   d) used mapping instead of origin_folio->mapping.
2. Added a TODO in __folio_split(), since large in-swap-cache shmem folio
   split is not supported yet.
3. Changed __split_folio_to_order() based on David Hildenbrand's MM owner
   tracking for large folios patchset[15], due to rebasing.

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
[12] https://lore.kernel.org/linux-mm/D45D4F01-E5A5-47E6-8724-01610CC192CC@nvidia.com/
[13] https://lore.kernel.org/linux-mm/20250226210032.2044041-1-ziy@nvidia.com/
[14] https://lore.kernel.org/linux-mm/2fae27fe-6e2e-3587-4b68-072118d80cf8@google.com/
[15] https://lore.kernel.org/all/20250303163014.1128035-4-david@redhat.com/



Zi Yan (8):
  xarray: add xas_try_split() to split a multi-index entry
  mm/huge_memory: add two new (not yet used) functions for folio_split()
  mm/huge_memory: move folio split common code to __folio_split()
  mm/huge_memory: add buddy allocator like (non-uniform) folio_split()
  mm/huge_memory: remove the old, unused __split_huge_page()
  mm/huge_memory: add folio_split() to debugfs testing interface
  mm/truncate: use folio_split() in truncate operation
  selftests/mm: add tests for folio_split(), buddy allocator like split

 Documentation/core-api/xarray.rst             |  14 +-
 include/linux/huge_mm.h                       |  36 +
 include/linux/xarray.h                        |   6 +
 lib/test_xarray.c                             |  52 ++
 lib/xarray.c                                  | 132 ++-
 mm/huge_memory.c                              | 786 ++++++++++++------
 mm/truncate.c                                 |  37 +-
 tools/testing/radix-tree/Makefile             |   1 +
 .../selftests/mm/split_huge_page_test.c       |  34 +-
 9 files changed, 809 insertions(+), 289 deletions(-)

-- 
2.47.2


