Return-Path: <linux-kselftest+bounces-28513-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B89A56F58
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 18:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5055E17A770
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 17:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549D22475C7;
	Fri,  7 Mar 2025 17:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BKSGt6P0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BEC24887E;
	Fri,  7 Mar 2025 17:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741369228; cv=fail; b=d8soLQGZz3pVJ9WWDFhHXcxRPrR3rT++i6awjhliqnwcZ2eYkoEA8AgasYa9ac5WBKuLDEZMJRl0Ynh20ms1eny/X4b/7Q0Co4LDwz0bIES0JZ0eb/kR2J2YhforqXBZMvJcNsU9Y1iogIN7zxqGXhKVu8un1gKqez9jLrBPfgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741369228; c=relaxed/simple;
	bh=YdA1An/r8jK0LvcbvGscS0LYTRBW0J5ESmCuZT1yWHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uAgJPmhDvmTnrv9QKNEtnnJ/JMag8E+yDtxS5Fp4Xtc5c+5y1atUGppy+PEdjOXgXjLFpMnWldcJbmEOkJjXcBzstlb6TKUxKKnVUowCLXzTIMADxluhLxXnX+rOzfM54xyY5XjY8eOenPAOcVHlCRPQuMp9IBQONde5XLYdI8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BKSGt6P0; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QpEP95e5z+L003b4we555aJBN4V+WVGpj1omJoResylGjija/HZ/TndvUEbl+an0DphILt6g8mhrKVhVWkHcu8UiuJ1ke5/U0kJnXuHIS57UtF+8nq5OmHasDUJscHFQ2Cw6LLF/Y3JUkbpVDES8pTt80kq2KxUZQF96rj3Vkx8a2uNgX/wUnfEMGaYSuchAMyp2LAqbaWHbdwJzwOMrxiKaGdlZZ2XoRi2Fo36K5Nv3M/ORWYEP27gee7pfJ+hHnPsIius2tu6vY7hJxwgdvi0pB94DQzylVTFS3kYzlOqEFsFuslVkI+6+DAi3q51ZnOcGfGUaDTwEFX2UIzq49w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLKTs1iCIsIrZWDcg4jplK2n3gitTWDTC5hh13uSgm8=;
 b=PY24TeKfcKLIx5R2zQ685xDJqjqQ8vvClWR54xFHgeilLsoLEImQtSZc8h7x5onPF6xpfQOGWKPhDZiPgiN2wQsNiGkIl09nvz16MAW7D2d66jJ+LltYZVKGQXGP9fNKAcqcfa4QC0fH/FSlD9YfcF1bCUmArZdPjdMYbDoJW+ROQ6nBRvsOuU55jQOBR0rOjIjCXXaR6dEtCRR4MqD3bJnLanoWGwxtqZXrW9xrYNR4bzl+Y7aZmwv5zvpDLSTwuWSX6A9P6N20RbyJJmQSk0CEFcY4PL4xW3+aS+/9A9LW9LZjZPaeSNhjejlodBgmAgRVs0V7cgns2obRS1eVIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLKTs1iCIsIrZWDcg4jplK2n3gitTWDTC5hh13uSgm8=;
 b=BKSGt6P0KJiq0PRePOhIarnQJOm/epk49luC7YovfM23iaSDaUEY5yf3HbbdFu1JTw+gRrjHMxgJZS3/D/IoAIQ5BP/W6RagKQJEh5jRDtJjE5zRX1M8Mk46KUqGbTO7XyGbuL6x629bY9USykrM0imnduZRIgGti5UEYLw02nLW9xzoHa+TMlFAENEyOb9BTpnEMePLma5aBpo2OjhauAUNb7Cin9mcNxhKXjwgc7M5vbv0voAaLlfXnsyJ+jM9kEk40CoOW7Sk0kSf6cgJmlDo+Wv5/lnW1XygaFx9CBwLyDF5EIvO53Cuafgk13S1XGDyMgsXH9EdXsy38G19qA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 LV2PR12MB6014.namprd12.prod.outlook.com (2603:10b6:408:170::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 17:40:14 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8511.020; Fri, 7 Mar 2025
 17:40:14 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
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
Subject: [PATCH v10 5/8] mm/huge_memory: remove the old, unused __split_huge_page()
Date: Fri,  7 Mar 2025 12:39:58 -0500
Message-ID: <20250307174001.242794-6-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250307174001.242794-1-ziy@nvidia.com>
References: <20250307174001.242794-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0090.namprd03.prod.outlook.com
 (2603:10b6:408:fc::35) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|LV2PR12MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b0d24c2-36c3-4f4a-fb49-08dd5d9f1e55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7dNS6wnaeyVLEN+8lDt7Y1y9Pv9t6ohlJjXtMic17wl6TbYCAKz/FKGBpare?=
 =?us-ascii?Q?wf73fj3UzmVLHlqUC0pM+/CJx4He1N9fRg0G7TxgU66XbHbtJMeb/ZI5f38l?=
 =?us-ascii?Q?cTDgMRpph0cmkpW540Zo3Gkd8rBOQkd5D1/xpKriXvSg6i74zl/Zi2cJyij+?=
 =?us-ascii?Q?uPeQ/XvnrLbSEiRJDSjXP6X69QFaS0XHdYX/lPeMQ91R0nE/zoVDCFKdwFeP?=
 =?us-ascii?Q?+TVwtbmVFZ7o5CFgMgiIs3PKeXSWpkbbyANuebgVwmYnF6JIf5p567T2wN8p?=
 =?us-ascii?Q?r0T6OGU2hL15+GTyUYOPIFKneUfaMxPc0X4pPu9ghOC9V3uaJl1vMzTw4gsK?=
 =?us-ascii?Q?U40hkhBy7SRMts4ByQCkMOe702nkLeyCkZG81fyqZl5ziZolFyH4sexec+UC?=
 =?us-ascii?Q?kkSYJavr0hCIYjfKYDK9b4UJbQG+Fq31u1BDhvV5i2Kjk5KI4LZWCQBAw5oS?=
 =?us-ascii?Q?2qLaJUzdOg5Nhh+JIJHGOJX+QFRtOVBnrKe2Uop/ei/+zwEEKQfAZGJ/QMU2?=
 =?us-ascii?Q?E6Caw5L7S0fNGk3wbDrk3pQueh+vwC0QXe3/liccBP3JzowYnb6jnG1iMRCT?=
 =?us-ascii?Q?r0XxGzWM34HQ8fw1IGsmdPIqbrZ3r0oAk95p77xHyyn1hvrIuXCRg4tZfmIa?=
 =?us-ascii?Q?n2kVqN3PWkPOVM7zQjyj8iMIYjImb86qNjFKotsnwBVsiPG9scoc5faEn0Fp?=
 =?us-ascii?Q?uU+FOpcSBoJSLRtvKzJ/c3+fwUsRw2suvQk2UGDyUf9oYEgKy8ZLIr8K25zz?=
 =?us-ascii?Q?HNOZA4SHAZU+J0C5ELXV3wJv5w8K8Dmguhfszo6VY3/45FrTcnqz1nJoYeun?=
 =?us-ascii?Q?GXlWG59vS9oJ2pXrBi0GzYnBmBvvGLHpAn9bOV9sRPkLkZUQ526UD03bteBI?=
 =?us-ascii?Q?zjIZ/S6K2ggYTcOcyEX6U1n1STyzoedW4446O6aF2jPaVQIDxmqIZ4AkmMV+?=
 =?us-ascii?Q?x1cScdOt48elmXBXZliNn++OtkuxKgvNfKR2b7VX0tzu2SYJRwySVuTM11pW?=
 =?us-ascii?Q?o7PljjNK/faXNDIb6i3IioZa4TX66cwVEKomBW8Xr/6YjJWmEd58TUcsbpSj?=
 =?us-ascii?Q?35Uw2StxLzocnm8ndP6C9Uimm7WzWQVy+u9sKjs4SJbzZom4mI+imrw9xaie?=
 =?us-ascii?Q?9PzN+a9BBiY5jkzpYi7A9aYGVQWPUp4MJHDIS0NQtdUiJPPC6sptyvX/7XuE?=
 =?us-ascii?Q?Er2iy3QOtiPcUgWqlOCCBusA8JOSTHi+V6vOER6tfUZQcrR3kPt4Tb7uTm8x?=
 =?us-ascii?Q?4shfx07fOzJihrFviM9eyE0RUPRktGASgdO6V9c6ItkZqEKWDtthzeUtTpa4?=
 =?us-ascii?Q?ZKzwbfUsUsO4Kwp3dPyf4xyOMVJztFDvoY1V4lEkLZ3awOwQskVLSQpwrTV3?=
 =?us-ascii?Q?4CZmOsVrxbRRJnWaCQKrmZnG2Zb6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9Cb+vYkv9A4M56bdX1KAmZn9CSy1OmDHZNeRvMBNFf+3znUzAk/2hFQGjqvB?=
 =?us-ascii?Q?fyS7r7WSTqpn2QBivIbsuQ+nwmlTd+GNXhnP/xDVvehSVz+k/IJzKxxg2bNC?=
 =?us-ascii?Q?/18bvjyUrfmd9/c5WVdEaC7xLiUV1hAKLKYiWSAOEFd3dM4w4mauImMhRf//?=
 =?us-ascii?Q?hJ+iNEup8yVNBIsUUoAG5Zy+QqcAVIGDlVDijafp3n2UBIOsWHIQ3xATZwm1?=
 =?us-ascii?Q?UMRAvO+5gle/0wXpx5ZgwOk8Vk4r+OOM4NXOCVlr1IkQLt84KWuqA6E0QRYO?=
 =?us-ascii?Q?J0+TC7PdX8LWXzdjEp3Yuye++A6OpXgiTbZA7wnfJbr18pTt1UeAReGeW616?=
 =?us-ascii?Q?leYR3/TLVBZn4aBTOM6QR0uDQhKxlTnXOYJpN1RXOuzFgYKihOyvFJ81Z2Px?=
 =?us-ascii?Q?7eOlNVw/eQoO4jSEDbegZcbhjWyS4oCMe+Y+v5ZYkbx0mhEbuLvCX3oQrYcR?=
 =?us-ascii?Q?eT9+Hk7ACIjEitj/4Dg3oG2f4ZzL6JhxhzXGKYDHOu4+oGQH9ejqQNWDdSh6?=
 =?us-ascii?Q?hDEZhHJOZQcXCN20h1zoHN6UiWgBsnQU0B4xlKoFs0CHTKKg3aIAQ+4QjE/H?=
 =?us-ascii?Q?7VnwRwjozrMblB4owtdv0ydqPJ5NE19KUQwGYaaRE3jLnXr7AsEnXpeXII4t?=
 =?us-ascii?Q?e5ttmRnQ6iSe/PZ28FddNjn8mmmHm1pGWsx7SAO+fBjjuzqmkE6USQrpeWTE?=
 =?us-ascii?Q?J1tnRpTChJfWPe0WiY0xny5l/DzXHsrucOzNJvVl+ecc1mFjEA3EtyouIQly?=
 =?us-ascii?Q?4BIxD4f5G8KsebyW2ouhCa1UD2HxiGhfATH+00RuISglwPWnk1tY0UqONT2C?=
 =?us-ascii?Q?IBSlAEXkh0yofNNls15FlGRJTydDPcbHBpmg9lL9b2sPK/J2dnEHXxugN749?=
 =?us-ascii?Q?7vm/0zPBpCt8gpF2/MvgHA3PhV2M8EfAs3cJ3aPegt+O/JH50kZQ0eHnWRZe?=
 =?us-ascii?Q?LSJw5biwN20657n23Ax3Yl1ZPZD88lNPTtVhx8GdNi+5hBAY12+ovK5Z3K5S?=
 =?us-ascii?Q?1rmkBJZ3/kudwsfWuEZ6s3tJrFK05A+VIEI9bCRW8cUab95BVAZm/FI+yvN1?=
 =?us-ascii?Q?kiF9keO8AZ+F50TQFVBDS2o2+TatF00LWXun06HRv3EmX6d41877K5FkfMUH?=
 =?us-ascii?Q?3vKo/d5M03sIKT6/W1PDUKbcOs4yr8kIfas7vbJJecjBY0VA6+d87/acx9mY?=
 =?us-ascii?Q?vxmRsaZnQHh27q7sL+0WqIHXpyE3UwYHLXpkL1HS7uh+Ri35KeFKxKIJlfry?=
 =?us-ascii?Q?gAjy4BXxRL19FlDdSxOON0QRyzvk/0o0joXaHMfGhejXxvTZSjH6WjbhldVU?=
 =?us-ascii?Q?aqjoKZ3Taf/eSsoljiIAZ0dUTdpOQF9atoQ4enZjmJVvYaUClhf4Nv9PWoFL?=
 =?us-ascii?Q?bijTu7dQr2wAvfgBYkVZB9U02vUt+mb/QYp9KnDj2XLsGMVirGLpyWDBtuJD?=
 =?us-ascii?Q?fa2u4AS9UJ7d6czl8z0Di1z46ZBL5rYAUlNBNHNxB678nkZCSLRgIrzYWRz2?=
 =?us-ascii?Q?mnMm1MmcSaiQw9Xewhe9wI/1vPKcczUxEkCdMD+w8rzK/Okc/z0zg/KW8pNd?=
 =?us-ascii?Q?GHqqy4zbPGPfbT7sC8w=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b0d24c2-36c3-4f4a-fb49-08dd5d9f1e55
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 17:40:14.7980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zTfnPpzrj+iZMQEZGuOkdhmpc0CbgPsbgZTG/41JX58sOvJpMXU1I16eK8ThqFz8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6014

Now split_huge_page_to_list_to_order() uses the new backend split code in
__split_unmapped_folio(), the old __split_huge_page() and
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
 mm/huge_memory.c | 215 -----------------------------------------------
 1 file changed, 215 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 3e05e62fdccb..6cc97d592797 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3284,221 +3284,6 @@ static void lru_add_page_tail(struct folio *folio, struct page *tail,
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
-	/*
-	 * Reset any memcg data overlay in the tail pages. folio_nr_pages()
-	 * is unreliable after this point.
-	 */
-#ifdef NR_PAGES_IN_LARGE_FOLIO
-	folio->_nr_pages = 0;
-#endif
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


