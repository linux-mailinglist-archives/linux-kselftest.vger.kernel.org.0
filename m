Return-Path: <linux-kselftest+bounces-26913-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EB5A3ACCC
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 00:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BF0B16BE8A
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 23:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083321DE4D7;
	Tue, 18 Feb 2025 23:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U/eXySGm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27881DE3C7;
	Tue, 18 Feb 2025 23:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739922627; cv=fail; b=ch/QQ9r7v1kkAJdH2EpIuGKsbYvwyowDAJ7MrVHDIhd7qsMNgMStHe9ilD2ddtgOevT04d7bfN2lVZRRh5OnSm3nsvJ9Fyp2YiyWJGRkw3ysKCWb5r2aKveSJcm3A2NWk1EDQYmBzV5PuEmT/gpxwbBoHMH5s+3DdyW3NpVndk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739922627; c=relaxed/simple;
	bh=jk28+P+MVPh3m/G97a5eKe+qgl25/Tn/xvwpkGT2W0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WcNSMyDt3btNFLyjLWpNY5EmxV9oe31Ft2pted8yfFFk7yZrzDnQZDnYaiJKnxzmageGl7yi/Sc1ubpB9wyfXDjgNeAk8Jk7vJ13k/HtBYdqfRAz5v1K6TWNanmH2nAwZNXAdIeOo2BNwOc57wCSPl2Xw+D/++RByIkqUC6PYRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U/eXySGm; arc=fail smtp.client-ip=40.107.237.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pBSJRrgvMOCoWCyli5ZslgXBreyT6DLOd4kBXyAYs8rhD10J3BIvR4moIfzYYwdyJZEpwcmr/sQKOsY0n5f2P8uiqbCYl9xdFLfNZWnlKFB2qnTwbSvUN3hDGBjdo04A4AcdRtYV3FnQtAiT7gOsEsOtPPJDl8EVbRlG2l9E7BHxqJLxo6kymJPTpEquzrawyso4v/JIlu1nzIykodNRNqxnBcUi+xon7JHcfkFkzj485f3E4YWX8mTXOw/H1pdCx20QABl1zxEfnKO6YiRLTeZcPclJlA9yTSRAVzhEJ9FDi/Lhj02dCbMrW0n3c0w1Dn+NVFa9STbOf7fApD9Wxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gcmqRGnFLKvtlY1e1CY4oxtUbAdoYFhIt8CwrLHI+zw=;
 b=nFDtuRxuNpqB6RVGV4uNlwUpmWdylwAQT8usxW+i33FzHbjiQJ+cQzwt7I2Q/Rtd50vbZ1v62dnMFrS2Bw/YRH4AEtoJ5QQgN1bUc4TpDrkDZur/H4B0DFQFeimHRue9BeNbQ0gscnB4fhc2zpJBULCRRFL/dL976jAKwXzAque+vyaSBSrgbSKXhSMF9tIdq/RZxAAuhnGhndO5GKLerq44yizlZXjOidgDo8icoJHjO8D/kyeRwCmQF8cYaZU/egCMkzQu/jmKCE55NiPdZpZnvjwAMUkSlPx2kXMpk7qv+o75BjOOf6Xz/ZgFQ/yhfJocyLC2eiXvHWPap2Eg1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcmqRGnFLKvtlY1e1CY4oxtUbAdoYFhIt8CwrLHI+zw=;
 b=U/eXySGmhUV/CWxWLtqUheRomdAT4bYB5s38yGQyjT7WoIJtGtEp//7ygXyRSgy0g+D7ydggW+Ox5eUaWP5VTYyYvfo3u+l2NmAJelMbVDZvn5SFVThBOxMsRj7OjXqVJC7OdJiUWZderKsiWwF5IqzL24tq2j5hK43/L3URO9Hl4OOZEmP5/NNs2TKUmsg7dgL3K1Fy2Avk0esJrvQBC5JQdOwlCjXFv9qlxbv9/LYAchTkYzhzzyEdfvmbfcgHoYohpG3ih5Jiqip1xUSWjjwsm45ASRGfQ/qAMWN+gdfqbhbSvKK9TqDS+Vkans474WJxy5YHen6f8TbIu3mIdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.14; Tue, 18 Feb 2025 23:50:20 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 23:50:20 +0000
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
Subject: [PATCH v8 2/8] mm/huge_memory: add two new (not yet used) functions for folio_split()
Date: Tue, 18 Feb 2025 18:50:06 -0500
Message-ID: <20250218235012.1542225-3-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250218235012.1542225-1-ziy@nvidia.com>
References: <20250218235012.1542225-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0066.namprd03.prod.outlook.com
 (2603:10b6:208:329::11) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH2PR12MB4326:EE_
X-MS-Office365-Filtering-Correlation-Id: 60ae6314-1dbd-4120-4546-08dd507700af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ydqjzstnGqnN7/f4IrP85Jie/RjKdkZ2WWEp50D4NwHmvHQhyktlWmE+8pFx?=
 =?us-ascii?Q?//AtdBcfCp+ARuOD+VzBysBjLbc4I0ppAD80wJiLZdjIcEillTWsFTTTiRlh?=
 =?us-ascii?Q?20OUx+WG5xGFj130/1yJeWaPpuoSZ/m4V7qeE+u+68QsNZ90jnCx4qRwwUYK?=
 =?us-ascii?Q?d/USPvpfHbCYn2LHnMXYVxa7AVfN66X2h96kR7OwHp1mW+G5qRigf9VRNtt/?=
 =?us-ascii?Q?sUyNBUx3FpOkmEN0wENlTE6+cGyMLwarDVKn9VE58Bjyr/ATjN7yN3LEfy9C?=
 =?us-ascii?Q?IZNfCJTxqzGjvgkjLGZfxfGzD5Ro5lKPV9zN9iyM6IM7yApPjBU7AzuQVKGp?=
 =?us-ascii?Q?WiBuHehIEZ28o2N8WucH3J4JQymok8wFq8L/j/FMDqWFC9cil4tD5ds4ZVxt?=
 =?us-ascii?Q?hNOlrhozTENnRviVuGi4ayRECrcECAM9nehRIAGp9+FAsrtAa7ug46qBASsN?=
 =?us-ascii?Q?5Cw+1hWIlPENeqJrJ8blr0PRthK2xehB8gkWuscnC8BOiJdW7VbT3Qf11m2C?=
 =?us-ascii?Q?i7E+QdVekRnZW3scVUL5O/ABu7KRr8aLoqq5bm3Nc7exkctVj1EnQxJNzeqm?=
 =?us-ascii?Q?Cc+WouW1PbcTE6bu5PUj1M+n5LJ4Vmh9kbjxaC0eFNuv1i293h8MNpeQYXgR?=
 =?us-ascii?Q?luTlg/uXTVcU4lxgIoZuqB2yV2xOq7oarhAP7JpEtjUxiwEP0izgRXRj3TC1?=
 =?us-ascii?Q?XR8LmDCWc+29R6ld+6bmih9mlifi+/vuONV26Nw240NOSmkN9A5tf8PPzDFk?=
 =?us-ascii?Q?2Ccx4FKNXHFC4+i1sG+0g3wGIPUC5Re3V6DVVxdvgcnbZ9ys9nOM6gEsFbhB?=
 =?us-ascii?Q?750UffBLwzEyoTmR48QsyRkK3/w1jl1WFbG74kB68D7W3GorwsC9r+lG0Ode?=
 =?us-ascii?Q?XxlrxK5C+1ja/BA64NqIsniaw08nvrRRzlFWDwHApZuMkYx6gdTV9dxGuG6O?=
 =?us-ascii?Q?QM9/z8JhX+dXcT1bdYOfH7Z5y2cXD7/PjU36frVU6+7VHX1qly+Z6ECDLWvq?=
 =?us-ascii?Q?esfQH0E405NqY7TbEGsdEsm8mPImjvlUz+EIc+rZyNRJl1RjxCKuziEFLghr?=
 =?us-ascii?Q?m8skmWvYtTQI4lUEQZePoR/8i9ntQ+j6UBg6IosDWFm7nZEzqSywvClKlOEr?=
 =?us-ascii?Q?mfM1ZAE8NKlw7cBfvj+JN94JbirLUGO3GGpxG7jAdk9cX9F1ryxdMbcyrjj8?=
 =?us-ascii?Q?7Ft98f70adfEZYIt3VAHj56bS5fCtY2aESJ7g7BoWZp3Q4c6TeeKu+B4I+dX?=
 =?us-ascii?Q?twTo4FNudP3hhW/h+QYHks2EnxsHNNb3oT90JsigMnRczwgibhq7qEH6BFNz?=
 =?us-ascii?Q?ZFMdQIZMRF2Fl4P2MOE85ljVne0pNB3v9s6iJz/didZ1Q7AbP1lFw3jrWgq2?=
 =?us-ascii?Q?tYjjh1GEI6d3lrIUGO1oMuhnR0FV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FiF9Bd8kCTd5jlX8ZHqe5EWsosgQAHopV5OX3tVDz0OkxhB4CJsP9cRn1zhk?=
 =?us-ascii?Q?l2T19kEiiIN99J/f7290oAdpIqtSkEqN3O7c+XgTbyeDKWYxDh5Xc5npCEGq?=
 =?us-ascii?Q?IkkeESI4lZo7Yl5wyHEcvLRaejk/tZ+7qTRsAydSaOvFy/WiWis/mEVaW3eD?=
 =?us-ascii?Q?91zQ99Zcujd46VMcsbsWo1okJZDziejXqZROzmcwFR3B6HONCWb2dTVCmP4X?=
 =?us-ascii?Q?fIYr7p5F9bRDnq+wlySf8/SRLh7dyPUfOdb9urE+4fvEUR+bMO4F1vGnkSwa?=
 =?us-ascii?Q?4NzpXQ62t5ySHCvA8XCHlw/KEAHNSzS910r3gAggZJ7Vt3yHx+SqavVNQvu2?=
 =?us-ascii?Q?1g9Ult0R0GvHFj1LV+1v4VG0KWy8+8oS2oRgfwiU2w38tRXEAJy8eZ6tqk8w?=
 =?us-ascii?Q?xQ2bx+y/muKSN/MFXQqvbyvY+5Eq7+zvC+IPOzaWHE4tedzGTVxUZTt9b3L7?=
 =?us-ascii?Q?O69krUTPnQJYKwNWhdDKBDKInD1ZnAQ8NXjD1CmTK1/CGDeeMSfPt/qvq0LL?=
 =?us-ascii?Q?3bOMJ5rZz+pHMZIxeN0vp3XQxns5NXEXGkSTEec7fJ+NNPFnPvYK7FkqR7o/?=
 =?us-ascii?Q?qaUsz7O4q59aKo+if6jqqAVUQrRcnAJ3QL6llDC8dej2EdDmunYMK3o0sxJU?=
 =?us-ascii?Q?ZFxNjwy8lYUENLbmngxYNvBFzv/8xnbjoBo8QEHQi0F8H3iOy+W48E0TySSf?=
 =?us-ascii?Q?8O3DZTrtf3Sdhraz6OTFIu3YWGO1HumlH1zkrY7jJifIWGni8xDfoZZS0C9K?=
 =?us-ascii?Q?SbpoFUblTdmcM/Wev1fmYdw/lgCgjSqGVe/doVNK7JWRhcNoCK5jZ4A6AKz3?=
 =?us-ascii?Q?zoYtWiKmUHrxaKjA3M/nERLMxfS1TsRHlwgcOm/JgEUmMkxMkbOEaDs92rW7?=
 =?us-ascii?Q?wqpTL3rK3fNxnYOOAEcNEAJA/3e/Ce77SX6gptk3oqyp1EccPRs2fiKIoeRe?=
 =?us-ascii?Q?zBi0GdsD+2sll6OAth1/i7xBrcoyxe6sfWpetdwisyGo9YaLPuvm155sZEGy?=
 =?us-ascii?Q?jaBYrfB3Et0vW3R1oaocSZkgdeVlSG4SA+1XJerjcNpXpEKy19t5Pt8P3Wxt?=
 =?us-ascii?Q?260tAc7QfEIEcKfpDb1zpVRkWChtE9LMMBeqFBVytOCsj98+WL22wDp0L2Di?=
 =?us-ascii?Q?oI/nxcmdtYkaZk1cZqpsi1R0sKeeAICM27Sy5oqtpZSJEcfFkOgkxLyEgbQV?=
 =?us-ascii?Q?/K4fAiFGMWXRinN5uu5tC6m3maR2r6XYflvzfOWJzDoJrUyibldAaMH16Zor?=
 =?us-ascii?Q?mUsZakh19lRCeBEgXpy9NPocT9yLHjPC4LaLx+ldRp6/zSPnX2mRDtxrupfn?=
 =?us-ascii?Q?oxkEomGqZVeWPS3RHYcdl7zE7K/JI70XrZdQIZyrTgmv9R9JJ2VBwp1YMOuO?=
 =?us-ascii?Q?k4R1EVrXZg0Fa6bhEucJjAtzN66zW8w8SDxBhPOd4FCerwUornMQHcx+yNsU?=
 =?us-ascii?Q?W4bxiqon+leHwQR6kj/WqNIkVemUmT5CHDrVmz+OfZvzxVQ+/qexRSjbBbnG?=
 =?us-ascii?Q?PsP+uwgsbuWw3F3PPN49nS9846g6QtSIMe98RiOZxAJ4uM8gTNkLEt+6dnb4?=
 =?us-ascii?Q?lCavp1/jeL+1cUQr8vxbpuI9sbtvCDAMeD9jH/Q7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60ae6314-1dbd-4120-4546-08dd507700af
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 23:50:20.0296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9WTd6jZsS8uFTvEFRmgTZL2sctXqOhxGO3HrtmPQ7PXY4x36PX41IX5BdJzCV7LO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4326

This is a preparation patch, both added functions are not used yet.

The added __split_unmapped_folio() is able to split a folio with its
mapping removed in two manners: 1) uniform split (the existing way), and
2) buddy allocator like split.

The added __split_folio_to_order() can split a folio into any lower order.
For uniform split, __split_unmapped_folio() calls it once to split the
given folio to the new order.  For buddy allocator split,
__split_unmapped_folio() calls it (folio_order - new_order) times and each
time splits the folio containing the given page to one lower order.

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
---
 mm/huge_memory.c | 339 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 338 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index de72713b1c45..385e424252d4 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3149,7 +3149,6 @@ static void remap_page(struct folio *folio, unsigned long nr, int flags)
 static void lru_add_page_tail(struct folio *folio, struct page *tail,
 		struct lruvec *lruvec, struct list_head *list)
 {
-	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
 	VM_BUG_ON_FOLIO(PageLRU(tail), folio);
 	lockdep_assert_held(&lruvec->lru_lock);
 
@@ -3393,6 +3392,344 @@ bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins)
 					caller_pins;
 }
 
+/*
+ * It splits @folio into @new_order folios and copies the @folio metadata to
+ * all the resulting folios.
+ */
+static void __split_folio_to_order(struct folio *folio, int new_order)
+{
+	long nr_pages = folio_nr_pages(folio);
+	long new_nr_pages = 1 << new_order;
+	long index;
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
+}
+
+/*
+ * It splits an unmapped @folio to lower order smaller folios in two ways.
+ * @folio: the to-be-split folio
+ * @new_order: the smallest order of the after split folios (since buddy
+ *             allocator like split generates folios with orders from @folio's
+ *             order - 1 to new_order).
+ * @split_at: in buddy allocator like split, the folio containing @split_at
+ *            will be split until its order becomes @new_order.
+ * @lock_at: the folio containing @lock_at is left locked for caller.
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
+		struct page *split_at, struct page *lock_at,
+		struct list_head *list, pgoff_t end,
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
+		__split_folio_to_order(folio, split_order);
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
+			if (release == page_folio(split_at)) {
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
+			if (release == origin_folio)
+				continue;
+
+			lru_add_page_tail(origin_folio, &release->page,
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
+		if (new_folio == page_folio(lock_at))
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


