Return-Path: <linux-kselftest+bounces-26379-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0A6A31035
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 16:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B0113A56AC
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 15:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29003253F3A;
	Tue, 11 Feb 2025 15:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VwNK7g/1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2076.outbound.protection.outlook.com [40.107.100.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB613253F25;
	Tue, 11 Feb 2025 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739289051; cv=fail; b=nhWZtP1fwMPnPAuYPrz41c5SPkdJ7st1F5IND/FJmZhs9dz8/k66i86tHplXoj/CEILAEyDAmpC+Z5rK6pzjp6ccY5HZFfjCxB1tmQ2vdWFZH4tvMmq8BB2ybX3r8jP7xRRO227tS9Y562IbkRMhQzmmZcbOoywuvfw37eqp5KQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739289051; c=relaxed/simple;
	bh=49f/dPp87RiFapq5p4qldVbwVIK+M6t0mbOEbglDROg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o8BDOYbvgVnvqkpIhzcun5rXfVn3x8x1BWU64p87+I14H4I+W6nPJ4S2YrG59j4OBfqQ90n6DexGBlkG3bg5SmLuV4cgI0F9DBDUB5MswuM7GYwVsb1Nm+jRMAAvbeGhhikYTicEXRlu4MRZTXNRx/yS8SUINkJFYVmJneFSgGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VwNK7g/1; arc=fail smtp.client-ip=40.107.100.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ed1Sk+z6wy8K04mWIZr6PyvBQlP+QzamhUb48ZoCbf2QM1QI8CgfkkNIe13wb6ZqMHwTxvII5k9lL4Di5oQN6RqrXtSQnDyAhCc0runN1lpZGZj7byVC4rdGYvqMf9tlGdSoE7S99FKt7Tgn17dfUf6FZCrEux9VT8kGV/FnjGPyr1rkL/LQcSIvxJpDkp7jw3rhevLSaL2WBy2r9pnz94IWo40CdlVJ5qBEGa4oBFUO+a/sZjAiJKzDpqczZFKE6XGI30edg4gCe5q16YxM1GVMciQfmRertq3rCnVJkD8H48lOv4dDHyyIaxcd7M2ODNyBjYfx5Z/vXZzwG7DzUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mwthoYlchLM8xN56fca1f+HkSHa3K7jmOxmklqBCBis=;
 b=v6ZSuveLIqJX16TaNRz5eC+MNJHGrWIvsrG7BQA8jXMbpBVowcL/0A7YF4B78FdP5iQKij3N/QXfGHi3kewJGY3JDWfWwbrnf0hdEoblP1w2ul+UKbM4ELUtlyVg+a1R6tH1CJJ8OVMBDzYBJbyfWNJhy7HptbH0+lyxBi8+l2x1omABLyus+r6bk/brn/SYJOLEk5pp2me12HP9p3DyXaCAQ0kJZKsy/R2WE1dODx4KJP9myj3XOGyJbbPYr4E9SaCHQVXjTeZpVONpRHiDz6NkGKZKxWGgFsbIB82q4YUTjDE3nJJ5OUs9sQncq9vu+ZpycVLycJdrKmH/qjHFPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwthoYlchLM8xN56fca1f+HkSHa3K7jmOxmklqBCBis=;
 b=VwNK7g/1pMCOeLZ2XLiu00RypGJH6btihxDNmAlf57PAN/gBBXruQ+nP/EAzKwT0YhrxeryXunASFPRqtUGN+DgGY9YfZjiVB9l37uh2BOxo54wE7S+YEVhfbSxEsiHw6l0QvAiJ9T2tt316TFPGPL5vQVLKOwIZcXJvo5G77k2dhVac8ZUx9JvvADEvNg2n64CLX6ri8hl08TErUWwVqT7qho/9k+B0xYF0nF9XM5jXv45h8L5antIndVvn7jaqvcueqeazHwZnMkHNk38Xz3AoxrpWm/y0zifhoYAK6HdZPmvdB/nhDGtprnksCn47llWn3Lhio/k60Ws6tO5Y1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA3PR12MB8764.namprd12.prod.outlook.com (2603:10b6:806:317::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 15:50:45 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 15:50:45 +0000
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
Subject: [PATCH v7 2/8] mm/huge_memory: add two new (not yet used) functions for folio_split()
Date: Tue, 11 Feb 2025 10:50:27 -0500
Message-ID: <20250211155034.268962-3-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250211155034.268962-1-ziy@nvidia.com>
References: <20250211155034.268962-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR1501CA0006.namprd15.prod.outlook.com
 (2603:10b6:207:17::19) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA3PR12MB8764:EE_
X-MS-Office365-Filtering-Correlation-Id: b455369e-f6a7-47ab-efe3-08dd4ab3d87f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?03TZXauAyTC1Q4P5nJGoJI5SmgsiKxSvoTVakhDz/WKyVKOTn05vqHShbzaa?=
 =?us-ascii?Q?1nbL0a4QaqPmUqyLLI+DACL8iLXf6bZF3qtxTbemPv6YuBplj16U+gia+Axn?=
 =?us-ascii?Q?0bKOuDTSAuCGaK4NE/D/SL2F4i/9cPJjma3uALs0+8Abi3tqw78aqmwXj1C2?=
 =?us-ascii?Q?nk0RoBYgoC94boQIsMZhYt8J+FG4Zt5CbnvIDzX+isNeAKx7eg0OAXLc2KNy?=
 =?us-ascii?Q?Owffw7icJotGE2B7p58GVl2eOE4eKjs96+4kOgx4msCo4Cjts54PRj26AOMt?=
 =?us-ascii?Q?GMJ9W1NwqWyg2PqyQf7qf6um0qqeW9lgDfvh6vS6OWOGsJSQSKPQqzHOBAD8?=
 =?us-ascii?Q?NZZ0niLfL4s+eh70dKENXwjjYl2rkV1zk0Y4nCRd5XbBYnLX8szJL/9Ymbrd?=
 =?us-ascii?Q?dWMD0CcOzVnLSA8s6ABiYWjSgWz1lzozlR2msZ9A9lsYIy4wUFL3xmYWxPkx?=
 =?us-ascii?Q?FtLiWTByptZO7AqAcjZJqGtwkcJw0Oq8CIyx30A+kaiIL+ETLtD8QDjev8Lv?=
 =?us-ascii?Q?sqSHuAzVOnJWHoxOZKVf0sniSRJpt5G1ZGbD0mvu8rbc6OnvP3CcIbA++QqB?=
 =?us-ascii?Q?gqJ/rB0wp7s5SaZ3jekSDUM5GeYW9BfmTnm/LmLWitZ6UwjVq8T3Q+8yA4x/?=
 =?us-ascii?Q?+4GAgdOIlmetuDRRvp98zw5fR6nCZOw53M1m/J5yQZvi0JzkZi21BepIFM9k?=
 =?us-ascii?Q?hprpzDR4EODSj/Z+9d7R8o4DKx1NTopoQ0CHLJoBF7YjuWTtYYUKFk02GzqU?=
 =?us-ascii?Q?LYHAAvkGva4oRGQdu2PT+QHwdzySf1zD/p/8U9EeqGWhP+2cULn6aUz3nHtL?=
 =?us-ascii?Q?xPUafD3xrrhSu6TNKpJ1xsAjufturmhFOwjt2EHt1s4C9SgiDV+qA3pc1VYC?=
 =?us-ascii?Q?SI7R81D1yzCqliomGnX9SylDJq8AXFVrOjLGxLxXY8SV9zgih71KVzfrmLnw?=
 =?us-ascii?Q?eQwZumARQLRhx56ZqAntKf9l90S7o4X5ppOCI42j70E1PYm/0g809ZeosAYA?=
 =?us-ascii?Q?E9sZYcyCzWOa3eHGRf9ed9oIxDP9b+8yEk5Bjco2DuGoI114dsq8ovKOm4Ru?=
 =?us-ascii?Q?5+7VT+QOoT9ondYnzsM9H+ejyUZx3bolmBDU5LF5zcvZWruTOMLS0wCndubq?=
 =?us-ascii?Q?gkXpX6DGKzPW7eyNEhWk3KkvQ87/Tczru44pMUXZsoWMK0ERldWtlvu8OpZG?=
 =?us-ascii?Q?f+xNjGipShKe1eoD3FUu3YSIA1UQzOu/xZVE2/CmBzGcNj4yRWGNu1FPErAa?=
 =?us-ascii?Q?ayoeYPNftubjZtyJOcr8bj1UBoaXkIj4nSEKi0kkF61HtQ91r+bj7impvh/h?=
 =?us-ascii?Q?J9BiGDZH1yiil6FPcaxo9H9s7fmn4U7uYzC+ksHASyyRI7cx/T/LwnflMHWj?=
 =?us-ascii?Q?fjPfl4XzvPHZnqBruBwJIYEzG7pn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kO8YePDlpJNHCV/AnOuK5upwfdQ8qV4knyI3VPY1V2sMdXtsyLvZ14iwgpZN?=
 =?us-ascii?Q?D5OSi9/bzN/bvrPmhL8gEl95uZbf/3exyblTku8ltzJVC6Du+SSPIsYvpxoY?=
 =?us-ascii?Q?16hojS96NCOOfTNO5Wu9iuTFwMVB+d8HMZKTKBw2kPEFva5pBhZbBy/udM+W?=
 =?us-ascii?Q?ESQqvfEUHEA829ucVF5Ja6GKXCW5GfgP/cUoJ3gg/J5wn2gXNRJ9y6i/iEAn?=
 =?us-ascii?Q?6TvqRcQmSkXnT2gEnKgWjng6VG0LoiSzw8jfKMMBNaxJGzn/yRJBzK54+PaQ?=
 =?us-ascii?Q?VHlXuvnvu1vUOKi7/Iz3OWy6D1wk3lcZUTbgHCIMpfcExFnVRLuHXmYIiJeB?=
 =?us-ascii?Q?Ecdd9i1Q6uc93gV5Rb10CgmbLbJ69XCE7RsXdoJRjibX37s93dhmR0IVN1uk?=
 =?us-ascii?Q?qG6Os8kX/5i9VmrqHmPNZPGGm9/JIQo15GdTlkVbim6jNvogBgg1qQX+4NdM?=
 =?us-ascii?Q?Dn9dL1N5dGxKPHis3/poDSs3Nf46m/wQSm/MWf5uJXrydV5ZjRTlevuuR6Rw?=
 =?us-ascii?Q?TAR9m/ElQCWhaIkFfV8T1rkYjw8aumQWbbsGWpbL+shdeS4jKQ3/q6wTe5sD?=
 =?us-ascii?Q?YMpIf8ukLEe3TxibCn3Zhn0UHxzx3Z/Uus7HqiWc13nWiyCIzb+lBCf2wlSZ?=
 =?us-ascii?Q?NRFViNdoOaGv3tL6skTBF8R+GlJnUhwMC+j79xz0PV9UADIoOiUeLsujSrSV?=
 =?us-ascii?Q?FlxlPK0NB6IAiv+fVWktswy2iSCIEJu0wQuHH0F7IKXquKGdUU8sLNR1544a?=
 =?us-ascii?Q?FZA2Qv3dukCmxwMRFB3M3rMHN2ZG6mQ1wkr0j8an70v5F8HxEfFME8xwwS8g?=
 =?us-ascii?Q?9Mw219Eq4b3+bjbzkkO+/hzuE95E0Ijhf4w78CgMsT2/g/se4tQmIiVvQO6C?=
 =?us-ascii?Q?645N/J1sN2l97MaKh2lJL4lyMy65tYdemOygCDZYCQo8Yw2zJlCXW+yUPlLD?=
 =?us-ascii?Q?CQO1re9ZtSBefnRmQ2oD7JG3VWZUDh2Iz+BMvScwwGRSJFeAXbLCpshXSLk4?=
 =?us-ascii?Q?qqDZ7m4Vmd3tq433kVZ5F65ff5hT2O/B5hGl/Gk45BXxTDheTCh7oDy6m8j8?=
 =?us-ascii?Q?YyCj2vBqBrgZfilJ1L5AEzupZ55c9EtttedS+uPuKhNhhCO/y23U7/wy6CMR?=
 =?us-ascii?Q?zWquBR2VsjOjbK8pZbxw2JptXwFhfoJZpBXj4N6oKC8CsBML8KMqm6aqmwdS?=
 =?us-ascii?Q?ZhgUPfej0JGnWeuzByEDL6IGeA/rX6fkGKXfxDZRRgWLyDg2jA13H8iuX3m+?=
 =?us-ascii?Q?RdtWCxJFB0QHU+rF1JtzNghMThNbF1rV6J2JuwZnOT9mC9myOpuR6xmBWVuk?=
 =?us-ascii?Q?55HAT7PWJLWCZQiJmuUB1wcA9E+AeUnMtYdu0wMkWTj10ORg6TbunT6kDzFs?=
 =?us-ascii?Q?E4LVe2exOc6e6XMqrFamfRnAocFLLZTrFZk6Vf3C55ZM01G6rq1g9kPQKvg3?=
 =?us-ascii?Q?qCbRrsj7ObLL+xGmb+U37fjUCX91zPPzy2APTAqnZGPlr8igMylz3RBmju34?=
 =?us-ascii?Q?YN2bX/P0+k6PVHU1bc7AJSHjpCW7euT4razmOfFjXmNJo6Xk/+wZMYcsImuK?=
 =?us-ascii?Q?BDzSgEOwQuHNJEzpP7CYQrUsewLuNr16XpqchfWjSkPivPRuR6qbvLmO/BLY?=
 =?us-ascii?Q?YsYgvsSKwz2YW+Scu1OwANpgPL2xzhkgo5CuRBLbVCAY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b455369e-f6a7-47ab-efe3-08dd4ab3d87f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 15:50:44.9470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q4D0hpur7x9PDTgnBPyhjHNIbZfF9+NFKopqy11xalkdzgC2uwLH67AECPKIWhIL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8764

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
 mm/huge_memory.c | 349 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 348 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a0277f4154c2..12d3f515c408 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3262,7 +3262,6 @@ static void remap_page(struct folio *folio, unsigned long nr, int flags)
 static void lru_add_page_tail(struct folio *folio, struct page *tail,
 		struct lruvec *lruvec, struct list_head *list)
 {
-	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
 	VM_BUG_ON_FOLIO(PageLRU(tail), folio);
 	lockdep_assert_held(&lruvec->lru_lock);
 
@@ -3506,6 +3505,354 @@ bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins)
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
+ * 2. buddy allocator like (non-uniform) split: the given @folio is split into
+ *    half and one of the half (containing the given page) is split into half
+ *    until the given @page's order becomes @new_order. This is done when
+ *    uniform_split is false.
+ *
+ * The high level flow for these two methods are:
+ * 1. uniform split: a single __split_folio_to_order() is called to split the
+ *    @folio into @new_order, then we traverse all the resulting folios one by
+ *    one in PFN ascending order and perform stats, unfreeze, adding to list,
+ *    and file mapping index operations.
+ * 2. non-uniform split: in general, folio_order - @new_order calls to
+ *    __split_folio_to_order() are made in a for loop to split the @folio
+ *    to one lower order at a time. The resulting small folios are processed
+ *    like what is done during the traversal in 1, except the one containing
+ *    @page, which is split in next for loop.
+ *
+ * After splitting, the caller's folio reference will be transferred to the
+ * folio containing @page. The other folios may be freed if they are not mapped.
+ *
+ * In terms of locking, after splitting,
+ * 1. uniform split leaves @page (or the folio contains it) locked;
+ * 2. buddy allocator like (non-uniform) split leaves @folio locked.
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
+			 * irq is disabled to allocate enough memory, whereas
+			 * non-uniform split can handle ENOMEM.
+			 */
+			if (uniform_split)
+				xas_split(xas, folio, old_order);
+			else {
+				xas_set_order(xas, folio->index, split_order);
+				xas_try_split(xas, folio, old_order,
+						GFP_NOWAIT);
+				if (xas_error(xas)) {
+					ret = xas_error(xas);
+					stop_split = true;
+					goto after_split;
+				}
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


