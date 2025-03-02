Return-Path: <linux-kselftest+bounces-27975-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB06DA4AF32
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Mar 2025 04:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E68F18940DE
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Mar 2025 03:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F98C155389;
	Sun,  2 Mar 2025 03:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DbvXtdBL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2078.outbound.protection.outlook.com [40.107.95.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594255661;
	Sun,  2 Mar 2025 03:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740887780; cv=fail; b=EMDvKisTVX+sEQQbJgfmkpEAes3hPASI8jUz/+M315fyMzjdBiV5JkaMEALaBVsKqO3EQ6Li5C72XDbc2e0cRsQFvpz2AmvDYgsRe91VJMEjb0sXok8HkSqtt89LnrfA2ajPhfSHOHMB9EWXAHy8g7UuPiY76LCjDC9C7o8M7nI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740887780; c=relaxed/simple;
	bh=dwhT2V3JItOKVMhvG7+Eo2G7j+q1xI7SQkPLEqf4Juw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EbOG5nqWLixaxuORTqgwP61Qi7yYUPWdU6op346enW3Qlx+vE/lUUtDbI5dFfGAht1Yq20K47DNBu2Vfn036lvTLO+jvGajArnvXvC9h1sH8ovoRVg7rnLDM7PwSAYhrPmgxh/aj2xZJ5R6akNjInMnBuYo2AfpEG3cte50PpPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DbvXtdBL; arc=fail smtp.client-ip=40.107.95.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XxRVuhiPQc3G7E+/9gY9bcOCohewZvvPCvxs2Z81rn8yNYEtHQAl2/NvJr1OsmxJa9LUByMTq9B68L1zrIlClHn+0iuZhRW9+98ieLA8R2T+BgRpwdhoGFFrvtXslf1suNmAwQ695pSWClkE4fexAzzc0+SNIA4aHMwigY/nHvtnTW8BLxR7YeLe1RlszWfsb1wyx3dLJ74aPdwtX7mJO56CmiO3JhLNcOKTJBdw0hyt1D9BT8MNvFLQWa34i4Bp/lRaY+YvmSo8/hqZJC2V/gYz9hThpwWwPqC+UmYemYx2okolhrWDf7CSRPdvm9jyNwZNkz57wnBoZTAsqOtEkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpzEgmVcNQbmuysGz3Mc2qLuzKXITa1sL0roM49GuKk=;
 b=RGBJm58WbENSLYVohM5F30gWqvXYs0P2TNRHMFvFMOJT6hCV4i/8cjHwQrLVuLbcc/mZ5cQXxwOSRbql0Po4ZC5XPsDGtXE/sU9/CylDlBw3CmmXIazAb4umGzb7qAo76WIW/9p4VFeg2KQeeQ27Ku9TWYdMtJdBadCHhiRKZG3gEHojw/ddBNx6gkQN6B3czhxzYSuy17Sa23BI3f4WU5doin3wApQ4stQXa3zFsohQerL3VZ4UfzFvK3aav+cDagnv5BVJOjBIvzak59jT5kaDYJbfmPHJOhQah5zBo3zQRaeDDy4waOJH/EKnVzvQ2wX2smzYnrzbSlJtO9PqHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpzEgmVcNQbmuysGz3Mc2qLuzKXITa1sL0roM49GuKk=;
 b=DbvXtdBLbblanxuYJcBA+5gBS4STUH//tXWlbL/7CKDGBCBBGziqIHJ6wLfi30ac2ML/0IOQt1sMPjIQYM3oGZShqbesiC440AqtCPWFGanwKnN0KGKIStJQN2fM1DgiqMRlMKLc//wgUYbYxM4i3DK1nZXmE5acGeeYP1QPkndN35L4rhzNmm4o0IRXhw07ID5Bq2q7R9YfXkNFpOwAn72PiPrvi7n3CIYt3lkznxMuxDc0eJEF86v4t4qmVqUvNJ1II9rSXBidemlQcYDzroFKQCYvw3eiM+fF3tMhxR25rbVpa5CJy4lGq3Zs48x7HsXXO5q0oFUbIVA0oj6pOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA0PR12MB8974.namprd12.prod.outlook.com (2603:10b6:208:488::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.22; Sun, 2 Mar
 2025 03:56:15 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8489.025; Sun, 2 Mar 2025
 03:56:15 +0000
From: Zi Yan <ziy@nvidia.com>
To: <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Hugh Dickins <hughd@google.com>,
 David Hildenbrand <david@redhat.com>, Yang Shi <yang@os.amperecomputing.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Yu Zhao <yuzhao@google.com>, John Hubbard <jhubbard@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 Zi Yan <ziy@nvidia.com>, Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH v9 7/8] mm/truncate: use buddy allocator like folio split
 for truncate operation
Date: Sat, 01 Mar 2025 22:52:59 -0500
X-Mailer: MailMate (2.0r6222)
Message-ID: <56EBE3B6-99EA-470E-B2B3-92C9C13032DF@nvidia.com>
In-Reply-To: <20250226210032.2044041-8-ziy@nvidia.com>
References: <20250226210032.2044041-1-ziy@nvidia.com>
 <20250226210032.2044041-8-ziy@nvidia.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR01CA0026.prod.exchangelabs.com (2603:10b6:208:10c::39)
 To DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA0PR12MB8974:EE_
X-MS-Office365-Filtering-Correlation-Id: a3f54ea9-05f5-41aa-80f2-08dd593e2e18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wzc5LcuVLvWQ8B1sdpGnWODu62pRUFzuuAkBNAjRR1A+17xD3K1TACqo0oME?=
 =?us-ascii?Q?U3l+qkpCgd09USPWVVmB7ZlDOjJvji2baqtkMhWuPEwNUNO6zpLtq6sPpMeT?=
 =?us-ascii?Q?3729PQdAS39HTFV66BoEnu9YigpJ63JBc6twxoflo/j457IdHnfy7Gqfn60M?=
 =?us-ascii?Q?1lUwjFT5NcbHdujpHEO6oIbJJiepT3WGw1e7bL7782sL1hDdLUOp2vJa9YOm?=
 =?us-ascii?Q?AeXHxdhODksR7nfHTg/rUUNAX2Mc+9X8G34qFAuNPZ5EZa5WKOwyI52C1MWq?=
 =?us-ascii?Q?HluugG/LUbhwo+OO8/q5VcrYhnVD1tgr2iDNU/445oyjhyWIf/jHmue2zfRN?=
 =?us-ascii?Q?zXCQNZDrt+8TizdRzNgBSfDAqU4NO6hiJ6CLH2dSehx2KH6p6TtgbwkDc4qc?=
 =?us-ascii?Q?gX7wClEbdVCRtdG9Nr3V483mcCTaqT8b1u84HJNhMRuEa7KNe+JmRu/WHlvh?=
 =?us-ascii?Q?J1FznvAkeMMIEFMxe2MBdhbIw6pQ494/vD6U57Z/d1TmQynTOfqIWpNyVUBu?=
 =?us-ascii?Q?rsJnVAx7lc1Jv3W1X8lraV6xLYMByzPW/00AJzLfcQVUS3VbDBNCYj2JADoE?=
 =?us-ascii?Q?KLbkw6zjdgJ9QBQfskxx5/TWnaRp3WJ7RnS1VlNwD4Z6PD6b9b+Nrnj9OD1u?=
 =?us-ascii?Q?fg9mv6tImsGXwuINE/MKqT45zdcpM9kWzzC8IYmN1AKKbi01sdWJmomc06Nl?=
 =?us-ascii?Q?jpQYdU04m27i8+0CbdsBKWzQN/y7cSrr4R7k/lXvQIL6JsmG3mIuNCLZIlYr?=
 =?us-ascii?Q?8XY6uKbFsczdQuOYJzWL1+265TLFU4cHel13XS1dA9sJS4lGBokNiQHoXiD2?=
 =?us-ascii?Q?KgIdLERTiYBB5XY3A1ro0bmNI2XZbkfJSOtbyJncnTsITMWPaW/aV2u4zlrt?=
 =?us-ascii?Q?VixtHE/IPdwAVew+YbT8nTStKZeiqkjZlJK7+se7wcjivQvZDoCAsp0Y3Z2j?=
 =?us-ascii?Q?6GvoeQ8XIl5btaFdOeCWdRNCd+EnUQ9U9sdNh4Rst9Js1+l7wxtahTNehuwl?=
 =?us-ascii?Q?pfHncmA8YA+d73cAtd+w7WLNsjia3LJ1uJVJmHhj77Y8Lf+FsUIAH7TrSDr8?=
 =?us-ascii?Q?y3ktrZjTwgMeIPG1et2e6+UsZEKUCpBWJ29sQLqioroDB7u2ttU9BeYIgNv/?=
 =?us-ascii?Q?1gZdY3Lx8BvEyC3bnePZ6/0sVu7p8Yyh3hOYLnk0HtnWtm9XLI8WgYe4Sz6k?=
 =?us-ascii?Q?LBcHxDWXry17opKMvGLWGdimZH27W2WzeU+kerOIvf/ekbga9ZY38+uLAbGj?=
 =?us-ascii?Q?aho5BDDb1GtSbEXP4lGl9UFC68WRfZ5SP1WFQeJoYwK3pNPnlqdc52Mz1P1Q?=
 =?us-ascii?Q?jnQEWX80X18AgW7lhkCF8WoI0fNmIfKuhZnlLYYMv8IoFA4hNB/TPKMYaZv1?=
 =?us-ascii?Q?OFM7poGgXNq2vCEtdzSxMiK2jK7c?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TKX5O52UPF6y0Hf+7XKAvlrdbHfh/Za3bRTrYKGR3QnTRuRb82FYI1C+HMEe?=
 =?us-ascii?Q?0Tp0OlcDM5jHV5XPLdeBTmP2/bHk6T1aUCqTUrBBf0kEmGO7MuQVzENDHAds?=
 =?us-ascii?Q?sNalEkacxbhtSDIpeY9LzhDV1ykApVNMIY8g34D4B6idfeAN46Y0zSy/PVQ/?=
 =?us-ascii?Q?p6b20qeNm0FL2jjK81C1MzgTBs1jORMcJe8kHmGyLCSRoOkTMB7d8dK/CyIF?=
 =?us-ascii?Q?WKtoKAMKBWFn9khPFkG8heUq9ad0sQ3CQ9L5eI7fsf4a3QUN7074y0HykKWj?=
 =?us-ascii?Q?In7A4FaY1Wc+8vyV0gwgrAD/iAXQjjS8HmTteTPMDYsoWXW4R2t+PNzICQmb?=
 =?us-ascii?Q?HYEdXpcbihwIHNaIFJtuLQ2mFxrwIpLu+39t3cJtnAt2ZaRqE4fZQqfLD24u?=
 =?us-ascii?Q?8WM/PuoR/7PN1u7nj20yrXg2cC/48Miazy/69VLJ46DjQE8zZlCV30ig4Li3?=
 =?us-ascii?Q?rs6ET7WlLRnMaRcfr3qT0n3eFdLylI/Ntt4ctMYkimifmKx20MGPqhbVdIxe?=
 =?us-ascii?Q?KH++RK+MaAHIKcC5saOeXWh0QPEuw9hhZBBGyeyO/ayMskBNPW33kPVEqbeU?=
 =?us-ascii?Q?XEHHeTHLlUujwJ2E0KwiPB9Llr/pjzkovI602yAPxQULtDXjp9wwYvmgpHHg?=
 =?us-ascii?Q?WjeRet1ldnzdF3QoG2Y3xQltbiICOFRZdtQ0DYFWj3KYtlDAyQGBYkj6QRPm?=
 =?us-ascii?Q?wglsoPyDufI68gJIHo2aJtmuy0CC3GFucWz9nPKp+pUG6RdTEkNL9XE0S/pW?=
 =?us-ascii?Q?TVFo5QAXwp/GcZJrPUG0MEwdzT06E4UvV2BpBHHLoEOWNIMkg926VaZxFUwr?=
 =?us-ascii?Q?WHY9fT/0p04IFNl4cxezhNJjOLBUuQjVcpfsfawRGCoOAg3b7rLpyWkQf5pd?=
 =?us-ascii?Q?To6JA8yTx65l8UtzWXtO3npRVtFHQZ9HmuOwJwoJq0TAktzj3buxhnws2IJ5?=
 =?us-ascii?Q?M8vUgQ2C2q1NmwHYwu/JhuyVIEFqZ4OLV2Ff/+Kyz+mqcZm0MROc0Gh09IHh?=
 =?us-ascii?Q?z/j35oUWTnRLXP8FlI+LNHfci+upEsMI/1fc2ViB5EuQaVlIB8E0c23guy2a?=
 =?us-ascii?Q?pO4m3nhoFSz5M6TaSJ0xy5ClZJOc7W+gN0Sjvat6BIvFluQazQNdFmq8TC5j?=
 =?us-ascii?Q?JMGyZB9cxjIPBaXKG7LZ3NaVJcYv/v1xYmuyHrr4sz31QVA22O8DdjhzwF5B?=
 =?us-ascii?Q?BHA+Hzs4GJcfua9s8teTbH65sCISHPFVrZPlgyOa66DB7XtaSKOHHWGR3f/b?=
 =?us-ascii?Q?wVV2uTbkilAPRhJrLkFAktzkDg/3sWZE5P9axh/x2VOI8yLy81exWz9RMqwR?=
 =?us-ascii?Q?ElC6iYLRO7L8qJk8BFxp29K0R31TxkJHB++4A3kdYNhLw7bGkOPYuKDUA+wV?=
 =?us-ascii?Q?v86gegam0/G/+9eoUNsHDxeHv0zLf5AKL8irVG6oAowSq4yMI/4LCe4+wTlX?=
 =?us-ascii?Q?f5GpKmMA8YgBPDDDwNOs+DKyvGRomrG45pSk3Muh48wX6i4CZ5XTO47lK5su?=
 =?us-ascii?Q?NQPqbqFYH2RINlw7dSWJAAwc+WuCt+nw5hTG8LpGg39b944dqsmOeVMye2Li?=
 =?us-ascii?Q?rTxjIF8QC+1vpUPQlAQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f54ea9-05f5-41aa-80f2-08dd593e2e18
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2025 03:56:15.3851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N6c5PAco5piOw+j2cECa9MKaNd2ttNqGHDm/mtfTXbZbVDTsNpnajo4HSabR2SBS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8974

On 26 Feb 2025, at 16:00, Zi Yan wrote:

> Instead of splitting the large folio uniformly during truncation, try t=
o
> use buddy allocator like split at the start of truncation range to
> minimize the number of resulting folios if it is supported.
> try_folio_split() is introduced to use folio_split() if supported and f=
all
> back to uniform split otherwise.
>
> For example, to truncate a order-4 folio
> [0, 1, 2, 3, 4, 5, ..., 15]
> between [3, 10] (inclusive), folio_split() splits the folio to
> [0,1], [2], [3], [4..7], [8..15] and [3], [4..7] can be dropped and
> [8..15] is kept with zeros in [8..10], then another folio_split() is
> done at 10, so [8..10] can be dropped.
>
> One possible optimization is to make folio_split() to split a folio bas=
ed
> on a given range, like [3..10] above.  But that complicates folio_split=
(),
> so it will be investigated when necessary.
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
>  include/linux/huge_mm.h | 36 ++++++++++++++++++++++++++++++++++++
>  mm/huge_memory.c        |  6 +++---
>  mm/truncate.c           | 31 ++++++++++++++++++++++++++++++-
>  3 files changed, 69 insertions(+), 4 deletions(-)
>

Hi Andrew,

Can you fold the patch below to this one? I find the issue based
on the syzbot report[1].

Thanks.

[1] https://lore.kernel.org/linux-mm/67c38d10.050a0220.dc10f.016d.GAE@goo=
gle.com/

=46rom 48cef9263cda2ea7a7a80219113c5c044eb31c0c Mon Sep 17 00:00:00 2001
From: Zi Yan <ziy@nvidia.com>
Date: Sat, 1 Mar 2025 22:34:24 -0500
Subject: [PATCH] mm/truncate: make sure folio2 is large and has the same
 mapping after lock

It is possible that folio2 no longer belongs to the original mapping.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/truncate.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index 031d0be19f42..0790b6227512 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -244,8 +244,14 @@ bool truncate_inode_partial_folio(struct folio *foli=
o, loff_t start, loff_t end)
 		if (!folio_trylock(folio2))
 			goto out;

-		/* split result does not matter here */
-		try_folio_split(folio2, split_at2, NULL);
+		/*
+		 * make sure folio2 is large and does not change its mapping.
+		 * Its split result does not matter here.
+		 */
+		if (folio_test_large(folio2) &&
+		    folio2->mapping =3D=3D folio->mapping)
+			try_folio_split(folio2, split_at2, NULL);
+
 		folio_unlock(folio2);
 out:
 		folio_put(folio2);
-- =

2.47.2



--
Best Regards,
Yan, Zi

