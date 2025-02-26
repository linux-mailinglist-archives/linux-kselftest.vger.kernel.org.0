Return-Path: <linux-kselftest+bounces-27664-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D69A46CE4
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 22:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 421EC1887481
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 21:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D577025D54A;
	Wed, 26 Feb 2025 21:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SA/Wd40m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9481D25D52B;
	Wed, 26 Feb 2025 21:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740603660; cv=fail; b=Zos2tnUVLdyNdt0d641SgsOmVR1dDBFfLY3znl9uBA+6XgTpsEYdwR+blKTWB6ImtQXncbaRfFzRitA2dySPRrGy/EneHjmoLT1A5f8Sids8Svs6KkFxB2hwUCj8UWnPpg9xa4WeChAH8IxgErpos1hVjp3PmlSRGwZr9eo/xmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740603660; c=relaxed/simple;
	bh=GoG064e3rBLWceG9UA6OR3g0PVWdE6ovuKWstULT1lU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XQD/FD+YoAPvinvADBL76QuHXjp8gIfmI2lBDDZNIWBvE+WwIcdhpRYpDimdKHAYEFpQlzJVY5KJosuG63aI1D6m0FNuGikRdnV+F16YsFlCKzjbZijqkRHVlhrUSSxDgM9uq/RxrGVBuLAP1ifNFKbfegupMtcRO+wF4HqEaHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SA/Wd40m; arc=fail smtp.client-ip=40.107.95.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LLKmiIlHKUymefgLidLsX71IoBc34fBeOgquHbAJLSqenmJvglbPbFrre3oCt45HaKRAmo+vb38nYkmIU5i2QgNVq9fStVxagAllRfVVHZLHllvs1L4cGsiYdeimXBw02jS2TEXQD/vRDxlEi2OZnnF77DPVw0hxXLx18egFkxZFE0V6PGlGDpaqfO+LGy6O5fNFj6tz0vraoW9ZVh4kDtqTYyodSGe5UKswJn7cjAPemXJyYb5LN8uBq7q3vw7miZJBuujkhF85fLcAv+Cfzs2HWUhwtlTKz+8yg91nhGfsOkZkpN4mKdESE8QJzIAfi6PQHKGIOKZ3ylAGFTrIww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5L4JUeJ4bSLnuteZv1Q+5nblizeI9NFaVHLjbQONbtA=;
 b=NloX0x4Z7Dj4oAAvoqirsBnmHvrz+7/c0s9rtzH7Oyli78CfmgTsOHqZW1/4yXLINmmrFFGHJ7ri6jw64wjQWXPNSs8PbpHKoAd6WtRwD0SFiLU9L1DOmaYfdBMMMG0A7mhtvvohtvExPt8Gh7eozJo3ahmLclWeGbEWi34/DpOZ8mGPJPDZB5g01dKbtIrsWBTgBC3h9o+tEA02fbqBcDchJQWLRYtF2hqP/83/lzjmMdj3leaewG/ZR7U7VGFCyVMvff3vEAd2cLfBHwRYx+r/wnQ146ln8XNsCQ+YcnHRk6SvSrnovvd+4rBjbus2bDNCUC00zsnr4eBjlNW9Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5L4JUeJ4bSLnuteZv1Q+5nblizeI9NFaVHLjbQONbtA=;
 b=SA/Wd40m9r+oSyb7K09lrMUo6S7OMwBLRNuwbdeGH848cGAE1ZiXreXVLqnP+3miVrO+8CiNsG2YUb0npnHNbCQA5J4Xsk91nQ8oDzXa95uixX/5duHVUiAW5yOfjNbo869xNDNLF5hBVhyAZDci9202N3HoWwGbopyGqdmp33DR77Q//UqIwtBf7xYLyNpEWMF0bUFzXNGeG6Z62qYElJUE3BmcsdEGy9YpdYH5nH6+v0VIJ6VjOlolLYmomWM1pAekUdB+Vd0gcjZlxU1GMSHMlnq0+5xpX4RXKnkHLg9LYcak52HIG3UmbXQ82fe0pBM3uZGhCt2I456SUxbpBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.19; Wed, 26 Feb 2025 21:00:46 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 21:00:46 +0000
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
	Zi Yan <ziy@nvidia.com>,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v9 5/8] mm/huge_memory: remove the old, unused __split_huge_page()
Date: Wed, 26 Feb 2025 16:00:28 -0500
Message-ID: <20250226210032.2044041-6-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250226210032.2044041-1-ziy@nvidia.com>
References: <20250226210032.2044041-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:207:3c::47) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA1PR12MB5614:EE_
X-MS-Office365-Filtering-Correlation-Id: 83e384ec-4e82-40ea-24e9-08dd56a8a407
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HBsQ25ONhgfOswFBt3ps7fgUYuX2fCVroKvQPxj92SVAdB5PUm3TjknpLdZt?=
 =?us-ascii?Q?sSEC55SfqUZRlX/qzdPiWGIK5w/VWYz7CrReTTislV6xv4qHJbrmX1xcCVYI?=
 =?us-ascii?Q?ZPr5Hu0F13DDnOUxKIKGcblkgRja5JIto9nY4BoKX4oYhVF0WZi0TR2Qq8bB?=
 =?us-ascii?Q?67CgRWOs9TsEk11BAwG8zl/hCINDBsS5L0QqUH3lyzEkh+d/YlyM4vf8v/uv?=
 =?us-ascii?Q?/3xOrHSkCDNDVFO9bUtXejZRXe6VyUxUE2mvEBNQj6PdxNE9sDz2cKeCK7/M?=
 =?us-ascii?Q?8AmRz/67er1iHcmaIZFp76Wn0oKReSaoNSDKfTSM9awHOcZYGV9SAcAHT2z6?=
 =?us-ascii?Q?NkUnGboAhm4TPA69sTNIWSOCUNVZYSy3G0I2S+Qyt1utGwLFtw1LZ8q/sBMD?=
 =?us-ascii?Q?mr5budf3AUVqELJ7NEx/31CwWBYyLVGLvvclf/4U4hlWUY1TO1I+GC+RXX3s?=
 =?us-ascii?Q?LgE7zh9HxA+ZbP/ny7UpHKixaZ22Bhcfbv0YOdWCtQ+BVilT88BhYUXhFRlU?=
 =?us-ascii?Q?6BOiQ9vEoPiIrW3NM+2Pe+3R/alP4OVGqC+YVce3mxt4RklLk/p9wQDDxX5H?=
 =?us-ascii?Q?16hIMxCZyVieRjjF4PoxO3/1S/kJ89r1icTkSaTPCxUdhTAM/S6vsgrfXk18?=
 =?us-ascii?Q?XHEY3hF9gxFRz8p3vT9RkTqM4og5gW97wwDTRJs2XWJlbnI3G+0pIGv+zyQ+?=
 =?us-ascii?Q?G4XIL42DDrfWYeEGztpcpXNu7n8uzC9yQ8/ipo4OXAT8t1tbmu4WHZiO9G/n?=
 =?us-ascii?Q?GoB0Aih65gRqKM8ISjW2I/zTW+IFy3aBFo/aN8X0lX0ZQXByhq/WqytdOYFJ?=
 =?us-ascii?Q?qOtVocXn3H3ghzdy+atVfx1WWYW+ihWlGxQ4kXHrKUtAlJEUuS/QHnv1pyKy?=
 =?us-ascii?Q?57XPc3AYr9yu0aKLI89gQn2VCkHnfyBthFh/AYFJCHUHAd3AIU3i7HSWzkNt?=
 =?us-ascii?Q?izX++uAkhsFwkW0QYOq6B4yEJ1HWnFf8aL+cbHQzKhoDV1+g3z1uFG/P+P4Y?=
 =?us-ascii?Q?TrFQl0FTRXYl95Z5OiNMistulxkaFRfpadhXgZa+DIZwIggT9zh/dzjw41i/?=
 =?us-ascii?Q?K66sjVxhFINnUOBQlcNi+2lAKMzSnufvCNj8/GA3JQecm0SV4QeLGejJOZkC?=
 =?us-ascii?Q?J+z6rbo1Zrq/RcEwh9cAP/c8eljA0QHWAvJtK9IFlCwbhssDaTfv/pioY5mt?=
 =?us-ascii?Q?GiNderNmx3nhhAn+QNOZkx+nbgrHYm74sMiGCRThIa5XiC8mZ0foAUSMiYNC?=
 =?us-ascii?Q?ltkDNC+4lSTP2ozjccpWOQ92FWSxu4jl+cyPSaollO7/MwWjdqpM5fGWio8e?=
 =?us-ascii?Q?nAdGWpiCrp5AY3OlRL/9VmFtgoiICr3njrjPQQosJOyxq/kz6Qi2VcFvN+tl?=
 =?us-ascii?Q?5pHHk/uPEcwgRLI7STT3ulf+7oFa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YFhswWTeUidh9/zn3+bZ3zElsiEprXNfOj9qxkgH+36wCzepKTMTmQJGKyB6?=
 =?us-ascii?Q?8U5TLqvA1Mr9zYPnbd8/0FnwZpdgBNk+TqUNDEMMGfFWRiaAVBMPpd6xhErD?=
 =?us-ascii?Q?xrVmQc+98flxF9STnIklJyEZtPA/y0yYqzdRvvUdx5HGZQ9VUnnAFTcKXzDa?=
 =?us-ascii?Q?wEKLT8V2vZy18yp65JqsQ1uvzdZbKqiT8IalTv+LEblveBelXJkC4YmmJw1P?=
 =?us-ascii?Q?mfktKb7OOtwRVopkeNiO0xCS0HZO8XQYCauG1V+K3YUYhfU1+4WnsE8wAwM3?=
 =?us-ascii?Q?D2+9/olKYjomlFzfQES+iq7AfP0SLtFG98VzOlv+56kJZfo5jiOpo/11j/NZ?=
 =?us-ascii?Q?W2s7g2i/lLR5QlBeEtHb4zO/5ewBlQEye92gqxwVb2yp1mjjmug5ol1w2vRo?=
 =?us-ascii?Q?3Ag7FoI4x0jDblR6Gf9jstei5jgUD7EnBKagmHne+RyV4wNEMpkeCcn9y5YT?=
 =?us-ascii?Q?PN15W4kLx4PD8CnLDmYqCZaf8nJq+D0v+mrlp4tSoICGOTlTscACStznyfjk?=
 =?us-ascii?Q?67P6XO4SEXSjBStjrQbcoXwLNWR/KysraCmU4ombi9ZuHzf+kZ/8O4Xw8SoJ?=
 =?us-ascii?Q?qx2dzwfSVqd37EqqPeKmVd4rDA7q7Xq0+g61RUSYddjLeuv3KHRvAoevCpEd?=
 =?us-ascii?Q?JQEUieWafNBDNjZCNex3NbgiZxhi7HS3lWqQXXlYNcBGZIcJoYg51lEbGfY/?=
 =?us-ascii?Q?Vgi4S6jEy8tMrb63C3TB2vV5nf4rhixTka2MnYOaPyRpdxDNlFHNABW2ru9N?=
 =?us-ascii?Q?Ap2d3XaTQnvvxoDrwdaP9wiNZPEYl+AcMFObMvmF2zMn5lVgSf7rGjWNHUno?=
 =?us-ascii?Q?3PUQeFRkt5Vin7OXZ1rf7qwNukfVjEAenkQdnqxYeAIedxS1aRC+yZT3Bx7/?=
 =?us-ascii?Q?nTy3f+4nPU4cTyzk8BYoKkUgAdPvY5bBbXQ743SJU5ckaESRhY+AgzJNJGYY?=
 =?us-ascii?Q?6ueB6YHb5JM7vyyFIjQBL/8/Ncvux570/3R6BbJny4k+6VPRZrvYw+PuzMXi?=
 =?us-ascii?Q?czCW2GjQKTOoo2u8/zlXWvbAp3DIwgpOVngI6lQjIVqOzYT7kndu/SvFK9wf?=
 =?us-ascii?Q?Uo6vSBz0wrVcdyRYVxEw+5KGzCIgc4vixIF7pW3ExytccGybR4+hmJtZNYyh?=
 =?us-ascii?Q?pMN0Wem1R7Ury36yuft2pKxo3KkKg5i3GtL1ka7xzOj73+Y1C2UKeY/YY3S8?=
 =?us-ascii?Q?Y7bvvlYuImaoQMhcw9OFxWbo0/RodK2X99d3H8zuOXxJjL25oJkvvz8NHXQm?=
 =?us-ascii?Q?njVvs7LdiiDL6nzlGl0kIqeagDVbTovGRdANb51jHF+hr5P72+9fEn4gttd2?=
 =?us-ascii?Q?UEcbyVq+4VgOWOUcYIDLReccfk2/EmdV0C/m7OIdfB0RJURy1CiPk0Odqi8E?=
 =?us-ascii?Q?PoNWfJt2JufIa+IyJiU0SVo3TnKvjyJrvpxN6egwO09rIPzM6GgQaxXmQFqe?=
 =?us-ascii?Q?FgWZfkaAn4JoVYavZFKEwsoGVmaH/IsZzGzobMAKfWsOvquCEaCa5PpL86bS?=
 =?us-ascii?Q?I0wDPEcYolG3a7t3cbtFGSRXc56Cq3ktVxwyLokzbaPJEhmiL1GkWFDoCXr1?=
 =?us-ascii?Q?MoYTcOhBYtQiz/XSbBOuz8jxAyFTbgwbPYiGzyct?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e384ec-4e82-40ea-24e9-08dd56a8a407
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 21:00:46.4573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NigCvpTg4EEs/IxwRn7FpwYDb0pLwCmSM8QrwZj+XAy8NnhFSXHOhTI31NWcaJec
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5614

Now split_huge_page_to_list_to_order() uses the new backend split code in
__folio_split_without_mapping(), the old __split_huge_page() and
__split_huge_page_tail() can be removed.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Kirill A. Shuemov <kirill.shutemov@linux.intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Yang Shi <yang@os.amperecomputing.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Kairui Song <kasong@tencent.com>
---
 mm/huge_memory.c | 207 -----------------------------------------------
 1 file changed, 207 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0e45937c0d91..e7e50b2b23f6 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3286,213 +3286,6 @@ static void lru_add_page_tail(struct folio *folio, struct page *tail,
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
2.47.2


