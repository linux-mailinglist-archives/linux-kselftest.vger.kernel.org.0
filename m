Return-Path: <linux-kselftest+bounces-25785-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A974A2827D
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 04:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FC443A6404
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 03:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785D62139C9;
	Wed,  5 Feb 2025 03:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SGoYa0kD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2077.outbound.protection.outlook.com [40.107.212.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9342135A4;
	Wed,  5 Feb 2025 03:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738725281; cv=fail; b=fm6klVnJXHM0LxNcET03DAP03pB48BoopRW+RE3rYcrJHeHYmDGRcfPB76diBLr6ufTtOFgFEs3QI49qfFt9keyssxB1PLJwwH3kiAYXdnoh7hfImJMCa2XhFd0JxwzvST0uXuN7NOiFCIVKFDfxuC6CBCht1mIB/25uvF9WIj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738725281; c=relaxed/simple;
	bh=rcHUtHAoeJ1bgu4vJoD57UrtHK/q3qQJwgUtdEaVu3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nzWYDs3Hi/jFkO+BbDAhnh7geM0XUnlMJkZd3VaSRTkYzNyqWwCbCxzpVTBFtaSaaBaHeTDvvEN5OVMWqsgCny2Dqr1V3WJFVvYJ2dWDQ+ECYHH6tQyf88ZiGHnmgdi8ByTPRdtDhNko78HydFUaOZCoShG8HHLLEDmZeHjhKWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SGoYa0kD; arc=fail smtp.client-ip=40.107.212.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YyIf/PBpOaTlL6+mpqI81ubZ7jdVEOaQnvOE9ZbSDCQfollYTsO/IhNjLHEWUlFkDOcsHUFG8NZCky4fje/lecrVqBCTFid3C/BK4FZ/rSYlpOro6XePYPeJc46Npu/RYQBdbShUMwDYqmbxbqg3kf69zmMyN5I4+HUiUpLj6bPsP7ZV7PeBaMjhlDIapm83e2t568d/H/3/v9fMAXMe0AztL3P/u8DQmoS+ZLmNOelrT9lamAxmbhrp43QK0PlSi2pXJuPqjiieD1zz3YJOEwLy5eY4tJsIHgCRpyTUWDu4HkV792bEAI2knFDI5iExpHUuvIDvIlnB16HxqEyvcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NpRDRb/eZrelexIks4B6+tOxHpJiNe6Y7P2MSAq/biI=;
 b=UgEFrymwOYQkjoPgaPnQH2gEFyjEADRNmh9kalxs9Ptl91co9wNHBauddjwuFnOIRv5xJZU1cVjeYXzHgbJ8LIGBdAtnB5SKECn30fnxPTWldGg15SdkwuRNVxJonbj22IEWZb8i4xcDNjPYL0ENXzJIBPF/SpAhUD00xu991WsRyoammM81ANPME4urQBtKPp8gp/l5so8tBOftlEXzj2BZnIUYX+y+Pz8wwNPBLeMEsaro2DU7r7TX8wEWnVDdMDvAQfu0Ra8r44f6slG8F3bcSVQcb1Da8bqachypB0/JdKc7Axw4pdawGnv72vVZTcVVt8//feL4GzXw05zHtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpRDRb/eZrelexIks4B6+tOxHpJiNe6Y7P2MSAq/biI=;
 b=SGoYa0kDdMlfAqTu7milsI2JnZjzhe/t+S8H5uez1F5/JXxyxEfc5UVM3gl3j4J4/4r9gMY/OE503XjBiXR9kTn+JoimkQsH9JLj1zll0s6Aji7bf5EAnEW25mE79j17gMIEb4uhY0J/drKcAtCMJi+d2WsUpmcTSv+YLK/Y1/tYqk74SfvZQyZQD9O7A1i8y8pbzhHbkpov86k3yTAXSMAehIE201zZ0bX04HEpH3PuKYilwSAzxFy6z/fDmjREf4h6evP2uQu0BpZL5fGyXInwv+ddn2pAQgHegHgp2SMLiTfm9DRzPWxx1oVf0bt04DuYFSesvwrs2TtH+9KGHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MW6PR12MB8865.namprd12.prod.outlook.com (2603:10b6:303:23b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 03:14:36 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 03:14:36 +0000
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
Subject: [PATCH v6 1/7] mm/huge_memory: add two new (not yet used) functions for folio_split()
Date: Tue,  4 Feb 2025 22:14:11 -0500
Message-ID: <20250205031417.1771278-2-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250205031417.1771278-1-ziy@nvidia.com>
References: <20250205031417.1771278-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0154.namprd03.prod.outlook.com
 (2603:10b6:408:f4::9) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MW6PR12MB8865:EE_
X-MS-Office365-Filtering-Correlation-Id: 8acc5693-0d1e-4cde-ed25-08dd45933827
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MLdyIRtvaPeBkbyAfJBeX5IxzSLqrSZyC7m3nEA89GzxQ7oesRYs8ok65QkV?=
 =?us-ascii?Q?+4pjBDvRNeviEvAGzYoGLqkXgNtptbeEMpbEQMK9DXMdPNyShO2a7SU8hvmb?=
 =?us-ascii?Q?9TxXnUVQKn0CVw/m1KQ/B2BXpDdFD9+hS6wcj7tcczvjspMykSAWWs2c5a6Q?=
 =?us-ascii?Q?hy35sPeT7EQwf0bH6mWgnZIIHzRMtKs4gCw6ijOhUQnosUDq7ejssauGAYGq?=
 =?us-ascii?Q?rUYZgPGi90sNfGXHynoi/wzN4AoCFAE1omT8chf7W8ApT1RoEeZFVHhut2/N?=
 =?us-ascii?Q?1HbaQk68Qsk0mVZLg30v2VS5Quh2i5DUxt46TD35o1RTfJ9G+B1sq3cPtvbh?=
 =?us-ascii?Q?ooRmryUhC3lXfIt5sk40xVHl1azBtxhn0erdi95uEhtidOlqjsXo+NMPVXC5?=
 =?us-ascii?Q?40Te03r82aX1tBgtjjiAAL8AE7lGtw35/kR75jSMIy4RFHZJ6FqhEevlrztf?=
 =?us-ascii?Q?K0z5fsD4pgJDkg9T4c374fAPtyHbZDjmplfc0WakiAXqsl+6aH2gDLKb0/E5?=
 =?us-ascii?Q?zwcoU+Yb7MJVoPosExYlOjt7laThGHFZmFZDvzatKaT4VcPziRHsxcfB7pFq?=
 =?us-ascii?Q?HuSdybcNzwNZ8AGspUMviIYbXL1+eM3nU1TJaYo0QZpti4NQzggeMMWumXkK?=
 =?us-ascii?Q?ulFyCBm3xXX+zPAXJwXrgmf9oMHgCcw9Cy5v/rMls8Na5BYozDN4/XgvOamU?=
 =?us-ascii?Q?oVZCgY4HNDHsHj2HjIswqFH0i6UpGL6BshMJT9fMCvgFDKEukzkrEKVwWkvc?=
 =?us-ascii?Q?tOoBtUrvqn/VPPbElJqQGx/aHFhYcExLtw+ho+YABwhtQIYaby/hHXNil6I+?=
 =?us-ascii?Q?UprjeQRp4eb5zBe8k9eYRM1P8OCeg9sKKd7t8qrWxweNQLy5mgjsbE3z+Wgg?=
 =?us-ascii?Q?IKzpthR4tMZ0sFr4MYk2N8nOG20SqGHEq1lPllqb88gR9gxFow+mi1YDTYY5?=
 =?us-ascii?Q?z8wB6CtO/xDco9bGWCELALHtyA2F5m9qQctmLUcDf+6ws157YsW/3qUJRNU2?=
 =?us-ascii?Q?j6wqh4V4FDX3btakBUab/H6zuQx9bWcCMwSOqS1rYKNfSK55GI7ta8WOSZIT?=
 =?us-ascii?Q?kVKjA8qgq0/+XiqV8klhWDUluBRfMttTDJiyKgmab0Mc8ATLgF8Gm/cjwhSt?=
 =?us-ascii?Q?YxlKgmGAh+ayYoVLfk1zd5qvPqsL1bXyCeISgT0T/8c5/pq+KHR7YBi25+BD?=
 =?us-ascii?Q?QOeoHGyXQRGUYJ81KKPOdt39mJGBUUwNkDbdtYTV6AYVeXwKg4l1V9Liux2s?=
 =?us-ascii?Q?7Kz/t/zJgG54uF3/68ZM9z1af1NRJHSb7LSby5sPTSiNIQEvXygL2TsHw43Y?=
 =?us-ascii?Q?DJKujIH65LxnG4BCXlV/FKr+jBkqBCwDC5q/MJPe7RrDTbg2kBPCWQcximxQ?=
 =?us-ascii?Q?DS4xFfbRtXMpFXLajabF/OSGhiEP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kXWlfIqh1Wh0FmJfAjMYZFDIunvC+yzw2QKvMu8anLkvjLaS2zcP4V1jr7DV?=
 =?us-ascii?Q?r4SLceqMJ0HTY4FWFWYCKBRramahf9QQkQJ4d73cwGnZY9Q/iGFX84CcMMHp?=
 =?us-ascii?Q?CAOp2xngKIA31uiKyHM8ZfwWf2nHlfQfhACQumRoM039ryWrKeNDAG3mIa3I?=
 =?us-ascii?Q?/I1vDMWw9pEArCSXmqwpot+oCJWCRaOUS1QzCfqWzcYqus2dzQPTAbv6L9+X?=
 =?us-ascii?Q?HpHqaqodDogQDZlxLvVuN9egOeya+sUyfPgksp3GfWScdnlJwCVH8Xy2pwtz?=
 =?us-ascii?Q?Njh8V87FwWEAPi8mkd1LbQz9k+nUWHFieHPmtkdoHeTs04iIQ+9nnL8EFXwa?=
 =?us-ascii?Q?o0zuPwWT3X6mVp+wPGdN0YinmPDVApmaNjHwYvNWT4PiNDQCWoRry5J9qcmc?=
 =?us-ascii?Q?VP3QNdY29NgfLy9lpT3UytjNftN6J0Agmqr+LKU15LJqQRHRnOHHeci0bW/e?=
 =?us-ascii?Q?qpldL5fz2bFU7HpSVUsdLp+Y4yOI+MfRdUBCwVoGZv3E2P/ABp9ChtK8QMbg?=
 =?us-ascii?Q?MxeQOa6rQhGZ52LY/AXAciXUdFhQaSWIguoOoBMyvn1V9npvPinCJ02Nalf5?=
 =?us-ascii?Q?4+roapbeOjR1CtDRf8QgsVowKjnt+Qv3MKbvLXX232Cf2U0Xo6WypQtyrRlC?=
 =?us-ascii?Q?grxf1x94ujPhFJyvwsy+1h2UvtYQAyQAphSdOSKcXvBKitskTYgZtb00+RKo?=
 =?us-ascii?Q?pJVHdMgBCAKEM1v9bWsbb6OU6/LEYjXJ9f82nT4aNeLTCYzH3vzAJL2Jy5lf?=
 =?us-ascii?Q?fmFrKZBYaH4ruOCrNDjpY8eMKeGLpbmwM7Op4kFa64iAykHPNgVNWEa6plHG?=
 =?us-ascii?Q?UB7yJc+1TISGtbPTfl+PVy2bV2TmaWlXqGR+hiLenBNEl9skrEsAxUvVAtd0?=
 =?us-ascii?Q?8wpbcmjSBpcuCZHI/L1+adEIw+lhP0tA8YXsmQN/ZRwFUAOVdy10S7IpoTke?=
 =?us-ascii?Q?ukq2svJyf15qKshfpNx+P0q7pa7WnLmcVCd1jHxfZDBhNN53yThphDcAaRMB?=
 =?us-ascii?Q?ywCOP2dvX0dF5DL3xpsviVKtgmuQxA0rJhk9zFFDgHuafO78gvHd2Zd5RnFi?=
 =?us-ascii?Q?HJKjGKnhMZ4qDsPKUaAgDl/hR3TTUdZ57us80YKrpqADE7P3biCaRafnRULr?=
 =?us-ascii?Q?O21IPH+66peTY51TXC/KWVr3Tz1siyLfFO3Bv7M/kcB1QcwxmSe5UM2cMt8p?=
 =?us-ascii?Q?brDlLliqPPM1iq9DcvcSkWT7svfR1d6Qnh7hzfZ9ER+KJmnj8EwwUlAX3AmK?=
 =?us-ascii?Q?yBjNHThjWz0RK30nBPTafSMN3gW/Y+O1Rc0kV6qBX+WWIS3O34ibIqkptwIP?=
 =?us-ascii?Q?w2+A7WpJG9Vv5VZghXlXnOw0t7iQq8JSBn65Ce5dhkK7rveeRLRrrm27lP5L?=
 =?us-ascii?Q?WtR5OBzjk/wDx06PXHTp+QuE9LNT83takSC6RYMZ1A2C97f5yYLs4gxT//3y?=
 =?us-ascii?Q?PXOlnF34HPS0CiTMaj04IStt2LRxNNW96zH45TuezL8XIFpZpEUueZ+F3kyG?=
 =?us-ascii?Q?eIpNBpJD5w+rnaZw8sm+Nn6nFdekI+FtXfGE+F++UmFrQVc2A1hjfuX84mCo?=
 =?us-ascii?Q?zCaPe4RsSEgrzVLZYxY260ijDrXU7BdDXf7WufZg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8acc5693-0d1e-4cde-ed25-08dd45933827
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 03:14:36.2238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F5V0fw+iOPOEUOQLz2YX6gZ678+g7vL7QIF50790EI1KHlaa9rrViffR5JHZ1E2r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8865

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
index de72713b1c45..1948d86ac4ce 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3149,7 +3149,6 @@ static void remap_page(struct folio *folio, unsigned long nr, int flags)
 static void lru_add_page_tail(struct folio *folio, struct page *tail,
 		struct lruvec *lruvec, struct list_head *list)
 {
-	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
 	VM_BUG_ON_FOLIO(PageLRU(tail), folio);
 	lockdep_assert_held(&lruvec->lru_lock);
 
@@ -3393,6 +3392,355 @@ bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins)
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
2.47.2


