Return-Path: <linux-kselftest+bounces-24680-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BEDA143CA
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 22:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DDE1169522
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 21:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC098242252;
	Thu, 16 Jan 2025 21:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f9vTHFkx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F4E2361E9;
	Thu, 16 Jan 2025 21:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737061864; cv=fail; b=lwGJbp640umaeOrcR7CKYpgVY9ndaJVzopWh5AjcDmASKy9yGNIrJd2/tedjgz2sc4uBSGC3QOjMjUnXoSqbkkdQCzGjGbj5F8DikbJyT51/Tx8up6unbic6ZAeF1eCM8YlZb0dkgvn1ZL0VzbxKMz3EN/8t+cJWiG2Z0bvaros=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737061864; c=relaxed/simple;
	bh=SG4zDvETg1F4aORMLvCFUUCitdwd3XrNJPMppt22MnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XCJNpzKy4DrSM4QMBaH3vF0G14nxtV+aYs5u/eJ+QHA8CniZez5dK12eUNiV2lYw0RQVvFyfou2F03M6klExUPwdN8zIn0F/wyyxUdPa6A2WJvi7P/DUGrqGzjNQCSgZnVXKvez/VDM8tBXpuIDvKNNoQZui92a6iwtQxyqpttA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f9vTHFkx; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tR/a5Z3BnIOtPAgFdoKRWGoAoDqY/Ph98RqLZ8URzeEXUz4JyP2HrkijMZfhT3z5JWqX6vvVmFnJlW5lD4Y5pJJWpuqTisluewY7+FcTVtB5wvWbV8N2jm9BJsJyYo2UoLHazIjHP0eq0qYsmpVgmo93xUDL05XJ5Wl9mQ+ypYwDS7p2/BsNyeKy8hcWVcNAK6R7o3NHcMj6zCssbLzZP38J8dd/aQWIrPhcsVmhMgGIaE5ZGMokR6vInGKdVxPYS9oHFDs8aulkh/eh8xSAM4v9bnI8kAEeTUQkd4pSrhUM/loYyNMhtkQcWc6lsGEQi0FM1czLis1ECPXQ1KsHPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=woUOmSHTfo6rwe2ZYwHaUuWygR5g64CLBIZHqefs/90=;
 b=FPoaiEpU5NZ1FP+uSwbM5A0CQVcWvIOzebf6WPQAAogjzoKs4ujjdQcSYq9k+ac4FiDqQ7OGEXR9Gk9M2MEJ9BED2kxq5kzgB21KTadbMqlLV+iZ3o+6GOSorAsbs/tpgbzlWlM3wjARBJzpzS3gXjGe6QZNV0aF5udxmSQLOdBqdhP8IlgRvrnp7EkXo7XeJGaTFEFhiJi/Ngl5/JH+dp9WAU7Bfh26dc8ulC00fM/IHrYzkEPlRY8wrHOTuT6NjzLrte4GlBq4GrforaEX8RGlxwy28rApYvMVa+GvqTf12PKpWmqj74DCp1NDj3/PL26bYdmSOCXl7fcZbjN9bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=woUOmSHTfo6rwe2ZYwHaUuWygR5g64CLBIZHqefs/90=;
 b=f9vTHFkxGPrKj/nMk8zedjDbDyQBLFwKJkrSTlIwXbsdmrBCM06EsRvf4kKwsLQL/AhTDlfG1V94wj/bRbdTJJgc1/m461sEi95rf+HsMtQwZ1ImL+NK6zHYyDfExn3V0QWTvgTpoYNLFpqfTeqYUdG6H2irmZ/2XVxxoEsaF0j6zoPxKbirjjYgmkMPb8mgn0hCNv486f9A8MSUxAXNRBBnh1GdZo3QWgyV8LE9wZMzBhnGIl5hbhlYpK82LGyKEVnXeHx2oFK389COH4I0PZttNe+VvKzdnBM/cMfhFzBmkR8kDI3m8CiaRgC+paNKeoDTeWbrva59ZaLbkBSLlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 LV8PR12MB9232.namprd12.prod.outlook.com (2603:10b6:408:182::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.15; Thu, 16 Jan
 2025 21:10:57 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%3]) with mapi id 15.20.8356.014; Thu, 16 Jan 2025
 21:10:57 +0000
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
Subject: [PATCH v5 04/10] mm/huge_memory: add two new (not yet used) functions for folio_split()
Date: Thu, 16 Jan 2025 16:10:36 -0500
Message-ID: <20250116211042.741543-5-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250116211042.741543-1-ziy@nvidia.com>
References: <20250116211042.741543-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:408:ee::13) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|LV8PR12MB9232:EE_
X-MS-Office365-Filtering-Correlation-Id: 09ed7870-ce76-4342-9393-08dd3672452f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A8tJR2ljMmihnm0zGPLaLzQ7hcskx+oivjhCnMG9NYV609pU8XyGDp+dvhnQ?=
 =?us-ascii?Q?l22AxNEMe54v7AFHK0pafwy0nl40wC90/ve+/6W0VFEOuzrntv4bFGjfJEGt?=
 =?us-ascii?Q?eL2uFxPYELGtdXEtPfgaKJnJK+I61geklL19R2fOyGis8TJ1YKCsklyO6vrw?=
 =?us-ascii?Q?avQ+r58gAlhLW7j3N+nkkuT2bZ5GNI3FhJ44gRWEH5vx3d+7453jVljM2BBF?=
 =?us-ascii?Q?zJTQxX8KR8UTsDRQguEzhSGyT8n0lvmd1ambiTw8nB6UXD4Zhte5zO6+hzr3?=
 =?us-ascii?Q?oCSG91NXkVHcNAWsdykm3B1b6/toW4ZtGwLKCS+yxkMCf1Vgrs6ES+Qjq3qr?=
 =?us-ascii?Q?NaCIcTKCbiyvAcuP8kQm7x8k4UmP60zlGpbJUfBSC8dhZFogeK3rUNkjW7Dn?=
 =?us-ascii?Q?1aF2WhDW/epvY7fuQgHfcj/vCxBpPXLiurOscBj0NrTPeySLH2HDZnDed4Nt?=
 =?us-ascii?Q?QsSsHYNumxzRtrdDQIAUZMR9UwzSqz6KIlGOENmcMrEC+GfKG6EE/Ruj+u94?=
 =?us-ascii?Q?3vMMfCq+fe4llXOIN/BwAKQQIlKOqB00ImH2v4g0Sel7o975UAARLWw3HRME?=
 =?us-ascii?Q?JQkEt0tFVbGE6FOnjvnFOuP/qT9jq1Sm+XfDvcq3PkRlIVvhpFVqfQQBN4R1?=
 =?us-ascii?Q?JT11VP5I8m1GR45QpgSrjqKGlv3fXLgJwp5ioBGpPBArPPv/xuXu0OLpRehb?=
 =?us-ascii?Q?atj3R1g4+bAugoUNY4SBX9rZfq5inwt+L0JUaii07/p9X+yjwMo4fW37/SsZ?=
 =?us-ascii?Q?fMj1ZqeIKPwuqX096iOp+Pz3bIJVLM/QfU5Dp9ym5s2+RI/lnmSRzt4p6oqB?=
 =?us-ascii?Q?nUS6vck8zekU3KoQ7y9EbgSBYkRpGpznN+rOSFQFbebHYo1fcK2TUqsXqT+Y?=
 =?us-ascii?Q?sD//087YUIHTCOVuYR2qYHp3KLwCcMNHsag9x8YG8VxBDErHdjOxj+p9X+JI?=
 =?us-ascii?Q?6+iWZHnbBr4P2UZvPIyf4aDvanXHP+gpKEINEx5++84o41thT6RRUnB3S5rK?=
 =?us-ascii?Q?iK1cGdWQcqHEnpnrvgHnIV+nVhfm9Gzg+7SaWBQC359llMhkEIynfKo+3uzG?=
 =?us-ascii?Q?2qW3eLLK2YPGDTxQt8a9BjjRph5PqEIt+iwqH6r/MdzVzwLia3SpNSHDMglb?=
 =?us-ascii?Q?QBPYTtdBuYLgbZXr70sfqed7sVnBKJ6uMcCUowCO4n6wx4GlrWyNFDxm4YIH?=
 =?us-ascii?Q?szhH8kRbdnOMmCkbHRu3knLcfNqEDwx0oMC8qnUhUwWp2YyOtd4aBtofxzZU?=
 =?us-ascii?Q?iUij0vtEKS/TcCf1xFX60DltMNjLcgTEmx0mZna/pRMEcQEduX1jMatqCobo?=
 =?us-ascii?Q?2GDOLbTDTxfU49wGu4ZbhuRlguRei9uQsPs/kpZ1kiQaAa8Ozifd4UTtEnwN?=
 =?us-ascii?Q?7bUHd5HymN+5aEL6oIaTUFgl91eH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z5sFlWh5dfVdcTkbswITpCzfkfkhkt7mYRFICVZp5vYNiiyyuEG5v8fSLpVu?=
 =?us-ascii?Q?srpV7CGouF4gNhUdo8fQws5cajFi+jFKO8Cu2or+xjSn+Pains5JL9LGgqEG?=
 =?us-ascii?Q?zErRQzVNesBCcK15hozYpX/q8XI046ilcfv1slprpNkB5NgZyYeNC2C1lHVw?=
 =?us-ascii?Q?bmqDXlFddLJvnn0EgDUiJlky2vQs+Z9HkwA1wntcrIjdpOTNL1MAWBWGurry?=
 =?us-ascii?Q?2Zt9vpUwFIWaSP/+RSmU6Fv9Xjpu+j4ZS0dPUdkLOnso7kXSVMZfEiwx+Mdh?=
 =?us-ascii?Q?17qOjhL5eGk29b+FmB7lF+fgidQxyZ+vzJvIfQs7nxzSyksTIkxOFb3eZwCg?=
 =?us-ascii?Q?f85WO+AaZ0Vxcj4xV6j+9zdED4Ou5n5E26UtPS9VNuPZ+w9M/sO+QKqLinaw?=
 =?us-ascii?Q?Veu/cqKfmaQC3RD0O3vg0i8PWXNtuOEhRv/t99VoyM+drQqU1fVoBeYrqUAA?=
 =?us-ascii?Q?/zgqwnQKKzc19iIb/OuOB0MClUTYi6AFceOXiJc+m1M2Enox9I227D/8XcKU?=
 =?us-ascii?Q?vWZK4ATaJv8cOTURTztoXK/s8BDMrTn6uNf6yWUxwecG9tQiutiA6ICT1imt?=
 =?us-ascii?Q?Zxy7Xo3jrjupVNuZyYbMFF3t3XcphU0r/+iuAtmY4ZXpzprocwiVgfFs6qzr?=
 =?us-ascii?Q?ZIOmlzo9W2xkdECIPu9NCEQmO2qkSPPRxIxCSILjPVwRY9SV2rJM5P8CX2JL?=
 =?us-ascii?Q?aohPYf0YovkopC6gvU2yHkfyM43GxmOIoZMEZ8xv/ML8iehFztvlARoMjynt?=
 =?us-ascii?Q?Gh3ucBZO86pX9tv9GsmWzkx0hp6QMA0RlIWo0MwIgwhTNTvmWIZ9I/xOOxvV?=
 =?us-ascii?Q?EUvVS6msZOIZk1mwqM2eeoe7TYPwtU23Jf7isi7LprRTDp1wS+kSA+c2WSz/?=
 =?us-ascii?Q?KgyVYissg/U1sdxrVWNbIE7f1jrQs8nmHmkkUHs3RgkThkNJAYJD38Ckj1Zi?=
 =?us-ascii?Q?0GXxp1AcF4AoH3XPb+wJDrAEGa3/AX4IfBw4lx+fHJGxTz+rKHoiZMyubsGY?=
 =?us-ascii?Q?/aM1qC6GSVpmxibCyGadmiXJ9PCOc3lp7unsMcwPWtJ+Q+B3fl+qEN53ZzLK?=
 =?us-ascii?Q?c6+ozlgersOTe/WcEuITOToflitpT39yYQ8trsukfE8OS8dlJcGOH/AB7bWl?=
 =?us-ascii?Q?Lk3h9y+ONqDf5TTKtBONKBmEaYJ0myrQ1n4UnYK7i65cPBfdlztpzi+J+D9i?=
 =?us-ascii?Q?wwQQZ0nsDDdEnyHZActZPMBWIL+rv/E6zpOYWdRVHZ2FiNp6pWiDhlGCDjbn?=
 =?us-ascii?Q?Q9irPdVkopJ9P5H05bHuYMqlfv5JkRmRiDe3OYXKBCaahQH2OYk3AbSAbQL7?=
 =?us-ascii?Q?wiJ1wcDRANmYBmhw244q3AwI7kNoOLnU3ILx6DPo+MPY/PDb/whq8YNtTgVw?=
 =?us-ascii?Q?ALKuNccejitVEY6IJyviOdenMjUbrKNDnjfmJxRK6KrPHUhPubSC3xdNfUIO?=
 =?us-ascii?Q?BWQrZ+CDrBQpkia//xQxJcEDg0xR3ieNCrXb+Frlo7HAAyeAezokPoIe2ef5?=
 =?us-ascii?Q?AhBC/AA2lMAaioCsOf4kLP719uPpQ4hQB/aslV5P+K7MfZw8EKv66AE3ODAL?=
 =?us-ascii?Q?BKRf3Sux8RhUhaf9xo/5iVfY1F3yphxk39XTn+9y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ed7870-ce76-4342-9393-08dd3672452f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 21:10:57.2446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PZuqwzM8C8/kL9a+3eyD9o+0LzTzQtLBxuawEfO9Df3TA779mgDWGSaemiIkGAjj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9232

This is a preparation patch, both added functions are not used yet.

The added __split_unmapped_folio() is able to split a folio with
its mapping removed in two manners: 1) uniform split (the existing way),
and 2) buddy allocator like split.

The added __split_folio_to_order() can split a folio into any lower order.
For uniform split, __split_unmapped_folio() calls it once to split
the given folio to the new order. For buddy allocator split,
__split_unmapped_folio() calls it (folio_order - new_order) times
and each time splits the folio containing the given page to one lower
order.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 350 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 349 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index deb4e72daeb9..c98a373babbb 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3146,7 +3146,6 @@ static void remap_page(struct folio *folio, unsigned long nr, int flags)
 static void lru_add_page_tail(struct folio *folio, struct page *tail,
 		struct lruvec *lruvec, struct list_head *list)
 {
-	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
 	VM_BUG_ON_FOLIO(PageLRU(tail), folio);
 	lockdep_assert_held(&lruvec->lru_lock);
 
@@ -3390,6 +3389,355 @@ bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins)
 					caller_pins;
 }
 
+/*
+ * It splits @folio into @new_order folios and copies the @folio metadata to
+ * all the resulting folios.
+ */
+static int __split_folio_to_order(struct folio *folio, int new_order)
+{
+	int curr_order = folio_order(folio);
+	long nr_pages = folio_nr_pages(folio);
+	long new_nr_pages = 1 << new_order;
+	long index;
+
+	if (curr_order <= new_order)
+		return -EINVAL;
+
+	/*
+	 * Skip the first new_nr_pages, since the new folio from them have all
+	 * the flags from the original folio.
+	 */
+	for (index = new_nr_pages; index < nr_pages; index += new_nr_pages) {
+		struct page *head = &folio->page;
+		struct page *new_head = head + index;
+
+		/*
+		 * Careful: new_folio is not a "real" folio before we cleared PageTail.
+		 * Don't pass it around before clear_compound_head().
+		 */
+		struct folio *new_folio = (struct folio *)new_head;
+
+		VM_BUG_ON_PAGE(atomic_read(&new_head->_mapcount) != -1, new_head);
+
+		/*
+		 * Clone page flags before unfreezing refcount.
+		 *
+		 * After successful get_page_unless_zero() might follow flags change,
+		 * for example lock_page() which set PG_waiters.
+		 *
+		 * Note that for mapped sub-pages of an anonymous THP,
+		 * PG_anon_exclusive has been cleared in unmap_folio() and is stored in
+		 * the migration entry instead from where remap_page() will restore it.
+		 * We can still have PG_anon_exclusive set on effectively unmapped and
+		 * unreferenced sub-pages of an anonymous THP: we can simply drop
+		 * PG_anon_exclusive (-> PG_mappedtodisk) for these here.
+		 */
+		new_head->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
+		new_head->flags |= (head->flags &
+				((1L << PG_referenced) |
+				 (1L << PG_swapbacked) |
+				 (1L << PG_swapcache) |
+				 (1L << PG_mlocked) |
+				 (1L << PG_uptodate) |
+				 (1L << PG_active) |
+				 (1L << PG_workingset) |
+				 (1L << PG_locked) |
+				 (1L << PG_unevictable) |
+#ifdef CONFIG_ARCH_USES_PG_ARCH_2
+				 (1L << PG_arch_2) |
+#endif
+#ifdef CONFIG_ARCH_USES_PG_ARCH_3
+				 (1L << PG_arch_3) |
+#endif
+				 (1L << PG_dirty) |
+				 LRU_GEN_MASK | LRU_REFS_MASK));
+
+		/* ->mapping in first and second tail page is replaced by other uses */
+		VM_BUG_ON_PAGE(new_nr_pages > 2 && new_head->mapping != TAIL_MAPPING,
+			       new_head);
+		new_head->mapping = head->mapping;
+		new_head->index = head->index + index;
+
+		/*
+		 * page->private should not be set in tail pages. Fix up and warn once
+		 * if private is unexpectedly set.
+		 */
+		if (unlikely(new_head->private)) {
+			VM_WARN_ON_ONCE_PAGE(true, new_head);
+			new_head->private = 0;
+		}
+
+		if (folio_test_swapcache(folio))
+			new_folio->swap.val = folio->swap.val + index;
+
+		/* Page flags must be visible before we make the page non-compound. */
+		smp_wmb();
+
+		/*
+		 * Clear PageTail before unfreezing page refcount.
+		 *
+		 * After successful get_page_unless_zero() might follow put_page()
+		 * which needs correct compound_head().
+		 */
+		clear_compound_head(new_head);
+		if (new_order) {
+			prep_compound_page(new_head, new_order);
+			folio_set_large_rmappable(new_folio);
+
+			folio_set_order(folio, new_order);
+		}
+
+		if (folio_test_young(folio))
+			folio_set_young(new_folio);
+		if (folio_test_idle(folio))
+			folio_set_idle(new_folio);
+
+		folio_xchg_last_cpupid(new_folio, folio_last_cpupid(folio));
+	}
+
+	if (!new_order)
+		ClearPageCompound(&folio->page);
+
+	return 0;
+}
+
+/*
+ * It splits an unmapped @folio to lower order smaller folios in two ways.
+ * @folio: the to-be-split folio
+ * @new_order: the smallest order of the after split folios (since buddy
+ *             allocator like split generates folios with orders from @folio's
+ *             order - 1 to new_order).
+ * @page: in buddy allocator like split, the folio containing @page will be
+ *        split until its order becomes @new_order.
+ * @list: the after split folios will be added to @list if it is not NULL,
+ *        otherwise to LRU lists.
+ * @end: the end of the file @folio maps to. -1 if @folio is anonymous memory.
+ * @xas: xa_state pointing to folio->mapping->i_pages and locked by caller
+ * @mapping: @folio->mapping
+ * @uniform_split: if the split is uniform or not (buddy allocator like split)
+ *
+ *
+ * 1. uniform split: the given @folio into multiple @new_order small folios,
+ *    where all small folios have the same order. This is done when
+ *    uniform_split is true.
+ * 2. buddy allocator like split: the given @folio is split into half and one
+ *    of the half (containing the given page) is split into half until the
+ *    given @page's order becomes @new_order. This is done when uniform_split is
+ *    false.
+ *
+ * The high level flow for these two methods are:
+ * 1. uniform split: a single __split_folio_to_order() is called to split the
+ *    @folio into @new_order, then we traverse all the resulting folios one by
+ *    one in PFN ascending order and perform stats, unfreeze, adding to list,
+ *    and file mapping index operations.
+ * 2. buddy allocator like split: in general, folio_order - @new_order calls to
+ *    __split_folio_to_order() are called in the for loop to split the @folio
+ *    to one lower order at a time. The resulting small folios are processed
+ *    like what is done during the traversal in 1, except the one containing
+ *    @page, which is split in next for loop.
+ *
+ * After splitting, the caller's folio reference will be transferred to the
+ * folio containing @page. The other folios may be freed if they are not mapped.
+ *
+ * In terms of locking, after splitting,
+ * 1. uniform split leaves @page (or the folio contains it) locked;
+ * 2. buddy allocator like split leaves @folio locked.
+ *
+ *
+ * For !uniform_split, when -ENOMEM is returned, the original folio might be
+ * split. The caller needs to check the input folio.
+ */
+static int __split_unmapped_folio(struct folio *folio, int new_order,
+		struct page *page, struct list_head *list, pgoff_t end,
+		struct xa_state *xas, struct address_space *mapping,
+		bool uniform_split)
+{
+	struct lruvec *lruvec;
+	struct address_space *swap_cache = NULL;
+	struct folio *origin_folio = folio;
+	struct folio *next_folio = folio_next(folio);
+	struct folio *new_folio;
+	struct folio *next;
+	int order = folio_order(folio);
+	int split_order;
+	int start_order = uniform_split ? new_order : order - 1;
+	int nr_dropped = 0;
+	int ret = 0;
+	bool stop_split = false;
+
+	if (folio_test_anon(folio) && folio_test_swapcache(folio)) {
+		/* a swapcache folio can only be uniformly split to order-0 */
+		if (!uniform_split || new_order != 0)
+			return -EINVAL;
+
+		swap_cache = swap_address_space(folio->swap);
+		xa_lock(&swap_cache->i_pages);
+	}
+
+	if (folio_test_anon(folio))
+		mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
+
+	/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
+	lruvec = folio_lruvec_lock(folio);
+
+	folio_clear_has_hwpoisoned(folio);
+
+	/*
+	 * split to new_order one order at a time. For uniform split,
+	 * folio is split to new_order directly.
+	 */
+	for (split_order = start_order;
+	     split_order >= new_order && !stop_split;
+	     split_order--) {
+		int old_order = folio_order(folio);
+		struct folio *release;
+		struct folio *end_folio = folio_next(folio);
+		int status;
+
+		/* order-1 anonymous folio is not supported */
+		if (folio_test_anon(folio) && split_order == 1)
+			continue;
+		if (uniform_split && split_order != new_order)
+			continue;
+
+		if (mapping) {
+			/*
+			 * uniform split has xas_split_alloc() called before
+			 * irq is disabled, since xas_nomem() might not be
+			 * able to allocate enough memory.
+			 */
+			if (uniform_split)
+				xas_split(xas, folio, old_order);
+			else {
+				xas_set_order(xas, folio->index, split_order);
+				xas_split_alloc(xas, folio, folio_order(folio),
+						GFP_NOWAIT);
+				if (xas_error(xas)) {
+					ret = xas_error(xas);
+					stop_split = true;
+					goto after_split;
+				}
+				xas_split(xas, folio, old_order);
+			}
+		}
+
+		/* complete memcg works before add pages to LRU */
+		split_page_memcg(&folio->page, old_order, split_order);
+		split_page_owner(&folio->page, old_order, split_order);
+		pgalloc_tag_split(folio, old_order, split_order);
+
+		status = __split_folio_to_order(folio, split_order);
+
+		if (status < 0) {
+			stop_split = true;
+			ret = -EINVAL;
+		}
+
+after_split:
+		/*
+		 * Iterate through after-split folios and perform related
+		 * operations. But in buddy allocator like split, the folio
+		 * containing the specified page is skipped until its order
+		 * is new_order, since the folio will be worked on in next
+		 * iteration.
+		 */
+		for (release = folio, next = folio_next(folio);
+		     release != end_folio;
+		     release = next, next = folio_next(next)) {
+			/*
+			 * for buddy allocator like split, the folio containing
+			 * page will be split next and should not be released,
+			 * until the folio's order is new_order or stop_split
+			 * is set to true by the above xas_split() failure.
+			 */
+			if (release == page_folio(page)) {
+				folio = release;
+				if (split_order != new_order && !stop_split)
+					continue;
+			}
+			if (folio_test_anon(release)) {
+				mod_mthp_stat(folio_order(release),
+						MTHP_STAT_NR_ANON, 1);
+			}
+
+			/*
+			 * Unfreeze refcount first. Additional reference from
+			 * page cache.
+			 */
+			folio_ref_unfreeze(release,
+				1 + ((!folio_test_anon(origin_folio) ||
+				     folio_test_swapcache(origin_folio)) ?
+					     folio_nr_pages(release) : 0));
+
+			if (release != origin_folio)
+				lru_add_page_tail(origin_folio, &release->page,
+						lruvec, list);
+
+			/* Some pages can be beyond EOF: drop them from page cache */
+			if (release->index >= end) {
+				if (shmem_mapping(origin_folio->mapping))
+					nr_dropped += folio_nr_pages(release);
+				else if (folio_test_clear_dirty(release))
+					folio_account_cleaned(release,
+						inode_to_wb(origin_folio->mapping->host));
+				__filemap_remove_folio(release, NULL);
+				folio_put(release);
+			} else if (!folio_test_anon(release)) {
+				__xa_store(&origin_folio->mapping->i_pages,
+						release->index, &release->page, 0);
+			} else if (swap_cache) {
+				__xa_store(&swap_cache->i_pages,
+						swap_cache_index(release->swap),
+						&release->page, 0);
+			}
+		}
+	}
+
+	unlock_page_lruvec(lruvec);
+
+	if (folio_test_anon(origin_folio)) {
+		if (folio_test_swapcache(origin_folio))
+			xa_unlock(&swap_cache->i_pages);
+	} else
+		xa_unlock(&mapping->i_pages);
+
+	/* Caller disabled irqs, so they are still disabled here */
+	local_irq_enable();
+
+	if (nr_dropped)
+		shmem_uncharge(mapping->host, nr_dropped);
+
+	remap_page(origin_folio, 1 << order,
+			folio_test_anon(origin_folio) ?
+				RMP_USE_SHARED_ZEROPAGE : 0);
+
+	/*
+	 * At this point, folio should contain the specified page.
+	 * For uniform split, it is left for caller to unlock.
+	 * For buddy allocator like split, the first after-split folio is left
+	 * for caller to unlock.
+	 */
+	for (new_folio = origin_folio, next = folio_next(origin_folio);
+	     new_folio != next_folio;
+	     new_folio = next, next = folio_next(next)) {
+		if (uniform_split && new_folio == folio)
+			continue;
+		if (!uniform_split && new_folio == origin_folio)
+			continue;
+
+		folio_unlock(new_folio);
+		/*
+		 * Subpages may be freed if there wasn't any mapping
+		 * like if add_to_swap() is running on a lru page that
+		 * had its mapping zapped. And freeing these pages
+		 * requires taking the lru_lock so we do the put_page
+		 * of the tail pages after the split is complete.
+		 */
+		free_page_and_swap_cache(&new_folio->page);
+	}
+	return ret;
+}
+
 /*
  * This function splits a large folio into smaller folios of order @new_order.
  * @page can point to any page of the large folio to split. The split operation
-- 
2.45.2


