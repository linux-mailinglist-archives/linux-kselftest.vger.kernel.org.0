Return-Path: <linux-kselftest+bounces-28652-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74475A59AB7
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 17:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22E983A59BD
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 16:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1F622F389;
	Mon, 10 Mar 2025 16:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kFDz2EsS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2060.outbound.protection.outlook.com [40.107.102.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C120E221708;
	Mon, 10 Mar 2025 16:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741623259; cv=fail; b=ea7sDdQ4ma3UYB8J9g0XKgA0EUgUZHdbo0BeKCZlwpTZYmPYp3B4A9SZkzoNf7L9ETleq2LhdVt9Yg2GkUvYYu9sxzHC4SptJQXU8zGeJLbzzGuyU1gexrcq1DRQuxpniO14HPgPsxNPh2T+u3M0az9FcHTWu0+VA/jqyuNmS0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741623259; c=relaxed/simple;
	bh=fz3Pr+AhpWrtTv9B90xzVbG/b2ZjvE03wDyfURyqWkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OPMSbMFrZXkfow9gKM2Gj6OW4447fn2KQkveJU8W2eR/7/hYRL8If7JrktVvD3nw2SUI/pFpbAfrH/GAo5Ovw41pE7iDGhLfqrpHPBXbjOFB62E+WqSYEropz25HDDCaSUGFiTi4Jd+38QjBZPwgwaP8lYDNGqhn/lS/Oo06byI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kFDz2EsS; arc=fail smtp.client-ip=40.107.102.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b53Bwfw2Uq7p2mAnXzXvsc0jVbs44YoqHS2xcovs/AZC6oj70ZpkvQU+dbHmCcO6Mahl1bTVjCrRokWht/sKnWPTCp1+64RVBOJ8Tw8WoBXis9KF/PoxnsgphrgI43qSBtMV3IL+VUkk0xo0CoSXvR3dbRHxWAHjGYgHDR9ofLNU/nBfwlblsA9ks82NgSTOTAbvp+EHPbTvqMVbfx6Cz0/7SO8sr/55pPKRXQUJ+5osIknGT3GSL0mB8EJ56hyiOlV8siD3cOoA4tqtzLw31LyD3NFdAM84h2r+6BZ/AVSYh+gyVkshkM+zwr1K1EC/f0owP2rrJgsOM+a+f8HrmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IbLkNPq7wEotwjHxdQvsYQp9ho5TDFi58b8HZumRlXA=;
 b=aNJPiYPmCYQlnXBNbHHEQZbRnsiR1vi+Pua0nJVP9esrC1hqwUEZTQFoG6GWO1PnjBgvDzIgwJkuOuOdmuQbHZQzMEYvvgTqaODChbFFIRKQq+qiodOGdZ4lJ0udnRFBcmLdWAZQem5UVChe+eAvGuPWJSLxSfXKEiTe+CbDcabza76oBK97LdZm+HboZkxjCnZAeRKvyUCW7q2REXjOuKNa6XzdIThvSBvx7a0kRefFBBa901Q/sTT/F02vMaaTfPNEm/1qSVovfdYUYr6zYd7ABByJg0WEag9r37/SF6LF0SX0P3z8UQEkp2flidI2APZoJ6sGaJ2eaLTTPffy+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IbLkNPq7wEotwjHxdQvsYQp9ho5TDFi58b8HZumRlXA=;
 b=kFDz2EsSqNy0sz5zaP3O9jdi97DAPz6/kb7TIilJ6b5hUIdYlzvsw8/QngfMXZ6m33PJBWsKBGhSc/yPgEZmHiefAHuhisxmRSk+a7GlnGOtXN/i8Gjzd7vWknVGUN72mcCvJAN7me28YsJRx8r1bsdES2efUekv0/TA82rA0nB+mI0aJrKLnIKtlLS74Gr2PBGlO3seAKcRNXnYyqCn1/2SBXBPxfHh69JjlBuybda5OAS7yioAlYVJzTzeHnZjM73mK/cLRjanjRm0DNlA11ntCl25HukclpBswz6P8JQhc2dqXuvi97uRZL+C60pGnWEdpGsnP8ktlFRZBBl0Yg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH8PR12MB7158.namprd12.prod.outlook.com (2603:10b6:510:22a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Mon, 10 Mar 2025 16:14:14 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 16:14:14 +0000
From: Zi Yan <ziy@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Ryan Roberts <ryan.roberts@arm.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 David Hildenbrand <david@redhat.com>, Yang Shi <yang@os.amperecomputing.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Yu Zhao <yuzhao@google.com>, John Hubbard <jhubbard@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
 Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH v10 2/8] mm/huge_memory: add two new (not yet used)
 functions for folio_split()
Date: Mon, 10 Mar 2025 12:14:11 -0400
X-Mailer: MailMate (2.0r6233)
Message-ID: <71414652-95AC-40C6-87BB-2B3B2E680C58@nvidia.com>
In-Reply-To: <20250307174001.242794-3-ziy@nvidia.com>
References: <20250307174001.242794-1-ziy@nvidia.com>
 <20250307174001.242794-3-ziy@nvidia.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1P223CA0008.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::13) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH8PR12MB7158:EE_
X-MS-Office365-Filtering-Correlation-Id: dc6cadb8-c0fb-4950-b112-08dd5fee999b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?50/kjkiNbWApzEOuWo7VdlAdhQFB6yfAF7Ji4uvGEJo/1Sr+QX7cw74jFmij?=
 =?us-ascii?Q?qDcJLOaDoGW+GsuEm7kk1KueS3b6afbmo23/CY4C4FhBcidyDhLevyk3PrZ3?=
 =?us-ascii?Q?RvcK155ytcNx8p+bTjFFsU1ZjnEUZEnnUbO6wXXNJRpyH9lg9U5PaBvFNfLo?=
 =?us-ascii?Q?4lBdqRvh43ZpXbu9eyJNA8nhpRcCJC312L12f7K273uD7EbXW8UHiseTaygT?=
 =?us-ascii?Q?WC/JWZw1pjNG5clYbqtGKPcF6DgXRCzph96ETZa05ODwvut5xVPV8yPIGXz0?=
 =?us-ascii?Q?By8oQXFSjiB0+840rEIKN9j3RSfIVmEZViuoQaWR7Sw6mmUOr78J8nM6Pu8z?=
 =?us-ascii?Q?O+ifQfJhPDPYKAbs3t5keqtXbMNNVcqWt9/G4qGQvdPFWSU8zUXHWQwOUT2M?=
 =?us-ascii?Q?V/KxkqcKAXcSEiZpMN1J8DfllL4TyHOEO54KwP7nY1BZDSBYEIXAHWWmF2pg?=
 =?us-ascii?Q?7KFPP5PcILJHNK7c0NLC1oXDpfH6S4iul8/ScUaow1to0OlRnow79yCm7Z+e?=
 =?us-ascii?Q?ulSIJ1H68jy5G/oaLKCbyFZ9krGuhJolvHX+DBkEYL/j659FWIC/kLRiSgwV?=
 =?us-ascii?Q?L4xzj4omMmLYO6WE/xtgPlOers+CpiHvC7h0JhrZVpZ2dG5hA/aWGXAjXi4D?=
 =?us-ascii?Q?rIyKsQk947D4Z9VkJWVhLYnoKHCU+Z3376gePcqsDK/1iMMFXvYrkD4i3GyQ?=
 =?us-ascii?Q?NAKyZoFkxX3rN4HTrX5V6lk7Zm9H80DtnPf673BExMtaBy1bzdB1O4wAUeJO?=
 =?us-ascii?Q?1M8x3o2xPS3Lu791b0KNlCQjCU57fH9H0JhICV5ZIRVlfYppqUqYWvugdtIW?=
 =?us-ascii?Q?lja8G5fJA0Gar3c1y/0gpQ/YHwZgFT4Vh4xYKpnjgabCZKQWYiEVwxfHsAFx?=
 =?us-ascii?Q?WIOK2xru4TrXAiXGrdadNV5XPNsyRujg+CqZ5FI2VklmH14S/fb9KnV6Eo2+?=
 =?us-ascii?Q?FNc/mOLhw4OVT9Ir8dclVU2SvGkBhJ3OCq4k5I9+3Xncdk9VMFJfhwDvHp+8?=
 =?us-ascii?Q?ZiB9h+R4v6MBY7+cT1d+4ku/3rzqYM4sl+mmyqPwRWkEr8XpmT1tXJrQcmTr?=
 =?us-ascii?Q?P7GiN5GjIFkx63qvT+wG6RXrUdSxlXbZ1yqHjDyE0OiomgnxBK6NIPjFFZ97?=
 =?us-ascii?Q?PgKYboWXzptrnwEIW1jjA1q0vE33aq545SreqE/gA4Xg8iSRImWyI1PBhxsn?=
 =?us-ascii?Q?bN/Qk3yDiQXglaRl02RHFXIxqr3zi9WLHb2ad/Ne+dfJm9Tl6x/jYgo6mpzn?=
 =?us-ascii?Q?uALJZoXBnGtqmuXmEvBx4kl0EWLOBZ3w68kMYLFqvkog6QzuzPR1Pz54jQtI?=
 =?us-ascii?Q?rbursQbekPAfI9wAojrisbjapaqezLtEP6RydiveVL8nHF3UXfRhyJqS2pIc?=
 =?us-ascii?Q?DdA8sNtuo/RtwTuzHTS0++r2auyv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5ka4KW8A7Sz52F+tfB1a2ci1M2pBJOL4v8806ME6RvTc6Xvz6J3UkGS4yNsC?=
 =?us-ascii?Q?xyUsad2CMmZIPKRmsc6ElZ9wRhyfra5y7rhCzUmrBFPHFbufBKxh+5ot8g1S?=
 =?us-ascii?Q?2+eWKPCiCmFZA3Toix6Sg5Fe8se28C3rXz37vx+oO2O/H8j9yNJV93mTTjN8?=
 =?us-ascii?Q?vo9Cxl+FdQ/pTVZeQyidyVFtML/6y7D17MVvpZ3c3nP/lba8UgN5U7rtiOkI?=
 =?us-ascii?Q?+YIqMEo/a8NoLhbjXBXfXkn5PjhM560MkhihJzeRLA0UiWKGrDjUOSCj7Xmw?=
 =?us-ascii?Q?JR8ReeKWdza6542e7AJ96wQS+FUMUK9FT3bybcE7TiXZ3+6oRNkb/pRgA9OX?=
 =?us-ascii?Q?+JqWYF3zmLwqcvic1XG2fMjLTr6OUfrsRygWg4wc5u7Tnqg0m/1KAqJvRGRp?=
 =?us-ascii?Q?n2qc7iy5Y4C4GxWf/1ddzCXnOzW4Bjpi04ndAwduXV4mEki4o+DdOPuhBrOZ?=
 =?us-ascii?Q?A6BJoL3TReMLQUAgN4Iw5BnmFm38WE1sHxRCY0Ic9x8t5hN6fcTbsIbjIbnY?=
 =?us-ascii?Q?VwYr53KQnnEG0+DD7G0pht35vLaxZxRyS0gVmPQi9xmWMDeCm0Qc0lGAmLuo?=
 =?us-ascii?Q?vPTKyhibbyIWIcoBv0QceGjEcH3Xf1e4pjvatKpnP1+ku0JVG3foRTBarY85?=
 =?us-ascii?Q?K1ufgMLyOwImSI0o8w8wgTcTaE1DWSQ/33H9rP01qYu1V4hVURd8oxWWF0uG?=
 =?us-ascii?Q?51mQ9ZVN8NXWwS8lwkLxc5Tsv/BGVGTGNq1VLcmDt9b7WdeQ1tq/E+k8gwxt?=
 =?us-ascii?Q?suAhgD/r4zEHGxP5RLYupCb9t3l5yldPzjXl19pJmPWy+XNFWdBW1drPlLVB?=
 =?us-ascii?Q?q1XF0Psgzl+vjpxeonPcGgHEe3wgIibbgmps1+bNYlAgmVbKKkKgP/0oV1GR?=
 =?us-ascii?Q?ohEq5IbYRwxhMdDLuO+n07VcOqPAwJ8SE+ofkkbv9l8dsvv7TZROJtKk7wA5?=
 =?us-ascii?Q?4jT4jFIKc2eA7LVO5kUdSBrTEVr9SRLO1DO6Q1zZ6PMgTEwNnCOwxZqSuVvX?=
 =?us-ascii?Q?/dwQ7DDtWM0JeOhgxaqb2XpHt3PFJ7tCSfUmvUOe2vo6YyJR0cVhyOHDfLk9?=
 =?us-ascii?Q?cKV2tDPg+OrOWMLNbpsPTYkiLh53lkdqhNYo6kyDocWtuaYHiQ0XVROqk9+2?=
 =?us-ascii?Q?jVYkirrvZMO9UY63SpdcuzKtMAh65fm/6JAuDmckFodeqF7XlP4eyVQoiVs2?=
 =?us-ascii?Q?0Al+20CD8ORK/eqmrBtw2f40mZeKk73neodCiEKIgsPr3Vonj4cr6drcejVT?=
 =?us-ascii?Q?o3R5WWGwEfyB67ZI7UFL+tTPD1hYCfreeqlU/RfYfUj3NTgcchuw56FDiP8O?=
 =?us-ascii?Q?Vov78AZNXPAu5tXsTLhUdC6fIWULyNi+bGz0nbauAY8e9dJF8/AsV+SodV9D?=
 =?us-ascii?Q?b+Ux87+VK6f922mXAluVBkhU+FGnYDN0q7d/6398YTvoHYYea0OKCqAgYjr0?=
 =?us-ascii?Q?58acKM20VwKyt9WP9CtWGznYnmafiHppcsSjwS9nCoCwaOmPqN2nB2p8TEjx?=
 =?us-ascii?Q?3/+LcgN7MkDdtie9yQ8ggR72dB6RamUuIKaBPp3WHTWWtQron4i+yv7adGit?=
 =?us-ascii?Q?ythtJs1IhNwf1Sd2pDA7gbHtjJC81YMbOlVf1mPY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc6cadb8-c0fb-4950-b112-08dd5fee999b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 16:14:14.2089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mb/3V/mcGYwjNPqFTdXTD4RWkeq+ARqqbLX49Lr93hQg1SpxuWTg55ShxLOsLOdY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7158

On 7 Mar 2025, at 12:39, Zi Yan wrote:

> This is a preparation patch, both added functions are not used yet.
>
> The added __split_unmapped_folio() is able to split a folio with its
> mapping removed in two manners: 1) uniform split (the existing way), an=
d
> 2) buddy allocator like (or non-uniform) split.
>
> The added __split_folio_to_order() can split a folio into any lower ord=
er.
> For uniform split, __split_unmapped_folio() calls it once to split the
> given folio to the new order. For buddy allocator like (non-uniform)
> split, __split_unmapped_folio() calls it (folio_order - new_order) time=
s
> and each time splits the folio containing the given page to one lower
> order.
>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: Kirill A. Shuemov <kirill.shutemov@linux.intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Yang Shi <yang@os.amperecomputing.com>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Kairui Song <kasong@tencent.com>
> ---
>  mm/huge_memory.c | 348 ++++++++++++++++++++++++++++++++++++++++++++++-=

>  1 file changed, 347 insertions(+), 1 deletion(-)

Hi Andrew,

The patch below should fix the issues discovered by Hugh. Please fold
it into this patch. Thank you for all the help.


=46rom 22ced0e84e756a1084a1eb32d1de596ca10e3b3c Mon Sep 17 00:00:00 2001
From: Zi Yan <ziy@nvidia.com>
Date: Mon, 10 Mar 2025 11:59:42 -0400
Subject: [PATCH] mm/huge_memory: unfreeze head folio after page cache ent=
ries
 are updated

Otherwise others can grab the head folio and see stale page cache entries=
=2E
Data corruption can happen because of that.

Drop large EOF tail folios with the right number of refs to prevent memor=
y
leak.

Reported-by: Hugh Dickins <hughd@google.com>
Closes: https://lore.kernel.org/all/fcbadb7f-dd3e-21df-f9a7-2853b53183c4@=
google.com/
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 8a42150298de..f06508e4d242 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3573,17 +3573,18 @@ static int __split_unmapped_folio(struct folio *f=
olio, int new_order,
 			}

 			/*
-			 * Unfreeze refcount first. Additional reference from
-			 * page cache.
+			 * origin_folio should be kept frozon until page cache
+			 * entries are updated with all the other after-split
+			 * folios to prevent others seeing stale page cache
+			 * entries.
 			 */
-			folio_ref_unfreeze(release,
-				1 + ((!folio_test_anon(origin_folio) ||
-				     folio_test_swapcache(origin_folio)) ?
-					     folio_nr_pages(release) : 0));
-
 			if (release =3D=3D origin_folio)
 				continue;

+			folio_ref_unfreeze(release, 1 +
+					((mapping || swap_cache) ?
+						folio_nr_pages(release) : 0));
+
 			lru_add_page_tail(origin_folio, &release->page,
 						lruvec, list);

@@ -3595,7 +3596,7 @@ static int __split_unmapped_folio(struct folio *fol=
io, int new_order,
 					folio_account_cleaned(release,
 						inode_to_wb(mapping->host));
 				__filemap_remove_folio(release, NULL);
-				folio_put(release);
+				folio_put_refs(release, folio_nr_pages(release));
 			} else if (mapping) {
 				__xa_store(&mapping->i_pages,
 						release->index, release, 0);
@@ -3607,6 +3608,15 @@ static int __split_unmapped_folio(struct folio *fo=
lio, int new_order,
 		}
 	}

+	/*
+	 * Unfreeze origin_folio only after all page cache entries, which used
+	 * to point to it, have been updated with new folios. Otherwise,
+	 * a parallel folio_try_get() can grab origin_folio and its caller can
+	 * see stale page cache entries.
+	 */
+	folio_ref_unfreeze(origin_folio, 1 +
+		((mapping || swap_cache) ? folio_nr_pages(origin_folio) : 0));
+
 	unlock_page_lruvec(lruvec);

 	if (swap_cache)
-- =

2.47.2



Best Regards,
Yan, Zi

