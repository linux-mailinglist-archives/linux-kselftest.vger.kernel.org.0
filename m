Return-Path: <linux-kselftest+bounces-25789-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DDDA28293
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 04:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F72E7A2FB3
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 03:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56386217719;
	Wed,  5 Feb 2025 03:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pqT4V5e4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2077.outbound.protection.outlook.com [40.107.212.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594BD215048;
	Wed,  5 Feb 2025 03:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738725293; cv=fail; b=qVZ6+S3noZJ27LPCkJPJd/S6Edf2/0wtHg3zq+O2DLPgdxNAWJl1o3ra0UsGIOQgh7ZZWmuDVx6V5OhOmecWAUXBrL5pL0HqUzE2EoSgA1z2oZF/MxPZKhnECyUxTiYCmuSaIb145kNSCXJz25cCkwT6YByR+d053o/UREmb4XU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738725293; c=relaxed/simple;
	bh=TTjbU6lxZ72v8uV5VPVQpasdPmmQjcMgKqTcHDDN/3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ngTEBmrotcuR/ta6iorCKt5bgsyCaWiGfWZAXM06wzEziEJZPI8Jrq8OPiS45hF3k0r5Sgoc2UerimXV7A8USg1wRurQ4unj1/FKTP4TUUXROLVwXxzD9RSZBJKM3xI42JKX+TjOM+FxdT04udhhwFPXvnITLncJn4Vosvt/pik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pqT4V5e4; arc=fail smtp.client-ip=40.107.212.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eVtbKZVerXU6l2l1pOBH88ianttDfd2BNBdr+gnrEi9MuztfGZir1UxEJ2wF0WnjAue2Z9c6ClqMSmBLWh9Nq00NEj0ScagGKGwRiJZxlfjWN+Vs+G7eYFG/bis4+jfyDB1puPl/MF/dbg1PI64CxzfGM4Naupddg6RuKG82Cda7YFt+NuM7654/Fwj/1Dsmp9TwZF9UvJzfZXdIFkhpXoYLhF2vbdQ1eYiEOT55piACOWw8OrY1X/nwGHuLtsAm+2LU9k+nURNEugU72Rw4RpgtiLNZJzRm+h5BbdH+zpQAOWCWF4uIIjabb+ba301iIUf/DEAYtg25HatrLsfckw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JcHn6EpuIJHmIzyx4MrjM6i0D2F+qnS76CpNUvLHJI0=;
 b=OYOci7TyJR6dc64R32iraKkqb3FktMJC9be3K3b0NW4yylbaqfwfxwoA0MV7yuAVT8Mn32Y3l2JMI4fkBnUV8HBDDdfkbAkPvsYZSfR7YFtuEPpdJHtcWNW//H9Llv2GMf5OTLF55kAoG5fKZefoIMD9ytF+aa8jOVxpaT1jjtROZZwE9jFP22EdhttBvNteGNCPETVKk1uUz1u6ieKVll195iYJFJ3Z9KmQIJ/QQt3tqcwiwaPYSTGSKOBeI2Y7m5Oqax+WScIsPoGVy1He9YZto6KDhCwMt3DDtp5QTzDS0SjFXDhbAHp5AGT4XA1mr+rxs59Qk3DHbI/oZ6jpug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcHn6EpuIJHmIzyx4MrjM6i0D2F+qnS76CpNUvLHJI0=;
 b=pqT4V5e4zSJ3P0L5C8q7EBD32na9cDLP+PC9L86/9Ckls3HsEfvm8hbob0mtSJDkaqyLL1QFOmr6OgA9RfDRj/w0u8yvb4DmEiO9iFckO910BegVf1flkOYwnOUWRJk6F8IrdmiEpliMpEDa7JLM8BjeE5/1Ptk5PuYZKVySBXhgpm37YzI9ZBcJN+F9cSPiAV7OrMzhRb5Wa2TfdBrIXfaQeIJJNBaWIZnJG9mtsRSj0eFZ3WVnf4PCkxnTRjWi60Ev0Lgvsf+6Ddih5n+u9Kv6/CP50PO9s6BiVjVEZC2x81+gM4gMBERcCOrllaRH/ZEJwXLh+7QPVMgIe5Rplg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MW6PR12MB8865.namprd12.prod.outlook.com (2603:10b6:303:23b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 03:14:40 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 03:14:40 +0000
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
Subject: [PATCH v6 4/7] mm/huge_memory: remove the old, unused __split_huge_page()
Date: Tue,  4 Feb 2025 22:14:14 -0500
Message-ID: <20250205031417.1771278-5-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250205031417.1771278-1-ziy@nvidia.com>
References: <20250205031417.1771278-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0152.namprd03.prod.outlook.com
 (2603:10b6:408:f4::7) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MW6PR12MB8865:EE_
X-MS-Office365-Filtering-Correlation-Id: 2877f672-caaa-4fee-afcd-08dd45933ac2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iA/dEYNJE9qhZAY/Syio/XNTBAWc2PV1yJc5Z4t8e6vjaiTna3Dt+t3Uas4m?=
 =?us-ascii?Q?qGfICst/UDdgF050Y1VE9WUDIjA2K3VUAtN53D1eCw+1TPzY2EiwPcKUP7SV?=
 =?us-ascii?Q?FbKet3vtt7azWMmeGNmwqkaP6HYZMksaa6N6o2JwMHkxeAA4Z8ui+k78QGG/?=
 =?us-ascii?Q?7S6jIcjNd3jBTshtvk9WJmsg2VclVfkO+ovndZOq3Ibi0bC8kJ29Adlh7tT+?=
 =?us-ascii?Q?IVtxsQrYB+oIE5W19WbTqH+UAB/Hs5BV1ExCF2P8cMt+N312eUdyo0HrRDOJ?=
 =?us-ascii?Q?HmhnNgvea5nJ2Fd4ntelcenVRRZFvNxLB9rwrJ/l/lJ7a1mFGSrewKu6KtUX?=
 =?us-ascii?Q?MAf5b+LfSIBJv3Vbum7XlZqwRNFszJDOFc8+FEldSOFxlKLJtZtRTNrN6wab?=
 =?us-ascii?Q?AtvuwHp6INKoSH0/taHs/9/6ZTrvHOLo4fMeFN6Pa6M369ir+MG+X8rZh5l1?=
 =?us-ascii?Q?F4YsEEqYm6fAGVzzWrfjH45x0NUEV/0Kd4HWvl7TtnyOO1Xfh9bUZDCCh9lz?=
 =?us-ascii?Q?9TIOwB29eTQDJqADpU3ICcWFEm3/twtQIbDUP6GDMLkn9Yv/UUY8xWEEATL0?=
 =?us-ascii?Q?mDpSuxA+MhvpKrV5EDKRYmtxpghK6KOW38iL4BsRJ+/mieN0gkHpkBPO9IVW?=
 =?us-ascii?Q?FE/hi0bsRR++E/mgwp+5myUKimcCVteSeSvPt+2JO8jshMEXdK2rcqf4mvWX?=
 =?us-ascii?Q?RDGS9BsZjIaQQCXav9kGTmg3M1Y6CdAg2sIBHpd/+i2GX75vP6MJWgSQ7ngj?=
 =?us-ascii?Q?LPD9ExF55+OuNd79rhD2jJfAMF+NYKAHiH9h4Nw9KHJsEpcQtHtPbK8iM1Xv?=
 =?us-ascii?Q?eF1wOIjXL5yZ5V9BSw1pm+TmDQiEK3spiE86J7D0I0tWirEf7WiaN+44sHHf?=
 =?us-ascii?Q?EyzNm7F1XFRjVHeAOlaHdkRFZIiALNHCOgUustvH1Q+uJ59xtnN2koNe8iLU?=
 =?us-ascii?Q?TsGE2wL3l44gVO4qe+lUZZUsu1tQte0qLb/H+35Lu/p6DJQzw+vbNfrK4kWc?=
 =?us-ascii?Q?5HIgjKE4pQhVC2AiYhxD8dMqlMaTJ+XYPnjWe8LY0N4sH5pAr3za4Li51iUy?=
 =?us-ascii?Q?gTiFNQnJz4Bnlg1j0xCJyoniF2zr/ip6RbfqXUEwihsklyHcurZSDzveDvxG?=
 =?us-ascii?Q?Uyozy4XRPtI5lp4ikN3Q9pSE1ze1GI/6LgyaxZ48mVIXKxQ2oi9LvORmkYVn?=
 =?us-ascii?Q?jJmXbPryi1An921LHE/pnPG8CcQIG1ZK46e4FKxoXIpuSFXDyrPFWrhQNcea?=
 =?us-ascii?Q?ykh8m92mXYeZMHJzPnnAeENUegHf7w0Gfe0XUotsjGQGcglTjAMonC2+clVZ?=
 =?us-ascii?Q?zQRje5quobG1StnK1XRUPs04lhH1KKBzIvz8Mr3gTaPTbLJGCIcHgcFYAFa8?=
 =?us-ascii?Q?0sAprGbvdGIF6THi5AT7Yq2L8XZS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AnZvlcee+FarLZaMILPlin/JYgah2RQ9vdMUBvsk4wu9D47bZUUJxVKaAiL6?=
 =?us-ascii?Q?vOvfRZfeTlQhXdiKSgchY8AULAC32fM/OpVxEpKZzHjbm4+rQyQP/e7nrrF3?=
 =?us-ascii?Q?ADWoPDJ5PAyU6DnOLVcERAquwQPVygkksnVg7RGGxODXzE9LXnn54tpwaIg7?=
 =?us-ascii?Q?WAXr2aYQwCCFM7ZWkImrhTTBCRL40BT51SAxWlXkGHx5Pb1kWx9Ln9HVmML7?=
 =?us-ascii?Q?OT0pi7vkZzBxRXg/F6muvc89CtSxR/c4GEE60x4702/VvEleiwbeof33zNAl?=
 =?us-ascii?Q?k8+5y+VMXGCJb9hmCzC7ygByQ86iMdSOyQyXP2ldF8e7uQz8dlcIbiOFS80z?=
 =?us-ascii?Q?seuU+E8svs4RxlJyJzD3VkpWwCEpQGYlqQ06QRIMQA4nN9Wk6TW5QUeewV9v?=
 =?us-ascii?Q?P+qrQCZctOw2Jnb2aa6B53jArbovh60GChc+H1HdyI6vTYWvMZEicnyrzDhP?=
 =?us-ascii?Q?fjMGK8gM+TRT7POBNsBKaKIKyIi3ixNIb46chUoe+4+kyvnqHtFum3f8oL9L?=
 =?us-ascii?Q?wQMdwJYNTbyOoHGw/csD0q2Q9feG9Dy7nOIq+hXsdYEIY6mi5X3y7cHzM3av?=
 =?us-ascii?Q?C08it67r8f9vVCRrEwGYEhfep+oYG0X0WLsqN18VF5/YNoCxG/n6qmPHigdZ?=
 =?us-ascii?Q?FXpKbC71CM9UnjWSpoK+r2IgxYX+sRcA4MkDhI7Yhdc/u8mwSnxuTjyFVhJg?=
 =?us-ascii?Q?YUkHtl7n3lhUP7B0T+B9VNyNBIiavHs/RhDswRLJ5qO8AH/jfrH05OI9fHe/?=
 =?us-ascii?Q?msSRvT24D9KFkDV9CwdJv6EMOn7FBMe6EN3QqXU/YlDaeMJt2VK10W+O11Zd?=
 =?us-ascii?Q?c6g8voYnsb7D2KYasavisOD/0V2Bc/dozY0ioXQ96x/yRbhowzh3ZT4lC/2P?=
 =?us-ascii?Q?zS7V9huAKzbcGkUckc8v8YEnlSEn54OTCVcYTkpc8U7l+DRXxmQkfN/k/a+i?=
 =?us-ascii?Q?jvJYhoQbH4RoG6NL4nJOzcQsXRnlhJ6fvwhZtcpwdYSWCj7GZ+detopzXJMI?=
 =?us-ascii?Q?pk75SZGmnMdPMEPklT8T/dzzCf7bUD0Y7OukoeDH27yme6wyKGbsOPdGsAon?=
 =?us-ascii?Q?IrSB8Bq3MFL1Vs/9dXrOvB9dC1pfGMvlHZm1tRjubEm3HlYkARPwVvEVYEud?=
 =?us-ascii?Q?SdtSxUH+MQ/tZWfw/fDSp44i31kkbAXiDUJvTr7pW9jA7dJn9BIkYNzQttLn?=
 =?us-ascii?Q?ndXGuy4O9VSKsdEp8ILgE8KziNokI0ppQMhuzRtnJtZrns2feM6DATzi3h2O?=
 =?us-ascii?Q?lh0RmZ336jqBeNvZPMJH19b0S224NrkCS8SgJFSbcqwC8wKscAvLV0BDIO8v?=
 =?us-ascii?Q?KA68HtoiwTfbIuRKUMbysap/vhg9UNd5a0Mde2oVLLTbeA3OIQ9+AIGEB1hp?=
 =?us-ascii?Q?+Nav1kH8OUpnsfjY/3NOY0IaH/XGmUh0O466wECbgKBkGzC+EvndlJokTvAA?=
 =?us-ascii?Q?wblCp4pocL9xmFdoXcYHQAScPje0ds9xHzWAYmuWnUrtParpZxsxMZ2dSNsE?=
 =?us-ascii?Q?BN5dbgET/JgpZdC9h39LrKnOx2qqoacZgvmuQPFsDjg5xFCHlEZ/8/0e3e5L?=
 =?us-ascii?Q?Z17DY+l5LLducE/WzCPXdJwM842CMVWKOPBskxBY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2877f672-caaa-4fee-afcd-08dd45933ac2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 03:14:40.5993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4UNldyv358+ZOAd0yjLhMFGzUvSRS2AOyo2S471MNz5vz7rNQbV9vUuAd7XBuGOV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8865

Now split_huge_page_to_list_to_order() uses the new backend split code in
__folio_split_without_mapping(), the old __split_huge_page() and
__split_huge_page_tail() can be removed.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 207 -----------------------------------------------
 1 file changed, 207 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 20d7be07cd7b..36594eef5c24 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3168,213 +3168,6 @@ static void lru_add_page_tail(struct folio *folio, struct page *tail,
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


