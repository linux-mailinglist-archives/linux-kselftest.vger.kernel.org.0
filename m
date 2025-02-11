Return-Path: <linux-kselftest+bounces-26384-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0ABBA31044
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 16:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50896188B7F4
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 15:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2749A257437;
	Tue, 11 Feb 2025 15:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nB5ieIxr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2076.outbound.protection.outlook.com [40.107.100.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C5E256C80;
	Tue, 11 Feb 2025 15:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739289062; cv=fail; b=hQClz4xiH2VtDk68UgtSQUIUaDg4jQWvt4AXiZXadGVeV8RszQ+kIdpQqP5+Kft/xSB+sajwoYnTAlXML105fh0B2u8yaxhJV+A8X58VkDqHk3M4ZxEidVmbbn4P9fcXzXNAccHZcCRZL5C5rjfnyVzJAM2a1JnOE/0+D8rs3v0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739289062; c=relaxed/simple;
	bh=0bLpwALuAXIzzAiXHFlosR/CcjOrfrSBQ3zNGBoLKdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dk2kXcCrLk3Dri/vn7+70rt5jHZpcqeXFtpofTEY0PqW9J3QJqs3YB69il2C2niRajjA2A3dU/f4PpZxp3yeBL4BsgGqu5dYeNy8azRtGNkyawXMDLsX1eEFlXKSAo60/7diIZbFd3u7FG+ZO75aNS8laKAuXDajcBJqZ0PKxHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nB5ieIxr; arc=fail smtp.client-ip=40.107.100.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PC+oN93ANSqPv8MvsL9e5iejAB2QvEIQ6VQw6L7DqEaeTTRSfq1selqr5hJ9EIh+S4KONHEntOKK/LVx/VYcgQybLIA5vvLZYNFRkHlvKQO0hlf+I3kHMvkGd4G7blguKJqYLq3S5Lf0mrWeZPNvQ5pDHnK6ZlMpkGUm+p1/W0FMpDoWKcNG4mdH6HoFfFGt5YnRZCoAutFkNd+cDL8yxCm5ONh7H89KnrD5PMD+qB/56yXA6hx6HmUWD1inn92DEryFZX2qVaqjrxLxZjWpnNrSr1WbbBYv5Hk42WLyRwmkqnbWXHKnSlY/zwRfFWLEnfkOiG/KOG5jfmv7RWQoqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBgcH6S2XURqteY25x7Y29GKEIPg8XQjwwfD1VcuqoE=;
 b=wkqtMFQ3RvcaUAJB/sn+mg0h05pZ4ESduKvqGXuGWOrR+9MzsYRykpDUjNfnOZF9gkil7oUrTbtIigzu78PIq518fyEPQI6liG/usWeAm/plpCHf3BVIxGHfPe9d2tAi/vfu2uVzsmm0rA+Vz8DB5kyhHKjwPoozLdVjQaw7IOjFyPTjlnOsC0ieOafyLadx4+lcPS1MB3Uik7WEIx7pomTnKsAHZYVQO3tgkzkHXbWOcEnkfUadwWfMYVlzcO8snjF3Wg9gxTyQBhZ6zd9QXCqL4J9nB6ozhOMKcPnfVUh8m8Ty4wp8OiESDQkoH1oofUnoxbrG+m7q+3noZCK0zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBgcH6S2XURqteY25x7Y29GKEIPg8XQjwwfD1VcuqoE=;
 b=nB5ieIxr6fSMGxqseQqYH2e1DQ5TlhNtR/10NwMzcLludMjjcUhRhx1utubhxo3xSENYduTK4dr1NvqjjJ1iQgzCsvn4XnQZjCi1fxNuN1Qexe3zX//kMG41Hi5OzfTWgJwfzhesBhDs6pRuHvdDdunvGGQIlVLQ3ji7vKp38tRyF9t3zPG8y6m/t7DM0egyTWIGe+us1wk7YPEvx5WUvWlSrRPsLqSqNDzeqOA+dUeGtT7DHXvh3x8nnDxuzdD1kL+yW80T3rgxd+jkJ1znnuEu97BUhHicn5aUXowTrAe5tCATeDDtCOnkvAdI8YFAYSZ7kLhE8hURSm/NCwQsng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA3PR12MB8764.namprd12.prod.outlook.com (2603:10b6:806:317::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 15:50:52 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 15:50:52 +0000
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
Subject: [PATCH v7 7/8] mm/truncate: use buddy allocator like folio split for truncate operation.
Date: Tue, 11 Feb 2025 10:50:32 -0500
Message-ID: <20250211155034.268962-8-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250211155034.268962-1-ziy@nvidia.com>
References: <20250211155034.268962-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::19) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA3PR12MB8764:EE_
X-MS-Office365-Filtering-Correlation-Id: 4701c149-1463-42a8-507e-08dd4ab3dd17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tMVe0uif34PQBLWVoKW8S15zpFr9h1edvwgrP7H/qgGiNobmi961GDN80t9g?=
 =?us-ascii?Q?in9XKvp10IUPByXG5Jye08HQqlnFcVOD4O7X8FVeC6W/MkrwlTSk0vMX9G6s?=
 =?us-ascii?Q?AcVWnWPGVEVMBrha4F0xKeRUHZymBU1uDZhtcBTqVXhtXVKt68itFB/wEfYW?=
 =?us-ascii?Q?ziHl685MZVSlEgXTfQTQPtv41DNAboVaSiO2uxBqLmRJrc0BF5bEEUkL6akL?=
 =?us-ascii?Q?OordVveheAdfenFah+brGD3IXau6oOIyKenr8UgHZluoFKw934YwABScmB6F?=
 =?us-ascii?Q?sRM7rV2p85dmZnvMTjNS4AGUayfr5ENTzIGrVtK8w1UrrHmHYqQCWSSSc+co?=
 =?us-ascii?Q?0TtJFB2qPDTQ1/az1n+mIDSlkBRoS/eLTsk+tIfDe59I46Yb8kmW5cO6z1dG?=
 =?us-ascii?Q?3edmHVFAR3YFQtavi1loWXa3ncgs7PJ3gLbWprv8AkmdsOlepGZcS9IRastY?=
 =?us-ascii?Q?zhitpGf4S4aptOofcl7GjomuUV75pwaTU1cxO1z9Ceo50UK0+3k5hRZEFqXn?=
 =?us-ascii?Q?UKI8zOn0+jUaSuJQZlsdUdEvwEAjLxVJJDJ2eRsnRcBP2sfrJW/qYTsVGC0G?=
 =?us-ascii?Q?3obS5NCMiDvPuyqzQrIqeCUph6DrjT9nAQuGm4I80WkTTwp/WCcr8wjYrft7?=
 =?us-ascii?Q?NGex/dZ4Jgarx9asKQTdUUvFphFCqyU7cdzlSbGWoB2ziGnWaL61NjF62yXB?=
 =?us-ascii?Q?Ce43jhGnPfy9D+QTXfn1G2iWEjso7hLmKi/4bKUP7kR410SqpxCDe3WRNMHp?=
 =?us-ascii?Q?yodUqQqLgvpcWqPcXNsTyhQ2+sP6dqysp3gDRv7W6yL/IiA/aN/7rgbsWeqS?=
 =?us-ascii?Q?7Q6NJfWPImXpFM8iwQcuXAWvTQpXGzBT6nfou+aanWDTIgaV2CStJkm6YiJ/?=
 =?us-ascii?Q?bG6DzfBXmklXarGmyyrIdIYWOEE8xGDYDfPz77mzAspIvXNzwNh6IlnDy47a?=
 =?us-ascii?Q?ZjZlpug307OvMuXsVzE+/dLQhxYzl5z17iVx0mjcYGfRuQGGiRgtOHCAvc78?=
 =?us-ascii?Q?8rMaw48cE9g/BBjnex87++A2VAWKNEK9MgC5ltpa4MAquFBY+QNP52Kv1xel?=
 =?us-ascii?Q?fDXtqy3saZY2A9eJyzLBtObPOprO5qlsOlg5dxrpPMp38kRP32upG8CXFCjf?=
 =?us-ascii?Q?g4COSZtX/dEdtpbxmxQwF6u7IJnpYyxIKJQ4S1HWxeQ6X5etyeIIC3WgRy+8?=
 =?us-ascii?Q?MEztKUGGyzDukkMwDOrWiK12bhhx/SMbHxf7C1PRESNE6XS4PIfgPpPVDV7D?=
 =?us-ascii?Q?fREQg2APzW4TnUUH9xdqimQEAWK1d8j/OfGfztI7mOumWeDIyC4XiQiUjfxY?=
 =?us-ascii?Q?ducbHTthOKPLyWdXTuRYXd4iOSV3a29egjAR1am+hoRa2+JWKML1r0oaAT+5?=
 =?us-ascii?Q?HLa6vp7svdLi9ZQIY9hjvvWtU1mh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6XLXforkPaYUg9w2FY/O9Axtb/P7EfSAQsWitSAPnGxnmQyWYPp1Nk3EXHwG?=
 =?us-ascii?Q?KET7y4VdhgglkN2JEsmOntaDT5qCG6LylIo548sDVoCaE9Ce+fynk5ZUcqz4?=
 =?us-ascii?Q?CezhQi9zquygY83PntpDqojLBaMke1NSeWl+RUuNsSM4s0qchq5aA2GOg20Y?=
 =?us-ascii?Q?14sitGYPpqAneU+w63hD/KiTLlSgmcq1duaAy2jSBUamQQA+X1rATS9HNiE+?=
 =?us-ascii?Q?5e/1eZjCLsMpkypVQcXpr7YjCFHNsZtkDDZWNh57pm/ZrFyWaxowqCdDNcPW?=
 =?us-ascii?Q?aXhSnKzP09oKrafI46B5G92g1gSdTeaatSbmoOnL+ubHoxTr+jOSNIJNCs8l?=
 =?us-ascii?Q?zkzLxUn3Javb7b6Q4VXjMpeaPSDq4VzQ2PAq8E+z/3QLedr4XkahL0TvPeJM?=
 =?us-ascii?Q?32INAGrDbEYka7q0Ip0UYXFoQlSly5YIbdzDfim4bi+enrRGYM1eoaLnjopo?=
 =?us-ascii?Q?hrUqw36DKtrRDDTjaTF7ikOF9x3ODepZgki7WIll7f3U8b8RJakf8MkQLPAK?=
 =?us-ascii?Q?wa0qf7cdgATMqTLa/YcQJ1kxSTUxyzVSOwMsS6EVwqlPuWv1ejPjSAJ5RWYv?=
 =?us-ascii?Q?AaVt7z7dG+I3ep04GRqv6dMdFavSKD9N6rHKFMRBTXc7IIxJOX0tTjE4ScKp?=
 =?us-ascii?Q?49cF/NiGPlLvfyB2npOn3eQZDyefgdZdBhCutWkEphyCeTS0FZPm1jwH6+Jt?=
 =?us-ascii?Q?ilODjnLRTAxIWO2zZI51MVpUlPnQJkIUv/zsoDDqtSDH9HdAq2vHwG/v88IF?=
 =?us-ascii?Q?QdpuJyuqGCAUD3nyINOIQp2zsw3kzFlxc0W2zKvs3ZBtwPtPrDuy2ftEvkf6?=
 =?us-ascii?Q?XSKDel9mQNxsw9kRCVZNs6vECjRbXTBPwP59kszprw7Nm8hEfgHE66937XMn?=
 =?us-ascii?Q?RNaAePtvs5w83wgYmuHb6e250ovEXVedLAKdNVOIoQMw1IK6SRdHsIItxjDX?=
 =?us-ascii?Q?c7j5qJDbypoui7lEcLvG16VmON3j1/ZJDoluANsz67FK9IDt7MTxrnL3Os7f?=
 =?us-ascii?Q?piLLaVzdkEKP4XzCvO4xV9/2QGbuWNzVDwQ7TwFq6J9gvtCVySP5vNN14Ajo?=
 =?us-ascii?Q?1ZqnjJHvbdBR0ZpZSmE1wkkLBS/OazYcTeJ4RKlSV/njriNnv1COvuDWKHGL?=
 =?us-ascii?Q?kcjD027E/VoGlMBocRlfEGLFHLr3lyfveFJpk1Tls+yeK6kaeSyYlnU3U+8B?=
 =?us-ascii?Q?TWLUD9XvP0dmXhnFKdHlDHbLFH2svuZOpVk2jfviV6LFdw89zyCrjGj/DbVr?=
 =?us-ascii?Q?SRZYwXmQDSvd/GjNByb+jjE0TGIn2qEYcNLKouemGGtH8Me46jCq54z5ikO4?=
 =?us-ascii?Q?8qqd2GaIzqh5oZ4lmpu/mAljIYH9h/pSld0siLJ8Xvn/sucWe8rDIiEGQ42w?=
 =?us-ascii?Q?LtPUdy/4XSHkzWKi5dapmhwJ5ltZoJpROuzoa/f+2bmosIXF4gOJOV5+jxhF?=
 =?us-ascii?Q?09yDDPXQyOUeAliO0hjR3KOQIbCgsgCCbEkgd0QIjga3GdFgIgUt1v7mCKk6?=
 =?us-ascii?Q?ZewVHTnQ8BrKcWWsm5cElfJ9pp4TZ/1iOMlqADkex7jKT07uU1XKWnRT/p7k?=
 =?us-ascii?Q?UbByU1nxB3gz1DaHrkiVpII8yCQwxT80TxPffu4D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4701c149-1463-42a8-507e-08dd4ab3dd17
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 15:50:52.6483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JVbnjSMgkAUqoBqdyC1kr5YfG9N2F7q1SaTpJLTw5Rv/I4Hl8IYBgYP8Nw4+g4QM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8764

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
index 9e7be666bb6c..c00669b4fdcd 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -343,6 +343,36 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
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
@@ -535,6 +565,12 @@ static inline int split_folio_to_list(struct folio *folio, struct list_head *lis
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
index 05c09b791676..ab80348f33dd 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3646,7 +3646,7 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
 	return ret;
 }
 
-static bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
+bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
 		bool warns)
 {
 	/* order-1 is not supported for anonymous THP. */
@@ -3679,7 +3679,7 @@ static bool non_uniform_split_supported(struct folio *folio, unsigned int new_or
 }
 
 /* See comments in non_uniform_split_supported() */
-static bool uniform_split_supported(struct folio *folio, unsigned int new_order,
+bool uniform_split_supported(struct folio *folio, unsigned int new_order,
 		bool warns)
 {
 	if (folio_test_anon(folio) && new_order == 1) {
diff --git a/mm/truncate.c b/mm/truncate.c
index 0395e578d946..031d0be19f42 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -192,6 +192,7 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 {
 	loff_t pos = folio_pos(folio);
 	unsigned int offset, length;
+	struct page *split_at, *split_at2;
 
 	if (pos < start)
 		offset = start - pos;
@@ -221,8 +222,36 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
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


