Return-Path: <linux-kselftest+bounces-25787-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5643A28282
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 04:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F7A716114E
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 03:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75D4214A73;
	Wed,  5 Feb 2025 03:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SPzXvQEV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2077.outbound.protection.outlook.com [40.107.212.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D883421422B;
	Wed,  5 Feb 2025 03:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738725285; cv=fail; b=erM54jSGSvywTLNsQf3fFM2nWq4WOathThZ3Kkj8lHs/mkCowUvfzuxc0vjG8+l1T6OyVbZidTGlLXTo2QOiXK900Q8302EJy54s8BuG28eKSe6hNBOWKiMmXyjYTzkPEQRPE1VaW73APBPdLMP00yLvINtTNeIveMj77/JXq54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738725285; c=relaxed/simple;
	bh=1d+NvaOvoKvlX9KzmLvvhy1ae5cs7bf5tRsjdEZoy5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m5IVvhv9HmooaauVt4RkTtVqGFPtR0ijH/xUPdtrF0HmnQbQF9BCiWv8EUgvwrUS4S9BuTVOjMvN+71LrYKmRtQxCOdnvRNdB9MfRps5lSYVt6iTRGoIUh0HktkHl5/2jS9u9wKhxpEQVDEXUrocxfTz4EMVx4ZwKt2/q9003y4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SPzXvQEV; arc=fail smtp.client-ip=40.107.212.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eLaAIBJoN7XenzwludgH2JkvonCO6zkalTWIELsuFfrgHLPYJCn182Yk3kMe+Y64TUl9M3IccHbQWNyqFxqxxTU6k0bW5ig9pciP9crAxYapLzXXoxuPudNktVuEDiX2siq1cgRKm6Yv7YgRrfpVyGN+O/EtmxWsKm6dg69H/7QvBvVkJ/GVxuQm94etNYXlEIXnl6wSyphL8dUA7E9FFX/GBhB4UJdan8Bfvn0V9YInqIiMnxNB4KEp5W/6Y67LQbPGCUIHNgCJixHSH3rjM4MFDtrS1M6MmpDbX3+xPrJUbpHBHVtWlk2tLuff5B0UcKcJq1cBM6bj8wQyM4Rtzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jW2+/ILTH9BszGEwh1OHt2pRusN1IYxi52xgipsQPkk=;
 b=tslar8kePCXBR9Q5lbVE+PaxIY9vOVJXVvhOb9SWDyocX67TPOS6rjwB1mVnZye5p2bA+QvttL7pzwXqSfkqo2oGQP5a1Sjb3Gbe4qUICoXC3hsvDG/nd+gb4R/eOWyVnRUIwNMYHKsDzgLbwKnp/jvNw9a0wdfkvHnvypCrdZmKhtm9wKk0AELNFE+SebOfXXRJn+OdVfpoOc6cMXg7BdbVgs0qGygty7i/7SXljX0CoEh0AyvbuXsOy7ZsKlXbsjZf7FUuSpXkAWlDsxQR7Qwqg/Z2JCkuISPfWvGHoTkP30/OxG9GAYkdE8NIajZBoUU2f5TSBySJYFPWhhR21A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jW2+/ILTH9BszGEwh1OHt2pRusN1IYxi52xgipsQPkk=;
 b=SPzXvQEVpmWOddzzZKkCaoqUcaRmo8PVsxv70kPr7SUhwKvu/nA9ERktvIo1gBxjzYo6JA3K/8mobqbUl++6fOVyS3lwfrL64euLOPMC4X+uA5sKiCoa+Q58+Oz3AVzx5f66a3sGkecYwQ+wDYosInUGlcU4NQutp0b7OHlxQhvZxm0kcOPU8/SLI2b9RhE5hCQj9Fbtq52WnWf9Kuq6kB9ZSy6iIlLAmAp+w27YYMLDlV3G7mwdeqJZB/UqaEiq2EsqloC77JiGQe24GWPXLycxF77FSh/1b/w5wUzM/GFh8gh6bfjWF539A/r1lgfsDkT90O3Rxr87iEKpOLxflQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MW6PR12MB8865.namprd12.prod.outlook.com (2603:10b6:303:23b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 03:14:37 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 03:14:37 +0000
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
Subject: [PATCH v6 2/7] mm/huge_memory: move folio split common code to __folio_split()
Date: Tue,  4 Feb 2025 22:14:12 -0500
Message-ID: <20250205031417.1771278-3-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250205031417.1771278-1-ziy@nvidia.com>
References: <20250205031417.1771278-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0171.namprd03.prod.outlook.com
 (2603:10b6:408:f4::26) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MW6PR12MB8865:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aab9b85-bee2-407a-b150-08dd45933906
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CvpErN0+xu8cdCDZkKTVKFtEx63dvMMkG+BORhaZg3QhrCVNg65zSb4eB31q?=
 =?us-ascii?Q?7EG3ua63paypEeoWGsaagufmRKJHuHO3nCqUeL06M0pRimOiNwiq0h2I9Ij4?=
 =?us-ascii?Q?fb9Cdsa0Ou421fcVDqGA2soVjQzCem2xw90boziwPLKf3L6l0wXhGtVJnQk0?=
 =?us-ascii?Q?4VkQF8Lc77fPVsft2FO+/X3mYnTCbBw+0D+loHAvIL+y6hE/iwPo9+TghFot?=
 =?us-ascii?Q?AkjoUAVndCsOY2BoZHclrzWzFunLoBRqDaKyrD4YhBu78aC3cjUlS2IMJ2VD?=
 =?us-ascii?Q?fDKfBfGp8Akmb8gxs1x8vo9E+5hW+aqPZgrco2XIPNt8b8mML9W9HuJ5W4n8?=
 =?us-ascii?Q?K4iI9XxtLM81aq8iSCJ3vBIoq44F3MGBnVQ5BbPudERc+Ot/hF/fKy4I004x?=
 =?us-ascii?Q?pyPKqm5r5ugVFOg5UoblXiwFYNfC5tqAbdapPXbQ70z44Sd0Zs1ogAflU/nn?=
 =?us-ascii?Q?OU/7PRWk/2l/5mGwEvFnjt/9eEd62KACoZk7zyYwSmSXZt7SaMIwQU2Z9e52?=
 =?us-ascii?Q?5FLVsl6o0pKgvQsFxepbhfYUeiBZ7rbKt5idZvr3YbNfGMJe5Ef3q/YIXqhb?=
 =?us-ascii?Q?CfvrFQvPSpPs0LaEGlai8LH4GgfqOdTR2QtJxbokSeC0vjdJMBwQCMBquaj1?=
 =?us-ascii?Q?f58okTTGZIK+wreVvIdxiEYm5cygR9ubY7rZbxPsZO+whOKZzpmGDDsuUgFw?=
 =?us-ascii?Q?i1OGO5nmhMl0OOOTyTCwGwPzn5hBy8ZgJhi4y/LpcvNvEOdvnLqi4//ivkrR?=
 =?us-ascii?Q?tFwXKPnAZv6Dus2kse1QvbVL9KeHw+cB2CtKBlswolFgHAmqdmqhmFJ3WzWW?=
 =?us-ascii?Q?6FDSNZMtNXe6VaAswVOUHESik6spM7TPJ0eDAcwMjCvzvHhhaD2TbiJtxCFN?=
 =?us-ascii?Q?0/fjm96RLfSMut7WbUbWpnNxQ8iAFeFzAPgaBqokR0ekgPu9daBGXHdv7Qr8?=
 =?us-ascii?Q?b46+tS8+ZilbfX6ouD9VEU9ABDTdJpEf6drXLRTB8jttqTy5wRMMuu4eMfqE?=
 =?us-ascii?Q?GX8exNlQ1e501eqhkcoWDoy7I5YVBmkNSQeg3R3SXCpktXRQJDA5aiHwrWF6?=
 =?us-ascii?Q?eoNqUfhtIUzYWy6hIZnM+ce4lh67bXzY5LCLk3M8OfvIRhrwcUtDuiD4EcYV?=
 =?us-ascii?Q?oz8zSibzGOBpLL8udcj+oby69xrFGI3xyP0N5YACvCZ0ep39wGrydUUFzoja?=
 =?us-ascii?Q?KI5OGHXXw5oWIdEDqIqHRTCGTO4ADAJTc947ZSgxs9MO6FhMbUbsBrbfmF4U?=
 =?us-ascii?Q?2kbnZ9K92jfMMdKF66yDyD9chS9vX/omiLkpgqJGJJ89LaWKfMGVXqy3C5FQ?=
 =?us-ascii?Q?qdT1TCQpklt0g1eseB+3/BSr7VoF+VzbjBKGDWDXFCbhcaGF1KOks6zuIbIT?=
 =?us-ascii?Q?u02J7yWzXibsahH29k202HgUi3BY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NHrkXLebJi81Pp153/HLPvJRlbkgW4zSQ7AnCsi/HIexMRQ0RSt7chiPKWG2?=
 =?us-ascii?Q?TWNHl3+s0r6V9g4vEDqpbCAehWhjae1ul739bkWKaflEkDfXHNm8vqe3tV0a?=
 =?us-ascii?Q?u4vKkRJCz4fU3Kz96vZ16Lq5c8Xx6wrXTf8E+VwL77g8JWL8+AaOmIrgidXu?=
 =?us-ascii?Q?dfbV7Y9Brr15th/oGa8jp5ZgOBAqMKbs402obosWGhakgds1J8wzptVx1BZ2?=
 =?us-ascii?Q?wktBZF+wLgSb5Z2BY/nIEaBvQKKXaDh2kHOR9PgNUYNeMQ3fKE7eIqu1oPNC?=
 =?us-ascii?Q?PX81lbatxX5/4X9n6+kPQdmK1zLA08bEELNZYzs4KMGxyNaXCASY/DwJqx0R?=
 =?us-ascii?Q?9osEjZOLan+80WBl2P3iDhc2uGqnaFn78Uok+jZbFk+MytZgQm1zopPcSZ4C?=
 =?us-ascii?Q?xlGsp9BWYYjDwAuJnMUNVPHAI1oETTWihafzlyt1tYJcvkWLeP21b8/anRC6?=
 =?us-ascii?Q?JHPBy9EQRUm5hZi7FY9krkWijVJY8X9kAZVz/jX1bCO2n8AKyI7GA5RmjsgB?=
 =?us-ascii?Q?mqe0DxwA3btIQOFXBGvoqVxsryACUFvxg3AJ7S4iviSa/h30Mf0Cr7SGGMDM?=
 =?us-ascii?Q?zXNDqMBXmsMlp+7H4OvYt9aBvzeQW1E/pYgVTPWZRr7an9O32Tv2bA77Csa3?=
 =?us-ascii?Q?99OcqRrq8EPd0eq3FWSvwEuxphSaN0xVXCtaOirSBNMo8GChCSyF3ALLgA9O?=
 =?us-ascii?Q?TDCOPzVEfCd+U0MPs+RBX2aDJCSe+reIq7l9d+gU15FOfHroAi1l2+zMhhj5?=
 =?us-ascii?Q?DhHtA2xJ7W6h45OGW3FCRLdwt2DEQ1gWj8zqAiKvjBDN2+P0Z5t6MWudwdtW?=
 =?us-ascii?Q?mnbiLZ4Z9y0gCBCWhA1a3HFZngi421FIwAMiOM0dIs1c2nAGh1oJiyICDs8u?=
 =?us-ascii?Q?i6+zQhPx6+kpUWBUBIWpEZCUHy6b4Q2Jw5taHkHSe8lTQDLGPICyurAOLvaC?=
 =?us-ascii?Q?ks6uCTxEYuFcwdr/sUC3wZW2k5hArNyuJNG7xtgIZrkbTRoXxXXGVOQhX48l?=
 =?us-ascii?Q?OgMzEejoNzzP3Eq2L62k5MArLYb7DfeTcpneyqJxvxZrN1AqxeAfrf86k3zk?=
 =?us-ascii?Q?qSgAvMM0NfAPrKaer9hqaPPgY7OwAO58KmBdGoSc2qcmKmBgT0di7AQucyMI?=
 =?us-ascii?Q?SsTGKvJF65Tbr1Aa+P7XEmd9zVkEhcd5YSLNbyfFt5EgvItRev0z0i1aaFuR?=
 =?us-ascii?Q?ZgcbSyQBdXhtwym4XFpAWJ3Cy1dP2R7lC73C+VH1cMnNnbYL9+PK2jMg0IUk?=
 =?us-ascii?Q?cqGm5KYI0NKmvhuXUangBCr9S2/EpZEQKrKemUvXY2BX7kzak+80NLhg4E7u?=
 =?us-ascii?Q?TUg1hFx8S5mrfhy1WNNeq28S2XghdRE+mPcCbIZFmz3M9iChermszQhZcQc+?=
 =?us-ascii?Q?EuX8z5yievgeoXFm+vVO0X0ehD4OA4nU1iqsHhQPc4oQPAgE+UW5EjCKtJ6g?=
 =?us-ascii?Q?YUGIoX9p2APkohV28jUglh+aGMtuRaUDFTX+52Ce38LNS+9EbeBTkLQ4SjiI?=
 =?us-ascii?Q?OJUTSoezcO/Gm04B02hN/bmd9P76mrdzSxh7LDAHAPKqBjbvx5kh9O69Zspo?=
 =?us-ascii?Q?Wqs6sByn03tI30HB59rXlWRoT20AC06cVFuS9ioq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aab9b85-bee2-407a-b150-08dd45933906
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 03:14:37.6949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V/ElNChP3AbTR5isYhkDh+1/43nOCjuQyDsFtQITf63yFz+4HCuL3M1niN5cSnbl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8865

This is a preparation patch for folio_split().

In the upcoming patch folio_split() will share folio unmapping and
remapping code with split_huge_page_to_list_to_order(), so move the code
to a common function __folio_split() first.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 107 +++++++++++++++++++++++++----------------------
 1 file changed, 57 insertions(+), 50 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1948d86ac4ce..848bf297e307 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3741,57 +3741,9 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
 	return ret;
 }
 
-/*
- * This function splits a large folio into smaller folios of order @new_order.
- * @page can point to any page of the large folio to split. The split operation
- * does not change the position of @page.
- *
- * Prerequisites:
- *
- * 1) The caller must hold a reference on the @page's owning folio, also known
- *    as the large folio.
- *
- * 2) The large folio must be locked.
- *
- * 3) The folio must not be pinned. Any unexpected folio references, including
- *    GUP pins, will result in the folio not getting split; instead, the caller
- *    will receive an -EAGAIN.
- *
- * 4) @new_order > 1, usually. Splitting to order-1 anonymous folios is not
- *    supported for non-file-backed folios, because folio->_deferred_list, which
- *    is used by partially mapped folios, is stored in subpage 2, but an order-1
- *    folio only has subpages 0 and 1. File-backed order-1 folios are supported,
- *    since they do not use _deferred_list.
- *
- * After splitting, the caller's folio reference will be transferred to @page,
- * resulting in a raised refcount of @page after this call. The other pages may
- * be freed if they are not mapped.
- *
- * If @list is null, tail pages will be added to LRU list, otherwise, to @list.
- *
- * Pages in @new_order will inherit the mapping, flags, and so on from the
- * huge page.
- *
- * Returns 0 if the huge page was split successfully.
- *
- * Returns -EAGAIN if the folio has unexpected reference (e.g., GUP) or if
- * the folio was concurrently removed from the page cache.
- *
- * Returns -EBUSY when trying to split the huge zeropage, if the folio is
- * under writeback, if fs-specific folio metadata cannot currently be
- * released, or if some unexpected race happened (e.g., anon VMA disappeared,
- * truncation).
- *
- * Callers should ensure that the order respects the address space mapping
- * min-order if one is set for non-anonymous folios.
- *
- * Returns -EINVAL when trying to split to an order that is incompatible
- * with the folio. Splitting to order 0 is compatible with all folios.
- */
-int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
-				     unsigned int new_order)
+static int __folio_split(struct folio *folio, unsigned int new_order,
+		struct page *page, struct list_head *list)
 {
-	struct folio *folio = page_folio(page);
 	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
 	/* reset xarray order to new order after split */
 	XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, new_order);
@@ -4001,6 +3953,61 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 	return ret;
 }
 
+/*
+ * This function splits a large folio into smaller folios of order @new_order.
+ * @page can point to any page of the large folio to split. The split operation
+ * does not change the position of @page.
+ *
+ * Prerequisites:
+ *
+ * 1) The caller must hold a reference on the @page's owning folio, also known
+ *    as the large folio.
+ *
+ * 2) The large folio must be locked.
+ *
+ * 3) The folio must not be pinned. Any unexpected folio references, including
+ *    GUP pins, will result in the folio not getting split; instead, the caller
+ *    will receive an -EAGAIN.
+ *
+ * 4) @new_order > 1, usually. Splitting to order-1 anonymous folios is not
+ *    supported for non-file-backed folios, because folio->_deferred_list, which
+ *    is used by partially mapped folios, is stored in subpage 2, but an order-1
+ *    folio only has subpages 0 and 1. File-backed order-1 folios are supported,
+ *    since they do not use _deferred_list.
+ *
+ * After splitting, the caller's folio reference will be transferred to @page,
+ * resulting in a raised refcount of @page after this call. The other pages may
+ * be freed if they are not mapped.
+ *
+ * If @list is null, tail pages will be added to LRU list, otherwise, to @list.
+ *
+ * Pages in @new_order will inherit the mapping, flags, and so on from the
+ * huge page.
+ *
+ * Returns 0 if the huge page was split successfully.
+ *
+ * Returns -EAGAIN if the folio has unexpected reference (e.g., GUP) or if
+ * the folio was concurrently removed from the page cache.
+ *
+ * Returns -EBUSY when trying to split the huge zeropage, if the folio is
+ * under writeback, if fs-specific folio metadata cannot currently be
+ * released, or if some unexpected race happened (e.g., anon VMA disappeared,
+ * truncation).
+ *
+ * Callers should ensure that the order respects the address space mapping
+ * min-order if one is set for non-anonymous folios.
+ *
+ * Returns -EINVAL when trying to split to an order that is incompatible
+ * with the folio. Splitting to order 0 is compatible with all folios.
+ */
+int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
+				     unsigned int new_order)
+{
+	struct folio *folio = page_folio(page);
+
+	return __folio_split(folio, new_order, page, list);
+}
+
 int min_order_for_split(struct folio *folio)
 {
 	if (folio_test_anon(folio))
-- 
2.47.2


