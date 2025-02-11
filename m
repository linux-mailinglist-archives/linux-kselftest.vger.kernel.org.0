Return-Path: <linux-kselftest+bounces-26377-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C79EFA3102D
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 16:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B72D1889697
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 15:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D61253B50;
	Tue, 11 Feb 2025 15:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="at2ICw8+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6273C250BF1;
	Tue, 11 Feb 2025 15:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739289044; cv=fail; b=E2ScN2d+W8DsflXFkyTURm9RSrg/zH5J5ZZ7cD8J3p8p7EmUicoZ3Y9IIYW/d60rmMCvZ4y8N4I5NyAEnaxqmwM84AWRfJP6kMNPYBWydzXG8ILiZ7u+1URKvf3ydhIg9rUsktDn0aHJMhWHo6xPux3rcZL96Vxjbg0WgGQo8qQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739289044; c=relaxed/simple;
	bh=OaLZK2tX8L3kWJaLjj1VMK7j2dW0JGrhKQkGLnSjBrk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bK9qItqC31aalNWuka0paLHoWOhM/AAV4vrv4LQ0ybXY4pgZsbHtKnA3xOgwL7TmakDJkuS9fc6e3jzW4ewSFrWsA4x+vzvp9udo2nL/YYjmfBXgoQ4Y2tiCXbacs/gofsvVLOmxs/CqKyBP5HOmpjHEO/GD4az07tnYEx7L0O0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=at2ICw8+; arc=fail smtp.client-ip=40.107.102.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yrGN6FSsSQdmIN8t7SiNhYH9GEQ94Q9DMlJOkaUiHC1zFa0R7yfxU1rlsYTKuvnLO8DCPaNBv3Hb96qeP5jO9OuiBocSzDPGB97LCcC/b9uptf3/qUzqt3++NO9uVkwjOb56aoiczUtJrjoBesQdyNghaZf+0Y8iy+Pe+TPYBD2BLruJHSz1WeVNGaYgCBik4ZSmcU64FpQcYZv7ZM8/cFuOFTCMiDK33SAZ3pbdDTEUNFL4em+lOv8ecwHitVhsZZI0Wxqr67gwgxl2Lb0oNpFoD9IMvzl5f2XZY8rVRK0pcpz855IXgqg4uEtkoTEhUqsiU+c/SqKniny+UxVJpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rURXNNE2J5ykIVBkBPu8iGNh2RvL1zhlyqkvk5Bqps=;
 b=u5CNo2s0E5EBF2Pp1zxQYKuz3MswQK8dK9BeegRXZ8ubKOYAwbVAVRsMVgnTQ5Ix4Oa590V+32kgrn0U+uVIbjgibC7T9Mx3kJHklNRiUx+QxBFfZb6i4UgAbXhYKUOGvd9bZ9SXX922ml9KkGQ+qV8CeRBe/POgi+fALo0SiKNcl5Os+169ZxGBkKP2gEKBpCha1eSdoKQBKiTihyJuSG1Z8yNzOpIvy+6HDRB8Yw5WQzhjcDPTgcc74WhHZ6YkIBFvfukcbEipzRaHlpqCEN+f9Qag3znvEvo9azQy3UKZJWC/LLxv5mOxzyfn9+Rv7dtgo4241Qp85bbJuXafNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rURXNNE2J5ykIVBkBPu8iGNh2RvL1zhlyqkvk5Bqps=;
 b=at2ICw8+prsXeqQsN7ezhDbtSlTPTrB2YgZ7EVKwxBQfONbOzioWOj7S2+QCKHjPGGCHNM7tn8KGm1nNq27c+4bBnse1OmCfFckoLYUlSVDpAA8gwx5g9YBE+eSkPXRzqH4r8jk1CGyp7peSqpUMk4+IORCQT1IwOYLWOGdMy2iHhu1klYUGhK19AbytW694w9oh60By1Yr4+i45IGxLvmMWyN7xSDlrVp3L1oyp+c/825kZVeZD6zypnzhtHdII70nUNAK+SIQRsTXKrMF/KwBCDsOKsPiYbLp57O4HKvxL0SLnmsDw37IDtA8zJusuCzXsKwiAZ5r38TZIZLQ6Ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA3PR12MB8764.namprd12.prod.outlook.com (2603:10b6:806:317::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 15:50:37 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 15:50:37 +0000
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
Subject: [PATCH v7 0/8] Buddy allocator like (or non-uniform) folio split
Date: Tue, 11 Feb 2025 10:50:25 -0500
Message-ID: <20250211155034.268962-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL6PEPF00016412.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:a) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA3PR12MB8764:EE_
X-MS-Office365-Filtering-Correlation-Id: a6e2c644-86ab-46a1-504b-08dd4ab3d3d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dqzGSez7UYfe1D2VuWGXXsNdo2srIXrjxHcLycD/JW9KilHUKBYHR3C+CKC2?=
 =?us-ascii?Q?uqheCeilOxpUoVNaBVjIADQrkIfEw1nV2qfJN3laCB5AbnDzmF0I1zGXMKck?=
 =?us-ascii?Q?iyNHf+QugUbRbPznfW6mcRf8y2s3PyO8lKvdu023Aufik2OXnecfFLmJ/7Y1?=
 =?us-ascii?Q?C3P4LOUXcSm0LRYiyavLNAfpnlRWtA9Jp0CcGRQn2l3oQk4FbbATk59mzjt4?=
 =?us-ascii?Q?u3FvzR05fbRLJLO+wRobsqXon0ndlWlGNpKikLV5vUS/JNXCOWYBjAdf3lsi?=
 =?us-ascii?Q?l0kwOoGkJNbFHIQTxrhAFYH8uE5ZaDimaS1v4MMqMg/Fc/Mem2UIoD5qL7vS?=
 =?us-ascii?Q?I4Vc6sbDSkLDJHFefnl8mC+/iIRZJAicIwtrE56tj1cD4bUT4QIq8u/ebnD9?=
 =?us-ascii?Q?Brv4vZAAQ+6zWfXNOOMapncrfrtsQmuWou0lFv7NIlo7YvrqFJg4lupfbqgx?=
 =?us-ascii?Q?2DY0fVVJxvbvCbh49rNMRu5lDUkT1xg07PxmM/dSPESvMuqvnt78RjsbJvz4?=
 =?us-ascii?Q?oJYWzBg+PTil90F2aYuW0U/vvEifjXSQnm93o4PWGH29N69CtKsB8tLI7sgj?=
 =?us-ascii?Q?+IJ5bVSP4sYfmT6m+vcUVZlfRXOro4KA62dpEviFfWP5z9TDLBfVz+3Ade/F?=
 =?us-ascii?Q?nurmydxPOU75fbcCSdNJUinWrcr644U6VVm07GhH2F4ct3XA8twqUvbwpmpW?=
 =?us-ascii?Q?EyfQ8yv9XkkeizcFhyu5dK8kFuGzvknpVqhlxiYbnSJWIqBO401Qozd/Z3kg?=
 =?us-ascii?Q?n+LOiW6hZGI22jY6Bc6Wck5mnBjusd3riMSdajDSHjW9MjW2x1WGTynRz6vs?=
 =?us-ascii?Q?QXTU91ZY9f+vvfLEQ7LMI1JITVJz49C7FeR4Kfac7d/97uIdo7VriEqfXsR8?=
 =?us-ascii?Q?hSFlhl0tdg3+4Xs0j4jSZ96qsHdlUjLZCyqCE/MpJAJktWJe+SZYcWgOZZ4H?=
 =?us-ascii?Q?fZLC1kxL/K9HoUYOvUbWXJroCsvCPDTGsqG4OLO9TXIW/MUBEc6omGtOVKDl?=
 =?us-ascii?Q?oL1s7MA+bhDQSto/syzgpVezlAFz0JljONAVNrJulYeRUDfTvv1Q2N23wQD4?=
 =?us-ascii?Q?54XpXT/vLd9/4uJ3LamUyCPLJSExYiQmguJcmgf6l+rsZzaQb6vn6/hI1HwI?=
 =?us-ascii?Q?1S7m7IdG3VFkc+e0GZQZB3MKzqAf/bND3Hm5njDR000YJ+95HwCVqzkkyHPt?=
 =?us-ascii?Q?PXyY1Ze+zAs6/hVlreKTWXfNaAuqBEMV0+77OeyQ/osuYyAWrw7iIT3QyvUR?=
 =?us-ascii?Q?TOFkeSbH6LbOhZceZclYLhX2cjS0aD2rreAwGCrNY3i+RvorQ2ZVG9u+4w8b?=
 =?us-ascii?Q?gF/ekr5xXIlcShoO6i4rHr18AHfoI40wjI+ayUyPA5j3JftckUd9ibyAZcSW?=
 =?us-ascii?Q?vjBr0PgA9tMrsJXAW2jbDbOtQwJg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BGHDQDdd0a5gimA+Weh7qVNwvfvIhAihNgkuFNNaNVMr+PrKQlgJs3sFjSEt?=
 =?us-ascii?Q?NJ354sGf8rbVh5allz43JX2IObt3Kb4//+xshSgCjGpRWKrdlZvl5EjfwUii?=
 =?us-ascii?Q?FMPa8CD6FTDEkiUd+Rxf9vDXuMcF3uIb0JXUTHRUMij7OWAo7R3PFK5uMox3?=
 =?us-ascii?Q?j0SfOtF6BZMiuQ1SEHN4LsEOO/5msUj4UgI5VBPm2NhSnnF7+FPrlMvVe2NL?=
 =?us-ascii?Q?OXet8wS+mUZc/FMq9pbi6fKkX7UxX3VUoQkzVuzuEquWRetRkSVH4W/xbKSw?=
 =?us-ascii?Q?sCudW+RjOQEc/7K7kFlJfy2FRUJANs9QKxkKtSMRvm3vflQs6XLLilMDyTzY?=
 =?us-ascii?Q?etESkrfzPY/sUhRKDNNmAcjaCj5LwcONK34SJXC+I4JbydCMuEZ/bKUrvMS2?=
 =?us-ascii?Q?zqULruG9ZSbEtz8QkW8LmeJH8e22UhxoB/LYOaZ0ZqshKTDzvZAIqudgu+J3?=
 =?us-ascii?Q?pmtCM6l3OoqUfzG/EgDq8zwOvtyr/3o2qh4fxBX+vp06yY5qbem63nBzc11/?=
 =?us-ascii?Q?b9U3yEg/9pM+mFvyd8B18Wmm9MKd+eKv7SeQidiE/08b1HWA+V1MKMSDBhOP?=
 =?us-ascii?Q?mUtFNpWIBms166aPkwz9B/7Q9cne4Tnl/Ev/jTOCC/MVENK+pPnyTFj/h9gu?=
 =?us-ascii?Q?672x5nx0t/v82NFBB22SYjjiskhu87uMkdVwyBWM6pJZLLMJbCV9ksXG8Iux?=
 =?us-ascii?Q?voAYJvMnB3X32G8Ypzp+cuzDu8H9/TAS6YOaTYz6+wN5H/25fOnl+b32MjNj?=
 =?us-ascii?Q?WTFLy67xxBN78aBWzpQOyTK56cA+SW/5kxZgVx8CDR5DqYsG6c+7g4/XuW6+?=
 =?us-ascii?Q?e6nY/AnwyAvp3r05WWnApOnpJmcE/Kwn+BIIDJEAYLZph0YzuzeijIUoK2Vu?=
 =?us-ascii?Q?rND3CPmlAihtNmfgyW6TrQGmhJ9QCI7XW2OcT8y6ZyBOTcvFPFN7Rids9Iq1?=
 =?us-ascii?Q?3rH2MHsYfoTGkeSQUNWUqk2rAsRuWbFTH6/iq5TACcvs50sSFTMXbbSESO3V?=
 =?us-ascii?Q?H0dH9QFzykf/FK7vw/1VVIvvpTFKdReQs0mLL0IfILG9zyWvvIHDra/vcnMm?=
 =?us-ascii?Q?izs3UH0w+4i26RNIkopSOPxzd5j/AsWXslTuUN61HkjHuE5NAdW2jid9/YO7?=
 =?us-ascii?Q?WWb9k0O6jqvYf3440ChGIJ/GKHHGvT59j89PlFyEHTXRbpgtJn6K4EtupVd8?=
 =?us-ascii?Q?Mryc+bffS5VgyY6TwylV6e9Fsc0wdwuNN1AZ8eW3rgt9OSOHRQ56orfNukhn?=
 =?us-ascii?Q?yg5dAudmpbh6yoKwB3o8cQi5xY+ui/+8Zrq1KYs6tl15UAZAe6VC7PgNojLO?=
 =?us-ascii?Q?qTKmiqdR4Gq97fNgYvYKNhBxiNk0xlEgyXDt5lWPjlaN3OpgmJqTAnHYdpLO?=
 =?us-ascii?Q?3TTmLyxo4s2bbCaLqIw23lRrgCpzTiAGSO2mHI3dkaa5jEcED4Mp8jGzWJZM?=
 =?us-ascii?Q?QUMJSoGV3I7xZDK2Hd3eN2MeVdIYtmQE7Z5uGpLYLrG+MrBK0O/C1kHrGJpy?=
 =?us-ascii?Q?sqMAH8IbLjzYRxYsdz9ypGqLq7btEqTjXFyYJKBev4sZZaqfF3BrcIrvY+Mf?=
 =?us-ascii?Q?xrh2qXXxTCRKcwxaYcH5CL1oQYjZNS8JA+NHiqHL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e2c644-86ab-46a1-504b-08dd4ab3d3d7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 15:50:37.1306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Di7lrJ5TGR2beILhXIdGxPWhgZTwX6hb9Y7B68dCdgDOZX/esm8PGJtesntXl19m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8764

Hi Matthew,

Can you please take a look at Patch 1 and let me know if the new xarray
function looks good to you? I will send __filemap_add_folio() and
shmem_split_large_entry() changes separately.

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

It is on top of mm-everything-2025-02-07-05-27 with V6 reverted. It is ready to
be merged.


Instead of duplicating existing split_huge_page*() code, __folio_split()
is introduced as the shared backend code for both
split_huge_page_to_list_to_order() and folio_split(). __folio_split()
can support both uniform split and buddy allocator like (or non-uniform) split.
All existing split_huge_page*() users can be gradually converted to use
folio_split() if possible. In this patchset, I converted
truncate_inode_partial_folio() to use folio_split().

xfstests quick group passed for both tmpfs and xfs.


Changelog
===
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

Zi Yan (8):
  xarray: add xas_try_split() to split a multi-index entry.
  mm/huge_memory: add two new (not yet used) functions for folio_split()
  mm/huge_memory: move folio split common code to __folio_split()
  mm/huge_memory: add buddy allocator like (non-uniform) folio_split()
  mm/huge_memory: remove the old, unused __split_huge_page()
  mm/huge_memory: add folio_split() to debugfs testing interface.
  mm/truncate: use buddy allocator like folio split for truncate
    operation.
  selftests/mm: add tests for folio_split(), buddy allocator like split.

 Documentation/core-api/xarray.rst             |  14 +-
 include/linux/huge_mm.h                       |  36 +
 include/linux/xarray.h                        |   7 +
 lib/test_xarray.c                             |  47 ++
 lib/xarray.c                                  | 136 +++-
 mm/huge_memory.c                              | 751 ++++++++++++------
 mm/truncate.c                                 |  31 +-
 tools/testing/radix-tree/Makefile             |   1 +
 .../selftests/mm/split_huge_page_test.c       |  34 +-
 9 files changed, 772 insertions(+), 285 deletions(-)

-- 
2.47.2


